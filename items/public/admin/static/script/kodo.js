$(function () {
    kodoApi.getRoot();
    $('body').keydown(function (e) {
        if (e.keyCode == 46) {
            kodoApi.del()
        }
    });
});
var kodoApi = {
    url: "https://file.hiphopbl.com/",
    //获取根目录
    getRoot: function () {
        askHelper.ajaxGet({
            url: '/kodo/getList',
            original: true,
            data: {
                num: 1000
            },
            before: function () {},
            success: function (result) {
                var prefixes = result.data.commonPrefixes || [];
                var list = kodoApi.make(prefixes);
                kodoApi.view(list, '');
            }
        });
    },
    //列出目录,目录文件混排
    make: function (catalog, items = [], route = '') {
        var list = [];
        //目录
        catalog.forEach(function (e) {
            list.push({
                'url': e,
                'key': e.replace(route, '')
            })
        });
        //文件||目录
        items.forEach(function (e) {
            if (e.key != route) {
                list.push({
                    'url': e.key,
                    'key': e.key.replace(route, '')
                })
            }
        });
        return list;
    },
    //创建显示
    view: function (infos, route) {
        var file = $("body .file"),
            queue = "",
            type = "folder";
        if (infos) {
            infos.forEach(e => {
                var thumbnail = '<i class="icon-folder2 folder"></i>';
                if (e.key.indexOf('.jpg') > -1) {
                    type = 'img';
                } else if (e.key.indexOf('.png') > -1) {
                    type = "img";
                } else if (e.key.indexOf('.gif') > -1) {
                    type = "img";
                } else if (e.key.indexOf('.mp3') > -1) {
                    type = "mp3";
                } else if (e.key.indexOf('.mp4') > -1) {
                    type = "mp4";
                } else if (e.key.indexOf('.apk') > -1) {
                    type = "apk";
                } else if (e.key.indexOf('/') > -1) {
                    type = "folder";
                } else {
                    type = "file";
                }
                if (type == "img") {
                    thumbnail = '<img original="' + kodoApi.url + e.url + '" src="' + kodoApi.url + e.url + '?imageMogr2/auto-orient/thumbnail/150x/blur/1x0/quality/80">';
                } else if (type == "mp4") {
                    thumbnail = ' <video src="' + kodoApi.url + e.url + '" controls="controls" preload="none"></video>';
                } else if (type == "mp3") {
                    thumbnail = ' <audio src="' + kodoApi.url + e.url + '" controls="controls" preload="none"></audio>';
                } else if (type == "apk") {
                    thumbnail = '<i class="icon-android2 android"></i>'
                } else if (type == "file") {
                    thumbnail = '<i class="icon-file-empty file"></i>'
                }
                e.key = e.key.replace('/', '');
                name = '<span class="name">' + e.key + '</span></div>';

                queue += "<div class='queue' data-type='" + type + "' title='" + e.key + "' data-route='" + route + "'>" + thumbnail + name + "</div>";
            });
            file.html(queue);
            //事件创建
            $(".queue").dblclick(function () {
                kodoApi.open(this);
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
        //有斜杠后缀处理
        if (index == route.length - 1) {
            route = route.substring(0, index);
            index = route.lastIndexOf("/");
        }
        if (index === -1) {
            //返回根目录
            kodoApi.getRoot();
            return;
        }
        route = route.substring(0, index);
        route = route + '/'.replace('//', '/');
        askHelper.ajaxGet({
            url: '/kodo/getList',
            original: true,
            data: {
                prefix: route,
                num: 30
            },
            before: function () {},
            success: function (result) {
                var items = result.data.items || [];
                var prefixes = result.data.commonPrefixes || [];
                var list = kodoApi.make(prefixes, items, route);
                kodoApi.view(list, route);
            }
        });

    },
    open: function (t) {
        if ($(t).data("type") == 'folder') {
            var name = $(t).attr('title');
            var route = ($(t).data("route") ? $(t).data("route") + "/" : "") + name + "/";
            route = route.replace('//', '/');
            askHelper.ajaxGet({
                url: '/kodo/getList',
                original: true,
                data: {
                    prefix: route,
                    num: 30
                },
                before: function () {},
                success: function (result) {
                    var items = result.data.items || [];
                    var prefixes = result.data.commonPrefixes || [];
                    var list = kodoApi.make(prefixes, items, route);
                    kodoApi.view(list, route);
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
            content: '/kodo/upload'
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
                url: '/kodo/delete',
                original: true,
                data: {
                    url: kodoApi.getSelectRoute() + "/" + name
                },
                success: function (result) {
                    if (result.code === 1) {
                        kodoApi.refresh();
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
        route = route + '/'.replace('//', '/');
        askHelper.ajaxGet({
            url: '/kodo/getList',
            original: true,
            data: {
                prefix: route,
                num: 30
            },
            before: function () {},
            success: function (result) {
                var items = result.data.items || [];
                var prefixes = result.data.commonPrefixes || [];
                var list = kodoApi.make(prefixes, items, route);
                kodoApi.view(list, route);
            }
        });
    }
};