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
        $data = array();
        for ($i = 0; $i < 10; $i++) {
            $data[] = array(
                "id" => $i+1,
                "text" => "一级".$i+1,
            );
        }
        echo json_encode($data);
    }
}
