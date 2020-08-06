<?php
namespace app\admin\middleware;

//用户未登录授权,中间件处理
class NoAuthorization
{
    /**
     * 处理请求
     * @param \think\Request $request
     * @param \Closure $next
     * return Response
     */
    public function handle($request, \Closure $next)
    {
        //过滤登录页
        if ($request->controller() != 'Index') {
            if ($request->isPost()) {
                //Post请求返回json信息
                $data = json_encode([
                    "rows" => 0,
                    "code" => 403,
                    "msg" => "当前登录账号已过期，请重新登录",
                ]);
                //响应输出
                return response($data);
            } else {
                //跳登录页面
                return redirect("/");
            }
        }
        // 继续执行进入到控制器
        return $next($request);
    }
}
