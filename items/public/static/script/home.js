layui.define(['layer', 'element'], function (exports) {
    //菜单树
    var body = $("body"),
        element = layui.element,
        tabs = "admin-layout-tabs",
        home = {
            tree: function () {
                $('#menu-tree').tree({
                    url: "/home/getMenuTree",
                    method: "post",
                    animate: true,
                    onBeforeLoad: function () {
                        //当加载数据的请求发出前触发
                    },
                    onLoadSuccess: function (node, data) {
                        //当数据加载成功时触发
                        if (data.code === 0) {
                            layer.msg(data.msg, {
                                time: 1000,
                                icon: 5
                            }, function () {
                                window.location.href = data.url;
                            });
                        }
                    },
                    onLoadError: function (arguments) {
                        //当数据加载失败时触发
                    },
                    onSelect: function (node) {
                        //节点被选中前触发，返回 false 则取消选择动作
                        //单击节点展开||关闭
                        if (node.state == "closed") {
                            $(this).tree('expand', node.target);
                        } else {
                            $(this).tree('collapse', node.target);
                        }
                        home.tabAdd(node);
                    }
                });
            },
            fullscreen: function (e) {
                //全屏切换
                var a = "layui-icon-screen-full",
                    i = "layui-icon-screen-restore",
                    t = e.children("i");
                if (t.hasClass(a)) {
                    var l = document.body;
                    l.webkitRequestFullScreen ? l.webkitRequestFullScreen() : l.mozRequestFullScreen ? l.mozRequestFullScreen() : l.requestFullScreen && l.requestFullscreen(), t.addClass(i).removeClass(a)
                } else {
                    var l = document;
                    l.webkitCancelFullScreen ? l.webkitCancelFullScreen() : l.mozCancelFullScreen ? l.mozCancelFullScreen() : l.cancelFullScreen ? l.cancelFullScreen() : l.exitFullscreen && l.exitFullscreen(), t.addClass(a).removeClass(i)
                }
            },
            tabAdd: function (e) {
                var t = this;
                //父模块不开新窗口,
                if (e.children && e.children.length > 0) {
                    return;
                }
                //判断是否存在tab
                if ($("li[lay-id='" + e.id + "']").length > 0) {
                    return;
                }
                //未配置链接
                if (!$.trim(e.link)) {
                    layer.tips('未配置链接地址', '#' + e.domId, {
                        tips: [4, $(e.target).css('background-color')]
                    });
                    return;
                }
                //新增一个Tab项
                element.tabAdd(tabs, {
                    title: '<i class="layui-icon tabs-icon ' + e.iconCls + '"></i>' + e.text + '<i class="layui-icon layui-unselect layui-tab-close">&#x1006;</i>',
                    content: '<iframe lay-id="' + e.id + '" src="' + e.link + '" frameborder="0" class="admin-iframe"></iframe>',
                    id: e.id
                });
                //每次新打开tab都是最后一个，所以只对最后一个tab添加点击关闭事件
                var r = $(".layui-tab-title").find("li");
                //加点击关闭事件  
                r.eq(r.length - 1).children(".layui-tab-close").on("click", function () {
                    t.tabDelete($(this).parent("li").attr('lay-id'));
                });
                //切换到该tab
                t.tabChange(e.id);
                element.init();
            },
            tabDelete: function (id) {
                //删除指定Tab项
                element.tabDelete(tabs, id);
            },
            tabChange: function (id) {
                //切换到指定Tab项
                element.tabChange(tabs, id);
            },
            tabsBody: function (e) {
                //显示月面内容
                return $("#tabs-body").find(".body-item").eq(e || 0)
            },
            refresh: function () {
                //刷新菜单树
                this.tree();
            },
            logout: function () {
                //退出登录
                $.ajax({
                    url: '/index/signOut',
                    type: 'POST', //GET
                    async: true, //或false,是否异步
                    timeout: 6000, //超时时间
                    data: {}, //请求对象
                    dataType: 'json', //返回的数据格式：json/xml/html/script/jsonp/text
                    success: function (result) {
                        if (result.code === 1) {
                            layer.msg(result.msg, {
                                time: 500,
                                icon: 1
                            }, function () {
                                window.location.href = result.data;
                            });
                        } else {
                            layer.msg(result.msg, {
                                time: 1000,
                                icon: 5
                            });
                        }
                    },
                    error: function (xhr, textStatus) {
                        ajaxErrMsg(xhr, textStatus);
                    }
                });
            },
            click: function () {
                var t = this;
                body.on("click", "*[admin-event]", function () {
                    var e = $(this);
                    var i = e.attr("admin-event");
                    //方法调用
                    eval("t." + i + "(e)");
                })
            }
        }
    //开启事件
    home.click();
    //生成树
    home.tree();
    //输出模块
    exports('home', home);
});