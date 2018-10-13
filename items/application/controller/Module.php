<?php
namespace app\controller;

use app\model\SysModule;
use think\Controller;
use think\Exception;

class Module extends Basic
{
    //模块列表 View
    public function index()
    {
        return View();
    }

    //添加模块 View || Json
    public function add()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                $model = new SysModule();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysModule');
        $model["Pid"] = input("pid") ?: 0;
        $this->assign('model', convertInitials($model));
        return View();
    }

    //编辑模块 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertInitials(input(), false);
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = new SysModule();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysModule::get($id)->getData();
        $this->assign('model', convertInitials($model));
        return View();
    }

    //删除模块 Json
    public function remove()
    {
        try {
            $id = input("id") ?: 0;
            $data = array(
                "IsDel" => 1,
                "ModifyTime" => date("Y-m-d H:i:s"),
                "ModifyUser" => $this->user["Id"],
            );
            $model = new SysModule();
            $model->save($data, ['Id' => $id]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //获取模块列表 Json
    public function getModuleList($id = 0)
    {
        try {
            $pid = empty(input("pid")) ? $id : input("pid");
            $key = input("key") ?: "";
            $pid = "AND t1.Pid={$pid}";
            $search = "";
            if ($key != "") {
                $search = is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '{$key}'";
                $pid = "";
            }

            $module = db('sys_module')->query("
            SELECT t1.*,(SELECT COUNT(t2.Id) FROM sys_module AS t2 WHERE t2.Pid=t1.Id AND t2.IsDel=0) AS Son
            FROM sys_module AS t1 WHERE t1.IsDel=0 {$pid} {$search} ORDER BY t1.Sort ASC
            ");
            $tree = array();
            foreach ($module as $m) {
                $m["state"] = $m["Son"] > 0 ? "closed" : "";
                $m["children"] = $m["Son"] > 0 ? $this->getModuleList($m["Id"]) : [];
                $tree[] = convertInitials($m);
            }
            if ($id > 0) {
                return $tree;
            }
            return toEasyTable($tree, false);
        } catch (Exception $e) {
            return toEasyTable([], false);
        }
    }
}
