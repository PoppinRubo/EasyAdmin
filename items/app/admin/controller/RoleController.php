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
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                $model = new SysRoleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                error($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $model = getEmptyModel('SysRole');
        View::assign(['model' => $model]);
        return View::fetch();
    }

    //编辑角色 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                //更新数据
                $model = SysRoleModel::find($data["Id"]);
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                error($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysRoleModel::find($id)->getData();
        View::assign(['model' => $model]);
        return View::fetch();
    }

    //删除角色 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "IsDel" => 1,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            );
            //更新数据
            $model = SysRoleModel::find($id);
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            error($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //获取角色列表 Json
    public function getRoleList()
    {
        try {
            $limit = input("rows") ?: 10;
            $key = input("key") ?: "";
            $sort = input("sort") ?: "Id";
            $order = input("order") ?: "ASC";
            //查询条件
            $where = [['IsDel', '=', 0]];
            if (!empty($key)) {
                //编号查询
                if (is_numeric($key)) {
                    $where[] = ['Id', '=', $key];
                } else {
                    //名称查询
                    $where[] = ['Name', 'like', '%' . $key . '%'];
                }
            }
            $data = Db::name('sys_role')->where($where)->order($sort, $order)->paginate($limit);
            return toEasyTable($data);
        } catch (\Exception $e) {
            error($e->getMessage());
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //自动排序 Json
    public function sorting()
    {
        //为方便调整顺序将按钮按顺序大小自动排序为间隔为10的顺序
        try {
            $list = Db::name('sys_role')->where(["IsDel" => 0])->order("Sort", "ASC")->select()->toArray();
            if ($list == null) {
                return jsonOut(config('code.error'), "操作失败,没有角色");
            }
            $sort = 10;
            $data = array();
            foreach ($list as $l) {
                $l['Sort'] = $sort;
                $data[] = $l;
                //以间隔为10递增
                $sort += 10;
            }
            //批量更新数据
            $model = new SysRoleModel();
            $model->saveAll($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            error($e->getMessage());
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
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '%{$key}%'";
            $module = Db::query("
            SELECT t1.Id,t1.Pid,t1.Name,t2.RoleId AS RoleId,CASE WHEN t2.Id IS NULL THEN FALSE ELSE TRUE END AS IsRelation,
            (SELECT COUNT(t3.Id) FROM sys_module AS t3 WHERE t3.Pid=t1.Id AND t3.IsDel=0 AND t3.IsValid=1) AS Son,t1.Level,
            (SELECT COUNT(t4.Id) FROM sys_module_button AS t4 WHERE t4.IsDel=0 AND t4.IsValid=1 AND t4.ModuleId=t2.ModuleId) AS Button
            FROM sys_module AS t1 LEFT JOIN sys_role_module AS t2 ON(t2.RoleId={$roleId} AND t2.ModuleId=t1.Id AND t2.IsDel=0)
            WHERE t1.IsDel=0 AND t1.IsValid=1 {$search} ORDER BY (CASE WHEN t2.Id IS NULL THEN 1 ELSE 0 END),t1.Pid,t1.Sort ASC;");
            $tree = array();
            foreach ($module as $m) {
                //获取一级
                if ($m["Pid"] == 0) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($module, $m["Id"]) : [];
                    $tree[] = convertLower($m);
                }
            }
            return toEasyTable($tree, false);
        } catch (\Exception $e) {
            error($e->getMessage());
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
                if ($m["Pid"] == $pid) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($array, $m["Id"]) : [];
                    $data[] = convertLower($m);
                }
            }
            return $data;
        } catch (\Exception $e) {
            error($e->getMessage());
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
                "operaterId" => $this->user["Id"],
            );
            $result = RoleFacade::relationModule($array);
            if ($result->code) {
                return jsonOut(config('code.success'), "操作成功");
            }
            return jsonOut(config('code.error'), $result->msg);
        } catch (\Exception $e) {
            error($e->getMessage());
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
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '%{$key}%'";
            $data = Db::query("
            SELECT t1.Id,t1.Name,t1.EnglishName,t2.ModuleId,{$roleId} AS RoleId,CASE WHEN t3.Id IS NULL THEN FALSE ELSE TRUE END AS IsRelation
            FROM sys_button AS t1 JOIN sys_module_button AS t2 ON(t2.ModuleId={$moduleId} AND t2.ButtonId=t1.Id AND t2.IsDel=0)
            LEFT JOIN sys_role_button AS t3 ON(t3.RoleId={$roleId} AND t3.ModuleId=t2.ModuleId AND t3.ButtonId=t2.ButtonId AND t3.IsDel=0)
            WHERE t1.IsDel=0 {$search} ORDER BY (CASE WHEN t2.Id IS NULL THEN 1 ELSE 0 END) ASC,t1.Sort ASC;");
            return toEasyTable($data);
        } catch (\Exception $e) {
            error($e->getMessage());
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
                "operaterId" => $this->user["Id"],
            );
            $result = RoleFacade::relationButton($array);
            if ($result->code) {
                return jsonOut(config('code.success'), "操作成功");
            }
            return jsonOut(config('code.error'), $result->msg);
        } catch (\Exception $e) {
            error($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

}
