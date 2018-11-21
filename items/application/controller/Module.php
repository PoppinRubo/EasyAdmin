<?php
namespace app\controller;

use app\model\SysModuleModel;
use app\model\SysModuleModelButtonModel;
use think\Exception;

class Module extends Basic
{
    //模块列表 View
    public function index()
    {
        //获取按钮
        $this->assign('button', $this->getModuleButton());
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
                $model = new SysModuleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysModuleModel');
        $model["Pid"] = input("pid") ?: 0;
        $model["Level"] = (input("level") ?: 0) + 1;
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
                $model = new SysModuleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return toJsonData(1, null, "操作成功");
            } catch (Exception $e) {
                return toJsonData(0, null, $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysModuleModel::get($id)->getData();
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
            $model = new SysModuleModel();
            $model->save($data, ['Id' => $id]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //获取模块列表 Json
    public function getModuleList()
    {
        try {
            $key = input("key") ?: "";
            //搜索
            $search = is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '%{$key}%'";
            $module = db()->query("
            SELECT t1.*,(SELECT COUNT(t2.Id) FROM sys_module AS t2 WHERE t2.Pid=t1.Id AND t2.IsDel=0) AS Son
            FROM sys_module AS t1 WHERE t1.IsDel=0 {$search} ORDER BY t1.Sort ASC");
            $tree = array();
            foreach ($module as $m) {
                //获取一级
                if ($m["Pid"] == 0) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($module, $m["Id"]) : [];
                    $tree[] = convertInitials($m);
                }
            }
            return toEasyTable($tree, false);
        } catch (Exception $e) {
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
                if ($m["Pid"] == $pid) {
                    $m["state"] = ($m["Son"] > 0) ? "open" : "";
                    $m["children"] = ($m["Son"] > 0) ? $this->getSonModule($array, $m["Id"]) : [];
                    $data[] = convertInitials($m);
                }
            }
            return $data;
        } catch (Exception $e) {
            return [];
        }
    }

    //模块按钮列表 View
    public function button()
    {
        return View();
    }

    //获取模块按钮列表
    public function getModuleButtonList()
    {
        try {
            $key = input("key") ?: "";
            $moduleId = input("moduleId") ?: 0;
            //搜索
            $search = $key == "" ? "" : is_numeric($key) ? "AND t1.Id={$key}" : "AND t1.Name like '%{$key}%'";
            $data = db()->query("
            SELECT t1.Id,t1.Name,t1.EnglishName,{$moduleId} AS ModuleId,CASE WHEN t2.Id IS NULL THEN FALSE ELSE TRUE END AS IsRelation
            FROM sys_button AS t1 LEFT JOIN sys_module_button AS t2 ON(t2.ModuleId={$moduleId} AND t2.ButtonId=t1.Id AND t2.IsDel=0)
            WHERE t1.IsDel=0 {$search} ORDER BY (CASE WHEN t2.Id IS NULL THEN 1 ELSE 0 END) ASC,t1.Sort ASC;");
            return toEasyTable($data);
        } catch (Exception $e) {
            return toEasyTable([], false, $e->getMessage());
        }
    }

    //模块关联按钮 Json
    public function relation()
    {
        try {
            $moduleId = input("moduleId") ?: 0;
            $buttonId = input("buttonId") ?: 0;
            if ($moduleId < 0 || $buttonId < 0) {
                return toJsonData(0, null, "参数错误");
            }
            $model = new SysModuleModelButtonModel();
            $data = db('sys_module_button')->where(array("ModuleId" => $moduleId, "ButtonId" => $buttonId))->find();
            if ($data == null) {
                //新增关联插入记录
                $model->save(array(
                    "ModuleId" => $moduleId,
                    "ButtonId" => $buttonId,
                    "CreateTime" => date("Y-m-d H:i:s"),
                    "CreateUser" => $this->user["Id"],
                    "ModifyTime" => date("Y-m-d H:i:s"),
                    "ModifyUser" => $this->user["Id"],
                ));
                return toJsonData(1, null, "操作成功");
            }
            //更新可用状态
            $data['IsValid'] = 1;
            $data['IsDel'] = 0;
            $data["ModifyTime"] = date("Y-m-d H:i:s");
            $data["ModifyUser"] = $this->user["Id"];
            $model->save($data, ['Id' => $data['Id']]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //模块删除关联按钮 Json
    public function delRelation()
    {
        try {
            $moduleId = input("moduleId") ?: 0;
            $buttonId = input("buttonId") ?: 0;
            if ($moduleId < 0 || $buttonId < 0) {
                return toJsonData(0, null, "参数错误");
            }
            $model = new SysModuleModelButtonModel();
            $data = db('sys_module_button')->where(array("ModuleId" => $moduleId, "ButtonId" => $buttonId))->find();
            if ($data == null) {
                return toJsonData(0, null, "未找到关联数据,无法删除关联");
            }
            //恢复可用状态
            $data['IsValid'] = 0;
            $data['IsDel'] = 1;
            $data["ModifyTime"] = date("Y-m-d H:i:s");
            $data["ModifyUser"] = $this->user["Id"];
            $model->save($data, ['Id' => $data['Id']]);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //自动排序 Json
    public function sorting($children = null)
    {
        //为方便调整顺序将模块按顺序大小和层级自动排序为间隔为10的顺序
        try {
            $list = db('sys_module')->where(array("IsDel" => 0))->order("Sort", "ASC")->select();
            if ($list == null) {
                return toJsonData(0, null, "操作失败,没有模块");
            }
            $data = array();
            $sort = array();
            foreach ($list as $l) {
                $level = $l['Level'];
                $pid = $l['Pid'];
                $key = $level . '-' . $pid;
                $sort[$key] = (isset($sort[$key]) ? $sort[$key] : 0) + 10;
                $l['Sort'] = $sort[$key];
                $data[] = $l;
            }
            //批量更新数据
            $model = new SysModuleModel;
            $model->saveAll($data);
            return toJsonData(1, null, "操作成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }
}
