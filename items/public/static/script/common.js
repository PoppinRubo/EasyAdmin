/*
Ajax错误信息
*/
function ajaxErrMsg(xhr, textStatus) {
    layer.msg("请求出现错误,错误状态码：" + textStatus);
}