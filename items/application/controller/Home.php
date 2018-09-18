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
        for ($i = 0; $i < 20; $i++) {
            $a = ["text" => "一级 " . ($i + 1), "iconCls" => "layui-icon-cellphone-fine"];
            if ($i <= 10) {
                $a = array(
                    "text" => "一级 " . ($i + 1),
                    "state" => "closed",
                    "iconCls" => "layui-icon-cellphone-fine",
                    "children" => [
                        ["text" => "二级 1",
                            "iconCls" => "layui-icon-cellphone-fine",
                            "children" => [
                                ["text" => "三级 1", "iconCls" => "layui-icon-cellphone-fine"],
                                ["text" => "三级 2", "iconCls" => "layui-icon-cellphone-fine"],
                            ],
                        ],
                        ["text" => "二级 2", "iconCls" => "layui-icon-cellphone-fine"],
                    ],
                );
            }
            array_push($data, $a);
        }
        echo json_encode($data);
    }
}
