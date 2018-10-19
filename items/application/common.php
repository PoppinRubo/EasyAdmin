<?php
use think\facade\Session;

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
 * 对象键名转化首字母小写或大写
 * @param $array 一、二维对象数组
 * @param bool $isLower 是否小写
 * @return array
 */
function convertInitials($array, $isLower = true)
{
    //转化,键名转换为首字母小写的驼峰命名
    if ($isLower) {
        $o = [];
        foreach ($array as $key => $value) {
            if (!is_array($value)) {
                $o[lcfirst($key)] = $value;
            } else {
                $d = [];
                foreach ($value as $k => $v) {
                    $d[lcfirst($k)] = $v;
                }
                $o[lcfirst($key)] = $d;
            }
        }
        return $o;
    }
    //还原,键名转换为首字母大写写的驼峰命名
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
 * 封装layui 表格数据
 * @param $array 对象数组
 * @param int $code 状态码
 * @param bool $convert 字段首字母是否转换小写
 * @param string $msg 返回消息
 * @return string
 */
function toLayTable($array, $convert = true, $code = 0, $msg = "")
{

    $result = array(
        "code" => $code,
        "msg" => $msg,
        "count" => count($array),
        "data" => $convert ? convertInitials($array) : $array,
    );
    echo json_encode($result);
}

/**
 * 封装easyui 表格数据
 * @param $array 对象数组
 * @param bool $convert 字段首字母是否转换小写
 * @return string
 */
function toEasyTable($array, $convert = true)
{

    $result = array(
        "total" => count($array),
        "rows" => $convert ? convertInitials($array) : $array,
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
