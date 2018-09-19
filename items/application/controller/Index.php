<?php
namespace app\controller;

use think\captcha\Captcha;
use think\Controller;
use think\Exception;
use think\Session;

class Index extends Controller
{
    //登录 view
    public function index()
    {
        //检测登录状态,已登录不停留在登录页面
        if (getUserAuthentication() == null) {
            return View();
        }
        $this->redirect('/home');
    }

    //登录
    public function signIn()
    {
        try {
            if (request()->isGet()) {
                return toJsonData(0, null, "不被接受的请求", true);
            }
            if (!$this->checkCaptcha(input('vercode'))) {
                return toJsonData(0, null, "登录失败,验证码错误或已过期");
            }
            $user = db('sys_user')->where(array("Account" => input("account"), "Password" => input("password"), "IsDel" => 0))->find();
            if ($user == null) {
                return toJsonData(0, null, "登录失败,账号或密码错误");
            }
            if (!$user['IsValid']) {
                return toJsonData(0, null, "账号无效,请联系管理员");
            }
            Session::set('Authentication', $user);
            if (getUserAuthentication() == null) {
                return toJsonData(0, null, "登录失败,请联系管理员");
            }
            return toJsonData(1, "/home", "登录成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
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
            if (getUserAuthentication() != null) {
                // 清除session（当前作用域）
                Session::clear();
                if (getUserAuthentication() != null) {
                    return toJsonData(0, null, "退出时出现问题，请稍后重试！");
                }
                //清理cookie记录,马上过期
                if (setcookie("autoSignIn", "Clear", time(), "/")) {
                    return toJsonData(1, null, "退出成功");
                } else {
                    return toJsonData(0, null, "记住密码清除失败,可手动清理浏览器cookie");
                }
            } else {
                return toJsonData(1, null, "退出成功");
            }
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }
}
