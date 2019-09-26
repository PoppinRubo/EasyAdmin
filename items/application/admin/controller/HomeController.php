<?php
namespace app\admin\controller;

class HomeController extends BasicController
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
            $pid = input("id") ?: 0;
            $module = db('sys_module')->query("
            SELECT t2.Id,t2.Pid,t2.Name,t2.Icon,t2.Link,t2.Sort,
            (SELECT COUNT(t3.Id) FROM sys_module AS t3 WHERE t3.Pid=t2.Id AND t3.IsDel=0 AND t3.IsValid=1) AS Son
            FROM sys_role_module AS t1 JOIN sys_module as t2 on(t2.Id=t1.ModuleId AND t2.IsValid=1 AND t2.IsDel=0)
            WHERE t1.IsDel=0 AND t1.IsValid=1 AND t1.RoleId AND t2.Pid={$pid} AND t1.RoleId IN(
            SELECT t4.RoleId FROM sys_user_role as t4 WHERE t4.IsDel=0 AND t4.IsValid=1 AND t4.UserId={$this->user["Id"]}
            )GROUP BY t2.Id ORDER BY t2.Sort ASC;");
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
        } catch (\Exception $e) {
            echo json_encode($e->getMessage());
        }
    }
}
