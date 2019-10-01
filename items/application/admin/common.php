<?php
/**
 * 封装easyui 表格数据
 * @param array $array 对象数组
 * @param int $total 数据总数
 * @param string $total 返回消息
 * @param bool $convert 字段首字母是否转换小写
 * @return string
 */
function toEasyTable($array, $total = 0, $msg = "", bool $convert = null)
{
    //计算数据条数
    $total = is_object($array) ? $array->total() : $total;
    //驼峰小写输出优先使用传入的条件
    if ($convert !== null) {
        $array = $convert ? convertLower($array) : $array;
    } else {
        //配置是否驼峰小写输出
        if (!empty(config('app.lower_hump'))) {
            $array = convertLower($array);
        }
    }
    $result = array(
        "total" => $total,
        "rows" => $array,
        "msg" => $msg,
        "serveTime" => date('Y-m-d H:m:s'),
    );
    echo json_encode($result);
}
