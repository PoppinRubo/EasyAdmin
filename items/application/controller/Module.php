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
            return toJsonData(0, null, "啦啦");
        }
        //输出页面
        $model = getEmptyModel('SysModule');
        $this->assign('model', convertInitials($model));
        return View();
    }

    //编辑模块 View || Json
    public function edit()
    {
        //数据请求
        if (request()->isPost()) {
            return toJsonData(0, null, "啦啦");
        }
        //输出页面
        $id = input("id") ?: 0;
        $model = SysModule::get($id)->getData();
        $this->assign('model', convertInitials($model));
        return View();
    }

    //获取模块列表 Json
    public function getModuleList()
    {
        try {
            $limit = input("limit") ?: 10;
            $data = db('sys_module')->where(array("IsDel" => 0, "IsValid" => 1))->paginate($limit);
            return toTable($data);
        } catch (Exception $e) {
            return toTable([], false, -1, $e->getMessage());
        }
    }
}
