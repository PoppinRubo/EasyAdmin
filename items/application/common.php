<?php
use app\common\facade\UserFacade;

/**
 * 封装需要的json格式
 * @param $code int 返回的状态码
 * @param string $msg 返回消息
 * @param null $data 输出数据
 * @return string
 */
function jsonOut($code, $msg = "", $data = null)
{
    //是否驼峰小写输出
    if (empty(config('app.lower_hump'))) {
        $data = convertLower($data);
    }
    $result = array(
        "code" => $code,
        "data" => $data,
        "msg" => $msg,
    );
    echo json_encode($result);
}

/**
 * 数组键名转化首字母小写
 * @param $array 多维对象数组
 * @return array
 */
function convertLower($array)
{
    if ((!is_array($array) && !is_object($array)) || empty($array)) {
        return $array;
    }
    //键名转换为首字母小写的驼峰命名
    $o = [];
    //一维
    foreach ($array as $key => $value) {
        if (!is_array($value)) {
            $o[lcfirst($key)] = $value;
        } else {
            $d = [];
            //二维
            foreach ($value as $k => $v) {
                if (!is_array($v)) {
                    $d[lcfirst($k)] = $v;
                } else {
                    //多维
                    $d[lcfirst($k)] = convertLower($v);
                }
            }
            $o[lcfirst($key)] = $d;
        }
    }
    return $o;
}

/**
 * 对象键名转化首字母大写
 * @param $array 一、二维对象数组
 * @return array
 */
function convertToupper($array)
{
    //键名转换为首字母大写写的驼峰命名
    $o = [];
    foreach ($array as $key => $value) {
        if (!is_array($value)) {
            $o[ucfirst($key)] = $value;
        } else {
            $d = [];
            foreach ($value as $k => $v) {
                $d[ucfirst($k)] = $v;
            }
            $o[lcfirst($key)] = $d;
        }
    }
    return $o;
}

/**
 * 用于验证当前登录状态,返回用户信息
 * @return bool|mixed
 */
function getUserAuthentication()
{
    $user = session('Authentication');
    $user = empty($user) ? (UserFacade::autoSignIn()) : $user;
    return $user;
}

/**
 * 获取空值模型
 * @return array
 */
function getEmptyModel($modelName)
{
    $fields = model($modelName)->getFieldsType();
    $o = [];
    foreach ($fields as $key => $value) {
        //设置值为空
        $o[$key] = null;
    }
    return $o;
}
