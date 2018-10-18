<?php
namespace app\controller;

use think\Controller;
use think\facade\Request;

class Basic extends Controller
{
    /*
     *当前登录用户
     */
    protected $user;

    /**
     * 构造函数
     */
    public function __construct()
    {
        //防止构造函数覆盖了父类的构造函数,调用一下父类的构造函数
        parent::__construct();

        //检测登录状态
        $this->user = getUserAuthentication();
        if ($this->user == null) {
            //强行登录
            $this->error("未登录或登录已过期", "/");
        }
    }

    /**
     * 获取模块页配置按钮
     * @access protected
     * @return array
     */
    protected function getModuleButton()
    {
        //获取模块页面按钮是根据该模块请求路径查询数据库配置路径获取,请务必将数据库路径与其模块路径对应
        $url = Request::url();
        $button = db()->query("
        SELECT t2.Name,t2.EnglishName,t2.Icon FROM sys_module_button AS t1
        JOIN sys_button AS t2 ON(t2.Id=t1.ButtonId)
        JOIN sys_module AS t3 ON(t3.Link='{$url}')
        WHERE t1.IsValid=1 AND t1.IsDel=0 AND t1.ModuleId=t3.Id
        ORDER BY t2.Sort ASC");
        return $button;
    }
}
