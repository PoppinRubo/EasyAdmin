layui.define(['layer', 'element'], function(exports) {
    //菜单树
    var body = $("body"),
        element = layui.element,
        tabs = "admin-layout-tabs",
        contextmenu = $("#context-menu"),
        tabBody = $("#tab-body"),
        pageId = "first",
        selectPageIndex = 0,
        status = '',
        home = {
            tree: function() {
                var t = this;
                $('#menu-tree').tree({
                    url: "/home/getMenuTree",
                    method: "post",
                    animate: true,
                    onBeforeLoad: function() {
                        //当加载数据的请求发出前触发
                    },
                    onLoadSuccess: function(node, data) {
                        //当数据加载成功时触发
                        if (data.code === 0) {
                            layer.msg(data.msg, {
                                time: 1000,
                                icon: 5
                            }, function() {
                                window.location.href = data.url;
                            });
                        }
                    },
                    onLoadError: function(arguments) {
                        //当数据加载失败时触发
                    },
                    onSelect: function(node) {
                        //菜单展开折叠
                        if (status === 'spread') {
                            t.sideFlexible();
                        }
                        //节点被选中前触发，返回 false 则取消选择动作
                        //单击节点展开||关闭
                        if (node.state == "closed") {
                            $(this).tree('expand', node.target);
                        } else {
                            $(this).tree('collapse', node.target);
                        }
                        //添加标签页
                        home.tabAdd(node);
                    }
                });
            },
            fullscreen: function(e) {
                //全屏切换
                var a = "layui-icon-screen-full",
                    i = "layui-icon-screen-restore",
                    t = e.children("i");
                if (t.hasClass(a)) {
                    //全屏
                    t.addClass(i).removeClass(a)
                    var e = document.documentElement,
                        a = e.requestFullScreen || e.webkitRequestFullScreen || e.mozRequestFullScreen || e.msRequestFullscreen;
                    "undefined" != typeof a && a && a.call(e)
                } else {
                    //退出全屏
                    t.addClass(a).removeClass(i);
                    document.documentElement;
                    document.exitFullscreen ? document.exitFullscreen() : document.mozCancelFullScreen ? document.mozCancelFullScreen() :
                        document.webkitCancelFullScreen ? document.webkitCancelFullScreen() : document.msExitFullscreen && document.msExitFullscreen();
                }
            },
            sideFlexible: function() {
                //侧边伸缩
                var app = $('#admin-app'),
                    iconElem = $('#app-flexible'),
                    screen = home.screen(),
                    iconShrink = 'layui-icon-shrink-right',
                    iconSpread = 'layui-icon-spread-left',
                    spreadSm = 'admin-side-spread-sm',
                    sideShrink = 'admin-side-shrink',
                    menuTree = $('#menu-tree');

                //设置状态，PC：默认展开、移动：默认收缩
                if (status === 'spread') {
                    //展开
                    iconElem.removeClass(iconSpread).addClass(iconShrink);

                    //移动：从左到右位移；PC：清除多余选择器恢复默认
                    if (screen < 2) {
                        app.addClass(spreadSm);
                    } else {
                        app.removeClass(spreadSm);
                    }
                    app.removeClass(sideShrink)
                    menuTree.removeClass('menu-shrink');
                } else {
                    //折叠
                    iconElem.removeClass(iconShrink).addClass(iconSpread);

                    //移动：清除多余选择器恢复默认；PC：从右往左收缩
                    if (screen < 2) {
                        app.removeClass(sideShrink);
                    } else {
                        app.addClass(sideShrink);
                    }
                    app.removeClass(spreadSm)
                    menuTree.addClass('menu-shrink');
                }
                status = status === 'spread' ? '' : 'spread';
            },
            screen: function() {
                //屏幕类型
                var width = $(window).width()
                if (width >= 1200) {
                    return 3; //大屏幕
                } else if (width >= 992) {
                    return 2; //中屏幕
                } else if (width >= 768) {
                    return 1; //小屏幕
                } else {
                    return 0; //超小屏幕
                }
            },
            tabAdd: function(e) {
                var t = this;
                //父模块不开新窗口,
                if (e.son > 0) {
                    return;
                }
                //未配置链接
                if (!$.trim(e.link)) {
                    layer.tips('未配置链接地址', '#' + e.domId, {
                        tips: [4, $(e.target).css('background-color')]
                    });
                    return;
                }
                //判断是否存在tab
                if ($("li[lay-id='" + e.id + "']").length > 0) {
                    this.tabChange(e.id);
                    return;
                }
                //新增一个Tab项
                element.tabAdd(tabs, {
                    title: '<i class="layui-icon tab-icon ' + e.iconCls + '"></i>' + e.text + '<i class="layui-icon layui-unselect layui-tab-close">&#x1006;</i>',
                    id: e.id
                });
                var iframe = '<iframe data-id="' + e.id + '" src="' + e.link + '" frameborder="0" class="admin-iframe"></iframe>';
                tabBody.append('<div class="body-item">' + iframe + '</div>');
                //每次新打开tab都是最后一个，所以只对最后一个tab添加点击关闭事件
                var r = $(".layui-tab-title").find("li");
                //加点击关闭事件  
                r.eq(r.length - 1).children(".layui-tab-close").on("click", function() {
                    t.tabDelete($(this).parent("li").attr('lay-id'));
                });
                element.init();
                //切换到该tab
                t.tabChange(e.id);
                //开启右键菜单
                home.contextMenu();
            },
            tabDelete: function(id) {
                var t = this;
                //删除指定Tab项
                element.tabDelete(tabs, id);
                //移除iframe
                var iframe = tabBody.find(".admin-iframe");
                iframe.each(function(index) {
                    if ($(this).data("id") == id) {
                        $(this).parent().remove();
                        //显示前一个iframe
                        t.tabChange($(iframe[index - 1]).data("id"));
                    }
                });
            },
            tabChange: function(id) {
                //切换到指定Tab项
                var item = tabBody.find(".body-item");
                //隐藏其他iframe
                item.removeClass("layui-show");
                item.each(function(index) {
                    if ($(this).children().data("id") == id) {
                        //显示指定页面
                        $(this).addClass("layui-show");
                        //记录当前页面索引
                        selectPageIndex = index;
                    }
                });
                element.tabChange(tabs, id);
            },
            refresh: function() {
                //刷新菜单树
                this.tree();
            },
            refreshThisTabs: function() {
                //刷新当前标签页
                var iframe = tabBody.find(".admin-iframe");
                iframe.each(function() {
                    if ($(this).data("id") == pageId) {
                        this.src = this.src;
                    }
                });
                contextmenu.removeClass("layui-show");
            },
            closeTabs: function(id) {
                //关闭标签页
                if (id == "first") {
                    return;
                }
                this.tabDelete(id);
                contextmenu.removeClass("layui-show");
            },
            closeThisTabs: function() {
                this.closeTabs(pageId);
            },
            closeOtherTabs: function() {
                var t = this;
                //关闭其他标签页
                var iframe = tabBody.find(".admin-iframe");
                iframe.each(function() {
                    if ($(this).data("id") != pageId) {
                        t.closeTabs($(this).data("id"));
                    }
                });
            },
            closeAllTabs: function() {
                var t = this;
                //关闭全部标签页
                var iframe = tabBody.find(".admin-iframe");
                iframe.each(function() {
                    t.closeTabs($(this).data("id"));
                });
            },
            logout: function() {
                //退出登录
                askHelper.ajaxPost({
                    url: '/index/signOut',
                    success: function(result) {
                        window.location.href = result.data;
                    }
                });
            },
            click: function() {
                var t = this;
                body.on("click", "*[admin-event]", function() {
                    var e = $(this);
                    var i = e.attr("admin-event");
                    //方法调用
                    eval("t." + i + "(e)");
                })
            },
            contextMenu: function() {
                // 阻止浏览器鼠标右键单击事件，生成右键菜单
                $('.layui-tab-title li').on('contextmenu', function() {
                    pageId = $(this).data("id") || $(this).attr('lay-id');;
                    var x = $(this).position().left;
                    contextmenu.css({
                        "margin-left": x + "px"
                    }).addClass("layui-show");
                    //隐藏显示控制
                    $(".layui-this").hover(function() {

                    }, function() {
                        contextmenu.removeClass("layui-show");
                    });
                    $("#context-menu").hover(function() {
                        contextmenu.addClass("layui-show");
                    }, function() {
                        contextmenu.removeClass("layui-show");
                    });
                    //生成屏蔽首页关闭标签页样式
                    var a = $(contextmenu.find("a")[1]);
                    a.addClass("layui-disabled");
                    if (pageId != "first") {
                        a.removeClass("layui-disabled");
                    }
                    return false;
                })
            }
        }
    //监听Tab切换
    element.on('tab(' + tabs + ')', function(obj) {
        if (selectPageIndex == obj.index) {
            //点击当前显示不处理
            return;
        }
        var e = $(".layui-tab-title").find("li")[obj.index];
        var id = $(e).data("id") || $(e).attr('lay-id');
        home.tabChange(id);
    });

    //窗口resize事件
    var resizeSystem = layui.data.resizeSystem = function() {
        if (!resizeSystem.lock) {
            setTimeout(function() {
                status = home.screen() < 2 ? '' : 'spread';
                home.sideFlexible();
                delete resizeSystem.lock;
            }, 100);
        }
        resizeSystem.lock = true;
    }
    $(window).on('resize', layui.data.resizeSystem);

    //开启事件
    home.click();
    //开启右键菜单
    home.contextMenu();
    //生成树
    home.tree();
    //输出模块
    exports('home', home);
});