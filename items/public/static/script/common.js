$(function() {
    //文本表单自动填充 placeholder
    $.each($(".layui-input-block").find("input,textarea"), function(i, v) {
        if ($(this).data('auto')) {
            //使用同级表单label值
            $(this).attr('placeholder', "请输入" + $(this).parent().prev().html());
        }
    });

    //处理开关未点击状态下的值设置为0或1
    $.each($('input[lay-skin="switch"]'), function(i, v) {
        $(v).val(this.checked ? 1 : 0);
    });
    //处理开关点击状态下的值设置为0或1
    layui.use(['form'], function() {
        var form = layui.form;
        //表单开关值处理
        form.on('switch', function(data) {
            $(data.elem).attr('type', 'hidden').val(this.checked ? 1 : 0);
        });
    });
    //处理easyui表格右边框超出隐藏问题
    $(".datagrid-wrap").css({ width: parseInt($(".datagrid-wrap").width() - 2) + "px" });

    //搜索框回车搜索
    $(".search input").keydown(function(e) {
        if (e.keyCode == 13) {
            $(this).parent().next('button').click();
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
            //非开窗口刷新的处理
            if (window.parent.isHome) {
                //表格刷新
                tableHelper.refresh('data-table');
                return;
            }
            //父级表格刷新
            window.parent.tableHelper.refresh('data-table');
            //窗口关闭
            window.parent.layer.closeAll('iframe');
        };
        var msgIndex = 0;
        o.fail = o.fail || function(result) {};
        o.type = o.type || "POST";
        o.data = o.data || {};
        o.dataType = o.dataType || "json";
        o.before = o.before || function() { msgIndex = layer.msg('处理中', { icon: 16, shade: 0.5, time: 86400 * 1000 }); }
        o.original = o.original || false;
        $.ajax({
            url: o.url, //请求接口
            type: o.type, //GET、POST
            async: true, //或false,是否异步
            timeout: 6000, //超时时间
            data: o.data, //请求对象
            dataType: o.dataType, //返回的数据格式：json/xml/html/script/jsonp/text
            beforeSend: function(xhr) { o.before(xhr); }, //请求前方法
            success: function(result) {
                //是否直接返回结果
                if (o.original) {
                    //关闭加载
                    if (msgIndex) {
                        layer.close(layer.msg());
                    }
                    return o.success(result);
                }
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
        o.cancel = o.cancel || function() {};
        //询问
        var index = layer.confirm(o.msg + '？', {
                btn: ['确定', '取消'] //按钮
            },
            function() {
                //确认
                layer.close(index);
                askHelper.ajaxPost(o);
            },
            function() {
                //取消
                layer.close(index);
                o.cancel();
            });
    }
}
/*
表格助手
*/
var tableHelper = {
    //高度适配
    setHeight: function(unit = true) {
        var height = parseInt($(window).height() - $(".admin-card-header-auto").height() - 45);
        return unit ? height + "px" : height;
    },
    //easyUI表格刷新
    refresh: function(tableId) {
        var table = $("#" + tableId);
        //树形表格
        if (table.closest(".datagrid-view").find(".treegrid-tr-tree").length > 0) {
            table.treegrid('reload');
            return;
        }
        table.datagrid('reload');
    },
    createButton: function(object, value) {
        //表格按钮创建助手
        var btn = "",
            btnList = object,
            layuiBtn = "layui-btn layui-btn-xs",
            style = ["layui-btn-primary", "", "layui-btn-normal", "layui-btn-warm", "layui-btn-danger", "layui-btn-disabled"];
        //参数是否为对象,为对象转json string装入dom
        if (typeof value == "object") {
            value = JSON.stringify(value).replace(/\"/g, "'");
        }
        for (var b in btnList) {
            if (btnList.hasOwnProperty(b)) {
                var genre = layuiBtn + " " + (style[btnList[b][1]] || "");
                //按钮设置值
                var data = btnList[b][2] || "";
                btn += '<a href="javascript:void(0);" data=\'' + data + '\' ondblclick="console.log("禁止双击");return false;" onclick="' + b + "(" + value + ',this);"' +
                    'class="' + genre + '">' + btnList[b][0] + "</a>";
            }
        }
        //点击按钮不点击行
        setTimeout(function() {
            $("table .layui-btn").click(function(e) {
                e.stopPropagation();
            });
        }, 1000);
        return btn;
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

/**
 * 图片助手
 */
var pictureHelper = {
    showBig: function(t, z) {
        z = z || 1;
        var width = parseInt(t.naturalWidth * z);
        var height = parseInt(t.naturalHeight * z);
        var scale = width / height;
        //超宽处理
        if (width > $(window).width()) {
            width = $(window).width() - 20;
        }
        //超高处理
        if (height > $(window).height()) {
            height = $(window).height() - 20;
            width = height * scale;
        }
        layer.open({
            type: 1,
            title: false,
            closeBtn: 0,
            area: width + 'px',
            skin: 'layui-layer-nobg', //没有背景色
            shadeClose: true,
            content: '<img src="' + t.src + '" width="' + width + '" height="' + height + '"> '
        });
        $(".layui-layer-content img").click(function() {
            $(".layui-layer-shade").click();
        });
    },
    error: function(t, s = false) {
        if (s) {
            t.parentElement.innerHTML = '图片损坏或不存在';
        } else {
            t.parentElement.innerHTML = '';
        }
    }
}