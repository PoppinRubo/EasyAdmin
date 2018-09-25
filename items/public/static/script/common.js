/*
Ajax错误信息
*/
function ajaxErrMsg(xhr, textStatus) {
    layer.msg("请求出现错误,错误状态码：" + textStatus);
}
/*
表格高度适配
*/
function tableHeight(table = "table") {
    return parseInt($(window).height() - $("#" + table).offset().top - 50);
}