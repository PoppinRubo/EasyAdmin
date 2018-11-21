/*
MySQL Backup
Database: admin
Backup Time: 2018-11-21 17:16:43
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
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(10) NOT NULL COMMENT '按钮名称',
  `EnglishName` varchar(30) NOT NULL COMMENT '按钮英文名称',
  `Icon` varchar(50) NOT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` varchar(30) NOT NULL DEFAULT '' COMMENT '备注',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='按钮表';
CREATE TABLE `sys_module` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Pid` int(11) NOT NULL DEFAULT '0' COMMENT '父级模块编号',
  `Level` int(2) NOT NULL COMMENT '层级',
  `Name` varchar(50) NOT NULL COMMENT '模块名称',
  `Link` varchar(100) NOT NULL DEFAULT '' COMMENT '模块链接',
  `Icon` varchar(50) NOT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `Remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='系统模块表';
CREATE TABLE `sys_module_button` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `ButtonId` int(11) NOT NULL COMMENT '按钮编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='系统模块、按钮关系表';
CREATE TABLE `sys_role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(50) NOT NULL COMMENT '角色名称',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text NOT NULL COMMENT '备注',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
CREATE TABLE `sys_role_button` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `ButtonId` int(11) NOT NULL COMMENT '按钮编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='角色、按钮、模块关系表/按钮权限控制表';
CREATE TABLE `sys_role_module` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='角色模块关系表/模块权限控制表';
CREATE TABLE `sys_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Account` varchar(50) NOT NULL COMMENT '帐号',
  `Password` varchar(50) NOT NULL COMMENT '密码',
  `Username` varchar(50) NOT NULL COMMENT '姓名',
  `Gender` int(1) NOT NULL COMMENT '性别',
  `LoginTimes` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `LastLoginTime` datetime DEFAULT NULL COMMENT '最后登录时间',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
CREATE TABLE `sys_user_login_log` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Ip` varchar(255) NOT NULL DEFAULT '' COMMENT '登录IP地址',
  `UserId` varchar(50) NOT NULL COMMENT '用户编号',
  `Remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注信息',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='用户登录日志表';
CREATE TABLE `sys_user_role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` int(11) NOT NULL COMMENT '用户编号',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`),
  KEY `FK_UserRole_User` (`UserId`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户、角色关系表';
BEGIN;
LOCK TABLES `admin`.`sys_button` WRITE;
DELETE FROM `admin`.`sys_button`;
INSERT INTO `admin`.`sys_button` (`Id`,`Name`,`EnglishName`,`Icon`,`Sort`,`Remark`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, '添加', 'add', 'layui-icon-add-1', 10, '添加按钮', '2018-07-12 20:00:00', 1, '2018-10-18 10:30:19', 1, 1, 0),(2, '编辑', 'edit', 'layui-icon-edit', 30, '编辑按钮', '2018-07-12 20:00:00', 1, '2018-10-18 10:30:41', 1, 1, 0),(3, '删除', 'remove', 'layui-icon-delete', 40, '删除按钮', '2018-07-12 20:00:00', 1, '2018-10-19 10:25:05', 1, 1, 0),(4, '添加子级', 'addSon', 'layui-icon-add-1', 20, '添加子级按钮', '2018-10-18 10:21:00', 1, '2018-10-18 10:30:28', 1, 1, 0),(5, '按钮关联', 'moduleButton', 'icon-link2', 50, '模块配置按钮关联', '2018-10-18 10:25:34', 1, '2018-10-19 10:32:32', 1, 1, 0),(6, '自动排序', 'sorting', 'icon-sort-amount-asc', 60, '自动排序按钮', '2018-10-19 10:05:47', 1, '2018-10-19 10:51:04', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_module` WRITE;
DELETE FROM `admin`.`sys_module`;
INSERT INTO `admin`.`sys_module` (`Id`,`Pid`,`Level`,`Name`,`Link`,`Icon`,`Sort`,`Remark`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 0, 1, '系统管理', '', 'icon-briefcase', 10, '系统管理', '2018-07-12 20:00:00', 1, '2018-09-20 12:31:28', 1, 1, 0),(2, 1, 2, '字体图标', '/icon/index', 'icon-open-book', 10, '字体图标', '2018-07-12 20:00:00', 1, '2018-09-20 12:51:20', 1, 1, 0),(3, 1, 2, '用户列表', '/user/index', 'icon-user', 20, '系统用户', '2018-07-12 20:00:00', 1, '2018-09-25 09:12:43', 1, 1, 0),(4, 1, 2, '模块列表', '/module/index', 'icon-books', 40, '系统模块', '2018-07-12 20:00:00', 1, '2018-09-28 18:03:54', 1, 1, 0),(5, 1, 2, '按钮管理', '/button/index', 'icon-bigcartel', 50, '按钮管理', '2018-10-18 10:13:21', 1, '2018-10-18 10:13:21', 1, 1, 0),(6, 1, 2, '角色列表', '/role/index', 'icon-jira', 30, '系统角色', '2018-11-21 16:53:56', 1, '2018-11-21 16:54:52', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_module_button` WRITE;
DELETE FROM `admin`.`sys_module_button`;
INSERT INTO `admin`.`sys_module_button` (`Id`,`ModuleId`,`ButtonId`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 5, 1, '2018-10-18 10:15:12', 1, '2018-10-18 10:15:12', 1, 1, 0),(2, 5, 2, '2018-10-18 10:15:15', 1, '2018-10-18 10:15:15', 1, 1, 0),(3, 5, 3, '2018-10-18 10:15:19', 1, '2018-10-18 10:15:19', 1, 1, 0),(4, 4, 1, '2018-10-18 10:22:05', 1, '2018-10-18 10:22:05', 1, 1, 0),(5, 4, 4, '2018-10-18 10:22:10', 1, '2018-10-18 10:22:10', 1, 1, 0),(6, 4, 3, '2018-10-18 10:22:16', 1, '2018-10-18 10:22:16', 1, 1, 0),(7, 4, 2, '2018-10-18 10:22:20', 1, '2018-10-18 10:22:20', 1, 1, 0),(8, 4, 5, '2018-10-18 10:25:44', 1, '2018-10-18 10:25:44', 1, 1, 0),(9, 3, 1, '2018-10-18 10:27:52', 1, '2018-10-18 10:27:52', 1, 1, 0),(10, 3, 2, '2018-10-18 10:27:56', 1, '2018-10-18 10:27:56', 1, 1, 0),(11, 3, 3, '2018-10-18 10:28:00', 1, '2018-10-18 10:28:00', 1, 1, 0),(12, 5, 6, '2018-10-19 10:06:26', 1, '2018-10-19 10:06:26', 1, 1, 0),(13, 4, 6, '2018-10-19 17:58:09', 1, '2018-10-19 17:58:09', 1, 1, 0),(14, 6, 1, '2018-11-21 17:00:28', 1, '2018-11-21 17:00:28', 1, 1, 0),(15, 6, 2, '2018-11-21 17:00:36', 1, '2018-11-21 17:00:36', 1, 1, 0),(16, 6, 3, '2018-11-21 17:00:41', 1, '2018-11-21 17:00:41', 1, 1, 0),(17, 6, 6, '2018-11-21 17:06:57', 1, '2018-11-21 17:06:57', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role` WRITE;
DELETE FROM `admin`.`sys_role`;
INSERT INTO `admin`.`sys_role` (`Id`,`Name`,`Sort`,`Remark`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, '超级管理员', 10, '超级管理员', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0),(2, '系统管理员', 20, '系统管理员', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role_button` WRITE;
DELETE FROM `admin`.`sys_role_button`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role_module` WRITE;
DELETE FROM `admin`.`sys_role_module`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_user` WRITE;
DELETE FROM `admin`.`sys_user`;
INSERT INTO `admin`.`sys_user` (`Id`,`Account`,`Password`,`Username`,`Gender`,`LoginTimes`,`LastLoginTime`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 'admin', '666666', '超级管理员', 1, 0, '2018-07-12 20:00:00', '2018-07-12 20:00:00', 1, '2018-09-10 11:50:18', 1, 1, 0);
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
INSERT INTO `admin`.`sys_user_role` (`Id`,`UserId`,`RoleId`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 1, 1, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0),(2, 1, 2, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
