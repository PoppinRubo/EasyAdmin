layui.define("layer", function (exports) {
    //菜单树
    var body = $("body"),
        home = {
            tree: function () {
                $('#menu-tree').tree({
                    url: "/home/getMenuTree",
                    method: "post",
                    animate: true,
                    onBeforeLoad: function () {
                        //当加载数据的请求发出前触发
                    },
                    onLoadSuccess: function () {
                        //当数据加载成功时触发
                    },
                    onLoadError: function () {
                        //当数据加载失败时触发
                    },
                    onSelect: function (node) {
                        //节点被选中前触发，返回 false 则取消选择动作
                        //单击节点展开||关闭
                        if (node.state == "closed")
                            $(this).tree('expand', node.target);
                        else
                            $(this).tree('collapse', node.target);
                    }
                });
            },
            fullscreen: function (e) {
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
            refresh: function () {
                //刷新菜单树
                this.tree();
            },
            logout: function () {
                $.ajax({
                    url: '/index/signOut',
                    type: 'POST', //GET
                    async: true, //或false,是否异步
                    timeout: 6000, //超时时间
                    data: {}, //请求对象
                    dataType: 'json', //返回的数据格式：json/xml/html/script/jsonp/text
                    success: function (result) {
                        if (result.code === 1) {
                            layer.msg(result.message, {
                                time: 500,
                                icon: 1
                            }, function () {
                                window.location.reload();
                            });
                        } else {
                            layer.msg(result.message, {
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
                    eval("t." + i + "($(this))");
                })
            }
        }
    //开启事件
    home.click();
    //生成树
    home.tree();
    //输出
    exports('home', home);
});