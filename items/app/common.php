<?php

/**
 * 封装需要的json格式
 * @param $code int 返回的状态码
 * @param string $msg 返回消息
 * @param null $data 输出数据
 * @return string
 */
function jsonOut($code, $msg = "", $data = null, bool $convert = null)
{
    //驼峰输出优先使用传入的条件
    if ($convert !== null) {
        $data = $convert ? convertCamelize($data) : $data;
    } else {
        //配置是否驼峰输出
        if (!empty(config('app.camelize'))) {
            $data = convertCamelize($data);
        }
    }
    $result = [
        "code" => $code,
        "data" => $data,
        "msg" => $msg,
        "serveTime" => date('Y-m-d H:i:s'),
    ];
    return json($result);
}

/**
 * 数组键名转化首字母小写驼峰命名
 * @param $array 多维对象数组
 * @return array
 */
function convertCamelize($array)
{
    if ((!is_array($array) && !is_object($array)) || empty($array)) {
        return $array;
    }
    //键名转换为首字母小写的驼峰命名
    $o = [];
    //一维
    foreach ($array as $key => $value) {
        if (!is_array($value)) {
            $o[camelize($key)] = $value;
        } else {
            $d = [];
            //二维
            foreach ($value as $k => $v) {
                if (!is_array($v)) {
                    $d[camelize($k)] = $v;
                } else {
                    //多维
                    $d[camelize($k)] = convertCamelize($v);
                }
            }
            $o[camelize($key)] = $d;
        }
    }
    return $o;
}

/**
 * 下划线命名转驼峰命名
 */
function camelize($words, $separator = '_')
{
    $words = $separator . str_replace($separator, " ", strtolower($words));
    return ltrim(str_replace(" ", "", ucwords($words)), $separator);
}

/**
 * 驼峰命名转下划线命名
 */
function uncamelize($camelCaps, $separator = '_')
{
    return strtolower(preg_replace('/([a-z])([A-Z])/', "$1" . $separator . "$2", $camelCaps));
}

/**
 * 获取空值模型
 * @param $tableName 数据库表名
 * @return array
 */
function getEmptyModel(String $tableName)
{
    $fields = think\facade\Db::name($tableName)->getFieldsType();
    $o = [];
    foreach ($fields as $key => $value) {
        //设置值为空
        $o[camelize($key)] = null;
    }
    return $o;
}

/**
 * 写入错误日志
 * @param $message 错误信息
 */
function errorJournal(String $message)
{
    $param = json_encode(input(), JSON_UNESCAPED_UNICODE);
    //记录参数及请求路径便于发现排查问题
    $error = $message . '[请求路径：' . request()->url() . ',请求参数：' . $param . ']';
    trace($error, 'error');
}
