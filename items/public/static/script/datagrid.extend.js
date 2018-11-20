/**
 * EasyUI Datagrid 扩展
 */
$.extend($.fn.datagrid.defaults.view, {
    //表格渲染后
    onAfterRender: function(target) {
        //表格美化选框
        var singleSelect = true;
        var checkbox = $(".datagrid-view").find("input[type=checkbox]");
        //选中处理图标
        function select() {
            //事件延迟等待复选框状态
            setTimeout(function() {
                checkbox = $(".datagrid-view").find("input[type=checkbox]");
                $.each(checkbox, function(i, v) {
                    this.checked ? $(this).parent().addClass("layui-form-checked") : $(this).parent().removeClass("layui-form-checked");
                });
            }, 100)
        }
        $.each(checkbox, function(i, v) {
            //表头
            if ($(v).parent()[0].className == "datagrid-header-check") {
                if (singleSelect) {
                    //单选模式表头不显示
                    $(v).parent().html("");
                }
                $(".datagrid-header-check").click(function() {
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