-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.6.26 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 zhoushanland.area 结构
DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.area 的数据：~10 rows (大约)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`ID`, `Name`, `ParentID`) VALUES
	(1, '市本级', 0),
	(2, '新城', 1),
	(3, '定海区', 0),
	(4, '岱山县', 0),
	(5, '普陀区', 0),
	(6, '嵊泗县', 0),
	(9, '产业集聚区', 1),
	(10, '金塘', 3),
	(11, '六横', 5),
	(12, '朱家尖', 5);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;


-- 导出  表 zhoushanland.dossier 结构
DROP TABLE IF EXISTS `dossier`;
CREATE TABLE IF NOT EXISTS `dossier` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Year` int(11) NOT NULL,
  `Quarter` int(11) NOT NULL,
  `Remark` varchar(1023) DEFAULT NULL,
  `UploadTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.dossier 的数据：~10 rows (大约)
/*!40000 ALTER TABLE `dossier` DISABLE KEYS */;
INSERT INTO `dossier` (`ID`, `Year`, `Quarter`, `Remark`, `UploadTime`) VALUES
	(1, 2016, 1, 'uploads/QL_20160725_0007.pdf', '2016-08-14 23:16:38'),
	(2, 2016, 2, 'uploads/QL_20160725_0007.pdf', '2016-07-27 11:22:58'),
	(3, 2016, 3, 'uploads/QL_20160725_0007.pdf', '2016-07-27 11:27:07'),
	(4, 2015, 1, '第一季度', '2016-08-01 16:34:10'),
	(5, 2014, 1, '年度统计册子', '2016-08-01 16:33:33'),
	(6, 2015, 2, 'uploads/QL_20160725_0008636052294359612835.pdf', '2016-07-27 15:17:17'),
	(7, 2016, 4, 'uploads/SKM_C364e16072710310_0001636052294514076858.pdf', '2016-07-27 15:17:37'),
	(8, 2013, 1, NULL, '2016-07-29 10:22:53'),
	(9, 2013, 2, '123342', '2016-07-29 10:44:02'),
	(10, 2012, 2, '第二季度', '2016-07-29 13:38:47');
/*!40000 ALTER TABLE `dossier` ENABLE KEYS */;


-- 导出  表 zhoushanland.dossierfile 结构
DROP TABLE IF EXISTS `dossierfile`;
CREATE TABLE IF NOT EXISTS `dossierfile` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FileName` varchar(255) NOT NULL,
  `FilePath` varchar(1023) NOT NULL,
  `DossierID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.dossierfile 的数据：~8 rows (大约)
/*!40000 ALTER TABLE `dossierfile` DISABLE KEYS */;
INSERT INTO `dossierfile` (`ID`, `FileName`, `FilePath`, `DossierID`) VALUES
	(1, 'QL_20160725_0007.pdf', 'uploads/QL_20160725_0007636053858312597793.pdf', 9),
	(2, 'QL_20160725_0008.pdf', 'uploads/QL_20160725_0008636053858344267208.pdf', 9),
	(3, 'SKM_C364e16072710310_0001.pdf', 'uploads/SKM_C364e16072710310_0001636053858373893285.pdf', 9),
	(4, 'SKM_C364e16072710310_0003.pdf', 'uploads/SKM_C364e16072710310_0003636053858404059122.pdf', 9),
	(6, 'SKM_C364e16072710310_0004.pdf', 'uploads/SKM_C364e16072710310_0004636053963259065437.pdf', 10),
	(7, '2014年度数据册子.doc', 'uploads/2014年度数据册子636056660126596791.doc', 5),
	(8, '2015年第一季度数据册子.doc', 'uploads/2015年第一季度数据册子636056660493232278.doc', 4),
	(9, 'QL_20160725_0007.pdf', 'uploads/QL_20160725_0007636053962884252665.pdf', 1);
/*!40000 ALTER TABLE `dossierfile` ENABLE KEYS */;


-- 导出  表 zhoushanland.form 结构
DROP TABLE IF EXISTS `form`;
CREATE TABLE IF NOT EXISTS `form` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `ImportTemplate` varchar(512) DEFAULT NULL,
  `ExportTemplate` varchar(512) DEFAULT NULL,
  `ExcludeSubArea` bit(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.form 的数据：~9 rows (大约)
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` (`ID`, `Name`, `ImportTemplate`, `ExportTemplate`, `ExcludeSubArea`) VALUES
	(1, '建设用地审批', NULL, NULL, b'1'),
	(2, '建设用地供应', NULL, NULL, b'1'),
	(3, '土地储备', NULL, NULL, b'0'),
	(4, '土地征收', NULL, NULL, b'0'),
	(5, '土地登记', NULL, NULL, b'1'),
	(6, '矿业权市场', NULL, NULL, b'0'),
	(7, '信访', NULL, NULL, b'0'),
	(8, '建设用地预审', NULL, NULL, b'1'),
	(9, '国土资源违法案件', NULL, NULL, b'1');
/*!40000 ALTER TABLE `form` ENABLE KEYS */;


-- 导出  表 zhoushanland.node 结构
DROP TABLE IF EXISTS `node`;
CREATE TABLE IF NOT EXISTS `node` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FormID` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `Group` varchar(50) DEFAULT NULL,
  `ValueTypes` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FormID` (`FormID`),
  KEY `ParentID` (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.node 的数据：~81 rows (大约)
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` (`ID`, `FormID`, `ParentID`, `Name`, `Group`, `ValueTypes`) VALUES
	(1, 1, 0, '批准建设用地面积', NULL, '1'),
	(3, 1, 1, '新增建设用地', NULL, '1'),
	(4, 1, 3, '农用地', NULL, '1'),
	(5, 1, 4, '耕地', NULL, '1'),
	(6, 1, 3, '未利用地', NULL, '1'),
	(7, 1, 1, '城市分批次建设用地', '类型', '1'),
	(8, 1, 1, '单独选址建设用地', '类型', '1'),
	(9, 1, 8, '能源用地', NULL, '1'),
	(10, 1, 8, '交通用地', NULL, '1'),
	(11, 1, 8, '水利用地', NULL, '1'),
	(12, 1, 8, '其他用地', NULL, '1'),
	(13, 2, 0, '建设用地供应总量', NULL, '1'),
	(14, 2, 13, '新增建设用地', NULL, '1'),
	(15, 2, 13, '房地产用地', '用地类型', '1'),
	(16, 2, 13, '工业仓储用地', '用地类型', '1'),
	(17, 2, 15, '商服用地', NULL, '1'),
	(18, 2, 15, '普通商品房用地', NULL, '1'),
	(19, 3, 0, '新增土地储备宗数', NULL, '4'),
	(20, 3, 0, '新增土地储备面积', NULL, '1'),
	(21, 3, 20, '回收土地', NULL, '1'),
	(24, 3, 0, '期内支出', NULL, '5'),
	(25, 3, 24, '补偿款', NULL, '5'),
	(37, 4, 0, '土地征收', NULL, '1'),
	(38, 4, 0, '征收费用', NULL, '5'),
	(43, 4, 0, '安置农业人口', NULL, '6'),
	(48, 5, 0, '期末情况', '土地抵押登记', '1,4,5'),
	(49, 5, 0, '期内增加', '土地抵押登记', '1,4,5'),
	(50, 5, 0, '期内减少', '土地抵押登记', '1,4,5'),
	(58, 5, 0, '国有土地使用权', '土地登记发证', '4'),
	(59, 5, 0, '集体土地所有权', '土地登记发证', '4'),
	(68, 4, 37, '农用地', NULL, '1'),
	(72, 6, 0, '采矿权许可证数', NULL, '6'),
	(73, 6, 72, '新立', NULL, '6'),
	(74, 6, 72, '撤销', NULL, '6'),
	(75, 6, 0, '采矿权出让', NULL, '6'),
	(76, 6, 75, '采矿权出让个数', NULL, '6'),
	(77, 6, 75, '缴纳采矿权出让价款', NULL, '5'),
	(87, 2, 13, '其他用地', '用地类型', '1'),
	(88, 2, 13, '划拨面积', '供地方式', '1'),
	(89, 2, 13, '出让面积', '供地方式', '1'),
	(90, 2, 89, '招拍挂出让面积', NULL, '1'),
	(91, 2, 0, '出让金', NULL, '5'),
	(92, 3, 20, '收购土地', NULL, '1'),
	(93, 3, 20, '其他', NULL, '1'),
	(94, 3, 24, '开发费', NULL, '5'),
	(95, 3, 0, '结算土地收储成本', NULL, '5'),
	(96, 3, 0, '报告期末土地储备面积', NULL, '1'),
	(103, 5, 0, '集体土地使用权', '土地登记发证', '4'),
	(104, 5, 0, '宅基地使用权', '土地登记发证', '4'),
	(105, 8, 0, '预审件数', NULL, '3'),
	(106, 8, 0, '预审面积', NULL, '1'),
	(107, 8, 106, '耕地', NULL, '1'),
	(108, 8, 106, '能源用地', NULL, '1'),
	(109, 8, 106, '交通用地', NULL, '1'),
	(110, 8, 106, '水利用地', NULL, '1'),
	(111, 8, 106, '其他用地', NULL, '1'),
	(112, 9, 0, '土地违法案件', '土地违法案件', '3'),
	(113, 9, 112, '涉及土地面积', NULL, '1'),
	(114, 9, 113, '耕地', NULL, '1'),
	(115, 9, 0, '土地违法结案', '土地违法案件', '3'),
	(116, 9, 115, '收回土地面积', NULL, '1'),
	(117, 9, 116, '耕地', NULL, '1'),
	(118, 9, 115, '拆除建筑面积', NULL, '8'),
	(119, 9, 115, '没收建筑面积', NULL, '8'),
	(120, 9, 115, '罚没款', NULL, '5'),
	(121, 9, 0, '矿产违法案件', '土地违法案件', '3'),
	(122, 9, 121, '立案', NULL, '3'),
	(123, 9, 121, '结案', NULL, '3'),
	(124, 9, 121, '罚没款', NULL, '5'),
	(131, 6, 0, '采矿权出让', NULL, '6'),
	(132, 6, 131, '采矿权出让个数', NULL, '6'),
	(133, 6, 131, '采矿权出让价款', NULL, '5'),
	(137, 6, 0, '矿产三费收费情况', NULL, '5'),
	(138, 6, 137, '出让金', NULL, '5'),
	(139, 6, 137, '治理备用金', NULL, '5'),
	(140, 6, 137, '资源补偿费', NULL, '5'),
	(141, 7, 0, '本期来信', NULL, '3'),
	(142, 7, 0, '本期来访', NULL, '7,9'),
	(145, 3, 0, '期内新增面积', NULL, '1'),
	(146, 3, 0, '期末面积', NULL, '1'),
	(147, 4, 68, '耕地', NULL, '1'),
	(151, 4, 37, '建设用地', NULL, '1'),
	(152, 4, 37, '其他用地', NULL, '1'),
	(154, 4, 68, '其他农用地', NULL, '1');
/*!40000 ALTER TABLE `node` ENABLE KEYS */;


-- 导出  表 zhoushanland.node_value 结构
DROP TABLE IF EXISTS `node_value`;
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
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.node_value 的数据：~75 rows (大约)
/*!40000 ALTER TABLE `node_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_value` ENABLE KEYS */;


-- 导出  表 zhoushanland.season 结构
DROP TABLE IF EXISTS `season`;
CREATE TABLE IF NOT EXISTS `season` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Quarter` int(11) NOT NULL DEFAULT '0',
  `StartTime` datetime NOT NULL,
  `Year` int(11) NOT NULL,
  `EndTime` datetime NOT NULL,
  `SetTime` datetime NOT NULL,
  `Delete` bit(3) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.season 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
INSERT INTO `season` (`ID`, `Quarter`, `StartTime`, `Year`, `EndTime`, `SetTime`, `Delete`) VALUES
	(1, 1, '2016-01-01 00:00:00', 0, '2016-03-01 00:00:00', '2016-07-30 21:14:23', b'001'),
	(2, 2, '2016-03-01 00:00:00', 2016, '2016-04-29 00:00:00', '2016-08-01 15:34:41', b'000'),
	(3, 3, '2016-06-01 00:00:00', 2016, '2016-08-30 00:00:00', '2016-08-01 15:34:47', b'000'),
	(4, 4, '2016-11-02 00:00:00', 2016, '2016-12-30 00:00:00', '2016-08-01 15:34:51', b'000');
/*!40000 ALTER TABLE `season` ENABLE KEYS */;


-- 导出  表 zhoushanland.trend_template 结构
DROP TABLE IF EXISTS `trend_template`;
CREATE TABLE IF NOT EXISTS `trend_template` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `FilePath` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.trend_template 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `trend_template` DISABLE KEYS */;
INSERT INTO `trend_template` (`ID`, `Name`, `FilePath`) VALUES
	(1, '建设用地预审.xls', '建设用地预审.xls'),
	(2, '各土地应用变化.xls', '各土地应用变化.xls'),
	(3, '信访情况.xls', '信访情况.xls'),
	(4, '土地储备.xls', '土地储备.xls'),
	(5, '矿产收费情况.xls', '矿产收费情况.xls'),
	(6, '国土资源违法案件.xls', '国土资源违法案件.xls'),
	(7, '土地登记和抵押.xls', '土地登记和抵押.xls'),
	(8, '土地征收.xls', '土地征收.xls');
/*!40000 ALTER TABLE `trend_template` ENABLE KEYS */;


-- 导出  表 zhoushanland.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Deleted` bit(1) NOT NULL,
  `LastLoginTime` datetime DEFAULT NULL,
  `AreaIds` varchar(50) DEFAULT NULL,
  `FormIds` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.user 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`ID`, `Username`, `Password`, `Role`, `Name`, `Deleted`, `LastLoginTime`, `AreaIds`, `FormIds`) VALUES
	(1, 'admin', '202cb962ac59075b964b07152d234b70', 4, 'admin', b'0', '2016-08-24 14:09:32', NULL, ''),
	(3, 'loowootech', '202cb962ac59075b964b07152d234b70', 4, 'loowootech', b'0', NULL, NULL, ''),
	(4, 'ty', '202cb962ac59075b964b07152d234b70', 3, '唐尧', b'0', NULL, NULL, ''),
	(5, 'zq', '202cb962ac59075b964b07152d234b70', 2, '赵泉', b'0', '2016-08-18 14:09:55', '1', ''),
	(6, 'zwj', '202cb962ac59075b964b07152d234b70', 1, '周威俊', b'0', NULL, '6', ''),
	(7, 'xc', '202cb962ac59075b964b07152d234b70', 1, '新城', b'0', '2016-08-18 13:45:25', '2', '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- 导出  表 zhoushanland.value_type 结构
DROP TABLE IF EXISTS `value_type`;
CREATE TABLE IF NOT EXISTS `value_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `Units` varchar(255) NOT NULL,
  `Ratio` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  zhoushanland.value_type 的数据：~8 rows (大约)
/*!40000 ALTER TABLE `value_type` DISABLE KEYS */;
INSERT INTO `value_type` (`ID`, `Name`, `Units`, `Ratio`) VALUES
	(1, '面积', '亩,公顷', 1000),
	(3, '件数', '件', 0),
	(4, '宗数', '宗', 0),
	(5, '费用', '万元,亿元', 10000),
	(6, '个数', '个', 0),
	(7, '人数', '人', 0),
	(8, '面积', '平方米', 0),
	(9, '批次', '次', 0);
/*!40000 ALTER TABLE `value_type` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
