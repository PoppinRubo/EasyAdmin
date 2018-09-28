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
 * 请求助手
 */
var askHelper = {
    //Ajax错误信息
    ajaxErrMsg: function(xhr, textStatus) {
        layer.msg("请求出现错误,错误状态码：" + textStatus);
    },
    //Post请求
    ajaxPost: function(url, data, success, fail, type = "POST") {
        success = success || function(result) {
            //表格刷新
            window.parent.tableHelper.refresh('data-table');
            //窗口关闭
            window.parent.layer.closeAll('iframe');
        };
        fail = fail || function(result) {};
        $.ajax({
            url: url,
            type: type, //GET、POST
            async: true, //或false,是否异步
            timeout: 6000, //超时时间
            data: data, //请求对象
            dataType: 'json', //返回的数据格式：json/xml/html/script/jsonp/text
            success: function(result) {
                if (result.code === 1) {
                    layer.msg(result.msg, {
                            time: 500,
                            icon: 1
                        },
                        function() {
                            success(result);
                        }
                    );
                } else {
                    layer.msg(result.msg, {
                            time: 2000,
                            icon: 5
                        },
                        function() {
                            fail(result);
                        }
                    );
                }
            },
            error: function(xhr, textStatus) {
                askHelper.ajaxErrMsg(xhr, textStatus);
            }
        });
    },
    // Get请求
    ajaxGet: function(url, data, success, fail) {
        askHelper.ajaxPost(url, data, success, fail, "GET");
    },
    //询问数据请求
    ajaxConfirm: function(url, data, msg, success, fail, type = "POST") {
        //询问
        var index = layer.confirm(msg + '？', {
                btn: ['确定', '取消'] //按钮
            },
            function() {
                //点击后立即关闭
                layer.close(index);
                askHelper.ajaxPost(url, data, success, fail, type);
            });
    }
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
    //表格刷新
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