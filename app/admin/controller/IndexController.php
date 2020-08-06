<?php

namespace app\admin\controller;

use app\common\facade\UserFacade;
use think\captcha\facade\Captcha;
use think\facade\Db;
use think\facade\View;

class IndexController extends BasicController
{
    //登录 view
    public function index()
    {
        //检测登录状态,已登录不停留在登录页面
        if (empty($this->user)) {
            //模板赋值
            View::assign(['year' => date('Y')]);
            //模板输出
            return View::fetch();
        }
        return redirect('/home');
    }

    //登录
    public function signIn()
    {
        try {
            if (request()->isGet()) {
                return jsonOut(config('code.error'), "不被接受的请求");
            }
            //过期登录免验证码
            if (empty(cookie('expire'))) {
                if (!$this->checkCaptcha(input('vercode'))) {
                    return jsonOut(config('code.error'), "登录失败,验证码错误或已过期");
                }
            }
            cookie('expire', null);
            //明文密码加密比对
            $password = md5(input("password"));
            $user = Db::name('sys_user')->where(["account" => input("account"), "password" => $password])->find();
            if (empty($user)) {
                return jsonOut(config('code.error'), "登录失败,账号或密码错误");
            }
            if ($user['is_del']) {
                return jsonOut(config('code.error'), "账号已删除,请联系管理员");
            }
            if (!$user['is_valid']) {
                return jsonOut(config('code.error'), "账号无效,请联系管理员");
            }
            //登录过期时间默认3天
            $day = 3;
            //记住登录状态
            if (!empty(input('remember'))) {
                //记住30天
                $day = 30;
            }
            //记录登录信息
            $this->setUser($user, $day);
            //登录日志
            UserFacade::signInLog($user['id']);
            return jsonOut(config('code.success'), "登录成功", "/home");
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }

    //生成验证码
    public function captcha()
    {
        return Captcha::create('number');
    }

    //检测输入的验证码是否正确
    private function checkCaptcha($code)
    {
        return Captcha::check($code);
    }

    //退出登录
    public function signOut()
    {
        try {
            if (!empty($this->user)) {
                //删除登录信息
                $this->setUser(null);
            }
            return jsonOut(config('code.success'), "退出成功", "/");
        } catch (\Exception $e) {
            errorJournal($e->getMessage());
            return jsonOut(config('code.error'), '出现错误,请联系管理员');
        }
    }
}
