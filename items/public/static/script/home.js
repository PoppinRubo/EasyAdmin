$(function () {
    $('#menu-tree').tree({
        url: "/home/getMenuTree",
        method:"post",
        animate: true
    });
});