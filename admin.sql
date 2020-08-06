/*
MySQL Backup
Database: admin
Backup Time: 2020-08-06 14:46:52
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `admin`.`sys_button`;
DROP TABLE IF EXISTS `admin`.`sys_module`;
DROP TABLE IF EXISTS `admin`.`sys_module_button`;
DROP TABLE IF EXISTS `admin`.`sys_role`;
DROP TABLE IF EXISTS `admin`.`sys_role_button`;
DROP TABLE IF EXISTS `admin`.`sys_role_module`;
DROP TABLE IF EXISTS `admin`.`sys_user`;
DROP TABLE IF EXISTS `admin`.`sys_user_login_log`;
DROP TABLE IF EXISTS `admin`.`sys_user_role`;
CREATE TABLE `sys_button` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(10) NOT NULL COMMENT '按钮名称',
  `english_name` varchar(30) NOT NULL COMMENT '按钮英文名称',
  `icon` varchar(50) NOT NULL COMMENT '图标',
  `sort` int(11) NOT NULL COMMENT '排序',
  `remark` varchar(30) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='按钮表';
CREATE TABLE `sys_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父级模块编号',
  `level` int(2) NOT NULL COMMENT '层级',
  `name` varchar(50) NOT NULL COMMENT '模块名称',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '模块链接',
  `icon` varchar(50) NOT NULL COMMENT '图标',
  `sort` int(11) NOT NULL DEFAULT 100 COMMENT '排序',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统模块表';
CREATE TABLE `sys_module_button` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `button_id` int(11) NOT NULL COMMENT '按钮编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统模块、按钮关系表';
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `sort` int(11) NOT NULL COMMENT '排序',
  `remark` text NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='角色表';
CREATE TABLE `sys_role_button` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `button_id` int(11) NOT NULL COMMENT '按钮编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='角色、按钮、模块关系表/按钮权限控制表';
CREATE TABLE `sys_role_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='角色模块关系表/模块权限控制表';
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account` varchar(50) NOT NULL COMMENT '帐号',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `username` varchar(50) NOT NULL COMMENT '姓名',
  `gender` int(1) NOT NULL COMMENT '性别',
  `login_times` int(11) NOT NULL DEFAULT 0 COMMENT '登录次数',
  `last_login_time` datetime DEFAULT '1949-10-01 00:00:00' COMMENT '最后登录时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户表';
CREATE TABLE `sys_user_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键,编号',
  `ip` varchar(255) NOT NULL DEFAULT '' COMMENT '登录IP地址',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户登录日志表';
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_UserRole_User` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户、角色关系表';
BEGIN;
LOCK TABLES `admin`.`sys_button` WRITE;
DELETE FROM `admin`.`sys_button`;
INSERT INTO `admin`.`sys_button` (`id`,`name`,`english_name`,`icon`,`sort`,`remark`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, '添加', 'add', 'layui-icon-add-1', 10, '添加按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, '编辑', 'edit', 'layui-icon-edit', 30, '编辑按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(3, '删除', 'remove', 'layui-icon-delete', 40, '删除按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(4, '添加子级', 'addSon', 'layui-icon-add-1', 20, '添加子级按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(5, '按钮配置', 'moduleButton', 'icon-link2', 50, '模块配置按钮关联', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(6, '自动排序', 'sorting', 'icon-sort-amount-asc', 60, '自动排序按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(7, '权限配置', 'roleModule', 'icon-squarespace', 70, '角色关联模块', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(8, '角色配置', 'userRole', 'icon-squarespace', 80, '用户关联角色', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(9, '密码重置', 'resetPassword', 'icon-back', 90, '用户密码重置', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(10, '调整层级', 'move', 'icon-hand', 100, '调整菜单层级', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_module` WRITE;
DELETE FROM `admin`.`sys_module`;
INSERT INTO `admin`.`sys_module` (`id`,`pid`,`level`,`name`,`link`,`icon`,`sort`,`remark`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, 0, 1, '系统管理', '', 'icon-briefcase', 10, '系统管理', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, 1, 2, '字体图标', '/icon/index', 'icon-open-book', 10, '字体图标', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(3, 1, 2, '用户列表', '/user/index', 'icon-user', 20, '系统用户', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(4, 1, 2, '模块列表', '/module/index', 'icon-books', 40, '系统模块', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(5, 1, 2, '按钮管理', '/button/index', 'icon-bigcartel', 50, '按钮管理', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(6, 1, 2, '角色列表', '/role/index', 'icon-jira', 30, '系统角色', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_module_button` WRITE;
DELETE FROM `admin`.`sys_module_button`;
INSERT INTO `admin`.`sys_module_button` (`id`,`module_id`,`button_id`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, 5, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, 5, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(3, 5, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(4, 4, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(5, 4, 4, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(6, 4, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(7, 4, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(8, 4, 5, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(9, 3, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(10, 3, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(11, 3, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(12, 5, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(13, 4, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(14, 6, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(15, 6, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(16, 6, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(17, 6, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(18, 6, 7, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(19, 3, 8, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(20, 3, 9, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(21, 4, 10, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role` WRITE;
DELETE FROM `admin`.`sys_role`;
INSERT INTO `admin`.`sys_role` (`id`,`name`,`sort`,`remark`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, '超级管理员', 10, '超级管理员', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, '系统管理员', 20, '系统管理员', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role_button` WRITE;
DELETE FROM `admin`.`sys_role_button`;
INSERT INTO `admin`.`sys_role_button` (`id`,`role_id`,`module_id`,`button_id`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, 1, 6, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, 1, 6, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(3, 1, 6, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(4, 1, 6, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(5, 1, 6, 7, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(6, 1, 3, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(7, 1, 3, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(8, 1, 3, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(9, 1, 3, 8, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(10, 1, 4, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(11, 1, 4, 4, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(12, 1, 4, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(13, 1, 4, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(14, 1, 4, 5, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(15, 1, 4, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(16, 1, 5, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(17, 1, 5, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(18, 1, 5, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(19, 1, 5, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(20, 1, 3, 9, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(21, 1, 4, 10, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role_module` WRITE;
DELETE FROM `admin`.`sys_role_module`;
INSERT INTO `admin`.`sys_role_module` (`id`,`role_id`,`module_id`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, 1, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, 1, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(3, 1, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(4, 1, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(5, 1, 4, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(6, 1, 5, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_user` WRITE;
DELETE FROM `admin`.`sys_user`;
INSERT INTO `admin`.`sys_user` (`id`,`account`,`password`,`username`,`gender`,`login_times`,`last_login_time`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, 'admin', 'f379eaf3c831b04de153469d1bec345e', '超级管理员', 1, 0, '1949-10-01 00:00:00', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_user_login_log` WRITE;
DELETE FROM `admin`.`sys_user_login_log`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_user_role` WRITE;
DELETE FROM `admin`.`sys_user_role`;
INSERT INTO `admin`.`sys_user_role` (`id`,`user_id`,`role_id`,`create_time`,`create_user`,`modify_time`,`modify_user`,`is_valid`,`is_del`) VALUES (1, 1, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0),(2, 1, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
