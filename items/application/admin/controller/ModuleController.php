<?php
namespace app\admin\controller;

use app\common\facade\ModuleFacade;
use app\common\model\SysModuleModel;

class ModuleController extends BasicController
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
                $data = convertToupper(input());
                $data["CreateTime"] = date("Y-m-d H:i:s");
                $data["CreateUser"] = $this->user["Id"];
                $data["ModifyTime"] = $data["CreateTime"];
                $data["ModifyUser"] = $data["CreateUser"];
                $model = new SysModuleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        //输出页面
        $model = getEmptyModel('SysModule');
        $model["Pid"] = input("pid") ?: 0;
        $model["Level"] = (input("level") ?: 0) + 1;
        $this->assign('model', convertLower($model));
        return View();
    }

    //编辑模块 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertToupper(input());
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $model = new SysModuleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysModuleModel::get($id)->getData();
        $this->assign('model', convertLower($model));
        return View();
    }

    //调整层级 View || Json
    public function move()
    {
        //数据请求
        if (request()->isPost()) {
            try {
                //首字母还原为大写
                $data = convertToupper(input());
                $data["ModifyTime"] = date("Y-m-d H:i:s");
                $data["ModifyUser"] = $this->user["Id"];
                $data['Pid'] = (int) $data['Pid'];
                $data["Level"] = ((int) db('sys_module')->where('Id', $data['Pid'])->value('Level')) + 1;
                $model = new SysModuleModel();
                // 过滤表单数组中的非数据表字段数据
                $model->allowField(true)->save($data, ['Id' => $data["Id"]]);
                return jsonOut(config('code.success'), "操作成功");
            } catch (\Exception $e) {
                return jsonOut(config('code.error'), $e->getMessage());
            }
        }
        //输出页面
        $id = input("id") ?: 0;
        $this->assign('id', $id);
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
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
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
                    $tree[] = convertLower($m);
                }
            }
            $data = (bool) input("root") ? array(array('id' => 0, 'name' => '根目录', 'children' => $tree)) : $tree;
            return toEasyTable($data, false);
        } catch (\Exception $e) {
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
                    $data[] = convertLower($m);
                }
            }
            return $data;
        } catch (\Exception $e) {
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
        } catch (\Exception $e) {
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
                "operaterId" => $this->user["Id"],
            );
            $result = ModuleFacade::relationButton($array);
            if ($result->code) {
                return jsonOut(config('code.success'), "操作成功");
            }
            return jsonOut(config('code.error'), $result->msg);
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }

    //自动排序 Json
    public function sorting($children = null)
    {
        //为方便调整顺序将模块按顺序大小和层级自动排序为间隔为10的顺序
        try {
            $list = db('sys_module')->where(array("IsDel" => 0))->order("Sort", "ASC")->select();
            if ($list == null) {
                return jsonOut(config('code.error'), "操作失败,没有按模块");
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
            return jsonOut(config('code.success'), "操作成功");
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }
}
