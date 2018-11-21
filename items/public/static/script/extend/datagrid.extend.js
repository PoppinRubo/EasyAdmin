/**
 * EasyUI Datagrid 扩展
 */
$.extend($.fn.datagrid.defaults.view, {
    //表格渲染后
    onAfterRender: function(target) {
        datagridExtend.beautify(target);
    }
});
$.extend($.fn.treegrid.defaults.view, {
    //表格树渲染后
    onAfterRender: function(target) {
        datagridExtend.beautify(target);
    }
});
//扩展方法
var datagridExtend = {
    //美化
    beautify: function(target) {
        var options = $(target).datagrid('options');
        var singleSelect = options.singleSelect;
        var view = $(target).closest(".datagrid-view");
        var checkbox = view.find("tr input[type=checkbox]");
        if (singleSelect) {
            //表头选框去除
            view.find(".datagrid-header-check").addClass("layui-form-radio").html("");
            //单选模式
            $.each(checkbox, function(i, v) {
                var parent = $(v).parent();
                parent.html('<input type="radio" name="radio">');
                var radio = parent.find("input[type=radio]");
                //添加样式
                radio.addClass("layui-hide").parent().addClass("layui-form-radio").append('<i class="layui-anim layui-icon">&#xe63f;</i>')
                radio.closest("tr").click(function() {
                    radioSelect(this);
                });
            });
            //选中处理图标
            function radioSelect(t) {
                var radio = $(t).find("input[type=radio]");
                radio[0].checked = !radio[0].checked;
                //事件延迟等待复选框状态
                setTimeout(function() {
                    checkbox = view.find("tr input[type=radio]");
                    $.each(checkbox, function(i, v) {
                        var icon = $(this).parent().find("i");
                        this.checked ? icon.html("&#xe643;") : icon.html("&#xe63f;");
                        this.checked ? $(this).parent().addClass("layui-form-radioed") : $(this).parent().removeClass("layui-form-radioed");
                    });
                }, 100)
            }
        } else {
            //复选模式
            $.each(checkbox, function(i, v) {
                //表头
                if ($(v).parent()[0].className == "datagrid-header-check") {
                    view.find(".datagrid-header-check").click(function() {
                        $(this).find("input[type=checkbox]").click();
                        checkboxSelect();
                    });
                }
                //添加样式
                $(v).addClass("layui-hide").parent().addClass("layui-form-checkbox").attr("lay-skin", "primary").append('<i class="layui-icon layui-icon-ok"></i>')
                $(v).closest("tr").click(function() {
                    checkboxSelect();
                });
            });
            //选中处理图标
            function checkboxSelect() {
                //事件延迟等待复选框状态
                setTimeout(function() {
                    checkbox = view.find("tr input[type=checkbox]");
                    $.each(checkbox, function(i, v) {
                        this.checked ? $(this).parent().addClass("layui-form-checked") : $(this).parent().removeClass("layui-form-checked");
                    });
                }, 100)
            }
        }
    }
}