/*
Ajax错误信息
*/
function ajaxErrMsg(xhr, textStatus) {
    layer.msg("请求出现错误,错误状态码：" + textStatus);
}
/*
表格助手
*/
var tableHelper = {
    //高度适配
    setHeight: function(table = "data-table") {
        return parseInt($(window).height() - $("#" + table).offset().top - 35);
    },
    choose: function(tr) {
        var selection = tr.find("input[type='checkbox'],input[type='radio']");
        $.each(selection, function(i, v) {
            //点击一下渲染好的选框
            $(v).next().on("click", function(e) {
                //阻止事件冒泡
                e.stopPropagation();
            }).click();
        });
        //标注选中样式
        tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
    }
};