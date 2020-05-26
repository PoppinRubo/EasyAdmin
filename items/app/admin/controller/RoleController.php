<?php

namespace app\admin\controller;

use app\common\facade\RoleFacade;
use app\common\model\SysRoleModel;
use think\facade\Db;
use think\facade\View;

class RoleController extends BasicController
{
    //角色列表 View
    public function index()
    {
        //获取按钮
        View::assign(['button' => $this->getModuleButton()]);
        return View::fetch();
    }

    //添加角色 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["create_time"] = date("Y-m-d H:i:s");
                $data["create_user"] = $this->user["id"];
                $data["modify_time"] = $data["create_time"];
                $data["modify_user"] = $data["create_user"];
                $model = new SysRoleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                errorJournal($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $model = getEmptyModel('SysRole');
        View::assign(['model' => convertCamelize($model)]);
        return View::fetch();
    }

    //编辑角色 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["modify_time"] = date("Y-m-d H:i:s");
                $data["modify_user"] = $this->user["id"];
                //更新数据
                $model = SysRoleModel::find($data["id"]);
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                errorJournal($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysRoleModel::find($id)->getData();
        View::assign(['model' => convertCamelize($model)]);
        return View::fetch();
    }

    //删除角色 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "is_del" => 1,
                "modify_time" => date("Y-m-d H:i:s"),
                "modify_user" => $this->user["id"],
            );
            //更新数据
            $model = SysRoleModel::find($id);
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //获取角色列表 Json
    public function getRoleList()
    {
        try {
            $limit = input("rows") ?: 10;
            $key = input("key") ?: "";
            $sort = input("sort") ?: "id";
            $order = input("order") ?: "ASC";
            //查询条件
            $where = [['is_del', '=', 0]];
            if (!empty($key)) {
                //编号查询
                if (is_numeric($key)) {
                    $where[] = ['id', '=', $key];
                } else {
                    //名称查询
                    $where[] = ['Name', 'like', '%' . $key . '%'];
                }
            }
            $data = Db::name('sys_role')->where($where)->order($sort, $order)->paginate($limit);
            return toEasyTable($data);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //自动排序 Json
    public function sorting()
    {
        //为方便调整顺序将按钮按顺序大小自动排序为间隔为10的顺序
        try {
            $list = Db::name('sys_role')->where(["is_del" => 0])->order("sort", "ASC")->select()->toArray();
            if ($list == null) {
                return jsonOut(config('code.error'), "操作失败,没有角色");
            }
            $sort = 10;
            $data = array();
            foreach ($list as $l) {
                $l['sort'] = $sort;
                $data[] = $l;
                //以间隔为10递增
                $sort += 10;
            }
            //批量更新数据
            $model = new SysRoleModel();
            $model->saveAll($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //角色模块列表 View
    public function model()
    {
        return View::fetch();
    }

    //获取角色模块列表 Json
    public function getRoleModuleList()
    {
        try {
            $key = input("key") ?: "";
            $roleId = input("roleId") ?: 0;
            //搜索
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.id={$key}" : "AND t1.Name like '%{$key}%'";
            $module = Db::query("
            SELECT t1.id,t1.pid,t1.Name,t2.role_id AS role_id,CASE WHEN t2.id IS NULL THEN FALSE ELSE TRUE END AS IsRelation,
            (SELECT COUNT(t3.id) FROM sys_module AS t3 WHERE t3.pid=t1.id AND t3.is_del=0 AND t3.is_valid=1) AS Son,t1.level,
            (SELECT COUNT(t4.id) FROM sys_module_button AS t4 WHERE t4.is_del=0 AND t4.is_valid=1 AND t4.module_id=t2.module_id) AS Button
            FROM sys_module AS t1 LEFT JOIN sys_role_module AS t2 ON(t2.role_id={$roleId} AND t2.module_id=t1.id AND t2.is_del=0)
            WHERE t1.is_del=0 AND t1.is_valid=1 {$search} ORDER BY (CASE WHEN t2.id IS NULL THEN 1 ELSE 0 END),t1.pid,t1.sort ASC;");
            $tree = array();
            foreach ($module as $m) {
                //获取一级
                if ($m["pid"] == 0) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($module, $m["id"]) : [];
                    $tree[] = convertCamelize($m);
                }
            }
            return toEasyTable($tree, false);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //获取子级模块 array
    protected function getSonModule($array, $pid)
    {
        try {
            $data = array();
            foreach ($array as $m) {
                //递归子级
                if ($m["pid"] == $pid) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($array, $m["id"]) : [];
                    $data[] = convertCamelize($m);
                }
            }
            return $data;
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return [];
        }
    }

    //角色模块关联 Json
    public function relationdModel()
    {
        try {
            $array = array(
                "isRelation" => (bool) json_decode(input("isRelation")),
                "ids" => input("ids"),
                "roleId" => input("roleId"),
                "operaterId" => $this->user["id"],
            );
            $result = RoleFacade::relationModule($array);
            if ($result->code) {
                return jsonOut(config('code.success'), "操作成功");
            }
            return jsonOut(config('code.error'), $result->msg);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //角色模块按列表 View
    public function button()
    {
        return View::fetch();
    }

    //获取角色模块按钮列表
    public function getRoleModuleButtonList()
    {
        try {
            $key = input("key") ?: "";
            $moduleId = input("moduleId") ?: 0;
            $roleId = input("roleId") ?: 0;
            //搜索
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.id={$key}" : "AND t1.Name like '%{$key}%'";
            $data = Db::query("
            SELECT t1.id,t1.Name,t1.english_name,t2.module_id,{$roleId} AS role_id,CASE WHEN t3.id IS NULL THEN FALSE ELSE TRUE END AS IsRelation
            FROM sys_button AS t1 JOIN sys_module_button AS t2 ON(t2.module_id={$moduleId} AND t2.button_id=t1.id AND t2.is_del=0)
            LEFT JOIN sys_role_button AS t3 ON(t3.role_id={$roleId} AND t3.module_id=t2.module_id AND t3.button_id=t2.button_id AND t3.is_del=0)
            WHERE t1.is_del=0 {$search} ORDER BY (CASE WHEN t2.id IS NULL THEN 1 ELSE 0 END) ASC,t1.sort ASC;");
            return toEasyTable($data);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //角色模块关联按钮 Json
    public function relationButton()
    {
        try {
            $array = array(
                "isRelation" => (bool) json_decode(input("isRelation")),
                "ids" => input("ids"),
                "roleId" => input("roleId"),
                "moduleId" => input("moduleId"),
                "operaterId" => $this->user["id"],
            );
            $result = RoleFacade::relationButton($array);
            if ($result->code) {
                return jsonOut(config('code.success'), "操作成功");
            }
            return jsonOut(config('code.error'), $result->msg);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }
}
