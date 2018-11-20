/**
 * EasyUI Datagrid 扩展
 */
$.extend($.fn.datagrid.defaults.view, {
    //表格渲染前
    onBeforeRender: function(target) {
        var options = $(target).datagrid('options');
        var singleSelect = options.singleSelect;
        var view = $(target).closest(".datagrid-view");
        var checkbox = view.find(".datagrid-header-check").find("input[type=checkbox]");
        //单选模式表头移除选框
        if (singleSelect && checkbox.length > 0) {
            view.find(".datagrid-header-check").html("");
        }
    },
    //表格渲染后
    onAfterRender: function(target) {
        var options = $(target).datagrid('options');
        var singleSelect = options.singleSelect;
        var view = $(target).closest(".datagrid-view");
        var checkbox = view.find("input[type=checkbox]");
        //选中处理图标
        function select() {
            //事件延迟等待复选框状态
            setTimeout(function() {
                checkbox = view.find("input[type=checkbox]");
                $.each(checkbox, function(i, v) {
                    this.checked ? $(this).parent().addClass("layui-form-checked") : $(this).parent().removeClass("layui-form-checked");
                });
            }, 100)
        }
        $.each(checkbox, function(i, v) {
            //表头
            if ($(v).parent()[0].className == "datagrid-header-check") {
                view.find(".datagrid-header-check").click(function() {
                    $(this).find("input[type=checkbox]").click();
                    select();
                });
            }
            //添加样式
            $(v).addClass("layui-hide").parent().addClass("layui-form-checkbox").attr("lay-skin", "primary").append('<i class="layui-icon layui-icon-ok"></i>')
            $(v).parent().parent().parent(".datagrid-row").click(function() {
                select();
            });
        });
    }
});