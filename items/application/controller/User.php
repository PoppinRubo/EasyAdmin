<?php
namespace app\controller;

use think\Controller;
use think\Exception;

class User extends Basic
{
    //用户列表 View
    public function index()
    {
        return View();
    }

    //获取用户列表
    public function getUserList()
    {
        try {
            $limit = input("limit") ?: 10;
            $data = db('sys_user')->where(array("IsDel" => 0, "IsValid" => 1))->paginate($limit);
            return toTable($data);
        } catch (Exception $e) {
            return toTable([], false, -1, $e->getMessage());
        }
    }
}
