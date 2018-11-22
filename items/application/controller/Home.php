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
        try {
            sleep(5);
            $pid = input("id") ?: 0;
            $module = db('sys_module')->query("
            SELECT t1.Id,t1.Pid,t1.Name,t1.Icon,t1.Link,t1.Sort,
            (SELECT COUNT(t2.Id) FROM sys_module AS t2 WHERE t2.Pid=t1.Id AND t2.IsDel=0 AND t2.IsValid=1) AS Son
            FROM sys_module AS t1 WHERE t1.IsDel=0 AND t1.IsValid=1 AND t1.Pid={$pid} ORDER BY t1.Sort ASC
            ");
            $tree = array();
            foreach ($module as $m) {
                $state = $m["Son"] > 0 ? "closed" : "";
                $tree[] = array(
                    "id" => $m["Id"],
                    "state" => $state,
                    "text" => $m["Name"],
                    "iconCls" => $m["Icon"],
                    "link" => $m["Link"],
                    "son" => $m["Son"],
                );
            }
            echo json_encode($tree);
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
        }
    }
}
