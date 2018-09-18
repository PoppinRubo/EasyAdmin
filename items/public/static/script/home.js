layui.define(function (exports) {
    //菜单树
    var body = $("body"),
        home = {
            tree: function () {
                $('#menu-tree').tree({
                    url: "/home/getMenuTree",
                    method: "post",
                    animate: true,
                    onSelect: function (node) {
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
    //输出
    exports('home', home);
});