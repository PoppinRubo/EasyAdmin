$(function() {
    //文本表单自动填充 placeholder
    $.each($(".layui-input-block").find("input[type='text'],textarea"), function(i, v) {
        if ($(this).data('auto')) {
            //使用同级表单label值
            $(this).attr('placeholder', "请输入" + $(this).parent().prev().html());
        }
    });
});

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
    //行选设置
    choose: function(tableId, tr) {
        var selection = tr.find("input[type='checkbox'],input[type='radio']");
        $.each(selection, function(i, v) {
            //点击一下渲染好的选框
            $(v).next().on("click", function(e) {
                //阻止事件冒泡
                e.stopPropagation();
            }).click();
        });
        //单选 选中状态设置
        if (selection.length > 0 && selection[0].type == "radio") {
            var cache = layui.table.cache[tableId];
            var index = tr.data("index");
            cache.forEach(function(v, i, a) {
                index === i ? v.LAY_CHECKED = true : delete v.LAY_CHECKED;
            });
        }
        //复选 选中状态设置
        if (selection.length > 0 && selection[0].type == "checkbox") {
            var cache = layui.table.cache[tableId];
            var checkbox = tr.offsetParent().find('input[name="layTableCheckbox"]');
            cache.forEach(function(v, i, a) {
                checkbox[i].checked ? v.LAY_CHECKED = true : delete v.LAY_CHECKED;
            });
        }
        //标注选中样式
        tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
    },
    refresh: function(tableId) {
        //点击当前页码来刷新表格数据
        $("#" + tableId).next().find(".layui-laypage-btn").click();
    }
};

/*
时间助手
*/
var timeHelper = {
    //格式化日期,使用方法 传入时间(可以是时间字符串)及格式(如 yyyy-MM-dd HH:mm:ss)
    formatDate: function(time, format) {
        if (typeof time === 'string') {
            time = time.replace(/-/g, '/').replace(/T/g, ' ');
            if (time.indexOf('.') > 0) {
                time = time.substring(0, time.indexOf('.'));
            }

            time = new Date(time);
        }
        var o = {
            'M+': time.getMonth() + 1, //月份
            'd+': time.getDate(), //日期
            'H+': time.getHours(), //小时
            'm+': time.getMinutes(), //分钟
            's+': time.getSeconds(), //秒
            'q+': Math.floor((time.getMonth() + 3) / 3), //quarter
            'S': time.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(format)) {
            format = format.replace(RegExp.$1, (time.getFullYear() + '').substr(4 - RegExp.$1.length));
        }
        for (var k in o) {
            if (new RegExp('(' + k + ')').test(format)) {
                format = format.replace(RegExp.$1,
                    RegExp.$1.length === 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));
            }
        }
        return format;
    }
}