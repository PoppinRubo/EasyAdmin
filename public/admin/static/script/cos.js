$(function () {
    cosApi.getRoot();
    $('body').keydown(function (e) {
        if (e.keyCode == 46) {
            cosApi.del()
        }
    });
});
var cosApi = {
    url: "https://gz.file.myqcloud.com/files/v2/1251752722/hiphopbl/",
    //获取根目录
    getRoot: function () {
        askHelper.ajaxGet({
            url: cosApi.url,
            original: true,
            data: {
                op: "list",
                num: 200
            },
            before: function () {},
            success: function (result) {
                cosApi.view(result.data.infos, "");
            }
        });
    },
    //创建显示
    view: function (infos, route) {
        var file = $("body .file"),
            queue = "",
            type = "folder";
        if (infos) {
            infos.forEach(e => {
                var thumbnail = '<i class="icon-folder2 folder"></i>';
                if (e.name.indexOf('.jpg') > -1) {
                    type = 'img';
                } else if (e.name.indexOf('.png') > -1) {
                    type = "img";
                } else if (e.name.indexOf('.gif') > -1) {
                    type = "img";
                } else if (e.name.indexOf('.mp3') > -1) {
                    type = "mp3";
                } else if (e.name.indexOf('.mp4') > -1) {
                    type = "mp4";
                } else if (e.name.indexOf('.apk') > -1) {
                    type = "apk";
                } else if (e.name.indexOf('/') > -1) {
                    type = "folder";
                } else {
                    type = "file";
                }
                if (type == "img") {
                    thumbnail = '<img src="' + e.source_url + '">';
                } else if (type == "mp4") {
                    thumbnail = ' <video src="' + e.source_url + '" controls="controls" preload="none"></video>';
                } else if (type == "mp3") {
                    thumbnail = ' <audio src="' + e.source_url + '" controls="controls" preload="none"></audio>';
                } else if (type == "apk") {
                    thumbnail = '<i class="icon-android2 android"></i>'
                } else if (type == "file") {
                    thumbnail = '<i class="icon-file-empty file"></i>'
                }
                e.name = e.name.replace('/', '');
                name = '<span class="name">' + e.name + '</span></div>';

                queue += "<div class='queue' data-type='" + type + "' title='" + e.name + "' data-route='" + route + "'>" + thumbnail + name + "</div>";
            });
            file.html(queue);
            //事件创建
            $(".queue").dblclick(function () {
                cosApi.open(this);
            });
            $(".queue").click(function () {
                //选中
                $(".queue").removeClass("checked");
                $(this).addClass("checked");
            });
            route && route != "/" ? $('.black').removeClass("layui-hide") : $('.black').addClass("layui-hide");
            $(".url-route").html(route.replace('//', '/') || "/");
        }
    },
    //返回上级
    black: function () {
        var route = $(".url-route").html();
        var index = route.lastIndexOf("/");
        if (index === 0) {
            //返回根目录
            cosApi.getRoot();
            return;
        }
        route = route.substring(0, index);
        askHelper.ajaxGet({
            url: cosApi.url + route + "/",
            original: true,
            data: {
                op: "list",
                num: 200
            },
            before: function () {},
            success: function (result) {
                cosApi.view(result.data.infos, route);
            }
        });

    },
    open: function (t) {
        if ($(t).data("type") == 'folder') {
            var name = $(t).attr('title');
            var route = $(t).data("route") + "/" + name;
            askHelper.ajaxGet({
                url: cosApi.url + route + "/",
                original: true,
                data: {
                    op: "list",
                    num: 200
                },
                before: function () {},
                success: function (result) {
                    cosApi.view(result.data.infos, route);
                }
            });
            return;
        }
        if ($(t).data("type") == 'img') {
            pictureHelper.showBig($(t).find('img')[0]);
            return;
        }
        layer.msg('暂不支持打开');
    },
    //添加文件
    add: function () {
        var checked = $("body .file .checked");
        if (!checked || checked.length < 1) {
            layer.msg('请选择目录');
            return;
        }
        if (checked.data("type") != "folder") {
            layer.msg('请选择目录，而不是文件');
            return;
        }
        layer.open({
            type: 2,
            title: "上传文件",
            shadeClose: false, //是否点击遮罩关闭
            shade: 0.5, //遮罩透明度
            maxmin: false, //开启最大化最小化按钮
            area: ['350px', '250px'],
            content: '/cos/upload'
        });
    },
    //删除文件
    del: function () {
        var checked = $("body .file .checked");
        if (!checked || checked.length < 1) {
            layer.msg('未选择删除文件');
            return;
        }
        if (checked.data("type") == "folder") {
            layer.msg('不支持删除目录');
            return;
        }
        var name = checked.attr("title");
        layer.confirm('确定删除该文件吗？', {
            icon: 3,
            title: '删除提示'
        }, function (index) {
            askHelper.ajaxPost({
                url: '/cos/delete',
                original: true,
                data: {
                    url: cosApi.getSelectRoute() + "/" + name
                },
                success: function (result) {
                    if (result.code === 1) {
                        cosApi.refresh();
                        layer.msg(result.msg, {
                            time: 3000,
                            icon: 1
                        }, function () {});
                    } else {
                        layer.msg(result.msg, {
                            time: 3000,
                            icon: 5
                        }, function () {});
                    }
                }
            });
            layer.close(index);
        });
    },
    //获取选中的路径
    getSelectRoute: function () {
        var checked = $("body .file .checked");
        var route = checked.data("route") && checked.data("type") == 'folder' ? checked.data("route") + "/" + checked.attr("title") : checked.data("route") || checked.attr("title");
        return route || null;
    },
    //刷新当前目录
    refresh: function () {
        var route = $(".url-route").html();
        askHelper.ajaxGet({
            url: cosApi.url + route + "/",
            original: true,
            data: {
                op: "list",
                num: 200
            },
            before: function () {},
            success: function (result) {
                cosApi.view(result.data.infos, route);
            }
        });
    }
};