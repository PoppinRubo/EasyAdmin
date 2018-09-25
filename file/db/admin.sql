/*
MySQL Backup
Database: admin
Backup Time: 2018-09-25 09:55:59
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `admin`.`sys_module`;
DROP TABLE IF EXISTS `admin`.`sys_module_button`;
DROP TABLE IF EXISTS `admin`.`sys_role`;
DROP TABLE IF EXISTS `admin`.`sys_role_button`;
DROP TABLE IF EXISTS `admin`.`sys_role_module`;
DROP TABLE IF EXISTS `admin`.`sys_user`;
DROP TABLE IF EXISTS `admin`.`sys_user_role`;
CREATE TABLE `sys_module` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Pid` int(11) NOT NULL COMMENT '父级模块编号',
  `Name` varchar(50) NOT NULL COMMENT '模块名称',
  `Link` varchar(100) NOT NULL DEFAULT '' COMMENT '模块链接',
  `Icon` varchar(50) NOT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text NOT NULL COMMENT '备注',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='系统模块表';
CREATE TABLE `sys_module_button` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `Name` varchar(10) NOT NULL COMMENT '按钮名称',
  `EnglishName` varchar(30) NOT NULL COMMENT '按钮英文名称',
  `Icon` varchar(50) NOT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text NOT NULL COMMENT '备注',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='系统模块表';
CREATE TABLE `sys_role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(50) NOT NULL COMMENT '角色名称',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text NOT NULL COMMENT '备注',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
CREATE TABLE `sys_role_button` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `ButtonId` int(11) NOT NULL COMMENT '按钮编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='角色按钮表/按钮权限控制表';
CREATE TABLE `sys_role_module` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='角色模块表/模块权限控制表';
CREATE TABLE `sys_user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Account` varchar(50) NOT NULL COMMENT '帐号',
  `Password` varchar(50) NOT NULL COMMENT '密码',
  `Username` varchar(50) NOT NULL COMMENT '姓名',
  `Gender` int(1) NOT NULL COMMENT '性别',
  `LoginTimes` int(11) NOT NULL COMMENT '登录次数',
  `LastLoginTime` datetime NOT NULL COMMENT '最后登录时间',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
CREATE TABLE `sys_user_role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` int(11) NOT NULL COMMENT '用户编号',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `CreateTime` datetime NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`Id`),
  KEY `FK_UserRole_User` (`UserId`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户角色表';
BEGIN;
LOCK TABLES `admin`.`sys_module` WRITE;
DELETE FROM `admin`.`sys_module`;
INSERT INTO `admin`.`sys_module` (`Id`,`Pid`,`Name`,`Link`,`Icon`,`Sort`,`Remark`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 0, '系统管理', '', 'icon-briefcase', 1, '系统管理', '2018-07-12 20:00:00', 1, '2018-09-20 12:31:28', 1, 1, 0),(2, 1, '字体图标', '/icon/index', 'icon-open-book', 2, '字体图标', '2018-07-12 20:00:00', 1, '2018-09-20 12:51:20', 1, 1, 0),(3, 1, '用户列表', '/user/index', 'icon-user', 3, '系统用户', '2018-07-12 20:00:00', 1, '2018-09-25 09:12:43', 1, 1, 0),(4, 1, '模块列表', '/module/index', 'icon-books', 3, '系统模块', '2018-07-12 20:00:00', 1, '2018-09-25 09:40:47', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_module_button` WRITE;
DELETE FROM `admin`.`sys_module_button`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_role` WRITE;
DELETE FROM `admin`.`sys_role`;
INSERT INTO `admin`.`sys_role` (`Id`,`Name`,`Sort`,`Remark`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, '超级管理员', 1, '超级管理员', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0),(2, '系统管理员', 2, '系统管理员', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0);
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
INSERT INTO `admin`.`sys_user` (`Id`,`Account`,`Password`,`Username`,`Gender`,`LoginTimes`,`LastLoginTime`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 'admin', '666666', '超级管理员', 1, 0, '2018-08-07 00:00:00', '2018-07-12 20:00:00', 1, '2018-09-10 11:50:18', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `admin`.`sys_user_role` WRITE;
DELETE FROM `admin`.`sys_user_role`;
INSERT INTO `admin`.`sys_user_role` (`Id`,`UserId`,`RoleId`,`CreateTime`,`CreateUser`,`ModifyTime`,`ModifyUser`,`IsValid`,`IsDel`) VALUES (1, 1, 1, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0),(2, 1, 2, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0),(3, 2, 2, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0);
UNLOCK TABLES;
COMMIT;
