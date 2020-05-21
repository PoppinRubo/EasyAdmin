/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100410
 Source Host           : localhost:3306
 Source Schema         : admin

 Target Server Type    : MySQL
 Target Server Version : 100410
 File Encoding         : 65001

 Date: 21/05/2020 18:44:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_button`;
CREATE TABLE `sys_button`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '按钮名称',
  `english_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '按钮英文名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图标',
  `sort` int(11) NOT NULL COMMENT '排序',
  `remark` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '按钮表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_button
-- ----------------------------
INSERT INTO `sys_button` VALUES (1, '添加', 'add', 'layui-icon-add-1', 10, '添加按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (2, '编辑', 'edit', 'layui-icon-edit', 30, '编辑按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (3, '删除', 'remove', 'layui-icon-delete', 40, '删除按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (4, '添加子级', 'addSon', 'layui-icon-add-1', 20, '添加子级按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (5, '按钮配置', 'moduleButton', 'icon-link2', 50, '模块配置按钮关联', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (6, '自动排序', 'sorting', 'icon-sort-amount-asc', 60, '自动排序按钮', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (7, '权限配置', 'roleModule', 'icon-squarespace', 70, '角色关联模块', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (8, '角色配置', 'userRole', 'icon-squarespace', 80, '用户关联角色', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (9, '密码重置', 'resetpassword', 'icon-back', 90, '用户密码重置', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_button` VALUES (10, '调整层级', 'move', 'icon-hand', 100, '调整菜单层级', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_module`;
CREATE TABLE `sys_module`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父级模块编号',
  `level` int(2) NOT NULL COMMENT '层级',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块名称',
  `link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '模块链接',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图标',
  `sort` int(11) NOT NULL DEFAULT 100 COMMENT '排序',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统模块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_module
-- ----------------------------
INSERT INTO `sys_module` VALUES (1, 0, 1, '系统管理', '', 'icon-briefcase', 10, '系统管理', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module` VALUES (2, 1, 2, '字体图标', '/icon/index', 'icon-open-book', 10, '字体图标', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module` VALUES (3, 1, 2, '用户列表', '/user/index', 'icon-user', 20, '系统用户', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module` VALUES (4, 1, 2, '模块列表', '/module/index', 'icon-books', 40, '系统模块', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module` VALUES (5, 1, 2, '按钮管理', '/button/index', 'icon-bigcartel', 50, '按钮管理', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module` VALUES (6, 1, 2, '角色列表', '/role/index', 'icon-jira', 30, '系统角色', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_module_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_module_button`;
CREATE TABLE `sys_module_button`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `button_id` int(11) NOT NULL COMMENT '按钮编号',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统模块、按钮关系表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_module_button
-- ----------------------------
INSERT INTO `sys_module_button` VALUES (1, 5, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (2, 5, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (3, 5, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (4, 4, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (5, 4, 4, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (6, 4, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (7, 4, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (8, 4, 5, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (9, 3, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (10, 3, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (11, 3, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (12, 5, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (13, 4, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (14, 6, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (15, 6, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (16, 6, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (17, 6, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (18, 6, 7, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (19, 3, 8, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (20, 3, 9, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_module_button` VALUES (21, 4, 10, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `sort` int(11) NOT NULL COMMENT '排序',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '备注',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 10, '超级管理员', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role` VALUES (2, '系统管理员', 20, '系统管理员', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_role_button
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_button`;
CREATE TABLE `sys_role_button`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `button_id` int(11) NOT NULL COMMENT '按钮编号',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色、按钮、模块关系表/按钮权限控制表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_role_button
-- ----------------------------
INSERT INTO `sys_role_button` VALUES (1, 1, 6, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (2, 1, 6, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (3, 1, 6, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (4, 1, 6, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (5, 1, 6, 7, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (6, 1, 3, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (7, 1, 3, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (8, 1, 3, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (9, 1, 3, 8, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (10, 1, 4, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (11, 1, 4, 4, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (12, 1, 4, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (13, 1, 4, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (14, 1, 4, 5, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (15, 1, 4, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (16, 1, 5, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (17, 1, 5, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (18, 1, 5, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (19, 1, 5, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (20, 1, 3, 9, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_button` VALUES (21, 1, 4, 10, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_role_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_module`;
CREATE TABLE `sys_role_module`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色模块关系表/模块权限控制表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_role_module
-- ----------------------------
INSERT INTO `sys_role_module` VALUES (1, 1, 3, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_module` VALUES (2, 1, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_module` VALUES (3, 1, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_module` VALUES (4, 1, 6, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_module` VALUES (5, 1, 4, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_role_module` VALUES (6, 1, 5, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '帐号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `gender` int(1) NOT NULL COMMENT '性别',
  `login_times` int(11) NOT NULL DEFAULT 0 COMMENT '登录次数',
  `last_login_time` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'f379eaf3c831b04de153469d1bec345e', '超级管理员', 1, 0, '2020-05-20 20:00:00', '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_login_log`;
CREATE TABLE `sys_user_login_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录IP地址',
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户编号',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_login_log
-- ----------------------------
INSERT INTO `sys_user_login_log` VALUES (1, '127.0.0.1', '1', '2020-05-21 16:06:40', 0);
INSERT INTO `sys_user_login_log` VALUES (2, '::1', '1', '2020-05-21 18:31:22', 0);
INSERT INTO `sys_user_login_log` VALUES (3, '::1', '1', '2020-05-21 18:32:31', 0);
INSERT INTO `sys_user_login_log` VALUES (4, '::1', '1', '2020-05-21 18:33:22', 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建人',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `modify_user` int(11) NOT NULL COMMENT '修改人',
  `is_valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效',
  `is_del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_UserRole_User`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户、角色关系表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (2, 1, 2, '2020-05-20 20:00:00', 1, '2020-05-20 20:00:00', 1, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
