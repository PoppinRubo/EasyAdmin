<?php
namespace app\controller;

use think\Controller;

class Basic extends Controller
{
    public function __construct()
    {
        //防止构造函数覆盖了父类的构造函数,调用一下父类的构造函数
        parent::__construct();
        //检测登录状态
        if (getUserAuthentication() == null) {
            //强行登录
            $this->error("未登录或登录已过期", "/");
        }
    }
}
