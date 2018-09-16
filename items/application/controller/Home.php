<?php
namespace app\controller;

class Home extends Basic
{
    //系统主页 view
    public function index()
    {
        return View();
    }

    //获取菜单树
    public function getMenuTree()
    {
        $data=array(
            "id"=>1,
            "name"=>"一级"
        );
        return json_encode($data);
    }
}
