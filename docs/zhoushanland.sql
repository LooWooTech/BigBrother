-- --------------------------------------------------------
-- 主机:                           10.22.102.90
-- 服务器版本:                        5.1.73-community - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 zhoushanland 的数据库结构
CREATE DATABASE IF NOT EXISTS `zhoushanland` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `zhoushanland`;


-- 导出  表 zhoushanland.area 结构
CREATE TABLE IF NOT EXISTS `area` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.area 的数据：~10 rows (大约)
DELETE FROM `area`;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`ID`, `Name`, `ParentID`) VALUES
	(1, '市本级', 0),
	(2, '定海区', 0),
	(3, '普陀区', 0),
	(4, '岱山县', 0),
	(5, '嵊泗县', 0),
	(6, '新城', 1),
	(7, '产业集聚区', 1),
	(8, '金塘', 2),
	(9, '六横', 3),
	(10, '朱家尖', 3);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;


-- 导出  表 zhoushanland.dossier 结构
CREATE TABLE IF NOT EXISTS `dossier` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Year` int(11) NOT NULL,
  `Quarter` int(11) NOT NULL,
  `Remark` varchar(1023) DEFAULT NULL,
  `UploadTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.dossier 的数据：~0 rows (大约)
DELETE FROM `dossier`;
/*!40000 ALTER TABLE `dossier` DISABLE KEYS */;
/*!40000 ALTER TABLE `dossier` ENABLE KEYS */;


-- 导出  表 zhoushanland.dossierfile 结构
CREATE TABLE IF NOT EXISTS `dossierfile` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FileName` varchar(255) NOT NULL,
  `FilePath` varchar(1023) NOT NULL,
  `DossierID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.dossierfile 的数据：~0 rows (大约)
DELETE FROM `dossierfile`;
/*!40000 ALTER TABLE `dossierfile` DISABLE KEYS */;
/*!40000 ALTER TABLE `dossierfile` ENABLE KEYS */;


-- 导出  表 zhoushanland.form 结构
CREATE TABLE IF NOT EXISTS `form` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `ImportTemplate` varchar(512) DEFAULT NULL,
  `ExportTemplate` varchar(512) DEFAULT NULL,
  `ExcludeSubArea` bit(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.form 的数据：~9 rows (大约)
DELETE FROM `form`;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` (`ID`, `Name`, `ImportTemplate`, `ExportTemplate`, `ExcludeSubArea`) VALUES
	(1, '建设用地预审', NULL, NULL, b'1'),
	(2, '建设用地审批', NULL, NULL, b'1'),
	(3, '建设用地供应', NULL, NULL, b'1'),
	(4, '土地储备', NULL, NULL, b'1'),
	(5, '土地征收', NULL, NULL, b'1'),
	(6, '土地登记', NULL, NULL, b'1'),
	(7, '矿业权市场', NULL, NULL, b'1'),
	(8, '国土资源违法案件', NULL, NULL, b'1'),
	(9, '信访', NULL, NULL, b'1');
/*!40000 ALTER TABLE `form` ENABLE KEYS */;


-- 导出  表 zhoushanland.node 结构
CREATE TABLE IF NOT EXISTS `node` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FormID` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `Group` varchar(50) DEFAULT NULL,
  `ValueTypes` varchar(50) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FormID` (`FormID`),
  KEY `ParentID` (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.node 的数据：~79 rows (大约)
DELETE FROM `node`;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` (`ID`, `FormID`, `ParentID`, `Name`, `Group`, `ValueTypes`) VALUES
	(1, 1, 0, '预审件数（件）', NULL, '2'),
	(2, 1, 0, '预审面积', NULL, '1'),
	(3, 1, 2, '耕地', NULL, '1'),
	(4, 1, 2, '能源用地', NULL, '1'),
	(5, 1, 2, '交通用地', NULL, '1'),
	(6, 1, 2, '水利用地', NULL, '1'),
	(7, 1, 2, '其他用地', NULL, '1'),
	(8, 2, 0, '批准建设用地面积', NULL, '1'),
	(9, 2, 8, '新增建设用地', '新增', '1'),
	(10, 2, 9, '农用地', NULL, '1'),
	(11, 2, 9, '未利用地', NULL, '1'),
	(12, 2, 10, '耕地', NULL, '1'),
	(13, 2, 8, '城市分批次建设用地', NULL, '1'),
	(14, 2, 8, '单独选址建设用地', NULL, '1'),
	(15, 2, 14, '能源用地', NULL, '1'),
	(16, 2, 14, '交通用地', NULL, '1'),
	(17, 2, 14, '水利用地', NULL, '1'),
	(18, 2, 14, '其他用地', NULL, '1'),
	(19, 3, 0, '建设用地供应总量', NULL, '1'),
	(20, 3, 19, '新增建设用地', '新增', '1'),
	(21, 3, 19, '房地产用地', NULL, '1'),
	(22, 3, 21, '商服用地', NULL, '1'),
	(23, 3, 21, '普通商品房用地', NULL, '1'),
	(24, 3, 19, '工业仓储用地', NULL, '1'),
	(25, 3, 19, '其他用地', NULL, '1'),
	(26, 3, 19, '划拨面积', '供地方式', '1'),
	(27, 3, 19, '出让面积', '供地方式', '1'),
	(28, 3, 27, '招拍挂出让面积', NULL, '1'),
	(29, 3, 0, '出让金（万元）', NULL, '4'),
	(30, 4, 0, '新增土地储备宗数', NULL, '3'),
	(31, 4, 0, '新增土地储备面积', NULL, '1'),
	(32, 4, 31, '回收土地', NULL, '1'),
	(33, 4, 31, '收购土地', NULL, '1'),
	(34, 4, 31, '其他', NULL, '1'),
	(35, 4, 0, '期内支出（万元）', NULL, '4'),
	(36, 4, 35, '补偿款', NULL, '4'),
	(37, 4, 35, '开发费', NULL, '4'),
	(38, 4, 0, '结算土地收储成本', NULL, '4'),
	(39, 4, 0, '报告期末土地储备面积', NULL, '1'),
	(40, 5, 0, '土地征收面积', NULL, '1'),
	(41, 5, 40, '农用地', NULL, '1'),
	(42, 5, 41, '耕地', NULL, '1'),
	(43, 5, 40, '征收费用', NULL, '4'),
	(44, 5, 40, '安置农业人口（人）', NULL, '6'),
	(45, 6, 0, '土地抵押登记宗数（宗）', '期末情况', '3'),
	(46, 6, 0, '土地抵押面积', '期末情况', '1'),
	(47, 6, 0, '抵押贷款金额（亿元）', '期末情况', '4'),
	(48, 6, 0, '土地抵押登记宗数（宗）', '期内增加', '3'),
	(49, 6, 0, '土地抵押登记面积', '期内增加', '1'),
	(50, 6, 0, '抵押贷款金额（亿元）', '期内增加', '4'),
	(51, 6, 0, '土地抵押登记宗数（宗）', '期内减少', '3'),
	(52, 6, 0, '土地抵押登记面积', '期内减少', '1'),
	(53, 6, 0, '抵押贷款金额（亿元）', '期内减少', '4'),
	(54, 6, 0, '国有土地使用权', NULL, '3'),
	(55, 6, 0, '集体土地所有权', NULL, '3'),
	(56, 6, 0, '集体土地使用权', NULL, '3'),
	(57, 6, 0, '宅基地使用权', NULL, '3'),
	(58, 7, 0, '采矿权许可证数', NULL, '5'),
	(59, 7, 58, '新立', NULL, '5'),
	(60, 7, 58, '撤销', NULL, '5'),
	(61, 7, 0, '采矿权出让个数', '采矿权出让', '5'),
	(62, 7, 0, '缴纳采矿权出让价款（万元）', '采矿权出让', '4'),
	(63, 7, 0, '采矿权转让个数', '采矿权转让', '5'),
	(64, 7, 0, '采矿权转让价款（万元）', '采矿权转让', '4'),
	(65, 8, 0, '土地违法案件（件）', NULL, '2'),
	(66, 8, 65, '涉及土地面积', NULL, '1'),
	(67, 8, 66, '耕地', NULL, '1'),
	(68, 8, 0, '土地违法结案（件）', NULL, '2'),
	(69, 8, 68, '收回土地面积', NULL, '1'),
	(70, 8, 69, '耕地', NULL, '1'),
	(71, 8, 68, '拆除建筑面积（平方米）', NULL, '1'),
	(72, 8, 68, '没收建筑面积（平方米）', NULL, '1'),
	(73, 8, 68, '罚没款（万元）', NULL, '4'),
	(74, 8, 0, '矿产违法案件（件）', NULL, '2'),
	(75, 8, 74, '立案（件）', NULL, '2'),
	(76, 8, 74, '结案（件）', NULL, '2'),
	(77, 8, 74, '罚没款（万元）', NULL, '4'),
	(78, 9, 0, '本期来信', NULL, '2'),
	(79, 9, 0, '本期来访', NULL, '7');
/*!40000 ALTER TABLE `node` ENABLE KEYS */;


-- 导出  表 zhoushanland.node_value 结构
CREATE TABLE IF NOT EXISTS `node_value` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NodeID` int(11) NOT NULL,
  `Value` double NOT NULL,
  `Raw_Value` double NOT NULL,
  `Quarter` int(11) NOT NULL,
  `AreaID` int(11) NOT NULL,
  `TypeID` int(11) NOT NULL,
  `Year` int(11) NOT NULL,
  `UpdateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `NodeID` (`NodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.node_value 的数据：~0 rows (大约)
DELETE FROM `node_value`;
/*!40000 ALTER TABLE `node_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_value` ENABLE KEYS */;


-- 导出  表 zhoushanland.season 结构
CREATE TABLE IF NOT EXISTS `season` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Quarter` int(11) NOT NULL DEFAULT '0',
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `SetTime` datetime NOT NULL,
  `Delete` bit(3) NOT NULL DEFAULT b'0',
  `Year` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.season 的数据：~4 rows (大约)
DELETE FROM `season`;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
INSERT INTO `season` (`ID`, `Quarter`, `StartTime`, `EndTime`, `SetTime`, `Delete`, `Year`) VALUES
	(1, 1, '2016-01-01 00:00:00', '2016-03-01 00:00:00', '2016-07-30 21:14:23', b'001', 0),
	(2, 2, '2016-03-01 00:00:00', '2016-04-29 00:00:00', '2016-08-01 15:34:41', b'000', 2016),
	(3, 3, '2016-06-01 00:00:00', '2016-08-30 00:00:00', '2016-08-05 09:35:23', b'000', 2016),
	(4, 4, '2016-11-02 00:00:00', '2016-12-30 00:00:00', '2016-08-01 15:34:51', b'000', 2016);
/*!40000 ALTER TABLE `season` ENABLE KEYS */;


-- 导出  表 zhoushanland.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Deleted` bit(1) NOT NULL,
  `LastLoginTime` time DEFAULT NULL,
  `AreaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.user 的数据：~6 rows (大约)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`ID`, `Username`, `Password`, `Role`, `Name`, `Deleted`, `LastLoginTime`, `AreaID`) VALUES
	(1, 'admin', '202cb962ac59075b964b07152d234b70', 4, 'admin', b'0', NULL, NULL),
	(3, 'loowootech', '202cb962ac59075b964b07152d234b70', 4, 'loowootech', b'0', NULL, NULL),
	(4, 'ty', '202cb962ac59075b964b07152d234b70', 3, '唐尧', b'0', NULL, NULL),
	(5, 'zq', '202cb962ac59075b964b07152d234b70', 2, '赵泉', b'0', NULL, 1),
	(6, 'zwj', '202cb962ac59075b964b07152d234b70', 1, '周威俊', b'0', NULL, 6),
	(7, 'xc', '202cb962ac59075b964b07152d234b70', 1, '新城', b'0', NULL, 2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- 导出  表 zhoushanland.value_type 结构
CREATE TABLE IF NOT EXISTS `value_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `Units` varchar(255) NOT NULL,
  `Ratio` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.value_type 的数据：~7 rows (大约)
DELETE FROM `value_type`;
/*!40000 ALTER TABLE `value_type` DISABLE KEYS */;
INSERT INTO `value_type` (`ID`, `Name`, `Units`, `Ratio`) VALUES
	(1, '面积', '亩,公顷', 1000),
	(2, '件数', '件', 0),
	(3, '宗数', '宗', 0),
	(4, '费用', '元,万元,亿元', 10000),
	(5, '个数', '个', 0),
	(6, '人数', '人', 0),
	(7, '来访', '批次/人次', 0);
/*!40000 ALTER TABLE `value_type` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
