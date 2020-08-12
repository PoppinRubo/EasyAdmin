$(function () {
    //表单配置
    $.each($(".layui-input-block").find("input,textarea"), function (i, v) {
        //文本表单自动填充 placeholder
        if ($(this).data('auto')) {
            //使用同级表单label值
            $(this).attr('placeholder', "请输入" + $(this).parent().prev().html());
        }
        //必填表单显示必填标志
        var verify = $(this).attr('lay-verify');
        if (verify && verify.indexOf("required") > -1) {
            var item = $(this).parents('.layui-form-item');
            var label = item.find('.layui-form-label');
            //设置必填class
            label.addClass('icon-required');
        }
    });

    //处理开关未点击状态下的值设置为0或1
    $.each($('input[lay-skin="switch"]'), function (i, v) {
        $(v).attr('type', 'hidden').val(this.checked ? 1 : 0);
    });
    //处理复选框未点击状态下的值设置为0或1
    $.each($('.layui-input-block input[type="checkbox"]'), function (i, v) {
        $(v).val(this.checked ? 1 : 0);
    });
    //处理开关点击状态下的值设置为0或1
    layui.use(['form'], function () {
        var form = layui.form;
        //表单开关值处理
        form.on('switch', function (data) {
            $(data.elem).attr('type', 'hidden').val(this.checked ? 1 : 0);
        });
        //表单复选框值处理
        form.on('checkbox', function (data) {
            $(data.elem).val(this.checked ? 1 : 0);
        });
    });
    //处理easyui表格右边框超出隐藏问题
    $(".datagrid-wrap").css({
        width: parseInt($(".datagrid-wrap").width() - 2) + "px"
    });

    //搜索框回车搜索
    $(".search input").keydown(function (e) {
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
    ajaxError: function (xhr, textStatus, error) {
        error = error || function () {};
        var msg = "请求出现错误,状态码:" + xhr.status + ",描述:" + textStatus;
        layer.msg(msg, {
            time: 3000,
            icon: 5
        }, function () {
            error();
        });
    },
    //Post请求
    ajaxPost: function (o) {
        o.success = o.success || function (result) {
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
        o.fail = o.fail || function (result) {};
        o.type = o.type || "POST";
        o.data = o.data || {};
        o.dataType = o.dataType || "json";
        o.timeout = o.timeout || 6000;
        o.before = o.before || function () {
            msgIndex = layer.msg('处理中', {
                icon: 16,
                shade: 0.5,
                time: 86400 * 1000
            });
        }
        o.original = o.original || false;
        $.ajax({
            url: o.url, //请求接口
            type: o.type, //GET、POST
            async: true, //或false,是否异步
            timeout: o.timeout, //超时时间
            data: o.data, //请求对象
            dataType: o.dataType, //返回的数据格式：json/xml/html/script/jsonp/text
            beforeSend: function (xhr) {
                o.before(xhr);
            }, //请求前方法
            success: function (result) {
                //是否直接返回结果
                if (o.original) {
                    //关闭加载
                    if (msgIndex) {
                        layer.close(layer.msg());
                    }
                    return o.success(result);
                }
                if (result.code === 1) {
                    layer.msg(result.msg, {
                        time: 500,
                        icon: 1
                    }, function () {
                        o.success(result);
                    });
                } else {
                    layer.msg(result.msg, {
                        time: 2000,
                        icon: 5
                    }, function () {
                        o.fail(result);
                    });
                }
            },
            error: function (xhr, textStatus) {
                askHelper.ajaxError(xhr, textStatus, o.error);
            }
        });
    },
    // Get请求
    ajaxGet: function (o) {
        o.type = "GET";
        askHelper.ajaxPost(o);
    },
    //询问数据请求
    ajaxConfirm: function (o) {
        o.cancel = o.cancel || function () {};
        //询问
        var index = layer.confirm(o.msg + '？', {
                btn: ['确定', '取消'] //按钮
            },
            function () {
                //确认
                layer.close(index);
                askHelper.ajaxPost(o);
            },
            function () {
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
    setHeight: function (unit = true) {
        var height = parseInt($(window).height() - $(".admin-card-header-auto").height() - 45);
        return unit ? height + "px" : height;
    },
    //表格行数适配
    setPage: function (p) {
        var header = $(".admin-card-header-auto");
        if (!header || header.length <= 0) {
            return p;
        }
        var height = parseInt($(window).height() - header.height() - 45);
        var toolbar = $("#toolbar").length <= 0 ? 0 : $("#toolbar").outerHeight();
        var viewHeight = height - toolbar;
        var pageSize = parseInt((viewHeight - 65) / 35);
        //页码容量列表
        if (Array.isArray(p)) {
            p.push(pageSize);
            //去重并排序
            return Array.from(new Set(p)).sort(function (a, b) {
                return a - b;
            });
        }
        return pageSize;
    },
    //easyUI表格刷新
    refresh: function (tableId) {
        var table = $("#" + tableId);
        //树形表格
        if (table.closest(".datagrid-view").find(".treegrid-tr-tree").length > 0) {
            table.treegrid('reload');
            return;
        }
        table.datagrid('reload');
    },
    createButton: function (object, value, clickRow = true) {
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
        if (!clickRow) {
            setTimeout(function () {
                $("table .layui-btn").click(function (e) {
                    e.stopPropagation();
                });
            }, 1000);
        }
        return btn;
    }
};

/*
时间助手
*/
var timeHelper = {
    //格式化日期,使用方法 传入时间(可以是时间字符串)及格式(如 yyyy-MM-dd HH:mm:ss)
    formatDate: function (time, format) {
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
    },
    //将秒转化为时、分、秒格式,如120秒转化为00:02:00
    secondToTime: function (value) {
        var second = parseInt(value); //秒
        var minute = 0; //分
        var hour = 0; //时
        if (second > 60) {
            minute = parseInt(second / 60);
            second = parseInt(second % 60);
            if (minute > 60) {
                hour = parseInt(minute / 60);
                minute = parseInt(minute % 60);
            }
        };
        var varietySecond = parseInt(second);
        if (varietySecond < 10) {
            varietySecond = '0' + varietySecond
        }
        var results = "" + varietySecond;
        if (minute > 0 || minute == 0) {
            var varietyMinute = parseInt(minute);
            if (varietyMinute < 10) {
                varietyMinute = '0' + varietyMinute;
            }
            results = "" + varietyMinute + ":" + results;
        }
        if (hour > 0 || hour == 0) {
            var varietyHour = parseInt(hour);
            if (varietyHour < 10) {
                varietyHour = '0' + varietyHour;
            }
            results = "" + varietyHour + ":" + results;
        }
        return results;
    }
}

/**
 * 图片助手
 */
var pictureHelper = {
    showBig: function (t, z) {
        z = z || 1;
        //获取原图尺寸
        var image = new Image();
        //是否设置原图地址
        image.src = t.getAttribute('original') || t.src;
        image.onload = function () {
            var width = parseInt(image.width * z);
            var height = parseInt(image.height * z);
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
                content: '<img src="' + image.src + '" width="' + width + '" height="' + height + '"> '
            });
            $(".layui-layer-content img").click(function () {
                $(".layui-layer-shade").click();
            });
        }
    },
    error: function (t, s = false) {
        if (s) {
            t.parentElement.innerHTML = '图片损坏或不存在';
        } else {
            t.parentElement.innerHTML = '';
        }
    }
}

/**
 * 数字助手
 */
var figuresHelper = {
    //长数字转化中文缩略,如转化为100万
    longConvert: function (curentNum) {
        var strNumSize = function (tempNum) {
            var stringNum = tempNum.toString();
            var index = stringNum.indexOf(".");
            var newNum = stringNum;
            if (index != -1) {
                newNum = stringNum.substring(0, index)
            };
            return newNum.length;
        }
        var units = ["", "万", "亿", "万亿"];
        var dividend = 10000;
        //转换数字
        var curentUnit = units[0];
        //转换单位 
        for (var i = 0; i < 4; i++) {
            curentUnit = units[i];
            if (strNumSize(curentNum) < 5) {
                break;
            };
            curentNum = curentNum / dividend;
        };
        var result = {
            num: parseFloat(curentNum.toFixed(1).replace('.0', '')),
            unit: curentUnit
        };
        return result;
    }
}

/**
 * html助手
 */
var htmlHelper = {
    //使用此方式获取html标签为文本,避免执行脚本，防止xxs攻击
    innerHTML: function (value) {
        var div = document.createElement('div');
        if (div.innerText) {
            div.innerText = value;
        } else {
            div.textContent = value;
        }
        return div.innerHTML;
    }
}

/**
 * 监听登录过期
 */
$(document).ajaxSuccess(function (event, xhr, options) {
    var data = xhr.responseJSON;
    if (data && data.rows === 0 && data.code === 403) {
        if ($("#again-form").length <= 0) {
            var html = '<form class="layui-form" style="padding: 20px" id="again-form">' +
                '<div class="layui-form-item" >' +
                '<input class="layui-input" id="account" placeholder="账号" lay-verify="required" type="text" autocomplete="off">' +
                '</div>' +
                '<div class="layui-form-item">' +
                '<input class="layui-input" id="password" placeholder="密码" lay-verify="required" type="password" autocomplete="off">' +
                '</div>' +
                '<div class="layui-btn" style="width: 100%" id="again-login">登录</div>' +
                '</form>';
            var open = layer.open({
                type: 1,
                title: data.msg,
                shadeClose: false,
                shade: 0.8,
                area: ['380px', '240px'],
                content: html
            });
            $.cookie('expire', true);
            $("#again-login").click(function () {
                var form = $(this).parent();
                askHelper.ajaxPost({
                    url: '/index/signIn',
                    data: {
                        account: form.find("#account").val(),
                        password: form.find("#password").val()
                    },
                    success: function () {
                        layer.close(open);
                    }
                });
            });
        }
    }
});