/**
 * EasyUI Datagrid 扩展
 */
$.extend($.fn.datagrid.defaults.view, {
    //表格渲染后
    onAfterRender: function(target) {
        var options = $(target).datagrid('options');
        var singleSelect = options.singleSelect;
        var view = $(target).closest(".datagrid-view");
        var checkbox = view.find("input[type=checkbox]");
        if (singleSelect) {
            //表头选框去除
            view.find(".datagrid-header-check").html("");
            //单选模式
            $.each(checkbox, function(i, v) {
                $(v)[0].type = "radio";
                //添加样式
                $(v).addClass("layui-hide").parent().addClass("layui-form-radio").append('<i class="layui-anim layui-icon">&#xe643;</i>')
                $(v).parent().parent().parent(".datagrid-row").click(function() {
                    radioSelect();
                });
            });
            //选中处理图标
            function radioSelect() {
                //事件延迟等待复选框状态
                setTimeout(function() {
                    checkbox = view.find("input[type=radio]");
                    $.each(checkbox, function(i, v) {
                        this.checked ? $(this).parent().addClass("layui-anim-scaleSpring") : $(this).parent().removeClass("layui-anim-scaleSpring");
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
                $(v).parent().parent().parent(".datagrid-row").click(function() {
                    checkboxSelect();
                });
            });
            //选中处理图标
            function checkboxSelect() {
                //事件延迟等待复选框状态
                setTimeout(function() {
                    checkbox = view.find("input[type=checkbox]");
                    $.each(checkbox, function(i, v) {
                        this.checked ? $(this).parent().addClass("layui-form-checked") : $(this).parent().removeClass("layui-form-checked");
                    });
                }, 100)
            }
        }
    }
});