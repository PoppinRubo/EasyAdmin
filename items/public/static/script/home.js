$(function () {
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
});