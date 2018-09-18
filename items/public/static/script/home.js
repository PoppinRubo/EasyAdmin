layui.define("layer", function (exports) {
    //菜单树
    var body = $("body"),
        home = {
            tree: function () {
                layer.load(1, {
                    shade: [0.1, '#fff']
                });
                $('#menu-tree').tree({
                    url: "/home/getMenuTree",
                    method: "post",
                    animate: true,
                    onSelect: function (node) {
                        //节点被选中前触发，返回 false 则取消选择动作
                        //单击节点展开||关闭
                        if (node.state == "closed")
                            $(this).tree('expand', node.target);
                        else
                            $(this).tree('collapse', node.target);
                    },
                    onLoadSuccess: function () {
                        //当数据加载成功时触发
                    },
                    onLoadError: function () {
                        //当数据加载失败时触发
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