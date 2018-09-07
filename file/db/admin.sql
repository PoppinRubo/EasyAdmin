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

 Date: 07/09/2018 14:38:28
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
) ENGINE = MyISAM AUTO_INCREMENT = 2874 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色模块表/权限控制表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_role_module
-- ----------------------------
INSERT INTO `sys_role_module` VALUES (3, 1, 6, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (4, 1, 7, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (5, 1, 8, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (6, 1, 9, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (7, 1, 10, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (8, 1, 11, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (9, 1, 12, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (10, 1, 13, '2016-03-27 11:11:36', 0, '2016-03-27 11:11:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (14, 1, 48, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (15, 1, 49, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (16, 1, 50, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (17, 1, 51, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (18, 1, 52, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (19, 1, 53, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (20, 1, 54, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (23, 1, 243, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (24, 1, 244, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (25, 1, 245, '2016-03-28 19:53:34', 0, '2016-03-28 19:53:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (27, 1, 140, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (28, 1, 141, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (29, 1, 163, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (30, 1, 255, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (31, 1, 275, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (32, 1, 276, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (33, 1, 277, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (34, 1, 278, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (35, 1, 281, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (36, 1, 282, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (37, 1, 283, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (38, 1, 313, '2016-04-01 23:06:44', 0, '2016-04-01 23:06:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1028, 1, 270, '2016-04-02 15:38:26', 0, '2016-04-02 15:38:26', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1029, 1, 273, '2016-04-02 15:38:26', 0, '2016-04-02 15:38:26', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1030, 1, 274, '2016-04-02 15:38:26', 0, '2016-04-02 15:38:26', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1031, 1, 271, '2016-06-20 10:59:12', 0, '2016-06-20 10:59:12', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1032, 1, 154, '2016-06-20 21:56:45', 0, '2016-06-20 21:56:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1033, 1, 256, '2016-06-20 21:56:45', 0, '2016-06-20 21:56:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1034, 1, 257, '2016-06-20 21:56:45', 0, '2016-06-20 21:56:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1035, 1, 285, '2016-06-20 21:56:45', 0, '2016-06-20 21:56:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1036, 1, 1313, '2016-06-22 11:49:49', 0, '2016-06-22 11:49:49', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1037, 1, 40, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1038, 1, 42, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1039, 1, 43, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1040, 1, 44, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1041, 1, 46, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1042, 1, 47, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1043, 1, 96, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1044, 1, 101, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1045, 1, 102, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1046, 1, 103, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1047, 1, 104, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1048, 1, 286, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1049, 1, 287, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1050, 1, 288, '2016-08-18 14:00:03', 0, '2016-08-18 14:00:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1051, 1, 41, '2016-08-18 17:36:53', 0, '2016-08-18 17:36:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1052, 1, 164, '2016-08-18 17:36:53', 0, '2016-08-18 17:36:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1053, 1, 165, '2016-08-18 17:36:53', 0, '2016-08-18 17:36:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1054, 1, 1314, '2016-08-18 17:36:53', 0, '2016-08-18 17:36:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1055, 1, 1315, '2016-08-18 17:36:53', 0, '2016-08-18 17:36:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1056, 1, 1316, '2016-08-18 17:36:53', 0, '2016-08-18 17:36:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1057, 1, 1317, '2016-08-20 22:37:53', 0, '2016-08-20 22:37:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1058, 1, 1318, '2016-08-21 13:28:02', 0, '2016-08-21 13:28:02', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1059, 1, 1319, '2016-08-21 13:34:20', 0, '2016-08-21 13:34:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1060, 1, 1320, '2016-08-21 13:34:20', 0, '2016-08-21 13:34:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1061, 1, 1321, '2016-08-25 17:19:19', 0, '2016-08-25 17:19:19', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1062, 1, 1322, '2016-08-25 17:19:19', 0, '2016-08-25 17:19:19', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (1063, 1, 1323, '2016-08-25 17:19:19', 0, '2016-08-25 17:19:19', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2061, 1, 16, '2016-08-29 21:03:58', 0, '2016-08-29 21:03:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2062, 1, 17, '2016-08-29 21:03:58', 0, '2016-08-29 21:03:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2063, 1, 18, '2016-08-29 21:03:58', 0, '2016-08-29 21:03:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2064, 1, 2321, '2016-09-08 21:19:47', 0, '2016-09-08 21:19:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2065, 1, 2322, '2016-09-08 21:19:47', 0, '2016-09-08 21:19:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2066, 1, 2323, '2016-09-08 21:19:47', 0, '2016-09-08 21:19:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2067, 1, 2324, '2016-12-09 22:19:26', 0, '2016-12-09 22:19:26', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2068, 1, 2325, '2016-12-09 22:19:26', 0, '2016-12-09 22:19:26', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2069, 1, 19, '2016-12-13 23:03:07', 0, '2016-12-13 23:03:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2070, 1, 20, '2016-12-13 23:03:07', 0, '2016-12-13 23:03:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2071, 1, 21, '2016-12-13 23:03:07', 0, '2016-12-13 23:03:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2072, 1, 268, '2016-12-13 23:03:07', 0, '2016-12-13 23:03:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2073, 1, 269, '2016-12-13 23:03:07', 0, '2016-12-13 23:03:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2083, 2, 41, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2084, 2, 42, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2087, 2, 46, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2095, 2, 96, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2096, 2, 102, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2097, 2, 103, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2098, 2, 104, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2101, 2, 154, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2103, 2, 164, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2104, 2, 165, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2106, 2, 256, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2112, 2, 285, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2114, 2, 1313, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2115, 2, 1314, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2116, 2, 1315, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2117, 2, 1316, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2118, 2, 1317, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2119, 2, 1318, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2120, 2, 1319, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2121, 2, 1320, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2122, 2, 1321, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2123, 2, 1322, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2124, 2, 1323, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2125, 2, 2321, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2126, 2, 2322, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2127, 2, 2323, '2017-08-16 17:35:07', 0, '2017-08-16 17:35:07', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2130, 3, 4, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2131, 3, 8, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2132, 3, 9, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2133, 3, 10, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2134, 3, 11, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2135, 3, 12, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2136, 3, 13, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2137, 3, 48, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2138, 3, 243, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2139, 3, 244, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2140, 3, 245, '2017-08-16 17:35:50', 0, '2017-08-16 17:35:50', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2141, 1, 2326, '2017-08-22 18:09:08', 0, '2017-08-22 18:09:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2142, 1, 2327, '2017-08-22 18:09:08', 0, '2017-08-22 18:09:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2143, 1, 2328, '2017-09-28 16:22:54', 0, '2017-09-28 16:22:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2144, 1, 2329, '2017-09-28 16:22:54', 0, '2017-09-28 16:22:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2145, 1, 2330, '2017-09-28 16:22:54', 0, '2017-09-28 16:22:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2146, 1, 2331, '2017-11-18 12:50:48', 0, '2017-11-18 12:50:48', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2147, 1, 2332, '2017-11-18 12:50:48', 0, '2017-11-18 12:50:48', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2149, 1, 2333, '2017-11-21 13:52:18', 0, '2017-11-21 13:52:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2150, 1, 2334, '2017-11-21 13:52:18', 0, '2017-11-21 13:52:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2151, 2, 1, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2152, 2, 19, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2153, 2, 20, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2155, 2, 40, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2156, 2, 43, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2157, 2, 44, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2158, 2, 140, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2159, 2, 141, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2160, 2, 163, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2161, 2, 255, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2162, 2, 268, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2163, 2, 269, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2164, 2, 270, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2165, 2, 273, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2166, 2, 274, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2167, 2, 313, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2168, 2, 2324, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2169, 2, 2325, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2170, 2, 2326, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2171, 2, 2327, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2172, 2, 2328, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2173, 2, 2329, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2174, 2, 2330, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2175, 2, 2331, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2176, 2, 2332, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2177, 2, 2333, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2178, 2, 2334, '2017-12-04 21:08:23', 0, '2017-12-04 21:08:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2179, 1, 2335, '2018-01-08 16:25:40', 0, '2018-01-08 16:25:40', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2180, 1, 2336, '2018-01-08 16:25:40', 0, '2018-01-08 16:25:40', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2182, 1, 123, '2018-03-09 09:35:28', 0, '2018-03-09 09:35:28', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2187, 1, 5, '2018-03-09 13:00:47', 0, '2018-03-09 13:00:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2188, 1, 34, '2018-03-09 13:00:47', 0, '2018-03-09 13:00:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2189, 1, 35, '2018-03-09 13:00:47', 0, '2018-03-09 13:00:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2190, 1, 36, '2018-03-09 13:00:47', 0, '2018-03-09 13:00:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2193, 1, 2346, '2018-03-13 09:42:09', 0, '2018-03-13 09:42:09', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2194, 1, 4, '2018-03-13 10:56:58', 0, '2018-03-13 10:56:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2195, 1, 2347, '2018-03-13 17:04:45', 0, '2018-03-13 17:04:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2196, 1, 2348, '2018-03-14 15:32:40', 0, '2018-03-14 15:32:40', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2197, 1, 2354, '2018-03-15 14:49:58', 0, '2018-03-15 14:49:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2198, 1, 2355, '2018-03-15 14:49:58', 0, '2018-03-15 14:49:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2199, 1, 2356, '2018-03-15 14:49:58', 0, '2018-03-15 14:49:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2200, 1, 2357, '2018-03-15 14:49:58', 0, '2018-03-15 14:49:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2203, 1, 2358, '2018-03-29 13:31:46', 0, '2018-03-29 13:31:46', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2204, 1, 2359, '2018-04-02 13:54:19', 0, '2018-04-02 13:54:19', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2205, 2, 2359, '2018-04-02 13:58:34', 0, '2018-04-02 13:58:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2206, 1, 2360, '2018-04-03 11:48:20', 0, '2018-04-03 11:48:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2207, 1, 2361, '2018-04-05 14:17:44', 0, '2018-04-05 14:17:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2208, 1, 2362, '2018-04-08 16:53:05', 0, '2018-04-08 16:53:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2209, 1, 2363, '2018-04-15 10:22:41', 0, '2018-04-15 10:22:41', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2210, 1, 2364, '2018-04-15 10:22:41', 0, '2018-04-15 10:22:41', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2211, 1, 2365, '2018-04-25 14:42:02', 0, '2018-04-25 14:42:02', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2245, 4, 19, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2246, 4, 21, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2248, 4, 43, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2249, 4, 44, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2250, 4, 140, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2251, 4, 141, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2252, 4, 163, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2253, 4, 255, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2254, 4, 313, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2255, 4, 2328, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2256, 4, 2329, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2257, 4, 2330, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2258, 4, 2331, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2259, 4, 2332, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2260, 4, 2333, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2261, 4, 2334, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2262, 4, 2346, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2263, 4, 2347, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2264, 4, 2348, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2265, 4, 2354, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2266, 4, 2355, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2267, 4, 2356, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2268, 4, 2357, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2269, 4, 2358, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2270, 4, 2359, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2271, 4, 2361, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2272, 4, 2362, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2273, 4, 2363, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2274, 4, 2364, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2275, 4, 2365, '2018-05-02 09:44:13', 0, '2018-05-02 09:44:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2276, 1, 2366, '2018-05-11 18:44:54', 0, '2018-05-11 18:44:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2277, 1, 2367, '2018-05-11 18:51:25', 0, '2018-05-11 18:51:25', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2278, 4, 2367, '2018-05-14 10:58:03', 0, '2018-05-14 10:58:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2279, 5, 19, '2018-05-14 13:36:05', 0, '2018-05-14 13:36:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2280, 5, 21, '2018-05-14 13:36:05', 0, '2018-05-14 13:36:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2281, 5, 141, '2018-05-14 13:36:05', 0, '2018-05-14 13:36:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2282, 5, 313, '2018-05-14 13:36:05', 0, '2018-05-14 13:36:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2283, 5, 2358, '2018-05-14 13:36:05', 0, '2018-05-14 13:36:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2284, 5, 2362, '2018-05-14 13:36:05', 0, '2018-05-14 13:36:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2285, 6, 19, '2018-05-14 13:36:45', 0, '2018-05-14 13:36:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2286, 6, 21, '2018-05-14 13:36:45', 0, '2018-05-14 13:36:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2289, 6, 313, '2018-05-14 13:36:45', 0, '2018-05-14 13:36:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2291, 6, 2362, '2018-05-14 13:36:45', 0, '2018-05-14 13:36:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2292, 6, 2363, '2018-05-14 13:36:45', 0, '2018-05-14 13:36:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2293, 6, 2364, '2018-05-14 13:36:45', 0, '2018-05-14 13:36:45', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2294, 5, 2363, '2018-05-14 13:36:54', 0, '2018-05-14 13:36:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2295, 5, 2364, '2018-05-14 13:36:54', 0, '2018-05-14 13:36:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2296, 5, 2361, '2018-05-14 13:38:09', 0, '2018-05-14 13:38:09', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2297, 1, 2368, '2018-05-14 19:50:28', 0, '2018-05-14 19:50:28', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2298, 2, 2367, '2018-05-14 19:50:47', 0, '2018-05-14 19:50:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2299, 2, 2368, '2018-05-14 19:50:47', 0, '2018-05-14 19:50:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2300, 4, 2368, '2018-05-14 19:51:00', 0, '2018-05-14 19:51:00', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2301, 1, 2369, '2018-05-15 13:16:00', 0, '2018-05-15 13:16:00', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2302, 1, 2370, '2018-05-15 13:16:00', 0, '2018-05-15 13:16:00', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2303, 4, 2366, '2018-05-15 13:16:54', 0, '2018-05-15 13:16:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2304, 4, 2369, '2018-05-15 13:16:54', 0, '2018-05-15 13:16:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2306, 1, 2371, '2018-05-16 20:10:03', 0, '2018-05-16 20:10:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2315, 2, 2365, '2018-05-16 20:10:23', 0, '2018-05-16 20:10:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2316, 2, 2366, '2018-05-16 20:10:23', 0, '2018-05-16 20:10:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2317, 2, 2369, '2018-05-16 20:10:23', 0, '2018-05-16 20:10:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2318, 2, 2370, '2018-05-16 20:10:23', 0, '2018-05-16 20:10:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2319, 2, 2371, '2018-05-16 20:10:23', 0, '2018-05-16 20:10:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2320, 4, 2371, '2018-05-16 20:10:44', 0, '2018-05-16 20:10:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2321, 1, 2372, '2018-05-17 09:44:12', 0, '2018-05-17 09:44:12', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2323, 5, 2368, '2018-05-17 13:06:59', 0, '2018-05-17 13:06:59', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2324, 5, 4, '2018-05-17 13:07:18', 0, '2018-05-17 13:07:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2325, 5, 5, '2018-05-17 13:07:18', 0, '2018-05-17 13:07:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2326, 1, 2373, '2018-05-18 11:54:29', 0, '2018-05-18 11:54:29', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2327, 1, 2374, '2018-05-22 15:01:28', 0, '2018-05-22 15:01:28', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2328, 1, 2375, '2018-05-22 15:02:16', 0, '2018-05-22 15:02:16', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2331, 4, 102, '2018-05-22 15:04:32', 0, '2018-05-22 15:04:32', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2332, 4, 2374, '2018-05-22 15:04:32', 0, '2018-05-22 15:04:32', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2333, 4, 2375, '2018-05-22 15:04:32', 0, '2018-05-22 15:04:32', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2334, 1, 2376, '2018-05-23 12:51:44', 0, '2018-05-23 12:51:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2335, 4, 2376, '2018-05-23 12:51:55', 0, '2018-05-23 12:51:55', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2336, 2, 2374, '2018-05-29 10:04:32', 0, '2018-05-29 10:04:32', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2337, 2, 2375, '2018-05-29 10:04:32', 0, '2018-05-29 10:04:32', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2338, 1, 2377, '2018-05-29 10:05:03', 0, '2018-05-29 10:05:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2339, 1, 2378, '2018-05-29 10:05:03', 0, '2018-05-29 10:05:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2340, 4, 2377, '2018-05-29 10:05:17', 0, '2018-05-29 10:05:17', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2341, 4, 2378, '2018-05-29 10:05:17', 0, '2018-05-29 10:05:17', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2342, 1, 2379, '2018-05-30 10:20:01', 0, '2018-05-30 10:20:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2343, 1, 2380, '2018-06-04 20:54:47', 0, '2018-06-04 20:54:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2344, 4, 40, '2018-06-04 20:55:04', 0, '2018-06-04 20:55:04', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2345, 4, 2380, '2018-06-04 20:55:04', 0, '2018-06-04 20:55:04', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2346, 4, 2379, '2018-06-11 13:54:03', 0, '2018-06-11 13:54:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2348, 1, 2381, '2018-06-12 10:50:58', 0, '2018-06-12 10:50:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2349, 1, 2382, '2018-06-12 10:50:58', 0, '2018-06-12 10:50:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2350, 4, 2381, '2018-06-12 10:51:40', 0, '2018-06-12 10:51:40', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2351, 4, 2382, '2018-06-12 10:51:40', 0, '2018-06-12 10:51:40', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2450, 7, 19, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2451, 7, 21, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2452, 7, 40, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2453, 7, 43, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2454, 7, 44, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2455, 7, 102, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2456, 7, 140, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2457, 7, 141, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2458, 7, 163, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2459, 7, 255, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2460, 7, 313, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2461, 7, 2328, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2462, 7, 2329, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2463, 7, 2330, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2464, 7, 2331, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2465, 7, 2332, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2466, 7, 2333, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2467, 7, 2334, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2468, 7, 2346, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2469, 7, 2347, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2470, 7, 2348, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2471, 7, 2356, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2472, 7, 2357, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2473, 7, 2358, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2474, 7, 2359, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2475, 7, 2361, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2476, 7, 2362, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2477, 7, 2363, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2478, 7, 2364, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2479, 7, 2365, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2480, 7, 2366, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2481, 7, 2367, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2482, 7, 2368, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2483, 7, 2369, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2484, 7, 2370, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2485, 7, 2371, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2486, 7, 2372, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2487, 7, 2374, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2488, 7, 2375, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2489, 7, 2376, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2490, 7, 2377, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2491, 7, 2378, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2492, 7, 2379, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2493, 7, 2380, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2494, 7, 2381, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2495, 7, 2382, '2018-06-12 15:17:01', 0, '2018-06-12 15:17:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2496, 1, 2383, '2018-06-13 16:44:55', 0, '2018-06-13 16:44:55', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2497, 4, 2383, '2018-06-13 16:45:06', 0, '2018-06-13 16:45:06', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2502, 6, 2361, '2018-06-13 18:35:13', 0, '2018-06-13 18:35:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2503, 6, 2369, '2018-06-13 18:35:13', 0, '2018-06-13 18:35:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2504, 6, 2370, '2018-06-13 18:35:13', 0, '2018-06-13 18:35:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2505, 6, 2372, '2018-06-13 18:35:13', 0, '2018-06-13 18:35:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2507, 6, 2382, '2018-06-13 18:37:01', 0, '2018-06-13 18:37:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2508, 1, 2384, '2018-06-15 19:11:18', 0, '2018-06-15 19:11:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2509, 4, 2384, '2018-06-15 19:11:43', 0, '2018-06-15 19:11:43', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2510, 4, 2385, '2018-06-22 15:20:02', 0, '2018-06-22 15:20:02', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2511, 7, 2385, '2018-06-22 15:20:09', 0, '2018-06-22 15:20:09', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2512, 1, 2386, '2018-06-25 11:57:04', 0, '2018-06-25 11:57:04', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2513, 1, 2387, '2018-06-25 11:57:04', 0, '2018-06-25 11:57:04', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2515, 4, 2386, '2018-06-25 12:32:20', 0, '2018-06-25 12:32:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2516, 4, 2387, '2018-06-25 12:32:20', 0, '2018-06-25 12:32:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2517, 5, 2381, '2018-06-25 12:34:17', 0, '2018-06-25 12:34:17', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2518, 5, 2382, '2018-06-25 12:34:17', 0, '2018-06-25 12:34:17', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2519, 7, 2386, '2018-06-25 12:35:14', 0, '2018-06-25 12:35:14', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2520, 7, 2387, '2018-06-25 12:35:14', 0, '2018-06-25 12:35:14', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2537, 2, 2361, '2018-06-25 12:35:53', 0, '2018-06-25 12:35:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2676, 2, 21, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2677, 2, 48, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2678, 2, 49, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2679, 2, 52, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2680, 2, 123, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2681, 2, 243, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2682, 2, 2346, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2683, 2, 2348, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2684, 2, 2356, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2685, 2, 2357, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2686, 2, 2358, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2687, 2, 2360, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2688, 2, 2362, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2689, 2, 2363, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2690, 2, 2364, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2691, 2, 2372, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2692, 2, 2376, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2693, 2, 2377, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2694, 2, 2378, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2695, 2, 2379, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2696, 2, 2380, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2697, 2, 2381, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2698, 2, 2382, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2699, 2, 2383, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2700, 2, 2384, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2701, 2, 2385, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2702, 2, 2386, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2703, 2, 2387, '2018-06-25 12:36:39', 0, '2018-06-25 12:36:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2704, 6, 140, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2705, 6, 141, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2706, 6, 2368, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2707, 6, 2374, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2708, 6, 2375, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2709, 6, 2379, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2710, 6, 2380, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2711, 6, 2381, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2712, 6, 2383, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2713, 6, 2384, '2018-06-26 13:52:53', 0, '2018-06-26 13:52:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2715, 1, 2385, '2018-06-26 17:16:00', 0, '2018-06-26 17:16:00', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2716, 1, 2388, '2018-06-26 17:16:00', 0, '2018-06-26 17:16:00', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2717, 4, 2388, '2018-06-26 17:16:29', 0, '2018-06-26 17:16:29', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2718, 1, 2389, '2018-06-26 17:19:20', 0, '2018-06-26 17:19:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2719, 4, 2389, '2018-06-26 17:19:27', 0, '2018-06-26 17:19:27', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2720, 2, 2388, '2018-06-26 17:19:42', 0, '2018-06-26 17:19:42', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2721, 2, 2389, '2018-06-26 17:19:42', 0, '2018-06-26 17:19:42', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2724, 7, 2383, '2018-06-26 17:19:57', 0, '2018-06-26 17:19:57', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2725, 7, 2384, '2018-06-26 17:19:57', 0, '2018-06-26 17:19:57', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2726, 7, 2388, '2018-06-26 17:19:57', 0, '2018-06-26 17:19:57', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2727, 7, 2389, '2018-06-26 17:19:57', 0, '2018-06-26 17:19:57', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2728, 1, 2390, '2018-07-02 09:23:08', 0, '2018-07-02 09:23:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2729, 1, 2391, '2018-07-02 09:23:08', 0, '2018-07-02 09:23:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2730, 2, 2373, '2018-07-02 09:23:51', 0, '2018-07-02 09:23:51', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2731, 2, 2390, '2018-07-02 09:23:51', 0, '2018-07-02 09:23:51', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2732, 2, 2391, '2018-07-02 09:23:51', 0, '2018-07-02 09:23:51', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2733, 7, 2373, '2018-07-02 09:24:06', 0, '2018-07-02 09:24:06', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2734, 7, 2390, '2018-07-02 09:24:06', 0, '2018-07-02 09:24:06', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2735, 7, 2391, '2018-07-02 09:24:06', 0, '2018-07-02 09:24:06', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2736, 4, 2390, '2018-07-02 09:24:43', 0, '2018-07-02 09:24:43', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2737, 4, 2391, '2018-07-02 09:24:43', 0, '2018-07-02 09:24:43', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2738, 4, 48, '2018-07-04 13:49:04', 0, '2018-07-04 13:49:04', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2739, 4, 52, '2018-07-04 13:49:04', 0, '2018-07-04 13:49:04', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2740, 1, 2392, '2018-07-16 14:24:01', 0, '2018-07-16 14:24:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2741, 2, 2392, '2018-07-16 14:24:08', 0, '2018-07-16 14:24:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2742, 7, 2392, '2018-07-16 14:24:29', 0, '2018-07-16 14:24:29', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2743, 4, 2392, '2018-07-16 14:24:47', 0, '2018-07-16 14:24:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2744, 1, 2393, '2018-07-16 15:02:11', 0, '2018-07-16 15:02:11', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2746, 7, 2393, '2018-07-16 15:02:28', 0, '2018-07-16 15:02:28', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2747, 4, 2393, '2018-07-16 15:02:38', 0, '2018-07-16 15:02:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2748, 41, 2394, '2018-07-17 15:34:36', 0, '2018-07-17 15:34:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2749, 41, 2395, '2018-07-17 15:34:36', 0, '2018-07-17 15:34:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2750, 41, 2396, '2018-07-17 15:34:36', 0, '2018-07-17 15:34:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2751, 1, 2397, '2018-07-18 13:43:21', 0, '2018-07-18 13:43:21', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2752, 2, 2397, '2018-07-18 13:43:31', 0, '2018-07-18 13:43:31', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2753, 7, 2397, '2018-07-18 13:43:41', 0, '2018-07-18 13:43:41', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2754, 4, 2397, '2018-07-18 13:44:05', 0, '2018-07-18 13:44:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2755, 1, 2398, '2018-07-31 15:48:52', 0, '2018-07-31 15:48:52', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2756, 2, 2398, '2018-07-31 15:49:00', 0, '2018-07-31 15:49:00', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2757, 7, 2398, '2018-07-31 15:49:08', 0, '2018-07-31 15:49:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2758, 4, 2398, '2018-07-31 15:49:23', 0, '2018-07-31 15:49:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2759, 1, 2399, '2018-07-31 16:01:05', 0, '2018-07-31 16:01:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2760, 2, 2399, '2018-07-31 16:01:15', 0, '2018-07-31 16:01:15', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2761, 7, 2399, '2018-07-31 16:01:22', 0, '2018-07-31 16:01:22', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2762, 4, 2399, '2018-07-31 16:01:34', 0, '2018-07-31 16:01:34', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2763, 1, 2400, '2018-08-01 15:06:59', 0, '2018-08-01 15:06:59', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2764, 2, 2400, '2018-08-01 15:07:47', 0, '2018-08-01 15:07:47', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2765, 7, 2400, '2018-08-01 15:07:54', 0, '2018-08-01 15:07:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2766, 4, 2400, '2018-08-01 15:08:03', 0, '2018-08-01 15:08:03', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2767, 1, 2401, '2018-08-02 15:19:54', 0, '2018-08-02 15:19:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2768, 1, 2402, '2018-08-02 15:19:54', 0, '2018-08-02 15:19:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2769, 2, 2393, '2018-08-02 15:20:02', 0, '2018-08-02 15:20:02', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2770, 2, 2401, '2018-08-02 15:20:02', 0, '2018-08-02 15:20:02', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2771, 7, 2401, '2018-08-02 15:20:09', 0, '2018-08-02 15:20:09', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2772, 7, 2402, '2018-08-02 15:20:09', 0, '2018-08-02 15:20:09', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2773, 4, 2401, '2018-08-02 15:20:19', 0, '2018-08-02 15:20:19', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2774, 4, 2402, '2018-08-02 15:20:19', 0, '2018-08-02 15:20:19', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2775, 1, 2403, '2018-08-07 09:15:42', 0, '2018-08-07 09:15:42', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2776, 1, 2404, '2018-08-07 09:15:42', 0, '2018-08-07 09:15:42', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2777, 2, 2403, '2018-08-07 09:16:05', 0, '2018-08-07 09:16:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2778, 2, 2404, '2018-08-07 09:16:05', 0, '2018-08-07 09:16:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2779, 5, 2403, '2018-08-07 09:16:36', 0, '2018-08-07 09:16:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2780, 5, 2404, '2018-08-07 09:16:36', 0, '2018-08-07 09:16:36', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2781, 6, 2403, '2018-08-07 09:17:15', 0, '2018-08-07 09:17:15', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2782, 6, 2404, '2018-08-07 09:17:15', 0, '2018-08-07 09:17:15', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2795, 8, 2403, '2018-08-13 18:30:53', 0, '2018-08-13 18:30:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2796, 8, 2405, '2018-08-13 18:30:53', 0, '2018-08-13 18:30:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2797, 8, 2406, '2018-08-13 18:30:53', 0, '2018-08-13 18:30:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2798, 8, 2407, '2018-08-13 18:30:53', 0, '2018-08-13 18:30:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2799, 8, 2408, '2018-08-13 18:30:53', 0, '2018-08-13 18:30:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2800, 8, 2409, '2018-08-13 18:30:53', 0, '2018-08-13 18:30:53', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2803, 9, 2368, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2804, 9, 2374, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2805, 9, 2375, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2806, 9, 2380, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2807, 9, 2383, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2808, 9, 2384, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2809, 9, 2398, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2810, 9, 2399, '2018-08-13 18:33:18', 0, '2018-08-13 18:33:18', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2817, 9, 2363, '2018-08-14 09:56:24', 0, '2018-08-14 09:56:24', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2818, 9, 2400, '2018-08-14 09:56:24', 0, '2018-08-14 09:56:24', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2819, 42, 40, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2820, 42, 43, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2821, 42, 44, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2822, 42, 102, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2823, 42, 2366, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2824, 42, 2368, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2825, 42, 2374, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2826, 42, 2375, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2827, 42, 2380, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2828, 42, 2381, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2829, 42, 2382, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2830, 42, 2383, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2831, 42, 2384, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2832, 42, 2397, '2018-08-14 15:44:38', 0, '2018-08-14 15:44:38', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2833, 1, 2410, '2018-08-14 17:47:30', 0, '2018-08-14 17:47:30', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2834, 1, 2411, '2018-08-14 17:47:30', 0, '2018-08-14 17:47:30', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2835, 2, 2402, '2018-08-14 17:47:44', 0, '2018-08-14 17:47:44', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2836, 1, 2412, '2018-08-17 10:11:08', 0, '2018-08-17 10:11:08', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2837, 2, 2412, '2018-08-17 10:11:14', 0, '2018-08-17 10:11:14', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2838, 7, 2412, '2018-08-17 10:11:24', 0, '2018-08-17 10:11:24', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2839, 5, 2374, '2018-08-17 10:12:05', 0, '2018-08-17 10:12:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2840, 5, 2375, '2018-08-17 10:12:05', 0, '2018-08-17 10:12:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2841, 5, 2380, '2018-08-17 10:12:05', 0, '2018-08-17 10:12:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2842, 5, 2383, '2018-08-17 10:12:05', 0, '2018-08-17 10:12:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2843, 5, 2384, '2018-08-17 10:12:05', 0, '2018-08-17 10:12:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2844, 5, 2412, '2018-08-17 10:12:05', 0, '2018-08-17 10:12:05', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2845, 6, 2412, '2018-08-17 10:12:16', 0, '2018-08-17 10:12:16', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2846, 4, 2412, '2018-08-17 16:19:54', 0, '2018-08-17 16:19:54', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2847, 1, 2413, '2018-08-17 17:48:23', 0, '2018-08-17 17:48:23', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2848, 1, 2414, '2018-08-17 17:55:26', 0, '2018-08-17 17:55:26', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2850, 2, 2413, '2018-08-17 17:55:39', 0, '2018-08-17 17:55:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2851, 2, 2414, '2018-08-17 17:55:39', 0, '2018-08-17 17:55:39', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2852, 7, 2413, '2018-08-17 17:55:48', 0, '2018-08-17 17:55:48', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2853, 7, 2414, '2018-08-17 17:55:48', 0, '2018-08-17 17:55:48', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2854, 4, 2413, '2018-08-17 17:55:58', 0, '2018-08-17 17:55:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2855, 4, 2414, '2018-08-17 17:55:58', 0, '2018-08-17 17:55:58', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2856, 5, 2413, '2018-08-17 17:56:10', 0, '2018-08-17 17:56:10', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2857, 5, 2414, '2018-08-17 17:56:10', 0, '2018-08-17 17:56:10', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2858, 6, 2413, '2018-08-17 17:56:20', 0, '2018-08-17 17:56:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2859, 6, 2414, '2018-08-17 17:56:20', 0, '2018-08-17 17:56:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2860, 9, 2412, '2018-08-17 17:56:33', 0, '2018-08-17 17:56:33', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2861, 9, 2413, '2018-08-17 17:56:33', 0, '2018-08-17 17:56:33', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2862, 9, 2414, '2018-08-17 17:56:33', 0, '2018-08-17 17:56:33', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2863, 1, 2415, '2018-08-27 13:54:30', 0, '2018-08-27 13:54:30', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2864, 9, 2415, '2018-08-27 13:55:02', 0, '2018-08-27 13:55:02', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2865, 1, 2416, '2018-08-30 17:54:13', 0, '2018-08-30 17:54:13', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2866, 1, 2417, '2018-08-31 13:19:01', 0, '2018-08-31 13:19:01', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2867, 9, 2401, '2018-09-03 09:41:55', 0, '2018-09-03 09:41:55', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2868, 9, 2416, '2018-09-03 09:41:55', 0, '2018-09-03 09:41:55', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2869, 9, 2417, '2018-09-03 09:41:55', 0, '2018-09-03 09:41:55', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2870, 1, 2418, '2018-09-04 15:53:16', 0, '2018-09-04 15:53:16', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2871, 1, 2419, '2018-09-06 14:43:20', 0, '2018-09-06 14:43:20', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2872, 1, 2420, '2018-09-07 10:23:57', 0, '2018-09-07 10:23:57', 0, 1, 0);
INSERT INTO `sys_role_module` VALUES (2873, 1, 2421, '2018-09-07 10:23:57', 0, '2018-09-07 10:23:57', 0, 1, 0);

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
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1, '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 0, 1);
INSERT INTO `sys_user_role` VALUES (2, 2, 2, '2018-07-12 20:00:00', 1, '2018-07-12 20:00:00', 1, 0, 1);

SET FOREIGN_KEY_CHECKS = 1;
