<?php
namespace app\controller;

use think\Controller;

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
     * 获取模块按钮
     * @access protected
     * @param  int $moduleId 模块编号
     * @return button
     */
    protected function getModuleButton($moduleId)
    {
        $button = db('sys_module_button')->query("
        SELECT t2.Name,t2.EnglishName FROM sys_module_button AS t1
        JOIN sys_button AS t2 ON(t2.Id=t1.ButtonId)
        WHERE t1.IsValid=1 AND t1.IsDel=0 AND t1.ModuleId=1
        ORDER BY t2.Sort ASC");
    }
}
