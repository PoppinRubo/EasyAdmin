/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : admin

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 07/09/2018 15:40:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_module`;
CREATE TABLE `sys_module`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Pid` int(11) NOT NULL COMMENT '父级模块编号',
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块名称',
  `Link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块链接',
  `Icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '备注',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统模块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_module_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_module_button`;
CREATE TABLE `sys_module_button`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `Name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '按钮名称',
  `EnglishName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '按钮英文名称',
  `Icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图标',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '备注',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统模块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `Sort` int(11) NOT NULL COMMENT '排序',
  `Remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '备注',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 1, '超级管理员', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0);
INSERT INTO `sys_role` VALUES (2, '系统管理员', 2, '系统管理员', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_role_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_button`;
CREATE TABLE `sys_role_button`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `ButtonId` int(11) NOT NULL COMMENT '按钮编号',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色按钮表/按钮权限控制表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for sys_role_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_module`;
CREATE TABLE `sys_role_module`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `ModuleId` int(11) NOT NULL COMMENT '模块编号',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色模块表/模块权限控制表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `Account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '帐号',
  `Password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `Username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `Gender` int(1) NOT NULL COMMENT '性别',
  `LoginTimes` int(11) NOT NULL COMMENT '登录次数',
  `LastLoginTime` datetime(0) NOT NULL COMMENT '最后登录时间',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '12345789', '超级管理员', 1, 0, '2018-08-07 00:00:00', '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` int(11) NOT NULL COMMENT '用户编号',
  `RoleId` int(11) NOT NULL COMMENT '角色编号',
  `CreateTime` datetime(0) NOT NULL COMMENT '创建时间',
  `CreateUser` int(11) NOT NULL COMMENT '创建人',
  `ModifyTime` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `ModifyUser` int(11) NOT NULL COMMENT '修改人',
  `IsValid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `IsDel` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `FK_UserRole_User`(`UserId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (2, 1, 2, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (3, 2, 2, '2018-07-12 20:00:00', 1, '2018-09-07 15:39:29', 1, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
