<?php
use think\Session;
/**
 * 封装需要的json格式
 * @param $code int 返回的状态码
 * @param null $data 输出数据
 * @param string $msg 返回消息
 * @return string
 */
function toJsonData($code, $data = null, $msg = "")
{
    $result = array(
        "code" => $code,
        "data" => $data,
        "msg" => $msg,
    );
    return json_encode($result);
}

/**
 * 用于验证当前登录状态,返回用户信息
 * @return bool|mixed
 */
function getUserAuthentication()
{
    return Session::get('Authentication');
}
