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