<?php
namespace app\admin\controller;

use app\common\facade\UserFacade;
use think\captcha\Captcha;

class IndexController extends BasicController
{
    //登录 view
    public function index()
    {
        //检测登录状态,已登录不停留在登录页面
        if (empty($this->user)) {
            $this->assign([
                'year' => date('Y'),
                'ajaxUrl' => config('app.admin_ajax_url') ?? '',
            ]);
            return View();
        }
        $this->redirect('/home');
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
            $user = db('sys_user')->where(["Account" => input("account"), "Password" => $password])->find();
            if (empty($user)) {
                return jsonOut(config('code.error'), "登录失败,账号或密码错误");
            }
            if ($user['IsDel']) {
                return jsonOut(config('code.error'), "账号已删除,请联系管理员");
            }
            if (!$user['IsValid']) {
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
            UserFacade::signInLog($user['Id']);
            return jsonOut(config('code.success'), "登录成功", "/home");
        } catch (\Exception $e) {
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }

    //生成验证码
    public function captcha()
    {
        $captcha = new Captcha();
        //验证码位数
        $captcha->length = 4;
        //验证成功后是否重置
        $captcha->reset = true;
        //验证码字体大小(px)
        $captcha->fontSize = 17;
        //验证码过期时间（s）
        $captcha->expire = 120;
        //验证码图片宽度，设置为0为自动计算
        $captcha->imageW = 120;
        //验证码图片高度，设置为0为自动计算
        $captcha->imageH = 40;
        // 设置验证码字符为纯数字
        $captcha->codeSet = '0123456789';
        return $captcha->entry('signIn');
    }

    //检测输入的验证码是否正确
    private function checkCaptcha($code)
    {
        $captcha = new Captcha();
        return $captcha->check($code, 'signIn');
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
            return jsonOut(config('code.error'), $e->getMessage());
        }
    }
}
