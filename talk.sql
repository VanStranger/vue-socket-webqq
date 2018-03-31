-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.5.53 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  8.2.0.4675
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 talk 的数据库结构
CREATE DATABASE IF NOT EXISTS `talk` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `talk`;


-- 导出  表 talk.askfri 结构
DROP TABLE IF EXISTS `askfri`;
CREATE TABLE IF NOT EXISTS `askfri` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `askid` int(11) unsigned NOT NULL DEFAULT '0',
  `toid` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  talk.askfri 的数据：~0 rows (大约)
DELETE FROM `askfri`;
/*!40000 ALTER TABLE `askfri` DISABLE KEYS */;
/*!40000 ALTER TABLE `askfri` ENABLE KEYS */;


-- 导出  表 talk.friendgroups 结构
DROP TABLE IF EXISTS `friendgroups`;
CREATE TABLE IF NOT EXISTS `friendgroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `groups` char(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  talk.friendgroups 的数据：~4 rows (大约)
DELETE FROM `friendgroups`;
/*!40000 ALTER TABLE `friendgroups` DISABLE KEYS */;
INSERT INTO `friendgroups` (`id`, `userid`, `groups`) VALUES
	(1, 10000, '朋友,小学同学,中学同学,大学同学'),
	(2, 10001, '我的好友,家人,同事,小学同学,中学同学,大学同学'),
	(3, 10055, '朋友,小学同学,中学同学,大学同学,黑名单'),
	(4, 10056, '朋友,小学同学,中学同学,大学同学,黑名单');
/*!40000 ALTER TABLE `friendgroups` ENABLE KEYS */;


-- 导出  表 talk.friends 结构
DROP TABLE IF EXISTS `friends`;
CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `friendid` int(11) unsigned NOT NULL DEFAULT '0',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  talk.friends 的数据：~4 rows (大约)
DELETE FROM `friends`;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` (`id`, `userid`, `friendid`, `groupid`) VALUES
	(1, 10000, 10001, 0),
	(2, 10001, 10000, 0),
	(3, 10000, 10003, 1),
	(4, 10001, 10002, 0);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;


-- 导出  表 talk.fruit 结构
DROP TABLE IF EXISTS `fruit`;
CREATE TABLE IF NOT EXISTS `fruit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `color` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 正在导出表  talk.fruit 的数据：~6 rows (大约)
DELETE FROM `fruit`;
/*!40000 ALTER TABLE `fruit` DISABLE KEYS */;
INSERT INTO `fruit` (`id`, `name`, `color`) VALUES
	(2, 'banana', 'yellow'),
	(3, 'watermelon', 'green'),
	(4, 'pear', 'yellow'),
	(5, 'strawberry', 'yellow'),
	(6, 'mango', 'yellow'),
	(7, 'mango', 'yellow');
/*!40000 ALTER TABLE `fruit` ENABLE KEYS */;


-- 导出  表 talk.talk 结构
DROP TABLE IF EXISTS `talk`;
CREATE TABLE IF NOT EXISTS `talk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromid` int(11) NOT NULL,
  `toid` int(11) NOT NULL,
  `message` text COLLATE utf8_bin NOT NULL,
  `readed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- 正在导出表  talk.talk 的数据：~97 rows (大约)
DELETE FROM `talk`;
/*!40000 ALTER TABLE `talk` DISABLE KEYS */;
INSERT INTO `talk` (`id`, `fromid`, `toid`, `message`, `readed`, `create_time`, `update_time`) VALUES
	(1, 10000, 10003, 'sdf', 0, 1521613099, 0),
	(2, 10000, 10003, '是的', 0, 1521613149, 0),
	(3, 10000, 10003, '<img src="./ems/130.png" class="msEmoji">', 0, 1521613210, 0),
	(5, 10000, 10001, '我爱你', 0, 1521614425, 0),
	(6, 10000, 10001, '但是', 0, 1521620971, 0),
	(7, 10000, 10001, '山东省地方', 0, 1521799616, 0),
	(8, 10000, 10001, '胜多负少的', 0, 1522302067, 0),
	(13, 10000, 10001, '的非官方的', 0, 1522375181, 0),
	(14, 10000, 10001, '胜多负少的', 0, 1522377506, 0),
	(15, 10000, 10001, '胜多负少的', 0, 1522377513, 0),
	(16, 10000, 10001, '撒打算', 0, 1522377556, 0),
	(17, 10000, 10001, '胜多负少', 0, 1522377620, 0),
	(18, 10000, 10001, '是的', 0, 1522377979, 0),
	(19, 10000, 10001, '胜多负少的', 0, 1522378101, 0),
	(20, 10000, 10001, '山东省地方', 0, 1522378117, 0),
	(21, 10000, 10001, '胜多负少的', 0, 1522378302, 0),
	(22, 10000, 10001, '的第三方士大夫', 0, 1522378384, 0),
	(23, 10000, 10001, '胜多负少的', 0, 1522378428, 0),
	(24, 10000, 10001, '撒大声地', 0, 1522378444, 0),
	(25, 10000, 10001, 'sdfsd&nbsp;', 0, 1522379209, 0),
	(26, 10000, 10001, 'dsfsd', 0, 1522379285, 0),
	(27, 10000, 10001, 'sdfsdf', 0, 1522379328, 0),
	(28, 10000, 10001, 'sdfsdf', 0, 1522379408, 0),
	(29, 10000, 10001, 'sdfds', 0, 1522379654, 0),
	(30, 10000, 10001, 'sdfsdfsd', 0, 1522379656, 0),
	(41, 10001, 10000, 'sfe', 0, 1522389413, 0),
	(42, 10001, 10000, 'fwefwefw', 0, 1522389417, 0),
	(43, 10001, 10000, 'wwefewf', 0, 1522389420, 0),
	(44, 10001, 10000, 'sdfsd', 0, 1522389525, 0),
	(45, 10001, 10000, 'sdfsdf', 0, 1522389532, 0),
	(46, 10001, 10000, 'sdfsdf', 0, 1522389540, 0),
	(47, 10000, 10001, '的士速递', 0, 1522398237, 0),
	(48, 10000, 10001, 'sdfsdf', 0, 1522398711, 0),
	(49, 10000, 10001, 'sdfsd', 0, 1522398750, 0),
	(50, 10000, 10001, 'sdfsdf', 0, 1522398793, 0),
	(51, 10000, 10001, 'sdfsdf', 0, 1522398796, 0),
	(52, 10000, 10001, 'sdfsdfsd', 0, 1522398807, 0),
	(53, 10000, 10001, 'sdfsdf', 0, 1522398899, 0),
	(54, 10000, 10001, 'sdfsdf', 0, 1522398919, 0),
	(55, 10000, 10001, 'sdfdsf', 0, 1522399067, 0),
	(56, 10000, 10001, 'sdfsdfs', 0, 1522399069, 0),
	(57, 10000, 10001, 'sdfsdf', 0, 1522399101, 0),
	(58, 10000, 10001, 'sdfsd', 0, 1522399326, 0),
	(59, 10000, 10001, 'sdfsdf', 0, 1522399388, 0),
	(60, 10000, 10001, 'sdfsdf', 0, 1522399824, 0),
	(61, 10000, 10001, 'sdfsdf', 0, 1522399901, 0),
	(62, 10000, 10001, 'sdfsdfa', 0, 1522399913, 0),
	(63, 10000, 10001, 'sdfsdfsd', 0, 1522400112, 0),
	(64, 10000, 10001, '胜多负少', 0, 1522400584, 0),
	(65, 10000, 10001, '斯蒂芬斯蒂芬', 0, 1522400656, 0),
	(66, 10000, 10001, '是多少东方闪电', 0, 1522400926, 0),
	(67, 10000, 10001, '胜多负少的', 0, 1522401060, 0),
	(68, 10001, 10000, 'sdfsdfsd', 0, 1522401076, 0),
	(69, 10001, 10000, 'sfsdfsd', 0, 1522401079, 0),
	(70, 10001, 10000, 'ssdfsd', 0, 1522401284, 0),
	(71, 10000, 10001, '胜多负少的', 0, 1522401706, 0),
	(72, 10000, 10001, '胜多负少的', 0, 1522401809, 0),
	(73, 10000, 10001, '阿斯蒂芬', 0, 1522401816, 0),
	(74, 10000, 10001, '许', 0, 1522401833, 0),
	(75, 10001, 10000, 'sdfsdfa', 0, 1522402790, 0),
	(76, 10001, 10000, 'sdfsd', 0, 1522404420, 0),
	(77, 10001, 10000, 'sdfsdf', 0, 1522404472, 0),
	(78, 10000, 10001, 'sdfsdf', 0, 1522412489, 0),
	(79, 10000, 10001, 'sdfs', 0, 1522412535, 0),
	(80, 10000, 10001, 'sdfsd', 0, 1522412837, 0),
	(81, 10000, 10001, 'sdssd', 0, 1522412842, 0),
	(82, 10000, 10001, 'sdfsdf', 0, 1522412885, 0),
	(83, 10000, 10001, 'sdsd', 0, 1522413143, 0),
	(84, 10000, 10001, 'sdfsdf', 0, 1522413246, 0),
	(85, 10000, 10001, 'sdfsd', 0, 1522413388, 0),
	(86, 10000, 10001, 'ssdfds', 0, 1522413465, 0),
	(87, 10000, 10001, 'ssd', 0, 1522413510, 0),
	(88, 10000, 10001, 'sdfsd', 0, 1522414674, 0),
	(89, 10000, 10001, 'sdfsdf', 0, 1522414868, 0),
	(90, 10001, 10000, 'sdfsdfsd', 0, 1522414897, 0),
	(91, 10001, 10000, 'sdfsdfsd', 0, 1522414902, 0),
	(92, 10001, 10000, 'sdfsdfsd', 0, 1522414955, 0),
	(93, 10001, 10000, 'sdsd', 0, 1522414958, 0),
	(94, 10001, 10000, 'sdfsdfsd', 0, 1522414972, 0),
	(95, 10001, 10000, 'ssdfsdf', 0, 1522414975, 0),
	(96, 10001, 10000, 'sdfsdfsdfsd', 0, 1522414982, 0),
	(97, 10001, 10000, 'sdfsd', 0, 1522416780, 0),
	(98, 10001, 10000, 'sdfsdf', 0, 1522416784, 0),
	(99, 10001, 10000, 'sdfds', 0, 1522416840, 0),
	(100, 10001, 10000, 'sdfsd', 0, 1522416920, 0),
	(101, 10001, 10000, 'sdsdf', 0, 1522416931, 0),
	(102, 10001, 10000, 'sdfsdf', 0, 1522416956, 0),
	(103, 10001, 10000, 'sdfsfsd', 0, 1522416959, 0),
	(104, 10001, 10000, 'sdfsd', 0, 1522417024, 0),
	(105, 10001, 10000, 'fsdfsd', 0, 1522417213, 0),
	(106, 10001, 10000, 'sdfsdfsd', 0, 1522417268, 0),
	(107, 10001, 10000, 'sdfdsfsd', 0, 1522417425, 0),
	(108, 10001, 10000, 'dsfsdf', 0, 1522458555, 0),
	(109, 10001, 10000, 'asdasd', 0, 1522458584, 0),
	(110, 10001, 10000, 'dsdfsd', 0, 1522459302, 0),
	(111, 10001, 10000, 'sdfsdf', 0, 1522459370, 0),
	(112, 10000, 10001, '斯蒂芬斯蒂芬', 0, 1522460940, 0);
/*!40000 ALTER TABLE `talk` ENABLE KEYS */;


-- 导出  表 talk.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `online` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1在线0离线2隐身',
  `photo` char(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1449021620',
  `qianming` char(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10057 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  talk.user 的数据：~57 rows (大约)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `online`, `photo`, `qianming`) VALUES
	(10000, '范俊杰', 'e10adc3949ba59abbe56e057f20f883e', 1, '1449296625.jpg', '曙光女神在哪里？'),
	(10001, '李阳', '84360a977c722d6ac7b3c8be5e07219c', 1, '1449296639.jpg', '春风不识字，何故乱翻书'),
	(10002, '极度疯狂三', '7b774effe4a349c6dd82ad4f4f21d34c', 0, '1449296639.jpg', ''),
	(10003, '神鼎飞丹砂', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 0, '1449296639.jpg', ''),
	(10004, '第三方', 'eff7d5dba32b4da32d9a67a519434d3f', 0, '1449296639.jpg', ''),
	(10005, '李阳', 'c81e728d9d4c2f636f067f89cc14862c', 0, '1449296639.jpg', ''),
	(10006, '电饭锅', '1b014086a5cf92eb3238d0d45c8c61a4', 0, '1449296639.jpg', ''),
	(10007, '丘处机', '202cb962ac59075b964b07152d234b70', 1, '1449296639.jpg', ''),
	(10008, '刘亦菲', '84360a977c722d6ac7b3c8be5e07219c', 0, '1449296639.jpg', ''),
	(10009, 'liyang', '84360a977c722d6ac7b3c8be5e07219c', 0, '1449296639.jpg', ''),
	(10010, 'liyang', '84360a977c722d6ac7b3c8be5e07219c', 0, '1449296639.jpg', ''),
	(10011, 'ceshi', 'cc17c30cd111c7215fc8f51f8790e0e1', 0, '1449296639.jpg', ''),
	(10012, 'liuyang', '57cb5a26334a6c1d5e27c49def4a0f0d', 0, '1449296639.jpg', ''),
	(10013, '丘处机', '84360a977c722d6ac7b3c8be5e07219c', 0, '1449296639.jpg', ''),
	(10014, '刘亦菲', '84360a977c722d6ac7b3c8be5e07219c', 0, '1449296639.jpg', ''),
	(10015, '刘亦菲', '31f728f0ec88bdc9a62968797f234665', 0, '1449296639.jpg', ''),
	(10016, '刘亦菲', '31f728f0ec88bdc9a62968797f234665', 0, '1449296639.jpg', ''),
	(10017, '电饭锅', 'a8f5f167f44f4964e6c998dee827110c', 0, '1449296639.jpg', ''),
	(10018, '电饭锅', 'a8f5f167f44f4964e6c998dee827110c', 0, '1449296639.jpg', ''),
	(10019, '电饭锅', 'a8f5f167f44f4964e6c998dee827110c', 0, '1449296639.jpg', ''),
	(10020, '范俊杰', '01923b0bf7ba776f84c091f87cbb02ac', 0, '1449296639.jpg', ''),
	(10021, '李阳', '84360a977c722d6ac7b3c8be5e07219c', 0, '1449296639.jpg', ''),
	(10022, '舒畅', '37f19837a6700986aa30f8ede3203b1d', 0, '1449296639.jpg', ''),
	(10023, '杨幂', '37cfd10355f720302ddc330eb1a688ca', 0, '1449296639.jpg', ''),
	(10024, '朱茵', 'fddacbe1c9b0fddd4cbc0f2e0aa39b43', 0, '1449296639.jpg', ''),
	(10025, '范俊杰', 'bf1ea62e0381a59b80ff5026467689a7', 0, '1449296639.jpg', ''),
	(10026, '呵呵呵', 'ffe553694f5096471590343432359e02', 0, '1449296639.jpg', ''),
	(10027, 'xixixi', 'cbc1f4a470748885b56cf0981083dad0', 0, '1449296639.jpg', ''),
	(10028, '杨幂', '37cfd10355f720302ddc330eb1a688ca', 0, '1449296639.jpg', ''),
	(10029, 'username', '3a1d656d65ab5cd5f3d4a6c71e891884', 0, '1449296639.jpg', ''),
	(10030, 'username', '254578d30dbf8e96b2037bf770a9647e', 0, '1449296639.jpg', ''),
	(10031, 'username', '254578d30dbf8e96b2037bf770a9647e', 0, '1449296639.jpg', ''),
	(10032, 'username', '8d509c28896865f8640f328f30f15721', 0, '1449296639.jpg', ''),
	(10033, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10034, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10035, 'username', '633bd287609b5b5854509b614ef5bee0', 0, '1449296639.jpg', ''),
	(10036, 'username', '8d509c28896865f8640f328f30f15721', 0, '1449296639.jpg', ''),
	(10037, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10038, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10039, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10040, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10041, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10042, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10043, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10044, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10045, 'username', 'md5("df")', 0, '1449296639.jpg', ''),
	(10046, 'username', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10047, '随碟附送', 'd58e3582afa99040e27b92b13c8f2280', 1, '1449296639.jpg', ''),
	(10048, '撒旦法', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10049, 'adf', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10050, 'sdfs', 'e248757607906745a79c788ced45b3dc', 0, '1449296639.jpg', ''),
	(10051, '撒旦法', 'd58e3582afa99040e27b92b13c8f2280', 0, '1449296639.jpg', ''),
	(10052, 'f', '91c89f546e0f9dc81b792c1c871749fa', 1, '1449021620.jpg', ''),
	(10053, 'ceshieryi', '14f583e49d5aef60e55299c2226de08d', 0, '1449021620.jpg', ''),
	(10054, 'ceshiyima', '0c1bf2ee8d899dba50017cc6acda5362', 0, '1449021620.jpg', ''),
	(10055, '昵称水电费', '9073be16a4683c89046c7792c9eeb41c', 0, '1449021620.jpg', ''),
	(10056, 'liulifei', 'e10adc3949ba59abbe56e057f20f883e', 1, '1449021620', '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
