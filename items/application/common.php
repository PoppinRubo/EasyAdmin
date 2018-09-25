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
    echo json_encode($result);
}

/**
 * 封装layui table格式
 * @param $array 对象数组
 * @param int $code 状态码
 * @param bool $convert 字段首字母转换小写
 * @param string $msg 返回消息
 * @return string
 */
function toTable($array, $convert = true, $code = 0, $msg = "")
{
    //字段转换为首字母小写的驼峰命名
    if ($convert) {
        $data = [];
        foreach ($array as $key => $value) {
            $d = [];
            foreach ($value as $k => $v) {
                $d[lcfirst($k)] = $v;
            }
            $data[] = $d;
        }
        $array = $data;
    }
    $result = array(
        "code" => $code,
        "msg" => $msg,
        "count" => count($array),
        "data" => $array,
    );
    echo json_encode($result);
}

/**
 * 用于验证当前登录状态,返回用户信息
 * @return bool|mixed
 */
function getUserAuthentication()
{
    return Session::get('Authentication');
}
