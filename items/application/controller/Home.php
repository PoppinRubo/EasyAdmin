<?php
namespace app\controller;

class Home extends Basic
{
    //系统主页 view
    public function index()
    {
        $user = getUserAuthentication();
        $this->assign(
            array(
                'user' => $user,
            )
        );
        return View();
    }

    //获取菜单树
    public function getMenuTree()
    {
        $data = array();
        for ($i = 0; $i < 20; $i++) {
            $a = ["text" => "一级 " . ($i + 1) ];
            if ($i <= 10) {
                $a = array(
                    "text" => "一级 " . ($i + 1),
                    "state" => "closed",
                    
                    "children" => [
                        ["text" => "二级 1",
                            "state" => "closed",
                            "children" => [
                                ["text" => "三级 1",  "state" => "closed", "children" => [
                                    ["text" => "四级 1"],
                                    ["text" => "四级 2"],
                                ]],
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
