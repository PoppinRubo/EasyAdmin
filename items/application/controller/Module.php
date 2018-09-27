<?php
namespace app\controller;

use think\Controller;
use think\Exception;

class Module extends Basic
{
    //模块列表 View
    public function index()
    {
        return View();
    }

    //编辑模块 View
    public function edit()
    {
        $id = input("id") ?: 0;
        $data = db('sys_module')->where(array("Id" => $id))->find();
        $this->assign(
            array(
                'model' => convertInitials($data),
            )
        );
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
