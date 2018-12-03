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
        return !empty(db('sys_user')->where(array("IsDel" => 0, "Account" => $account))->find());
    }

    //记住密码，自动登录
    public static function autoSignIn()
    {
        $authentication = Cookie::get('admin_authentication');
        if (empty($authentication)) {
            return null;
        }
        $authentication = json_decode(CommonFacade::decode($authentication, 'authentication'));
        if (empty($authentication)) {
            return null;
        }
        $user = db('sys_user')->where(array("Id" => $authentication->Id, "Password" => $authentication->Password, "IsDel" => 0, "IsValid" => 1))->find();
        Session::set('Authentication', $user);
        UserFacade::signInLog("记住密码登录");
        return Session::get('Authentication');
    }

    //记录登录日志
    public static function signInLog($remark)
    {
        $user = getUserAuthentication();
        if (!empty($user)) {
            // 启动事务
            db()->startTrans();
            try {
                $now = date("Y-m-d H:i:s");
                //创建登录记录
                db('sys_user_login_log')->insert(array(
                    "UserId" => $user['Id'],
                    "CreateTime" => $now,
                    "Remark" => $remark,
                    "Ip" => Request()->ip(),
                    "IsDel" => 0,
                ));
                //更新用户表
                db()->execute("UPDATE `sys_user` SET LoginTimes=(SELECT COUNT(t2.Id) FROM `sys_user_login_log` AS t2 WHERE t2.UserId IN ({$user['Id']}) AND t2.IsDel=0),LastLoginTime='{$now}' WHERE Id={$user['Id']}");
                // 提交事务
                db()->commit();
            } catch (Exception $e) {
                // 回滚事务
                db()->rollback();
            }
        }
    }
}
