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
    //ajax 误处理
    ajaxError: function(xhr, textStatus, error) {
        error = error || function() {};
        var msg = "请求出现错误,状态码:" + xhr.status + ",描述:" + textStatus;
        layer.msg(msg, { time: 3000, icon: 5 }, function() { error(); });
    },
    //Post请求
    ajaxPost: function(o) {
        o.success = o.success || function(result) {
            //表格刷新
            window.parent.tableHelper.refresh('data-table');
            //窗口关闭
            window.parent.layer.closeAll('iframe');
        };
        o.fail = o.fail || function(result) {
            layer.msg(result.msg, { time: 2000, icon: 5 });
        };
        o.type = o.type || "POST";
        o.data = o.data || {};
        o.dataType = o.dataType || "json";
        o.before = o.before || function() { layer.msg('处理中', { icon: 16, shade: 0.5 }); }
        $.ajax({
            url: o.url, //请求接口
            type: o.type, //GET、POST
            async: true, //或false,是否异步
            timeout: 6000, //超时时间
            data: o.data, //请求对象
            dataType: o.dataType, //返回的数据格式：json/xml/html/script/jsonp/text
            beforeSend: function() { o.before(); }, //请求前方法
            success: function(result) {
                if (result.code === 1) {
                    layer.msg(result.msg, { time: 500, icon: 1 }, function() { o.success(result); });
                } else {
                    layer.msg(result.msg, { time: 2000, icon: 5 }, function() { o.fail(result); });
                }
            },
            error: function(xhr, textStatus) {
                askHelper.ajaxError(xhr, textStatus, o.error);
            }
        });
    },
    // Get请求
    ajaxGet: function(o) {
        o.type = "GET";
        askHelper.ajaxPost(o);
    },
    //询问数据请求
    ajaxConfirm: function(o) {
        //询问
        var index = layer.confirm(o.msg + '？', {
                btn: ['确定', '取消'] //按钮
            },
            function() {
                //点击后立即关闭
                layer.close(index);
                askHelper.ajaxPost(o);
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
    choose: function(tableId, tr, isSelection = true) {
        //是否开启行选选中复选框、单选框
        if (isSelection) {
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