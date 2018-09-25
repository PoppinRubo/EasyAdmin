/*
Ajax错误信息
*/
function ajaxErrMsg(xhr, textStatus) {
    layer.msg("请求出现错误,错误状态码：" + textStatus);
}
/*
Table高度shipei
*/
function tableHeight(table = "table") {
    return parseInt($(window).height() - $("#" + table).offset().top - 50);
}