<?php
/**
 * 封装easyui 表格数据
 * @param $array 对象数组
 * @param bool $convert 字段首字母是否转换小写
 * @return string
 */
function toEasyTable($array, $total = 0, $convert = true, $msg = "")
{
    $result = array(
        "total" => is_object($array) ? $array->total() : $total,
        "rows" => $convert ? convertLower($array) : $array,
        "msg" => $msg,
    );
    echo json_encode($result);
}
