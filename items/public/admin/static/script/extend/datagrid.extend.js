/**
 * EasyUI Datagrid 扩展
 */

//表格视图扩展
$.extend($.fn.datagrid.defaults.view, {
    //表格渲染后
    onAfterRender: function (target) {
        datagridExtend.beautify(target, "datagrid");
    }
});

//表格树视图扩展
$.extend($.fn.treegrid.defaults.view, {
    //表格树渲染后
    onAfterRender: function (target) {
        datagridExtend.beautify(target, "treegrid");
    }
});

//方法扩展
$.extend($.fn.datagrid.methods, {
    columnMenu: function (t) {
        return datagridExtend.buildMenu(t.get(0));
    }
});

//窗口大小变化
window.onresize = function () {
    datagridExtend.autoSize();
}

//扩展方法
var datagridExtend = {
    //美化
    beautify: function (target, type) {
        var options = $(target).datagrid('options');
        var singleSelect = options.singleSelect;
        var view = $(target).closest(".datagrid-view");
        var checkbox = view.find("td input[type=checkbox]");
        //绑定表头右键菜单
        datagridExtend.setHeaderContextMenu(options);
        if (singleSelect) {
            //表头选框去除
            view.find(".datagrid-header-check").addClass("layui-form-radio").html("");
            //单选模式
            $.each(checkbox, function (i, v) {
                var parent = $(v).parent();
                parent.html('<input type="radio" name="radio">');
                var radio = parent.find("input[type=radio]");
                //添加样式
                radio.addClass("layui-hide").parent().addClass("layui-form-radio").append('<i class="layui-anim layui-icon">&#xe63f;</i>')
                radio.closest("tr").click(function () {
                    radioSelect(this);
                });
            });
            //选中处理图标
            function radioSelect(t) {
                var radio = $(t).find("input[type=radio]");
                //事件延迟等待选框选中状态
                setTimeout(function () {
                    //单选根据行选状态设置选框
                    radio[0].checked = t.className.indexOf("datagrid-row-selected") != -1;
                    checkbox = view.find("td input[type=radio]");
                    $.each(checkbox, function (i, v) {
                        var icon = $(this).parent().find("i");
                        this.checked ? icon.html("&#xe643;") : icon.html("&#xe63f;");
                        this.checked ? $(this).parent().addClass("layui-form-radioed") : $(this).parent().removeClass("layui-form-radioed");
                    });
                }, 100);
            }
        } else {
            //复选模式
            $.each(checkbox, function (i, v) {
                //表头
                if ($(v).parent()[0].className.indexOf("datagrid-header-check") != -1) {
                    view.find(".datagrid-header-check").click(function () {
                        //时间戳处重复选中
                        if (!Window.checkboxTimestamp) {
                            Window.checkboxTimestamp = new Date().getTime();
                        } else {
                            var difference = (new Date().getTime() - Window.checkboxTimestamp) * 0.001;
                            Window.checkboxTimestamp = new Date().getTime();
                            if (difference < 0.5) {
                                return;
                            }
                        };
                        //全选反选控制
                        var all = $(this).find("input[type=checkbox]")[0];
                        all.checked = !all.checked;
                        all.checked ? $(target)[type]("selectAll") : $(target)[type]("clearSelections");
                        checkboxSelect();
                    });
                }
                //延迟等待选框选中状态再渲染，防止全选选框渲染样式不对应情况
                setTimeout(function () {
                    //移除产生的多余图标
                    $(v).siblings("i").remove();
                    //添加样式
                    $(v).addClass("layui-hide").parent().addClass("layui-form-checkbox").attr("lay-skin", "primary").append('<i class="layui-icon layui-icon-ok"></i>')
                    //根据选中绑定样式
                    v.checked ? $(v).parent().addClass("layui-form-checked") : $(v).parent().removeClass("layui-form-checked");
                    $(v).closest("tr").click(function () {
                        checkboxSelect();
                    });
                }, 100)
            });
            //选中处理图标
            function checkboxSelect() {
                //事件延迟等待选框选中状态
                setTimeout(function () {
                    checkbox = view.find("td input[type=checkbox]");
                    $.each(checkbox, function (i, v) {
                        this.checked ? $(this).parent().addClass("layui-form-checked") : $(this).parent().removeClass("layui-form-checked");
                    });
                }, 100)
            }
        }
    },
    autoSize: function () {
        //表格大小自适应设置
        var table = $(document).find(".datagrid-f");
        if (table.length > 0) {
            $.each(table, function (i, v) {
                var table = $(v);
                //表格类型
                var type = table.closest(".datagrid-view").find(".treegrid-tr-tree").length > 0 ? "treegrid" : "datagrid";
                //获取配置
                var options = table[type]('options');
                if (options.fitSize != false) {
                    table[type]('resize', {
                        height: tableHelper.setHeight(),
                        width: $(window).width() - 60
                    })
                }
            });
        }
    },
    //设置表头右键菜单
    setHeaderContextMenu: function (options) {
        options.onHeaderContextMenu = function (e) {
            e.preventDefault();
            $(this).datagrid('columnMenu').menu('show', {
                left: e.pageX,
                top: e.pageY
            });
        }
    },
    //绑定表头右键菜单
    buildMenu: function (target) {
        var state = $(target).data('datagrid');
        if (!state.columnMenu) {
            state.columnMenu = $('<div></div>').appendTo('body');
            state.columnMenu.menu({
                onClick: function (item) {
                    if (item.iconCls == 'icon-checkbox-checked') {
                        $(target).datagrid('hideColumn', item.name);
                        $(this).menu('setIcon', {
                            target: item.target,
                            iconCls: 'icon-checkbox-unchecked'
                        });
                    } else {
                        $(target).datagrid('showColumn', item.name);
                        $(this).menu('setIcon', {
                            target: item.target,
                            iconCls: 'icon-checkbox-checked'
                        });
                    }
                    //保持显示菜单
                    $(this).menu("show");
                }
            })
            var fields = $(target).datagrid('getColumnFields', true).concat($(target).datagrid('getColumnFields', false));
            for (var i = 0; i < fields.length; i++) {
                var field = fields[i];
                var col = $(target).datagrid('getColumnOption', field);
                var iconCls = col.hidden ? 'icon-checkbox-unchecked' : 'icon-checkbox-checked';
                state.columnMenu.menu('appendItem', {
                    text: col.title,
                    name: field,
                    iconCls: iconCls
                });
            }
        }
        return state.columnMenu;
    }
}