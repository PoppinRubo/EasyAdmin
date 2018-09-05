<?php
namespace app\admin\controller;

use think\captcha\Captcha;
use think\Controller;

class Login extends Admin
{
    public function index()
    {
        return View();
    }

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
        return $captcha->entry();
    }
}
