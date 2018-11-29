<?php
namespace app\facade;

use app\facade\CommonFacade;
use think\facade\Cookie;
use think\facade\Session;

class UserFacade
{

    //检测账号是否存在
    public static function isExist($account)
    {
        return db('sys_user')->where(array("IsDel" => 0, "Account" => $account))->find() != null;
    }

    //记住密码，自动登录
    public static function autoSignIn()
    {
        $authentication = Cookie::get('authentication');
        if (empty($authentication)) {
            return null;
        }
        $authentication = json_decode(CommonFacade::decode($authentication, 'authentication'));
        if (empty($authentication)) {
            return null;
        }
        $user = db('sys_user')->where(array("Id" => $authentication->Id, "Password" => $authentication->Password, "IsDel" => 0, "IsValid" => 1))->find();
        Session::set('Authentication', $user);
        return Session::get('Authentication');
    }
}
