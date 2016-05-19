-- --------------------------------------------------------
-- ??:                           127.0.0.1
-- ?????:                        5.6.26 - MySQL Community Server (GPL)
-- ???????:                      Win64
-- HeidiSQL ??:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- ??  ? zhoushanland.area ??
DROP TABLE IF EXISTS `area`;
CREATE TABLE IF NOT EXISTS `area` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ?????  zhoushanland.area ???:~2 rows (??)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`ID`, `Name`, `ParentID`) VALUES
	(1, '???', 0),
	(2, '??', 1);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;


-- ??  ? zhoushanland.form ??
DROP TABLE IF EXISTS `form`;
CREATE TABLE IF NOT EXISTS `form` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ?????  zhoushanland.form ???:~1 rows (??)
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` (`ID`, `Name`) VALUES
	(1, '????');
/*!40000 ALTER TABLE `form` ENABLE KEYS */;


-- ??  ? zhoushanland.node ??
DROP TABLE IF EXISTS `node`;
CREATE TABLE IF NOT EXISTS `node` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FormID` int(11) NOT NULL DEFAULT '0',
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FormID` (`FormID`),
  KEY `ParentID` (`ParentID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ?????  zhoushanland.node ???:~3 rows (??)
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` (`ID`, `FormID`, `ParentID`, `Name`) VALUES
	(1, 1, 0, '1'),
	(2, 1, 0, '12'),
	(3, 1, 1, '111');
/*!40000 ALTER TABLE `node` ENABLE KEYS */;


-- ??  ? zhoushanland.node_value ??
DROP TABLE IF EXISTS `node_value`;
CREATE TABLE IF NOT EXISTS `node_value` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NodeID` int(11) NOT NULL,
  `Value` double NOT NULL,
  `TimeID` int(11) NOT NULL,
  `AreaID` int(11) NOT NULL,
  `TypeID` int(11) NOT NULL,
  `Year` int(11) NOT NULL,
  `UpdateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `NodeID` (`NodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ?????  zhoushanland.node_value ???:~0 rows (??)
/*!40000 ALTER TABLE `node_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_value` ENABLE KEYS */;


-- ??  ? zhoushanland.user ??
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Deleted` bit(1) NOT NULL,
  `LastLoginTime` time DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ?????  zhoushanland.user ???:~1 rows (??)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`ID`, `Username`, `Password`, `Role`, `Name`, `Deleted`, `LastLoginTime`) VALUES
	(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 4, 'admin', b'0', NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- ??  ? zhoushanland.value_type ??
DROP TABLE IF EXISTS `value_type`;
CREATE TABLE IF NOT EXISTS `value_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL DEFAULT '0',
  `Unit` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ?????  zhoushanland.value_type ???:~1 rows (??)
/*!40000 ALTER TABLE `value_type` DISABLE KEYS */;
INSERT INTO `value_type` (`ID`, `Name`, `Unit`) VALUES
	(1, '??', '??');
/*!40000 ALTER TABLE `value_type` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
