<?php
namespace app\admin\controller;

use think\Controller;
use think\facade\Request;

class BasicController extends Controller
{

    //当前登录用户
    protected $user;

    //访问标识
    protected $accessToken;

    /**
     * 构造函数
     */
    public function __construct()
    {
        //防止构造函数覆盖了父类的构造函数,调用一下父类的构造函数
        parent::__construct();

        //访问标识
        $this->accessToken = (string) cookie("AdminAccessToken");
        if (empty($this->accessToken)) {
            $this->accessToken = strtoupper(md5(uniqid(microtime(true), true)));
            cookie("AdminAccessToken", $this->accessToken, 60 * 60 * 24 * 366);
        }

        //获取当前登录用户
        $this->user = $this->getUser();
        //登录检测，
        if (empty($this->user)) {
            //过滤登录页
            if (request()->controller() != 'Index') {
                if (request()->isPost()) {
                    //Post请求返回登录过期信息
                    echo json_encode(array(
                        "rows" => 0,
                        "code" => 403,
                        "msg" => "当前登录账号已过期，请重新登录",
                    ));
                    exit();
                } else {
                    //其他请求跳登录页面
                    $this->redirect("/");
                }
            }
        }
    }

    /**
     * 用于验证当前登录状态,返回用户信息
     * @return bool|mixed
     */
    protected function getUser()
    {
        $user = cache('user.' . $this->accessToken);
        return $user;
    }

    /**
     * 设置用户登录信息
     */
    protected function setUser($user, $day = 1)
    {
        cache('user.' . $this->accessToken, $user, 60 * 60 * 24 * $day);
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
        $userId = $this->user["Id"];
        $button = db()->query("
        SELECT t1.Name,t1.EnglishName,t1.Icon FROM sys_button AS t1
        JOIN sys_module AS t2 ON(t2.Link='{$url}' AND t2.IsValid=1 AND t2.IsDel=0)
        JOIN sys_role_button AS t3 ON(t3.ModuleId=t2.Id AND t3.ButtonId=t1.Id AND t3.RoleId IN (
        SELECT t4.RoleId FROM sys_user_role AS t4 WHERE t4.UserId={$userId} AND t4.IsValid=1 AND t4.IsDel=0
        )) AND t3.IsValid=1 AND t3.IsDel=0 WHERE t1.IsValid=1 AND t1.IsDel=0 AND t1.Id=t3.ButtonId GROUP BY t1.Id ORDER BY t1.Sort ASC;");
        return $button;
    }
}
