<?php
namespace app\common\facade;

use think\facade\Db;

class UserFacade
{

    //检测账号是否存在
    public static function isExist($account)
    {
        return !empty(Db::name('sys_user')->where(array("is_del" => 0, "Account" => $account))->find());
    }

    //记录登录日志
    public static function signInLog(int $userId)
    {
        if (!empty($userId)) {
            // 启动事务
            Db::startTrans();
            try {
                $now = date("Y-m-d H:i:s");
                //创建登录记录
                Db::name('sys_user_login_log')->insert(array(
                    "user_id" => $userId,
                    "create_time" => $now,
                    "ip" => Request()->ip(),
                    "is_del" => 0,
                ));
                //更新用户表
                Db::execute("UPDATE `sys_user` SET LoginTimes=(SELECT COUNT(t2.id) FROM `sys_user_login_log` AS t2 WHERE t2.user_id IN ({$userId}) AND t2.is_del=0),LastLoginTime='{$now}' WHERE id={$userId}");
                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
            }
        }
    }
}
