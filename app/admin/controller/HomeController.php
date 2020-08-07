<?php

namespace app\admin\controller;

use think\facade\Db;
use think\facade\View;

class HomeController extends BasicController
{
    //系统主页 view
    public function index()
    {
        $user = $this->user;
        View::assign(['user' => $user]);
        return View::fetch();
    }

    //获取菜单树
    public function getMenuTree()
    {
        try {
            $pid = input("id") ?: 0;
            $module = Db::name('sys_module')->query("
            SELECT t2.id,t2.pid,t2.name,t2.icon,t2.link,t2.sort,
            (SELECT COUNT(t3.id) FROM sys_module AS t3 WHERE t3.pid=t2.id AND t3.is_del=0 AND t3.is_valid=1) AS son
            FROM sys_role_module AS t1 JOIN sys_module as t2 on(t2.id=t1.module_id AND t2.is_valid=1 AND t2.is_del=0)
            WHERE t1.is_del=0 AND t1.is_valid=1 AND t1.role_id AND t2.pid={$pid} AND t1.role_id IN(
            SELECT t4.role_id FROM sys_user_role as t4 WHERE t4.is_del=0 AND t4.is_valid=1 AND t4.user_id={$this->user["id"]}
            )GROUP BY t2.id ORDER BY t2.sort ASC;");
            $tree = array();
            foreach ($module as $m) {
                $state = $m["son"] > 0 ? "closed" : "";
                $tree[] = array(
                    "id" => $m["id"],
                    "state" => $state,
                    "text" => $m['name'],
                    "iconCls" => $m["icon"],
                    "link" => $m["link"],
                    "son" => $m["son"],
                );
            }
            echo json_encode($tree);
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            echo json_encode($e->getMessage());
        }
    }
}
