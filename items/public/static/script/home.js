$(function () {
    $('#menu-tree').tree({
        url: "/home/getMenuTree",
        method:"POST",
        idField:"id",
        treeField:"name"
    });
});