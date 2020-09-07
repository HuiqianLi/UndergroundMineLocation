/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50151
Source Host           : localhost:3306
Source Database       : user

Target Server Type    : MYSQL
Target Server Version : 50151
File Encoding         : 65001

Date: 2020-04-26 15:57:31
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `createTime` varchar(255) DEFAULT NULL,
  `editTime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '123', 'e10adc3949ba59abbe56e057f20f883e', '187111111111', null, null, '2020-04-05 14:18:32');
INSERT INTO `user` VALUES ('2', '1234', 'e10adc3949ba59abbe56e057f20f883e', '187111111111', null, null, '2020-04-05 14:45:29');
INSERT INTO `user` VALUES ('3', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', null, null, null, '2020-04-05 14:45:33');
INSERT INTO `user` VALUES ('4', 'zhaosi', '202cb962ac59075b964b07152d234b70', null, '1@qq.com', null, '2020-04-05 14:46:00');
INSERT INTO `user` VALUES ('5', 'liwu', '123456', '12345678922', '22592@qq.com', null, '2020-04-15 08:30:05');
INSERT INTO `user` VALUES ('7', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '12@qq.com', null, '2020-04-15 08:55:26');
INSERT INTO `user` VALUES ('8', 'liuliu', 'e10adc3949ba59abbe56e057f20f883e', '', '1@qq.com', null, '2020-04-15 08:56:02');
