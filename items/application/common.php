<?php
/**
 * 封装需要的json格式
 * @param $code int 返回的状态码
 * @param null $data 输出数据
 * @param string $message 返回消息
 * @param $json bool 是否序列化json
 * @return string
 */
function toJsonData($code, $data = null, $message = "", $json = false)
{
    $result = array(
        "code" => $code,
        "data" => $data,
        "message" => $message,
    );
    $result = $json ? json_encode($result) : $result;
    return $result;
}
