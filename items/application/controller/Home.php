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
        for ($i = 0; $i < 5; $i++) {
            $a = ["text" => "一级 " . ($i + 1)];
            if ($i % 2 == 0) {
                $a = array(
                    "text" => "一级 " . ($i + 1),
                    "state" => "closed",
                    "iconCls" => "layui-icon-cellphone-fine",
                    "children" => [
                        ["text" => "二级 1",
                            "children" => [
                                ["text" => "三级 1", "iconCls" => "layui-icon-cellphone-fine"],
                                ["text" => "三级 2"],
                            ],
                        ],
                        ["text" => "二级 2"],
                    ],
                );
            }
            array_push($data, $a);
        }
        echo json_encode($data);
    }
}
