<?php

namespace app\admin\controller;

use app\common\facade\ModuleFacade;
use app\common\model\SysModuleModel;
use think\facade\Db;
use think\facade\View;

class ModuleController extends BasicController
{
    //模块列表 View
    public function index()
    {
        //获取按钮
        View::assign(['button' => $this->getModuleButton()]);
        return View::fetch();
    }

    //添加模块 View || Json
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
                $model = new SysModuleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                errorJournal($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $model = getEmptyModel('SysModule');
        $model["pid"] = input("pid") ?: 0;
        $model["level"] = (input("level") ?: 0) + 1;
        View::assign(['model' => convertCamelize($model)]);
        return View::fetch();
    }

    //编辑模块 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["modify_time"] = date("Y-m-d H:i:s");
                $data["modify_user"] = $this->user["id"];
                //更新数据
                $model = SysModuleModel::find($data["id"]);
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                errorJournal($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysModuleModel::find($id)->getData();
        View::assign(['model' => convertCamelize($model)]);
        return View::fetch();
    }

    //调整层级 View || Json
    public function move()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                $data = input();
                $data["modify_time"] = date("Y-m-d H:i:s");
                $data["modify_user"] = $this->user["id"];
                $data['pid'] = (int) $data['pid'];
                $data["level"] = ((int) Db::name('sys_module')->where('id', $data['pid'])->value('level')) + 1;
                //更新数据
                $model = SysModuleModel::find($data["id"]);
                $model->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                errorJournal($e->getMessage());
                return jsonOut(config('code.error'), '出现错误,请联系管理员');
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        View::assign(['id' => $id]);
        return View::fetch();
    }

    //删除模块 Json
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
            $model = SysModuleModel::find($id);
            $model->save($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //获取模块列表 Json
    public function getModuleList()
    {
        try {
            $key = input("key") ?: "";
            //搜索
            $search = is_numeric($key) ? "AND t1.id={$key}" : "AND t1.Name like '%{$key}%'";
            $module = Db::query("
            SELECT t1.*,(SELECT COUNT(t2.id) FROM sys_module AS t2 WHERE t2.pid=t1.id AND t2.is_del=0) AS Son
            FROM sys_module AS t1 WHERE t1.is_del=0 {$search} ORDER BY t1.sort ASC");
            $tree = array();
            foreach ($module as $m) {
                //获取一级
                if ($m["pid"] == 0) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($module, $m["id"]) : [];
                    $tree[] = convertCamelize($m);
                }
            }
            $data = (bool) input("root") ? array(array('id' => 0, 'name' => '根目录', 'children' => $tree)) : $tree;
            return toEasyTable($data, false);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return toEasyTable([], false);
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

    //模块按钮列表 View
    public function button()
    {
        return View::fetch();
    }

    //获取模块按钮列表
    public function getModuleButtonList()
    {
        try {
            $key = input("key") ?: "";
            $moduleId = input("moduleId") ?: 0;
            //搜索
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.id={$key}" : "AND t1.Name like '%{$key}%'";
            $data = Db::query("
            SELECT t1.id,t1.Name,t1.english_name,{$moduleId} AS module_id,CASE WHEN t2.id IS NULL THEN FALSE ELSE TRUE END AS is_relation
            FROM sys_button AS t1 LEFT JOIN sys_module_button AS t2 ON(t2.module_id={$moduleId} AND t2.button_id=t1.id AND t2.is_del=0)
            WHERE t1.is_del=0 {$search} ORDER BY (CASE WHEN t2.id IS NULL THEN 1 ELSE 0 END) ASC,t1.sort ASC;");
            return toEasyTable($data);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //模块关联按钮 Json
    public function relationButton()
    {
        try {
            $array = array(
                "isRelation" => (bool) json_decode(input("isRelation")),
                "ids" => input("ids"),
                "moduleId" => input("moduleId"),
                "operaterId" => $this->user["id"],
            );
            $result = ModuleFacade::relationButton($array);
            if ($result->code) {
                return jsonOut(config('code.success'), "操作成功");
            }
            return jsonOut(config('code.error'), $result->msg);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //自动排序 Json
    public function sorting($children = null)
    {
        //为方便调整顺序将模块按顺序大小和层级自动排序为间隔为10的顺序
        try {
            $list = Db::name('sys_module')->where(array("is_del" => 0))->order("sort", "ASC")->select()->toArray();
            if ($list == null) {
                return jsonOut(config('code.error'), "操作失败,没有按模块");
            }
            $data = array();
            $sort = array();
            foreach ($list as $l) {
                $level = $l['level'];
                $pid = $l['pid'];
                $key = $level . '-' . $pid;
                $sort[$key] = (isset($sort[$key]) ? $sort[$key] : 0) + 10;
                $l['sort'] = $sort[$key];
                $data[] = $l;
            }
            //批量更新数据
            $model = new SysModuleModel;
            $model->saveAll($data);
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }
}
