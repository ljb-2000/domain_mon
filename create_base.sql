-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: url_mon
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `montior_url`
--

DROP TABLE IF EXISTS `montior_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `montior_url` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `url` char(254) CHARACTER SET latin1 NOT NULL COMMENT '网络地址',
  `location` varchar(256) DEFAULT NULL COMMENT '监控的location\n',
  `method` enum('POST','GET') NOT NULL COMMENT '监控方法',
  `keyword` varchar(128) NOT NULL COMMENT '监控关键字',
  `post_data` varchar(1024) DEFAULT NULL COMMENT '如果method为post时，需要提供该参数',
  `fail_time` int(11) DEFAULT NULL COMMENT '最大的失败次数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='监控信息基础表\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `montior_url`
--

LOCK TABLES `montior_url` WRITE;
/*!40000 ALTER TABLE `montior_url` DISABLE KEYS */;
INSERT INTO `montior_url` VALUES (1,'app.mi.com','/detail/85089','GET','合肥',NULL,3,NULL),(2,'app.mi.com','/detail/1122','GET','微信',NULL,3,NULL),(3,'zhuti.xiaomi.com','/detail/0cc124fb-ab9d-4a32-b8ec-d9eee54eab2c','GET','当前评分',NULL,3,NULL);
/*!40000 ALTER TABLE `montior_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_code`
--

DROP TABLE IF EXISTS `status_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_code` (
  `ID` int(11) NOT NULL,
  `status_code` int(11) DEFAULT '0' COMMENT '0为正常，错误时加1，计算方法 last_status * cur_status + cur_status',
  `rep_point` varchar(45) NOT NULL COMMENT '上报节点，建议使用IP',
  `rep_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上报时间\n',
  `last_fail` datetime DEFAULT NULL COMMENT '上次失败时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_code`
--

LOCK TABLES `status_code` WRITE;
/*!40000 ALTER TABLE `status_code` DISABLE KEYS */;
INSERT INTO `status_code` VALUES (1,0,'192.168.31.105','2015-02-14 15:32:41',NULL),(2,0,'192.168.31.105','2015-02-14 15:32:41',NULL),(3,10,'192.168.31.105','2015-02-14 15:32:41',NULL);
/*!40000 ALTER TABLE `status_code` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-15 10:20:01
