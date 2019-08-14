<?php
namespace app\controller;

use app\facade\CommonFacade;
use app\facade\UserFacade;
use think\captcha\Captcha;
use think\Controller;
use think\Exception;
use think\facade\Cookie;
use think\facade\Session;

class IndexController extends Controller
{
    //登录 view
    public function index()
    {
        //检测登录状态,已登录不停留在登录页面
        if (getUserAuthentication() == null) {
            $this->assign('year', date('Y'));
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
            //明文密码加密比对
            $password = md5(input("password"));
            $user = db('sys_user')->where(array("Account" => input("account"), "Password" => $password))->find();
            if ($user == null) {
                return toJsonData(0, null, "登录失败,账号或密码错误");
            }
            if ($user['IsDel']) {
                return toJsonData(0, null, "账号已删除,请联系管理员");
            }
            if (!$user['IsValid']) {
                return toJsonData(0, null, "账号无效,请联系管理员");
            }
            Session::set('Authentication', $user);
            if (getUserAuthentication() == null) {
                return toJsonData(0, null, "登录失败,请联系管理员");
            }
            //记住登录
            if (!empty(input('remember'))) {
                $authentication = CommonFacade::encode(json_encode(array('Id' => $user["Id"], 'Password' => $user["Password"])), 'authentication');
                Cookie::set('admin_authentication', $authentication, (60 * 60 * 24 * 7));
            }
            //登录日志
            UserFacade::signInLog("账号密码登录");
            return toJsonData(1, "/home", "登录成功");
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }

    //过期再次登录
    public function againSignIn()
    {
        try {
            if (request()->isGet()) {
                return toJsonData(0, null, "不被接受的请求", true);
            }
            //明文密码加密比对
            $password = md5(input("password"));
            $user = db('sys_user')->where(array("Account" => input("account"), "Password" => $password))->find();
            if ($user == null) {
                return toJsonData(0, null, "登录失败,账号或密码错误");
            }
            if ($user['IsDel']) {
                return toJsonData(0, null, "账号已删除,请联系管理员");
            }
            if (!$user['IsValid']) {
                return toJsonData(0, null, "账号无效,请联系管理员");
            }
            Session::set('Authentication', $user);
            if (getUserAuthentication() == null) {
                return toJsonData(0, null, "登录失败,请联系管理员");
            }
            //登录日志
            UserFacade::signInLog("账号密码登录");
            return toJsonData(1, null, "登录成功");
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
            if (!empty(getUserAuthentication())) {
                //删除登录信息session
                Session::delete("Authentication");
                //删除记住登录cookie记录
                Cookie::delete('admin_authentication');
                if (!empty(getUserAuthentication())) {
                    return toJsonData(0, null, "退出时出现问题，请稍后重试！");
                }
                return toJsonData(1, "/", "退出成功");
            } else {
                return toJsonData(1, "/", "退出成功");
            }
        } catch (Exception $e) {
            return toJsonData(0, null, $e->getMessage());
        }
    }
}
