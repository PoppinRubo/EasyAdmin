<?php
namespace app\facade;

class UserFacade
{

    public static function isExist($account)
    {
        return db('sys_user')->where(array("IsDel" => 0, "Account" => $account))->find() != null;
    }
}
