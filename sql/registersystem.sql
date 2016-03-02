/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : registersystem

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2016-02-26 14:50:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `adminuser`
-- ----------------------------
DROP TABLE IF EXISTS `adminuser`;
CREATE TABLE `adminuser` (
  `adminusername` varchar(40) NOT NULL,
  `adminuserpassword` varchar(40) DEFAULT NULL,
  `adminuserrole` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`adminusername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminuser
-- ----------------------------

-- ----------------------------
-- Table structure for `bedchamber`
-- ----------------------------
DROP TABLE IF EXISTS `bedchamber`;
CREATE TABLE `bedchamber` (
  `BedchamberId` int(11) unsigned NOT NULL,
  `BedchamberName` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`BedchamberId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bedchamber
-- ----------------------------

-- ----------------------------
-- Table structure for `classta`
-- ----------------------------
DROP TABLE IF EXISTS `classta`;
CREATE TABLE `classta` (
  `ClassId` int(11) unsigned NOT NULL,
  `ClassName` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ClassId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classta
-- ----------------------------

-- ----------------------------
-- Table structure for `speciality`
-- ----------------------------
DROP TABLE IF EXISTS `speciality`;
CREATE TABLE `speciality` (
  `SpecialityId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `SpecialityName` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`SpecialityId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of speciality
-- ----------------------------
INSERT INTO `speciality` VALUES ('7', '通信工程');
INSERT INTO `speciality` VALUES ('8', '软件工程');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `StudentId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `StudentName` varchar(40) DEFAULT NULL,
  `SpecialityId` int(11) unsigned DEFAULT NULL,
  `ClassId` int(11) unsigned DEFAULT NULL,
  `BedchamberId` int(11) unsigned DEFAULT NULL,
  `MatriNo` varchar(20) DEFAULT NULL,
  `PayOk` tinyint(4) DEFAULT NULL,
  `RegistDate` date DEFAULT NULL,
  PRIMARY KEY (`StudentId`),
  KEY `BedchamberId` (`BedchamberId`),
  KEY `FK_ClassTa` (`ClassId`),
  KEY `FK_Speciality` (`SpecialityId`),
  CONSTRAINT `FK_Bedchamber` FOREIGN KEY (`BedchamberId`) REFERENCES `bedchamber` (`BedchamberId`) ON DELETE SET NULL,
  CONSTRAINT `FK_ClassTa` FOREIGN KEY (`ClassId`) REFERENCES `classta` (`ClassId`) ON DELETE SET NULL,
  CONSTRAINT `FK_Speciality` FOREIGN KEY (`SpecialityId`) REFERENCES `speciality` (`SpecialityId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
