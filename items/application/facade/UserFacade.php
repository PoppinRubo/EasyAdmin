<?php
namespace app\facade;

class UserFacade
{

    //检测账号是否存在
    public static function isExist($account)
    {
        return db('sys_user')->where(array("IsDel" => 0, "Account" => $account))->find() != null;
    }
}
