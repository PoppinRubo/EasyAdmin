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
            if (request()->isGet()) {
                //get请求、页面访问强制跳至登录
                $this->redirect('/');
            } else {
                //post请求返回登录提示
                echo toJsonData(0, null, "未登录或登录已过期请重新登录再操作");
            }
            exit();
        }
    }
}
