-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: taurussoft_happetite
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.12.04.1

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
-- Table structure for table `engine4_activity_actions`
--

DROP TABLE IF EXISTS `engine4_activity_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_actions` (
  `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `date` datetime NOT NULL,
  `attachment_count` smallint(3) unsigned NOT NULL DEFAULT '0',
  `comment_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `like_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`),
  KEY `OBJECT` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_actions`
--

LOCK TABLES `engine4_activity_actions` WRITE;
/*!40000 ALTER TABLE `engine4_activity_actions` DISABLE KEYS */;
INSERT INTO `engine4_activity_actions` VALUES (4,'signup','user',2,'user',2,'','[]','2014-06-23 08:48:37',0,0,0),(5,'signup','user',3,'user',3,'','[]','2014-06-23 08:48:43',0,0,0),(6,'signup','user',4,'user',4,'','[]','2014-06-23 08:48:49',0,0,0),(11,'event_create','user',2,'event',5,'','[]','2014-07-14 14:05:06',1,0,0),(24,'signup','user',7,'user',7,'','[]','2014-08-17 09:41:19',0,0,0),(25,'event_create','user',7,'event',18,'','[]','2014-08-17 11:23:45',1,0,0),(26,'signup','user',8,'user',8,'','[]','2014-08-17 11:28:45',0,0,0),(27,'signup','user',9,'user',9,'','[]','2014-08-19 23:09:11',0,0,0),(28,'profile_photo_update','user',9,'user',9,'{item:$subject} added a new profile photo.','[]','2014-08-19 23:09:42',1,0,0),(33,'event_create','user',8,'event',20,'','[]','2014-08-20 09:14:47',1,0,0),(43,'event_create','user',1,'event',25,'','[]','2014-09-03 07:28:14',1,0,0),(44,'event_create','user',1,'event',26,'','[]','2014-09-03 12:05:04',1,0,0),(46,'signup','user',11,'user',11,'','[]','2014-09-13 22:11:23',0,0,0),(47,'event_create','user',11,'event',28,'','[]','2014-09-13 22:45:24',1,0,0),(48,'post','user',11,'event',28,'Hello, I think this is a really cool class','[]','2014-09-13 22:46:21',0,0,0),(49,'event_create','user',11,'event',29,'','[]','2014-09-14 23:12:27',1,0,0),(50,'signup','user',12,'user',12,'','[]','2014-09-14 23:24:19',0,0,0),(51,'event_create','user',11,'event',30,'','[]','2014-09-14 23:57:31',1,0,0),(52,'signup','user',13,'user',13,'','[]','2014-09-17 22:33:36',0,0,0),(55,'event_create','user',1,'event',33,'','[]','2014-10-03 12:50:39',1,0,0),(56,'event_create','user',1,'event',34,'','[]','2014-10-09 14:20:05',1,0,0),(57,'event_create','user',1,'event',35,'','[]','2014-11-05 13:27:30',1,0,0);
/*!40000 ALTER TABLE `engine4_activity_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_actionsettings`
--

DROP TABLE IF EXISTS `engine4_activity_actionsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_actionsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_actionsettings`
--

LOCK TABLES `engine4_activity_actionsettings` WRITE;
/*!40000 ALTER TABLE `engine4_activity_actionsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_activity_actionsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_actiontypes`
--

DROP TABLE IF EXISTS `engine4_activity_actiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_actiontypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `displayable` tinyint(1) NOT NULL DEFAULT '3',
  `attachable` tinyint(1) NOT NULL DEFAULT '1',
  `commentable` tinyint(1) NOT NULL DEFAULT '1',
  `shareable` tinyint(1) NOT NULL DEFAULT '1',
  `is_generated` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_actiontypes`
--

LOCK TABLES `engine4_activity_actiontypes` WRITE;
/*!40000 ALTER TABLE `engine4_activity_actiontypes` DISABLE KEYS */;
INSERT INTO `engine4_activity_actiontypes` VALUES ('event_create','event','{item:$subject} created a new event:',1,5,1,1,1,1),('event_join','event','{item:$subject} joined the event {item:$object}',1,3,1,1,1,1),('event_photo_upload','event','{item:$subject} added {var:$count} photo(s).',1,3,2,1,1,1),('event_topic_create','event','{item:$subject} posted a {item:$object:topic} in the event {itemParent:$object:event}: {body:$body}',1,3,1,1,1,1),('event_topic_reply','event','{item:$subject} replied to a {item:$object:topic} in the event {itemParent:$object:event}: {body:$body}',1,3,1,1,1,1),('friends','user','{item:$subject} is now friends with {item:$object}.',1,3,0,1,1,1),('friends_follow','user','{item:$subject} is now following {item:$object}.',1,3,0,1,1,1),('login','user','{item:$subject} has signed in.',0,1,0,1,1,1),('logout','user','{item:$subject} has signed out.',0,1,0,1,1,1),('network_join','network','{item:$subject} joined the network {item:$object}',1,3,1,1,1,1),('post','user','{actors:$subject:$object}: {body:$body}',1,7,1,1,1,0),('post_self','user','{item:$subject} {body:$body}',1,5,1,1,1,0),('profile_photo_update','user','{item:$subject} has added a new profile photo.',1,5,1,1,1,1),('share','activity','{item:$subject} shared {item:$object}\'s {var:$type}. {body:$body}',1,5,1,1,0,1),('signup','user','{item:$subject} has just signed up. Say hello!',1,5,0,1,1,1),('status','user','{item:$subject} {body:$body}',1,5,0,1,4,0),('tagged','user','{item:$subject} tagged {item:$object} in a {var:$label}:',1,7,1,1,0,1);
/*!40000 ALTER TABLE `engine4_activity_actiontypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_attachments`
--

DROP TABLE IF EXISTS `engine4_activity_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_attachments` (
  `attachment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action_id` int(11) unsigned NOT NULL,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `mode` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`attachment_id`),
  KEY `action_id` (`action_id`),
  KEY `type_id` (`type`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_attachments`
--

LOCK TABLES `engine4_activity_attachments` WRITE;
/*!40000 ALTER TABLE `engine4_activity_attachments` DISABLE KEYS */;
INSERT INTO `engine4_activity_attachments` VALUES (5,11,'event',5,1),(18,25,'event',18,1),(19,28,'storage_file',41,1),(21,33,'event',20,1),(26,43,'event',25,1),(27,44,'event',26,1),(29,47,'event',28,1),(30,49,'event',29,1),(31,51,'event',30,1),(34,55,'event',33,1),(35,56,'event',34,1),(36,57,'event',35,1);
/*!40000 ALTER TABLE `engine4_activity_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_comments`
--

DROP TABLE IF EXISTS `engine4_activity_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_comments`
--

LOCK TABLES `engine4_activity_comments` WRITE;
/*!40000 ALTER TABLE `engine4_activity_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_activity_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_likes`
--

DROP TABLE IF EXISTS `engine4_activity_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_id` (`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_likes`
--

LOCK TABLES `engine4_activity_likes` WRITE;
/*!40000 ALTER TABLE `engine4_activity_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_activity_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_notifications`
--

DROP TABLE IF EXISTS `engine4_activity_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_notifications` (
  `notification_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `mitigated` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `LOOKUP` (`user_id`,`date`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `object` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_notifications`
--

LOCK TABLES `engine4_activity_notifications` WRITE;
/*!40000 ALTER TABLE `engine4_activity_notifications` DISABLE KEYS */;
INSERT INTO `engine4_activity_notifications` VALUES (14,1,'user',2,'messages_conversation',1,'message_system_new',NULL,1,0,'2014-07-09 12:51:58'),(17,1,'user',1,'messages_conversation',2,'message_system_new',NULL,1,0,'2014-07-09 15:49:08'),(18,1,'user',1,'messages_conversation',3,'message_system_new',NULL,1,0,'2014-07-10 09:05:52'),(20,1,'user',1,'messages_conversation',4,'message_system_new',NULL,1,0,'2014-07-10 09:07:02'),(22,3,'user',1,'messages_conversation',5,'message_system_new',NULL,1,0,'2014-07-10 09:09:48'),(24,3,'user',1,'messages_conversation',6,'message_system_new',NULL,1,0,'2014-07-10 09:14:13'),(26,3,'user',1,'messages_conversation',7,'message_system_new',NULL,1,0,'2014-07-10 09:40:45'),(28,2,'user',1,'messages_conversation',8,'message_system_new',NULL,1,0,'2014-07-10 09:59:29'),(30,2,'user',1,'messages_conversation',9,'message_system_new',NULL,1,0,'2014-07-10 10:00:22'),(33,3,'user',1,'messages_conversation',10,'message_system_new',NULL,1,0,'2014-07-10 10:03:41'),(36,3,'user',1,'messages_conversation',11,'message_system_new',NULL,1,0,'2014-07-10 12:10:13'),(38,3,'user',1,'messages_conversation',13,'message_system_new',NULL,1,0,'2014-07-10 12:13:24'),(39,1,'user',3,'messages_conversation',14,'message_system_new',NULL,1,0,'2014-07-10 12:27:23'),(41,3,'user',1,'messages_conversation',15,'message_system_new',NULL,1,0,'2014-07-10 12:30:56'),(42,1,'user',3,'messages_conversation',16,'message_system_new',NULL,1,0,'2014-07-10 12:32:09'),(44,3,'user',1,'messages_conversation',17,'message_system_new',NULL,1,0,'2014-07-10 12:58:40'),(45,1,'user',3,'messages_conversation',18,'message_system_new',NULL,1,0,'2014-07-10 12:59:52'),(46,1,'user',3,'messages_conversation',19,'message_system_new',NULL,1,0,'2014-07-10 12:59:52'),(47,1,'user',2,'messages_conversation',20,'message_system_new',NULL,1,0,'2014-07-10 15:36:55'),(50,2,'user',1,'messages_conversation',21,'message_system_new',NULL,1,0,'2014-07-10 15:38:32'),(51,2,'user',1,'messages_conversation',22,'message_system_new',NULL,1,0,'2014-07-10 16:04:16'),(52,1,'user',1,'messages_conversation',23,'message_system_new',NULL,1,0,'2014-07-10 16:13:47'),(53,1,'user',1,'messages_conversation',24,'message_system_new',NULL,1,0,'2014-07-10 16:13:47'),(54,1,'user',1,'messages_conversation',25,'message_system_new',NULL,1,0,'2014-07-10 16:13:47'),(55,1,'user',1,'messages_conversation',26,'message_system_new',NULL,1,0,'2014-07-10 16:13:48'),(56,2,'user',1,'messages_conversation',27,'message_system_new',NULL,1,0,'2014-07-10 16:13:48'),(57,1,'user',1,'messages_conversation',28,'message_system_new',NULL,1,0,'2014-07-10 16:13:48'),(58,1,'user',1,'messages_conversation',29,'message_system_new',NULL,1,0,'2014-07-10 16:13:48'),(59,1,'user',1,'messages_conversation',30,'message_system_new',NULL,1,0,'2014-07-10 16:13:48'),(60,1,'user',1,'messages_conversation',31,'message_system_new',NULL,1,0,'2014-07-10 16:13:49'),(61,1,'user',1,'messages_conversation',32,'message_system_new',NULL,1,0,'2014-07-10 16:13:49'),(63,2,'user',1,'messages_conversation',33,'message_system_new',NULL,1,0,'2014-07-10 16:26:01'),(64,1,'user',3,'messages_conversation',34,'message_system_new',NULL,1,0,'2014-07-10 16:48:59'),(65,2,'user',1,'messages_conversation',35,'message_system_new',NULL,1,0,'2014-07-10 16:56:26'),(66,1,'user',1,'messages_conversation',36,'message_system_new',NULL,1,0,'2014-07-10 19:47:01'),(67,1,'user',1,'messages_conversation',37,'message_system_new',NULL,1,0,'2014-07-10 19:47:55'),(69,1,'user',2,'messages_conversation',38,'message_system_new',NULL,1,0,'2014-07-11 08:20:44'),(70,3,'user',1,'messages_conversation',39,'message_system_new',NULL,1,0,'2014-07-11 08:26:22'),(73,2,'user',1,'messages_conversation',40,'message_system_new',NULL,1,0,'2014-07-11 08:36:02'),(74,2,'user',1,'messages_conversation',41,'message_system_new',NULL,1,0,'2014-07-11 08:36:09'),(75,3,'user',1,'messages_conversation',42,'message_system_new',NULL,1,0,'2014-07-11 08:36:09'),(76,2,'user',1,'messages_conversation',43,'message_system_new',NULL,1,0,'2014-07-11 08:42:00'),(77,3,'user',1,'messages_conversation',44,'message_system_new',NULL,1,0,'2014-07-11 08:42:00'),(78,3,'user',1,'messages_conversation',45,'message_system_new',NULL,1,0,'2014-07-11 08:55:17'),(79,1,'user',3,'messages_conversation',46,'message_system_new',NULL,1,0,'2014-07-11 09:14:19'),(80,3,'user',1,'messages_conversation',47,'message_system_new',NULL,1,0,'2014-07-11 13:12:07'),(81,1,'user',3,'messages_conversation',48,'message_system_new',NULL,1,0,'2014-07-11 13:42:20'),(82,2,'user',1,'messages_conversation',49,'message_system_new',NULL,1,0,'2014-07-12 06:10:27'),(83,3,'user',1,'messages_conversation',50,'message_system_new',NULL,1,0,'2014-07-13 09:01:18'),(84,1,'user',3,'messages_conversation',51,'message_system_new',NULL,1,0,'2014-07-13 09:03:10'),(85,3,'user',1,'messages_conversation',52,'message_system_new',NULL,1,0,'2014-07-13 09:03:53'),(86,3,'user',1,'messages_conversation',53,'message_system_new',NULL,1,0,'2014-07-13 12:01:09'),(87,1,'user',3,'messages_conversation',54,'message_system_new',NULL,1,0,'2014-07-13 12:04:17'),(88,1,'user',3,'messages_conversation',55,'message_system_new',NULL,1,0,'2014-07-13 12:04:18'),(89,1,'user',3,'messages_conversation',56,'message_system_new',NULL,1,0,'2014-07-13 12:05:13'),(90,3,'user',1,'messages_conversation',57,'message_system_new',NULL,1,0,'2014-07-13 12:05:28'),(91,3,'user',1,'messages_conversation',58,'message_system_new',NULL,1,0,'2014-07-13 12:10:14'),(92,1,'user',2,'messages_conversation',59,'message_system_new',NULL,1,0,'2014-07-13 12:29:57'),(93,1,'user',2,'messages_conversation',60,'message_system_new',NULL,1,0,'2014-07-13 12:29:57'),(94,1,'user',2,'messages_conversation',61,'message_system_new',NULL,1,0,'2014-07-13 12:31:53'),(95,1,'user',2,'messages_conversation',62,'message_system_new',NULL,1,0,'2014-07-13 12:31:53'),(96,1,'user',2,'messages_conversation',63,'message_system_new',NULL,1,0,'2014-07-13 12:37:58'),(97,1,'user',2,'messages_conversation',64,'message_system_new',NULL,1,0,'2014-07-13 12:37:58'),(98,1,'user',2,'messages_conversation',65,'message_system_new',NULL,1,0,'2014-07-13 12:39:14'),(99,1,'user',2,'messages_conversation',66,'message_system_new',NULL,1,0,'2014-07-13 12:39:14'),(100,1,'user',1,'messages_conversation',67,'message_system_new',NULL,1,0,'2014-07-13 12:43:17'),(101,1,'user',1,'messages_conversation',68,'message_system_new',NULL,1,0,'2014-07-13 12:45:04'),(102,1,'user',3,'messages_conversation',69,'message_system_new',NULL,1,0,'2014-07-13 18:04:20'),(103,3,'user',3,'messages_conversation',70,'message_system_new',NULL,1,0,'2014-07-13 18:04:20'),(104,1,'user',1,'messages_conversation',71,'message_system_new',NULL,1,0,'2014-07-13 18:10:47'),(105,1,'user',1,'messages_conversation',72,'message_system_new',NULL,1,0,'2014-07-13 18:11:07'),(106,1,'user',1,'messages_conversation',73,'message_system_new',NULL,1,0,'2014-07-13 18:13:59'),(107,1,'user',3,'messages_conversation',74,'message_system_new',NULL,1,0,'2014-07-13 18:24:00'),(108,2,'user',1,'messages_conversation',75,'message_system_new',NULL,1,0,'2014-07-13 20:56:52'),(109,1,'user',2,'messages_conversation',76,'message_system_new',NULL,1,0,'2014-07-14 12:52:41'),(110,2,'user',1,'messages_conversation',77,'message_system_new',NULL,1,0,'2014-07-14 12:53:02'),(111,2,'user',1,'messages_conversation',78,'message_system_new',NULL,1,0,'2014-07-14 12:54:56'),(112,1,'user',2,'messages_conversation',79,'message_system_new',NULL,1,0,'2014-07-14 12:56:25'),(113,1,'user',2,'messages_conversation',80,'message_system_new',NULL,1,0,'2014-07-14 12:56:25'),(114,1,'user',2,'messages_conversation',81,'message_system_new',NULL,1,0,'2014-07-14 13:13:46'),(115,2,'user',1,'messages_conversation',82,'message_system_new',NULL,1,0,'2014-07-14 13:13:54'),(116,2,'user',1,'messages_conversation',83,'message_system_new',NULL,1,0,'2014-07-14 13:14:27'),(117,1,'user',2,'messages_conversation',84,'message_system_new',NULL,1,0,'2014-07-14 13:14:42'),(118,1,'user',2,'messages_conversation',85,'message_system_new',NULL,1,0,'2014-07-14 13:14:42'),(119,1,'user',3,'messages_conversation',86,'message_system_new',NULL,1,0,'2014-07-14 13:25:39'),(120,1,'user',2,'messages_conversation',87,'message_system_new',NULL,1,0,'2014-07-14 13:34:51'),(121,1,'user',2,'messages_conversation',88,'message_system_new',NULL,1,0,'2014-07-14 13:35:02'),(122,1,'user',2,'messages_conversation',89,'message_system_new',NULL,1,0,'2014-07-14 13:36:13'),(123,2,'user',1,'messages_conversation',90,'message_system_new',NULL,1,0,'2014-07-14 13:59:39'),(124,2,'user',1,'messages_conversation',91,'message_system_new',NULL,1,0,'2014-07-14 14:01:02'),(125,1,'user',3,'messages_conversation',92,'message_system_new',NULL,1,0,'2014-07-14 14:01:44'),(126,3,'user',1,'messages_conversation',93,'message_system_new',NULL,1,0,'2014-07-14 14:02:14'),(127,3,'user',1,'messages_conversation',94,'message_system_new',NULL,1,0,'2014-07-14 14:03:08'),(128,2,'user',3,'messages_conversation',95,'message_system_new',NULL,1,0,'2014-07-14 14:07:16'),(129,3,'user',1,'messages_conversation',96,'message_system_new',NULL,1,0,'2014-07-14 14:07:28'),(130,3,'user',1,'messages_conversation',97,'message_system_new',NULL,1,0,'2014-07-14 14:07:58'),(131,1,'user',3,'messages_conversation',98,'message_system_new',NULL,1,0,'2014-07-14 14:17:58'),(132,1,'user',3,'messages_conversation',99,'message_system_new',NULL,1,0,'2014-07-14 14:17:58'),(133,1,'user',4,'messages_conversation',100,'message_system_new',NULL,1,0,'2014-07-15 12:05:30'),(134,4,'user',1,'messages_conversation',101,'message_system_new',NULL,1,0,'2014-07-15 12:05:44'),(135,4,'user',1,'messages_conversation',102,'message_system_new',NULL,1,0,'2014-07-15 12:09:07'),(138,1,'user',4,'messages_conversation',105,'message_system_new',NULL,1,0,'2014-07-15 12:18:19'),(139,1,'user',4,'messages_conversation',106,'message_system_new',NULL,1,0,'2014-07-15 12:18:20'),(140,1,'user',1,'messages_conversation',107,'message_system_new',NULL,1,0,'2014-07-15 12:35:42'),(141,1,'user',2,'messages_conversation',108,'message_system_new',NULL,1,0,'2014-07-16 16:42:27'),(142,2,'user',1,'messages_conversation',109,'message_system_new',NULL,1,0,'2014-07-16 16:42:45'),(143,2,'user',1,'messages_conversation',110,'message_system_new',NULL,1,0,'2014-07-16 16:48:20'),(144,1,'user',3,'messages_conversation',111,'message_system_new',NULL,1,0,'2014-07-23 15:42:37'),(145,3,'user',1,'messages_conversation',112,'message_system_new',NULL,1,0,'2014-07-23 15:42:45'),(146,1,'user',2,'messages_conversation',113,'message_system_new',NULL,1,0,'2014-08-01 10:07:44'),(147,2,'user',1,'messages_conversation',114,'message_system_new',NULL,1,0,'2014-08-01 10:08:01'),(148,2,'user',1,'messages_conversation',115,'message_system_new',NULL,1,0,'2014-08-01 10:11:58'),(149,1,'user',3,'messages_conversation',116,'message_system_new',NULL,1,0,'2014-08-01 10:15:42'),(150,3,'user',1,'messages_conversation',117,'message_system_new',NULL,1,0,'2014-08-01 10:15:57'),(151,3,'user',1,'messages_conversation',118,'message_system_new',NULL,1,0,'2014-08-01 10:16:22'),(152,1,'user',4,'messages_conversation',119,'message_system_new',NULL,1,0,'2014-08-01 10:16:44'),(153,4,'user',1,'messages_conversation',120,'message_system_new',NULL,1,0,'2014-08-01 10:16:54'),(155,1,'user',2,'messages_conversation',122,'message_system_new',NULL,1,0,'2014-08-01 10:18:19'),(156,1,'user',2,'messages_conversation',123,'message_system_new',NULL,1,0,'2014-08-01 10:18:19'),(158,1,'user',1,'messages_conversation',125,'message_system_new',NULL,1,0,'2014-08-01 10:36:45'),(159,2,'user',1,'messages_conversation',126,'message_system_new',NULL,1,0,'2014-08-01 10:36:45'),(160,1,'user',1,'messages_conversation',127,'message_system_new',NULL,1,0,'2014-08-01 10:36:46'),(161,1,'user',1,'messages_conversation',128,'message_system_new',NULL,1,0,'2014-08-01 10:36:46'),(162,1,'user',1,'messages_conversation',129,'message_system_new',NULL,1,0,'2014-08-01 10:36:46'),(163,1,'user',1,'messages_conversation',130,'message_system_new',NULL,1,0,'2014-08-01 10:36:47'),(164,1,'user',1,'messages_conversation',131,'message_system_new',NULL,1,0,'2014-08-01 10:36:47'),(165,1,'user',1,'messages_conversation',132,'message_system_new',NULL,1,0,'2014-08-01 10:36:47'),(166,1,'user',1,'messages_conversation',133,'message_system_new',NULL,1,0,'2014-08-01 10:36:47'),(167,1,'user',1,'messages_conversation',134,'message_system_new',NULL,1,0,'2014-08-01 10:36:47'),(168,1,'user',1,'messages_conversation',135,'message_system_new',NULL,1,0,'2014-08-01 10:36:48'),(170,3,'user',1,'messages_conversation',137,'message_system_new',NULL,1,0,'2014-08-01 10:36:48'),(172,1,'user',1,'messages_conversation',139,'message_system_new',NULL,1,0,'2014-08-01 10:36:49'),(173,3,'user',1,'messages_conversation',140,'message_system_new',NULL,1,0,'2014-08-01 10:36:49'),(174,1,'user',1,'messages_conversation',141,'message_system_new',NULL,1,0,'2014-08-01 10:36:49'),(175,1,'user',1,'messages_conversation',142,'message_system_new',NULL,1,0,'2014-08-01 10:36:59'),(176,1,'user',2,'messages_conversation',143,'message_system_new',NULL,1,0,'2014-08-01 12:34:41'),(177,1,'user',3,'messages_conversation',144,'message_system_new',NULL,1,0,'2014-08-01 12:42:20'),(178,2,'user',1,'messages_conversation',145,'message_system_new',NULL,1,0,'2014-08-01 12:43:07'),(179,3,'user',1,'messages_conversation',146,'message_system_new',NULL,1,0,'2014-08-01 12:43:24'),(180,2,'user',1,'messages_conversation',147,'message_system_new',NULL,1,0,'2014-08-01 12:44:48'),(181,2,'user',1,'messages_conversation',148,'message_system_new',NULL,1,0,'2014-08-01 12:46:32'),(182,1,'user',2,'messages_conversation',149,'message_system_new',NULL,1,0,'2014-08-01 12:47:09'),(183,2,'user',1,'messages_conversation',150,'message_system_new',NULL,1,0,'2014-08-01 12:47:31'),(184,2,'user',1,'messages_conversation',151,'message_system_new',NULL,1,0,'2014-08-01 12:53:55'),(185,3,'user',1,'messages_conversation',152,'message_system_new',NULL,1,0,'2014-08-01 12:56:53'),(186,1,'user',2,'messages_conversation',153,'message_system_new',NULL,1,0,'2014-08-01 12:58:19'),(187,1,'user',2,'messages_conversation',154,'message_system_new',NULL,1,0,'2014-08-01 12:58:19'),(188,1,'user',1,'messages_conversation',155,'message_system_new',NULL,1,0,'2014-08-01 13:00:25'),(189,1,'user',1,'messages_conversation',156,'message_system_new',NULL,1,0,'2014-08-01 13:00:44'),(193,1,'user',1,'messages_conversation',160,'message_system_new',NULL,1,0,'2014-08-01 13:41:19'),(194,1,'user',1,'messages_conversation',161,'message_system_new',NULL,1,0,'2014-08-01 13:41:29'),(195,4,'user',1,'messages_conversation',162,'message_system_new',NULL,1,0,'2014-08-04 20:21:36'),(196,4,'user',1,'messages_conversation',163,'message_system_new',NULL,1,0,'2014-08-05 10:44:38'),(197,1,'user',1,'messages_conversation',164,'message_system_new',NULL,1,0,'2014-08-05 10:44:38'),(198,7,'user',8,'messages_conversation',165,'message_system_new',NULL,1,0,'2014-08-17 11:29:49'),(199,7,'user',8,'messages_conversation',166,'message_system_new',NULL,1,0,'2014-08-17 11:30:31'),(200,7,'user',8,'messages_conversation',167,'message_system_new',NULL,1,0,'2014-08-17 11:30:38'),(201,8,'user',1,'messages_conversation',168,'message_system_new',NULL,1,0,'2014-08-18 13:20:18'),(202,7,'user',8,'messages_conversation',169,'message_system_new',NULL,1,0,'2014-08-20 08:42:08'),(203,7,'user',8,'messages_conversation',170,'message_system_new',NULL,1,0,'2014-08-20 08:42:43'),(204,7,'user',8,'messages_conversation',171,'message_system_new',NULL,1,0,'2014-08-20 08:42:57'),(211,8,'user',1,'messages_conversation',175,'message_system_new',NULL,1,0,'2014-08-20 09:01:37'),(216,7,'user',1,'messages_conversation',179,'message_system_new',NULL,1,0,'2014-08-20 09:10:43'),(217,8,'user',1,'messages_conversation',180,'message_system_new',NULL,1,0,'2014-08-20 09:10:57'),(218,8,'user',1,'messages_conversation',181,'message_system_new',NULL,1,0,'2014-08-20 09:23:58'),(219,8,'user',1,'messages_conversation',182,'message_system_new',NULL,1,0,'2014-08-20 09:27:03'),(220,7,'user',1,'messages_conversation',183,'message_system_new',NULL,1,0,'2014-08-20 09:30:18'),(223,8,'user',7,'messages_conversation',185,'message_system_new',NULL,1,0,'2014-08-20 12:46:38'),(225,7,'user',1,'messages_conversation',187,'message_system_new',NULL,1,0,'2014-08-20 12:48:03'),(230,8,'user',7,'messages_conversation',192,'message_system_new',NULL,0,0,'2014-08-20 13:47:58'),(245,7,'user',1,'messages_conversation',204,'message_system_new',NULL,1,0,'2014-08-20 21:35:22'),(246,7,'user',1,'messages_conversation',205,'message_system_new',NULL,1,0,'2014-08-20 21:35:22'),(247,8,'user',1,'messages_conversation',206,'message_system_new',NULL,0,0,'2014-08-20 21:35:23'),(248,8,'user',1,'messages_conversation',207,'message_system_new',NULL,0,0,'2014-08-20 21:35:23'),(250,1,'user',1,'messages_conversation',209,'message_system_new',NULL,1,0,'2014-08-20 21:36:41'),(252,8,'user',1,'messages_conversation',211,'message_system_new',NULL,0,0,'2014-08-20 21:38:12'),(253,8,'user',1,'messages_conversation',212,'message_system_new',NULL,0,0,'2014-08-20 21:39:06'),(254,8,'user',1,'messages_conversation',213,'message_system_new',NULL,0,0,'2014-08-20 21:39:08'),(255,1,'user',1,'messages_conversation',214,'message_system_new',NULL,1,0,'2014-08-20 21:39:36'),(258,8,'user',1,'messages_conversation',217,'message_system_new',NULL,0,0,'2014-08-24 12:57:36'),(260,8,'user',1,'messages_conversation',219,'message_system_new',NULL,0,0,'2014-08-24 12:57:37'),(261,7,'user',1,'messages_conversation',220,'message_system_new',NULL,1,0,'2014-08-24 12:57:37'),(263,7,'user',1,'messages_conversation',222,'message_system_new',NULL,1,0,'2014-08-24 12:57:38'),(264,1,'user',3,'messages_conversation',223,'message_system_new',NULL,1,0,'2014-08-26 13:51:46'),(265,1,'user',3,'messages_conversation',224,'message_system_new',NULL,1,0,'2014-08-26 13:52:30'),(266,1,'user',3,'messages_conversation',225,'message_system_new',NULL,1,0,'2014-08-26 14:16:41'),(267,3,'user',1,'messages_conversation',226,'message_system_new',NULL,1,0,'2014-08-26 14:16:57'),(268,3,'user',1,'messages_conversation',227,'message_system_new',NULL,1,0,'2014-08-26 14:17:46'),(278,1,'user',1,'messages_conversation',234,'message_system_new',NULL,1,0,'2014-09-02 09:41:21'),(279,7,'user',1,'messages_conversation',235,'message_system_new',NULL,1,0,'2014-09-02 09:41:22'),(280,8,'user',2,'messages_conversation',236,'message_system_new',NULL,1,0,'2014-09-02 21:55:37'),(281,8,'user',2,'messages_conversation',237,'message_system_new',NULL,0,0,'2014-09-02 22:01:53'),(293,1,'user',4,'messages_conversation',249,'message_system_new',NULL,1,0,'2014-09-03 08:15:41'),(295,1,'user',3,'messages_conversation',251,'message_system_new',NULL,1,0,'2014-09-03 08:18:53'),(296,3,'user',1,'messages_conversation',252,'message_system_new',NULL,1,0,'2014-09-03 08:19:15'),(297,4,'user',1,'messages_conversation',253,'message_system_new',NULL,1,0,'2014-09-03 08:19:25'),(299,1,'user',3,'messages_conversation',255,'message_system_new',NULL,1,0,'2014-09-03 08:26:13'),(301,1,'user',1,'messages_conversation',257,'message_system_new',NULL,1,0,'2014-09-03 08:30:40'),(302,1,'user',1,'messages_conversation',258,'message_system_new',NULL,1,0,'2014-09-03 08:44:33'),(303,1,'user',3,'messages_conversation',259,'message_system_new',NULL,1,0,'2014-09-03 10:19:22'),(305,3,'user',1,'messages_conversation',261,'message_system_new',NULL,0,0,'2014-09-03 10:20:31'),(309,1,'user',3,'messages_conversation',265,'message_system_new',NULL,1,0,'2014-09-03 12:07:10'),(310,1,'user',2,'messages_conversation',266,'message_system_new',NULL,1,0,'2014-09-03 12:07:19'),(312,1,'user',3,'messages_conversation',268,'message_system_new',NULL,1,0,'2014-09-03 12:08:36'),(313,3,'user',1,'messages_conversation',269,'message_system_new',NULL,0,0,'2014-09-03 12:08:54'),(317,1,'user',3,'messages_conversation',273,'message_system_new',NULL,1,0,'2014-09-03 12:10:18'),(318,1,'user',2,'messages_conversation',274,'message_system_new',NULL,1,0,'2014-09-03 12:10:35'),(319,2,'user',1,'messages_conversation',275,'message_system_new',NULL,1,0,'2014-09-03 12:10:47'),(320,1,'user',3,'messages_conversation',276,'message_system_new',NULL,1,0,'2014-09-03 12:11:52'),(321,1,'user',2,'messages_conversation',277,'message_system_new',NULL,1,0,'2014-09-03 12:12:18'),(322,1,'user',1,'messages_conversation',278,'message_system_new',NULL,1,0,'2014-09-03 12:14:56'),(324,1,'user',1,'messages_conversation',280,'message_system_new',NULL,1,0,'2014-09-03 12:55:50'),(325,8,'user',1,'messages_conversation',281,'message_system_new',NULL,0,0,'2014-09-03 13:41:28'),(326,1,'user',1,'messages_conversation',282,'message_system_new',NULL,1,0,'2014-09-03 13:42:11'),(327,2,'user',1,'messages_conversation',283,'message_system_new',NULL,1,0,'2014-09-13 22:10:40'),(328,1,'user',1,'messages_conversation',284,'message_system_new',NULL,1,0,'2014-09-13 22:10:40'),(329,1,'user',1,'messages_conversation',285,'message_system_new',NULL,1,0,'2014-09-13 22:10:40'),(330,8,'user',1,'messages_conversation',286,'message_system_new',NULL,1,0,'2014-09-13 22:10:41'),(331,11,'user',9,'messages_conversation',287,'message_system_new',NULL,1,0,'2014-09-13 22:52:20'),(332,11,'user',9,'messages_conversation',288,'message_system_new',NULL,1,0,'2014-09-13 23:02:58'),(333,11,'user',9,'messages_conversation',289,'message_system_new',NULL,1,0,'2014-09-13 23:14:07'),(334,9,'user',1,'messages_conversation',290,'message_system_new',NULL,1,0,'2014-09-13 23:15:55'),(335,9,'user',1,'messages_conversation',291,'message_system_new',NULL,1,0,'2014-09-13 23:20:53'),(336,11,'user',9,'messages_conversation',292,'message_system_new',NULL,1,0,'2014-09-13 23:39:24'),(337,1,'user',9,'messages_conversation',293,'message_system_new',NULL,1,0,'2014-09-13 23:39:24'),(338,11,'user',9,'messages_conversation',294,'message_system_new',NULL,1,0,'2014-09-14 00:02:41'),(339,11,'user',9,'messages_conversation',295,'message_system_new',NULL,1,0,'2014-09-14 00:08:21'),(340,9,'user',1,'messages_conversation',296,'message_system_new',NULL,1,0,'2014-09-14 00:09:02'),(341,11,'user',9,'messages_conversation',297,'message_system_new',NULL,1,0,'2014-09-14 00:11:38'),(342,11,'user',9,'messages_conversation',298,'message_system_new',NULL,1,0,'2014-09-14 00:14:00'),(343,9,'user',1,'messages_conversation',299,'message_system_new',NULL,1,0,'2014-09-14 00:14:22'),(344,9,'user',1,'messages_conversation',300,'message_system_new',NULL,1,0,'2014-09-14 00:17:47'),(345,9,'user',1,'messages_conversation',301,'message_system_new',NULL,1,0,'2014-09-14 00:23:11'),(346,11,'user',9,'messages_conversation',302,'message_system_new',NULL,1,0,'2014-09-14 00:24:42'),(347,9,'user',1,'messages_conversation',303,'message_system_new',NULL,1,0,'2014-09-14 00:30:03'),(348,11,'user',9,'messages_conversation',304,'message_system_new',NULL,1,0,'2014-09-14 00:33:45'),(349,11,'user',9,'messages_conversation',305,'message_system_new',NULL,1,0,'2014-09-14 00:34:09'),(350,11,'user',9,'messages_conversation',306,'message_system_new',NULL,1,0,'2014-09-14 00:35:24'),(351,9,'user',1,'messages_conversation',307,'message_system_new',NULL,1,0,'2014-09-14 00:35:45'),(352,9,'user',1,'messages_conversation',308,'message_system_new',NULL,1,0,'2014-09-14 00:36:22'),(353,11,'user',9,'messages_conversation',309,'message_system_new',NULL,1,0,'2014-09-14 00:39:44'),(354,1,'user',9,'messages_conversation',310,'message_system_new',NULL,1,0,'2014-09-14 00:39:44'),(355,11,'user',9,'messages_conversation',311,'message_system_new',NULL,1,0,'2014-09-14 00:53:33'),(356,11,'user',9,'messages_conversation',312,'message_system_new',NULL,1,0,'2014-09-14 23:13:16'),(357,9,'user',1,'messages_conversation',313,'message_system_new',NULL,1,0,'2014-09-14 23:14:20'),(358,11,'user',9,'messages_conversation',314,'message_system_new',NULL,0,0,'2014-09-14 23:31:48'),(359,11,'user',9,'messages_conversation',315,'message_system_new',NULL,0,0,'2014-09-14 23:40:26'),(360,9,'user',1,'messages_conversation',316,'message_system_new',NULL,0,0,'2014-09-14 23:41:13'),(361,9,'user',1,'messages_conversation',317,'message_system_new',NULL,0,0,'2014-09-14 23:42:10'),(362,9,'user',1,'messages_conversation',318,'message_system_new',NULL,0,0,'2014-09-14 23:43:54'),(363,1,'user',9,'messages_conversation',319,'message_system_new',NULL,1,0,'2014-09-14 23:43:54'),(364,11,'user',1,'messages_conversation',320,'message_system_new',NULL,0,0,'2014-09-14 23:57:33'),(365,1,'user',11,'messages_conversation',321,'message_system_new',NULL,1,0,'2014-09-15 00:02:47'),(366,8,'user',7,'messages_conversation',322,'message_system_new',NULL,1,0,'2014-09-16 20:00:44'),(367,8,'user',7,'messages_conversation',323,'message_system_new',NULL,0,0,'2014-09-16 20:23:43'),(369,7,'user',1,'messages_conversation',325,'message_system_new',NULL,1,0,'2014-09-17 21:42:31'),(370,11,'user',7,'messages_conversation',326,'message_system_new',NULL,0,0,'2014-09-17 22:02:04'),(371,8,'user',7,'messages_conversation',327,'message_system_new',NULL,1,0,'2014-09-17 22:02:29'),(372,7,'user',1,'messages_conversation',328,'message_system_new',NULL,1,0,'2014-09-17 22:03:55'),(373,7,'user',1,'messages_conversation',329,'message_system_new',NULL,1,0,'2014-09-17 22:29:35'),(374,8,'user',13,'messages_conversation',330,'message_system_new',NULL,0,0,'2014-09-17 22:43:13'),(375,13,'user',1,'messages_conversation',331,'message_system_new',NULL,0,0,'2014-09-17 22:44:11'),(376,11,'user',13,'messages_conversation',332,'message_system_new',NULL,0,0,'2014-09-18 20:54:20'),(377,13,'user',1,'messages_conversation',333,'message_system_new',NULL,0,0,'2014-09-18 20:57:05'),(378,7,'user',1,'messages_conversation',334,'message_system_new',NULL,1,0,'2014-09-18 22:35:40'),(379,13,'user',1,'messages_conversation',335,'message_system_new',NULL,0,0,'2014-09-21 23:38:35'),(380,8,'user',1,'messages_conversation',336,'message_system_new',NULL,0,0,'2014-10-01 13:27:32'),(381,1,'user',1,'messages_conversation',337,'message_system_new',NULL,1,0,'2014-10-01 13:27:32'),(382,11,'user',1,'messages_conversation',338,'message_system_new',NULL,0,0,'2014-10-01 13:27:33'),(383,1,'user',2,'messages_conversation',339,'message_system_new',NULL,1,0,'2014-10-02 12:43:32'),(384,1,'user',3,'messages_conversation',340,'message_system_new',NULL,1,0,'2014-10-02 12:43:50'),(385,2,'user',1,'messages_conversation',341,'message_system_new',NULL,1,0,'2014-10-02 12:44:17'),(386,3,'user',1,'messages_conversation',342,'message_system_new',NULL,0,0,'2014-10-02 12:44:24'),(387,1,'user',3,'messages_conversation',343,'message_system_new',NULL,1,0,'2014-10-02 12:45:02'),(388,1,'user',3,'messages_conversation',344,'message_system_new',NULL,1,0,'2014-10-02 12:47:14'),(389,3,'user',1,'messages_conversation',345,'message_system_new',NULL,0,0,'2014-10-02 12:47:29'),(390,3,'user',1,'messages_conversation',346,'message_system_new',NULL,0,0,'2014-10-02 12:47:59'),(391,1,'user',3,'messages_conversation',347,'message_system_new',NULL,1,0,'2014-10-02 12:48:23'),(392,1,'user',3,'messages_conversation',348,'message_system_new',NULL,1,0,'2014-10-02 12:48:23'),(393,1,'user',3,'messages_conversation',349,'message_system_new',NULL,1,0,'2014-10-03 11:12:49'),(394,1,'user',4,'messages_conversation',350,'message_system_new',NULL,1,0,'2014-10-03 11:18:54'),(395,4,'user',1,'messages_conversation',351,'message_system_new',NULL,1,0,'2014-10-03 11:19:14'),(396,4,'user',1,'messages_conversation',352,'message_system_new',NULL,1,0,'2014-10-03 11:20:00'),(397,1,'user',4,'messages_conversation',353,'message_system_new',NULL,1,0,'2014-10-03 11:20:47'),(398,1,'user',4,'messages_conversation',354,'message_system_new',NULL,1,0,'2014-10-03 11:20:47'),(399,2,'user',1,'messages_conversation',355,'message_system_new',NULL,1,0,'2014-10-03 11:48:02'),(400,4,'user',1,'messages_conversation',356,'message_system_new',NULL,1,0,'2014-10-03 11:48:02'),(401,1,'user',1,'messages_conversation',357,'message_system_new',NULL,1,0,'2014-10-03 12:04:52'),(402,1,'user',4,'messages_conversation',358,'message_system_new',NULL,1,0,'2014-10-03 12:50:50'),(403,4,'user',1,'messages_conversation',359,'message_system_new',NULL,1,0,'2014-10-03 12:51:05'),(404,4,'user',1,'messages_conversation',360,'message_system_new',NULL,1,0,'2014-10-03 12:51:53'),(405,1,'user',4,'messages_conversation',361,'message_system_new',NULL,1,0,'2014-10-03 13:09:28'),(406,1,'user',4,'messages_conversation',362,'message_system_new',NULL,1,0,'2014-10-03 13:09:28'),(407,1,'user',2,'messages_conversation',363,'message_system_new',NULL,1,0,'2014-10-08 13:55:46'),(408,2,'user',1,'messages_conversation',364,'message_system_new',NULL,1,0,'2014-10-08 13:56:01'),(409,2,'user',1,'messages_conversation',365,'message_system_new',NULL,1,0,'2014-10-08 13:56:38'),(410,1,'user',2,'messages_conversation',366,'message_system_new',NULL,1,0,'2014-10-09 14:24:20'),(411,2,'user',1,'messages_conversation',367,'message_system_new',NULL,1,0,'2014-10-09 14:24:53'),(412,2,'user',1,'messages_conversation',368,'message_system_new',NULL,1,0,'2014-10-09 14:25:44'),(413,1,'user',2,'messages_conversation',369,'message_system_new',NULL,1,0,'2014-10-09 14:26:30'),(414,1,'user',2,'messages_conversation',370,'message_system_new',NULL,1,0,'2014-10-09 14:26:30'),(415,1,'user',1,'messages_conversation',371,'message_system_new',NULL,1,0,'2014-10-29 12:52:29'),(416,1,'user',1,'messages_conversation',372,'message_system_new',NULL,1,0,'2014-10-29 12:52:30'),(417,13,'user',7,'user',13,'friend_request',NULL,0,0,'2014-11-04 22:40:31');
/*!40000 ALTER TABLE `engine4_activity_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_notificationsettings`
--

DROP TABLE IF EXISTS `engine4_activity_notificationsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_notificationsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_notificationsettings`
--

LOCK TABLES `engine4_activity_notificationsettings` WRITE;
/*!40000 ALTER TABLE `engine4_activity_notificationsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_activity_notificationsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_notificationtypes`
--

DROP TABLE IF EXISTS `engine4_activity_notificationtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_notificationtypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `is_request` tinyint(1) NOT NULL DEFAULT '0',
  `handler` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_notificationtypes`
--

LOCK TABLES `engine4_activity_notificationtypes` WRITE;
/*!40000 ALTER TABLE `engine4_activity_notificationtypes` DISABLE KEYS */;
INSERT INTO `engine4_activity_notificationtypes` VALUES ('commented','activity','{item:$subject} has commented on your {item:$object:$label}.',0,'',1),('commented_commented','activity','{item:$subject} has commented on a {item:$object:$label} you commented on.',0,'',1),('event_accepted','event','Your request to join the event {item:$object} has been approved.',0,'',1),('event_approve','event','{item:$subject} has requested to join the event {item:$object}.',0,'',1),('event_discussion_reply','event','{item:$subject} has {item:$object:posted} on a {itemParent:$object::event topic} you posted on.',0,'',1),('event_discussion_response','event','{item:$subject} has {item:$object:posted} on a {itemParent:$object::event topic} you created.',0,'',1),('event_invite','event','{item:$subject} has invited you to the event {item:$object}.',1,'event.widget.request-event',1),('friend_accepted','user','You and {item:$subject} are now friends.',0,'',1),('friend_follow','user','{item:$subject} is now following you.',0,'',1),('friend_follow_accepted','user','You are now following {item:$subject}.',0,'',1),('friend_follow_request','user','{item:$subject} has requested to follow you.',1,'user.friends.request-follow',1),('friend_request','user','{item:$subject} has requested to be your friend.',1,'user.friends.request-friend',1),('liked','activity','{item:$subject} likes your {item:$object:$label}.',0,'',1),('liked_commented','activity','{item:$subject} has commented on a {item:$object:$label} you liked.',0,'',1),('message_new','messages','{item:$subject} has sent you a {item:$object:message}.',0,'',1),('message_system_new','messages','You have received a system {item:$object:message}.',0,'',1),('post_user','user','{item:$subject} has posted on your {item:$object:profile}.',0,'',1),('shared','activity','{item:$subject} has shared your {item:$object:$label}.',0,'',1),('tagged','user','{item:$subject} tagged you in a {item:$object:$label}.',0,'',1);
/*!40000 ALTER TABLE `engine4_activity_notificationtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_activity_stream`
--

DROP TABLE IF EXISTS `engine4_activity_stream`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_activity_stream` (
  `target_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `target_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `action_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`target_type`,`target_id`,`action_id`),
  KEY `SUBJECT` (`subject_type`,`subject_id`,`action_id`),
  KEY `OBJECT` (`object_type`,`object_id`,`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_activity_stream`
--

LOCK TABLES `engine4_activity_stream` WRITE;
/*!40000 ALTER TABLE `engine4_activity_stream` DISABLE KEYS */;
INSERT INTO `engine4_activity_stream` VALUES ('event',5,'user',2,'event',5,'event_create',11),('event',18,'user',7,'event',18,'event_create',25),('event',20,'user',8,'event',20,'event_create',33),('event',25,'user',1,'event',25,'event_create',43),('event',26,'user',1,'event',26,'event_create',44),('event',28,'user',11,'event',28,'event_create',47),('event',28,'user',11,'event',28,'post',48),('event',29,'user',11,'event',29,'event_create',49),('event',30,'user',11,'event',30,'event_create',51),('event',33,'user',1,'event',33,'event_create',55),('event',34,'user',1,'event',34,'event_create',56),('event',35,'user',1,'event',35,'event_create',57),('everyone',0,'user',2,'user',2,'signup',4),('everyone',0,'user',3,'user',3,'signup',5),('everyone',0,'user',4,'user',4,'signup',6),('everyone',0,'user',2,'event',5,'event_create',11),('everyone',0,'user',7,'user',7,'signup',24),('everyone',0,'user',7,'event',18,'event_create',25),('everyone',0,'user',8,'user',8,'signup',26),('everyone',0,'user',9,'user',9,'signup',27),('everyone',0,'user',9,'user',9,'profile_photo_update',28),('everyone',0,'user',8,'event',20,'event_create',33),('everyone',0,'user',1,'event',25,'event_create',43),('everyone',0,'user',1,'event',26,'event_create',44),('everyone',0,'user',11,'user',11,'signup',46),('everyone',0,'user',11,'event',28,'event_create',47),('everyone',0,'user',11,'event',28,'post',48),('everyone',0,'user',11,'event',29,'event_create',49),('everyone',0,'user',12,'user',12,'signup',50),('everyone',0,'user',11,'event',30,'event_create',51),('everyone',0,'user',13,'user',13,'signup',52),('everyone',0,'user',1,'event',33,'event_create',55),('everyone',0,'user',1,'event',34,'event_create',56),('everyone',0,'user',1,'event',35,'event_create',57),('members',1,'user',1,'event',25,'event_create',43),('members',1,'user',1,'event',26,'event_create',44),('members',1,'user',1,'event',33,'event_create',55),('members',1,'user',1,'event',34,'event_create',56),('members',1,'user',1,'event',35,'event_create',57),('members',2,'user',2,'user',2,'signup',4),('members',2,'user',2,'event',5,'event_create',11),('members',3,'user',3,'user',3,'signup',5),('members',4,'user',4,'user',4,'signup',6),('members',7,'user',7,'user',7,'signup',24),('members',7,'user',7,'event',18,'event_create',25),('members',8,'user',8,'user',8,'signup',26),('members',8,'user',8,'event',20,'event_create',33),('members',9,'user',9,'user',9,'signup',27),('members',9,'user',9,'user',9,'profile_photo_update',28),('members',11,'user',11,'user',11,'signup',46),('members',11,'user',11,'event',28,'event_create',47),('members',11,'user',11,'event',28,'post',48),('members',11,'user',11,'event',29,'event_create',49),('members',11,'user',11,'event',30,'event_create',51),('members',12,'user',12,'user',12,'signup',50),('members',13,'user',13,'user',13,'signup',52),('owner',1,'user',1,'event',25,'event_create',43),('owner',1,'user',1,'event',26,'event_create',44),('owner',1,'user',1,'event',33,'event_create',55),('owner',1,'user',1,'event',34,'event_create',56),('owner',1,'user',1,'event',35,'event_create',57),('owner',2,'user',2,'user',2,'signup',4),('owner',2,'user',2,'event',5,'event_create',11),('owner',3,'user',3,'user',3,'signup',5),('owner',4,'user',4,'user',4,'signup',6),('owner',7,'user',7,'user',7,'signup',24),('owner',7,'user',7,'event',18,'event_create',25),('owner',8,'user',8,'user',8,'signup',26),('owner',8,'user',8,'event',20,'event_create',33),('owner',9,'user',9,'user',9,'signup',27),('owner',9,'user',9,'user',9,'profile_photo_update',28),('owner',11,'user',11,'user',11,'signup',46),('owner',11,'user',11,'event',28,'event_create',47),('owner',11,'user',11,'event',28,'post',48),('owner',11,'user',11,'event',29,'event_create',49),('owner',11,'user',11,'event',30,'event_create',51),('owner',12,'user',12,'user',12,'signup',50),('owner',13,'user',13,'user',13,'signup',52),('parent',1,'user',1,'event',25,'event_create',43),('parent',1,'user',1,'event',26,'event_create',44),('parent',1,'user',1,'event',33,'event_create',55),('parent',1,'user',1,'event',34,'event_create',56),('parent',1,'user',1,'event',35,'event_create',57),('parent',2,'user',2,'user',2,'signup',4),('parent',2,'user',2,'event',5,'event_create',11),('parent',3,'user',3,'user',3,'signup',5),('parent',4,'user',4,'user',4,'signup',6),('parent',7,'user',7,'user',7,'signup',24),('parent',7,'user',7,'event',18,'event_create',25),('parent',8,'user',8,'user',8,'signup',26),('parent',8,'user',8,'event',20,'event_create',33),('parent',9,'user',9,'user',9,'signup',27),('parent',9,'user',9,'user',9,'profile_photo_update',28),('parent',11,'user',11,'user',11,'signup',46),('parent',11,'user',11,'event',28,'event_create',47),('parent',11,'user',11,'event',28,'post',48),('parent',11,'user',11,'event',29,'event_create',49),('parent',11,'user',11,'event',30,'event_create',51),('parent',12,'user',12,'user',12,'signup',50),('parent',13,'user',13,'user',13,'signup',52),('registered',0,'user',2,'user',2,'signup',4),('registered',0,'user',3,'user',3,'signup',5),('registered',0,'user',4,'user',4,'signup',6),('registered',0,'user',2,'event',5,'event_create',11),('registered',0,'user',7,'user',7,'signup',24),('registered',0,'user',7,'event',18,'event_create',25),('registered',0,'user',8,'user',8,'signup',26),('registered',0,'user',9,'user',9,'signup',27),('registered',0,'user',9,'user',9,'profile_photo_update',28),('registered',0,'user',8,'event',20,'event_create',33),('registered',0,'user',1,'event',25,'event_create',43),('registered',0,'user',1,'event',26,'event_create',44),('registered',0,'user',11,'user',11,'signup',46),('registered',0,'user',11,'event',28,'event_create',47),('registered',0,'user',11,'event',28,'post',48),('registered',0,'user',11,'event',29,'event_create',49),('registered',0,'user',12,'user',12,'signup',50),('registered',0,'user',11,'event',30,'event_create',51),('registered',0,'user',13,'user',13,'signup',52),('registered',0,'user',1,'event',33,'event_create',55),('registered',0,'user',1,'event',34,'event_create',56),('registered',0,'user',1,'event',35,'event_create',57);
/*!40000 ALTER TABLE `engine4_activity_stream` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_announcement_announcements`
--

DROP TABLE IF EXISTS `engine4_announcement_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_announcement_announcements` (
  `announcement_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `networks` text COLLATE utf8_unicode_ci,
  `member_levels` text COLLATE utf8_unicode_ci,
  `profile_types` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`announcement_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_announcement_announcements`
--

LOCK TABLES `engine4_announcement_announcements` WRITE;
/*!40000 ALTER TABLE `engine4_announcement_announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_announcement_announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_authorization_allow`
--

DROP TABLE IF EXISTS `engine4_authorization_allow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_authorization_allow` (
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `action` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` tinyint(1) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_type`,`resource_id`,`action`,`role`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_authorization_allow`
--

LOCK TABLES `engine4_authorization_allow` WRITE;
/*!40000 ALTER TABLE `engine4_authorization_allow` DISABLE KEYS */;
INSERT INTO `engine4_authorization_allow` VALUES ('event',5,'comment','everyone',0,1,NULL),('event',5,'comment','member',0,1,NULL),('event',5,'comment','owner_member',0,1,NULL),('event',5,'comment','owner_member_member',0,1,NULL),('event',5,'comment','owner_network',0,1,NULL),('event',5,'comment','registered',0,1,NULL),('event',5,'invite','member',0,1,NULL),('event',5,'photo','everyone',0,1,NULL),('event',5,'photo','member',0,1,NULL),('event',5,'photo','owner_member',0,1,NULL),('event',5,'photo','owner_member_member',0,1,NULL),('event',5,'photo','owner_network',0,1,NULL),('event',5,'photo','registered',0,1,NULL),('event',5,'view','everyone',0,1,NULL),('event',5,'view','member',0,1,NULL),('event',5,'view','member_requested',0,1,NULL),('event',5,'view','owner_member',0,1,NULL),('event',5,'view','owner_member_member',0,1,NULL),('event',5,'view','owner_network',0,1,NULL),('event',5,'view','registered',0,1,NULL),('event',18,'comment','everyone',0,1,NULL),('event',18,'comment','member',0,1,NULL),('event',18,'comment','owner_member',0,1,NULL),('event',18,'comment','owner_member_member',0,1,NULL),('event',18,'comment','owner_network',0,1,NULL),('event',18,'comment','registered',0,1,NULL),('event',18,'invite','member',0,1,NULL),('event',18,'photo','everyone',0,1,NULL),('event',18,'photo','member',0,1,NULL),('event',18,'photo','owner_member',0,1,NULL),('event',18,'photo','owner_member_member',0,1,NULL),('event',18,'photo','owner_network',0,1,NULL),('event',18,'photo','registered',0,1,NULL),('event',18,'view','everyone',0,1,NULL),('event',18,'view','member',0,1,NULL),('event',18,'view','member_requested',0,1,NULL),('event',18,'view','owner_member',0,1,NULL),('event',18,'view','owner_member_member',0,1,NULL),('event',18,'view','owner_network',0,1,NULL),('event',18,'view','registered',0,1,NULL),('event',20,'comment','everyone',0,1,NULL),('event',20,'comment','member',0,1,NULL),('event',20,'comment','owner_member',0,1,NULL),('event',20,'comment','owner_member_member',0,1,NULL),('event',20,'comment','owner_network',0,1,NULL),('event',20,'comment','registered',0,1,NULL),('event',20,'invite','member',0,1,NULL),('event',20,'photo','everyone',0,1,NULL),('event',20,'photo','member',0,1,NULL),('event',20,'photo','owner_member',0,1,NULL),('event',20,'photo','owner_member_member',0,1,NULL),('event',20,'photo','owner_network',0,1,NULL),('event',20,'photo','registered',0,1,NULL),('event',20,'view','everyone',0,1,NULL),('event',20,'view','member',0,1,NULL),('event',20,'view','member_requested',0,1,NULL),('event',20,'view','owner_member',0,1,NULL),('event',20,'view','owner_member_member',0,1,NULL),('event',20,'view','owner_network',0,1,NULL),('event',20,'view','registered',0,1,NULL),('event',25,'comment','everyone',0,1,NULL),('event',25,'comment','member',0,1,NULL),('event',25,'comment','owner_member',0,1,NULL),('event',25,'comment','owner_member_member',0,1,NULL),('event',25,'comment','owner_network',0,1,NULL),('event',25,'comment','registered',0,1,NULL),('event',25,'invite','member',0,1,NULL),('event',25,'photo','everyone',0,1,NULL),('event',25,'photo','member',0,1,NULL),('event',25,'photo','owner_member',0,1,NULL),('event',25,'photo','owner_member_member',0,1,NULL),('event',25,'photo','owner_network',0,1,NULL),('event',25,'photo','registered',0,1,NULL),('event',25,'view','everyone',0,1,NULL),('event',25,'view','member',0,1,NULL),('event',25,'view','member_requested',0,1,NULL),('event',25,'view','owner_member',0,1,NULL),('event',25,'view','owner_member_member',0,1,NULL),('event',25,'view','owner_network',0,1,NULL),('event',25,'view','registered',0,1,NULL),('event',26,'comment','everyone',0,1,NULL),('event',26,'comment','member',0,1,NULL),('event',26,'comment','owner_member',0,1,NULL),('event',26,'comment','owner_member_member',0,1,NULL),('event',26,'comment','owner_network',0,1,NULL),('event',26,'comment','registered',0,1,NULL),('event',26,'invite','member',0,1,NULL),('event',26,'photo','everyone',0,1,NULL),('event',26,'photo','member',0,1,NULL),('event',26,'photo','owner_member',0,1,NULL),('event',26,'photo','owner_member_member',0,1,NULL),('event',26,'photo','owner_network',0,1,NULL),('event',26,'photo','registered',0,1,NULL),('event',26,'view','everyone',0,1,NULL),('event',26,'view','member',0,1,NULL),('event',26,'view','member_requested',0,1,NULL),('event',26,'view','owner_member',0,1,NULL),('event',26,'view','owner_member_member',0,1,NULL),('event',26,'view','owner_network',0,1,NULL),('event',26,'view','registered',0,1,NULL),('event',28,'comment','everyone',0,1,NULL),('event',28,'comment','member',0,1,NULL),('event',28,'comment','owner_member',0,1,NULL),('event',28,'comment','owner_member_member',0,1,NULL),('event',28,'comment','owner_network',0,1,NULL),('event',28,'comment','registered',0,1,NULL),('event',28,'invite','member',0,1,NULL),('event',28,'photo','everyone',0,1,NULL),('event',28,'photo','member',0,1,NULL),('event',28,'photo','owner_member',0,1,NULL),('event',28,'photo','owner_member_member',0,1,NULL),('event',28,'photo','owner_network',0,1,NULL),('event',28,'photo','registered',0,1,NULL),('event',28,'view','everyone',0,1,NULL),('event',28,'view','member',0,1,NULL),('event',28,'view','member_requested',0,1,NULL),('event',28,'view','owner_member',0,1,NULL),('event',28,'view','owner_member_member',0,1,NULL),('event',28,'view','owner_network',0,1,NULL),('event',28,'view','registered',0,1,NULL),('event',29,'comment','everyone',0,1,NULL),('event',29,'comment','member',0,1,NULL),('event',29,'comment','owner_member',0,1,NULL),('event',29,'comment','owner_member_member',0,1,NULL),('event',29,'comment','owner_network',0,1,NULL),('event',29,'comment','registered',0,1,NULL),('event',29,'invite','member',0,1,NULL),('event',29,'photo','everyone',0,1,NULL),('event',29,'photo','member',0,1,NULL),('event',29,'photo','owner_member',0,1,NULL),('event',29,'photo','owner_member_member',0,1,NULL),('event',29,'photo','owner_network',0,1,NULL),('event',29,'photo','registered',0,1,NULL),('event',29,'view','everyone',0,1,NULL),('event',29,'view','member',0,1,NULL),('event',29,'view','member_requested',0,1,NULL),('event',29,'view','owner_member',0,1,NULL),('event',29,'view','owner_member_member',0,1,NULL),('event',29,'view','owner_network',0,1,NULL),('event',29,'view','registered',0,1,NULL),('event',30,'comment','everyone',0,1,NULL),('event',30,'comment','member',0,1,NULL),('event',30,'comment','owner_member',0,1,NULL),('event',30,'comment','owner_member_member',0,1,NULL),('event',30,'comment','owner_network',0,1,NULL),('event',30,'comment','registered',0,1,NULL),('event',30,'invite','member',0,1,NULL),('event',30,'photo','everyone',0,1,NULL),('event',30,'photo','member',0,1,NULL),('event',30,'photo','owner_member',0,1,NULL),('event',30,'photo','owner_member_member',0,1,NULL),('event',30,'photo','owner_network',0,1,NULL),('event',30,'photo','registered',0,1,NULL),('event',30,'view','everyone',0,1,NULL),('event',30,'view','member',0,1,NULL),('event',30,'view','member_requested',0,1,NULL),('event',30,'view','owner_member',0,1,NULL),('event',30,'view','owner_member_member',0,1,NULL),('event',30,'view','owner_network',0,1,NULL),('event',30,'view','registered',0,1,NULL),('event',33,'comment','everyone',0,1,NULL),('event',33,'comment','member',0,1,NULL),('event',33,'comment','owner_member',0,1,NULL),('event',33,'comment','owner_member_member',0,1,NULL),('event',33,'comment','owner_network',0,1,NULL),('event',33,'comment','registered',0,1,NULL),('event',33,'invite','member',0,1,NULL),('event',33,'photo','everyone',0,1,NULL),('event',33,'photo','member',0,1,NULL),('event',33,'photo','owner_member',0,1,NULL),('event',33,'photo','owner_member_member',0,1,NULL),('event',33,'photo','owner_network',0,1,NULL),('event',33,'photo','registered',0,1,NULL),('event',33,'view','everyone',0,1,NULL),('event',33,'view','member',0,1,NULL),('event',33,'view','member_requested',0,1,NULL),('event',33,'view','owner_member',0,1,NULL),('event',33,'view','owner_member_member',0,1,NULL),('event',33,'view','owner_network',0,1,NULL),('event',33,'view','registered',0,1,NULL),('event',34,'comment','everyone',0,1,NULL),('event',34,'comment','member',0,1,NULL),('event',34,'comment','owner_member',0,1,NULL),('event',34,'comment','owner_member_member',0,1,NULL),('event',34,'comment','owner_network',0,1,NULL),('event',34,'comment','registered',0,1,NULL),('event',34,'invite','member',0,1,NULL),('event',34,'photo','everyone',0,1,NULL),('event',34,'photo','member',0,1,NULL),('event',34,'photo','owner_member',0,1,NULL),('event',34,'photo','owner_member_member',0,1,NULL),('event',34,'photo','owner_network',0,1,NULL),('event',34,'photo','registered',0,1,NULL),('event',34,'view','everyone',0,1,NULL),('event',34,'view','member',0,1,NULL),('event',34,'view','member_requested',0,1,NULL),('event',34,'view','owner_member',0,1,NULL),('event',34,'view','owner_member_member',0,1,NULL),('event',34,'view','owner_network',0,1,NULL),('event',34,'view','registered',0,1,NULL),('event',35,'comment','everyone',0,1,NULL),('event',35,'comment','member',0,1,NULL),('event',35,'comment','owner_member',0,1,NULL),('event',35,'comment','owner_member_member',0,1,NULL),('event',35,'comment','owner_network',0,1,NULL),('event',35,'comment','registered',0,1,NULL),('event',35,'invite','member',0,1,NULL),('event',35,'photo','everyone',0,1,NULL),('event',35,'photo','member',0,1,NULL),('event',35,'photo','owner_member',0,1,NULL),('event',35,'photo','owner_member_member',0,1,NULL),('event',35,'photo','owner_network',0,1,NULL),('event',35,'photo','registered',0,1,NULL),('event',35,'view','everyone',0,1,NULL),('event',35,'view','member',0,1,NULL),('event',35,'view','member_requested',0,1,NULL),('event',35,'view','owner_member',0,1,NULL),('event',35,'view','owner_member_member',0,1,NULL),('event',35,'view','owner_network',0,1,NULL),('event',35,'view','registered',0,1,NULL),('user',1,'comment','everyone',0,1,NULL),('user',1,'comment','member',0,1,NULL),('user',1,'comment','network',0,1,NULL),('user',1,'comment','registered',0,1,NULL),('user',1,'view','everyone',0,1,NULL),('user',1,'view','member',0,1,NULL),('user',1,'view','network',0,1,NULL),('user',1,'view','registered',0,1,NULL),('user',2,'comment','everyone',0,1,NULL),('user',2,'comment','member',0,1,NULL),('user',2,'comment','network',0,1,NULL),('user',2,'comment','registered',0,1,NULL),('user',2,'view','everyone',0,1,NULL),('user',2,'view','member',0,1,NULL),('user',2,'view','network',0,1,NULL),('user',2,'view','registered',0,1,NULL),('user',3,'comment','everyone',0,1,NULL),('user',3,'comment','member',0,1,NULL),('user',3,'comment','network',0,1,NULL),('user',3,'comment','registered',0,1,NULL),('user',3,'view','everyone',0,1,NULL),('user',3,'view','member',0,1,NULL),('user',3,'view','network',0,1,NULL),('user',3,'view','registered',0,1,NULL),('user',4,'comment','everyone',0,1,NULL),('user',4,'comment','member',0,1,NULL),('user',4,'comment','network',0,1,NULL),('user',4,'comment','registered',0,1,NULL),('user',4,'view','everyone',0,1,NULL),('user',4,'view','member',0,1,NULL),('user',4,'view','network',0,1,NULL),('user',4,'view','registered',0,1,NULL),('user',7,'comment','everyone',0,1,NULL),('user',7,'comment','member',0,1,NULL),('user',7,'comment','network',0,1,NULL),('user',7,'comment','registered',0,1,NULL),('user',7,'view','everyone',0,1,NULL),('user',7,'view','member',0,1,NULL),('user',7,'view','network',0,1,NULL),('user',7,'view','registered',0,1,NULL),('user',8,'comment','everyone',0,1,NULL),('user',8,'comment','member',0,1,NULL),('user',8,'comment','network',0,1,NULL),('user',8,'comment','registered',0,1,NULL),('user',8,'view','everyone',0,1,NULL),('user',8,'view','member',0,1,NULL),('user',8,'view','network',0,1,NULL),('user',8,'view','registered',0,1,NULL),('user',9,'comment','everyone',0,1,NULL),('user',9,'comment','member',0,1,NULL),('user',9,'comment','network',0,1,NULL),('user',9,'comment','registered',0,1,NULL),('user',9,'view','everyone',0,1,NULL),('user',9,'view','member',0,1,NULL),('user',9,'view','network',0,1,NULL),('user',9,'view','registered',0,1,NULL),('user',11,'comment','everyone',0,1,NULL),('user',11,'comment','member',0,1,NULL),('user',11,'comment','network',0,1,NULL),('user',11,'comment','registered',0,1,NULL),('user',11,'view','everyone',0,1,NULL),('user',11,'view','member',0,1,NULL),('user',11,'view','network',0,1,NULL),('user',11,'view','registered',0,1,NULL),('user',12,'comment','everyone',0,1,NULL),('user',12,'comment','member',0,1,NULL),('user',12,'comment','network',0,1,NULL),('user',12,'comment','registered',0,1,NULL),('user',12,'view','everyone',0,1,NULL),('user',12,'view','member',0,1,NULL),('user',12,'view','network',0,1,NULL),('user',12,'view','registered',0,1,NULL),('user',13,'comment','everyone',0,1,NULL),('user',13,'comment','member',0,1,NULL),('user',13,'comment','network',0,1,NULL),('user',13,'comment','registered',0,1,NULL),('user',13,'view','everyone',0,1,NULL),('user',13,'view','member',0,1,NULL),('user',13,'view','network',0,1,NULL),('user',13,'view','registered',0,1,NULL);
/*!40000 ALTER TABLE `engine4_authorization_allow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_authorization_levels`
--

DROP TABLE IF EXISTS `engine4_authorization_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_authorization_levels` (
  `level_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('public','user','moderator','admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `flag` enum('default','superadmin','public') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_authorization_levels`
--

LOCK TABLES `engine4_authorization_levels` WRITE;
/*!40000 ALTER TABLE `engine4_authorization_levels` DISABLE KEYS */;
INSERT INTO `engine4_authorization_levels` VALUES (1,'Superadmins','Users of this level can modify all of your settings and data.  This level cannot be modified or deleted.','admin','superadmin'),(2,'Admins','Users of this level have full access to all of your network settings and data.','admin',''),(3,'Moderators','Users of this level may edit user-side content.','moderator',''),(4,'Default Level','This is the default user level.  New users are assigned to it automatically.','user','default'),(5,'Public','Settings for this level apply to users who have not logged in.','public','public');
/*!40000 ALTER TABLE `engine4_authorization_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_authorization_permissions`
--

DROP TABLE IF EXISTS `engine4_authorization_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_authorization_permissions` (
  `level_id` int(11) unsigned NOT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` tinyint(3) NOT NULL DEFAULT '0',
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`,`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_authorization_permissions`
--

LOCK TABLES `engine4_authorization_permissions` WRITE;
/*!40000 ALTER TABLE `engine4_authorization_permissions` DISABLE KEYS */;
INSERT INTO `engine4_authorization_permissions` VALUES (1,'admin','view',1,NULL),(1,'announcement','create',1,NULL),(1,'announcement','delete',2,NULL),(1,'announcement','edit',2,NULL),(1,'announcement','view',2,NULL),(1,'core_link','create',1,NULL),(1,'core_link','delete',2,NULL),(1,'core_link','view',2,NULL),(1,'event','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(1,'event','auth_photo',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(1,'event','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(1,'event','comment',2,NULL),(1,'event','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),(1,'event','create',1,NULL),(1,'event','delete',2,NULL),(1,'event','edit',2,NULL),(1,'event','invite',1,NULL),(1,'event','photo',1,NULL),(1,'event','style',1,NULL),(1,'event','view',2,NULL),(1,'general','activity',2,NULL),(1,'general','style',2,NULL),(1,'messages','auth',3,'friends'),(1,'messages','create',1,NULL),(1,'messages','editor',3,'plaintext'),(1,'user','activity',1,NULL),(1,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(1,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(1,'user','block',1,NULL),(1,'user','comment',2,NULL),(1,'user','create',1,NULL),(1,'user','delete',2,NULL),(1,'user','edit',2,NULL),(1,'user','search',1,NULL),(1,'user','status',1,NULL),(1,'user','style',2,NULL),(1,'user','username',2,NULL),(1,'user','view',2,NULL),(2,'admin','view',1,NULL),(2,'announcement','create',1,NULL),(2,'announcement','delete',2,NULL),(2,'announcement','edit',2,NULL),(2,'announcement','view',2,NULL),(2,'core_link','create',1,NULL),(2,'core_link','delete',2,NULL),(2,'core_link','view',2,NULL),(2,'event','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(2,'event','auth_photo',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(2,'event','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(2,'event','comment',2,NULL),(2,'event','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),(2,'event','create',1,NULL),(2,'event','delete',2,NULL),(2,'event','edit',2,NULL),(2,'event','invite',1,NULL),(2,'event','photo',1,NULL),(2,'event','style',1,NULL),(2,'event','view',2,NULL),(2,'general','activity',2,NULL),(2,'general','style',2,NULL),(2,'messages','auth',3,'friends'),(2,'messages','create',1,NULL),(2,'messages','editor',3,'plaintext'),(2,'user','activity',1,NULL),(2,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(2,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(2,'user','block',1,NULL),(2,'user','comment',2,NULL),(2,'user','create',1,NULL),(2,'user','delete',2,NULL),(2,'user','edit',2,NULL),(2,'user','search',1,NULL),(2,'user','status',1,NULL),(2,'user','style',2,NULL),(2,'user','username',2,NULL),(2,'user','view',2,NULL),(3,'announcement','view',1,NULL),(3,'core_link','create',1,NULL),(3,'core_link','delete',2,NULL),(3,'core_link','view',2,NULL),(3,'event','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(3,'event','auth_photo',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(3,'event','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(3,'event','comment',2,NULL),(3,'event','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),(3,'event','create',1,NULL),(3,'event','delete',2,NULL),(3,'event','edit',2,NULL),(3,'event','invite',1,NULL),(3,'event','photo',1,NULL),(3,'event','style',1,NULL),(3,'event','view',2,NULL),(3,'general','activity',2,NULL),(3,'general','style',2,NULL),(3,'messages','auth',3,'friends'),(3,'messages','create',1,NULL),(3,'messages','editor',3,'plaintext'),(3,'user','activity',1,NULL),(3,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(3,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(3,'user','block',1,NULL),(3,'user','comment',2,NULL),(3,'user','create',1,NULL),(3,'user','delete',2,NULL),(3,'user','edit',2,NULL),(3,'user','search',1,NULL),(3,'user','status',1,NULL),(3,'user','style',2,NULL),(3,'user','username',2,NULL),(3,'user','view',2,NULL),(4,'announcement','view',1,NULL),(4,'core_link','create',1,NULL),(4,'core_link','delete',1,NULL),(4,'core_link','view',1,NULL),(4,'event','auth_comment',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(4,'event','auth_photo',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(4,'event','auth_view',5,'[\"everyone\",\"owner_network\",\"owner_member_member\",\"owner_member\",\"parent_member\",\"member\",\"owner\"]'),(4,'event','comment',1,NULL),(4,'event','commentHtml',3,'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr'),(4,'event','create',1,NULL),(4,'event','delete',1,NULL),(4,'event','edit',1,NULL),(4,'event','invite',1,NULL),(4,'event','photo',1,NULL),(4,'event','style',1,NULL),(4,'event','view',1,NULL),(4,'general','style',1,NULL),(4,'messages','auth',3,'friends'),(4,'messages','create',1,NULL),(4,'messages','editor',3,'plaintext'),(4,'user','auth_comment',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(4,'user','auth_view',5,'[\"everyone\",\"registered\",\"network\",\"member\",\"owner\"]'),(4,'user','block',1,NULL),(4,'user','comment',1,NULL),(4,'user','create',1,NULL),(4,'user','delete',1,NULL),(4,'user','edit',1,NULL),(4,'user','search',1,NULL),(4,'user','status',1,NULL),(4,'user','style',1,NULL),(4,'user','username',1,NULL),(4,'user','view',1,NULL),(5,'announcement','view',1,NULL),(5,'core_link','view',1,NULL),(5,'event','view',1,NULL),(5,'user','view',1,NULL);
/*!40000 ALTER TABLE `engine4_authorization_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_adcampaigns`
--

DROP TABLE IF EXISTS `engine4_core_adcampaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_adcampaigns` (
  `adcampaign_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `end_settings` tinyint(4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `limit_view` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_click` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_ctr` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `network` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`adcampaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_adcampaigns`
--

LOCK TABLES `engine4_core_adcampaigns` WRITE;
/*!40000 ALTER TABLE `engine4_core_adcampaigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_adcampaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_adphotos`
--

DROP TABLE IF EXISTS `engine4_core_adphotos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_adphotos` (
  `adphoto_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`adphoto_id`),
  KEY `ad_id` (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_adphotos`
--

LOCK TABLES `engine4_core_adphotos` WRITE;
/*!40000 ALTER TABLE `engine4_core_adphotos` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_adphotos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_ads`
--

DROP TABLE IF EXISTS `engine4_core_ads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_ads` (
  `ad_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ad_campaign` int(11) unsigned NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `media_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `html_code` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ad_id`),
  KEY `ad_campaign` (`ad_campaign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_ads`
--

LOCK TABLES `engine4_core_ads` WRITE;
/*!40000 ALTER TABLE `engine4_core_ads` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_ads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_auth`
--

DROP TABLE IF EXISTS `engine4_core_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_auth` (
  `id` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `expires` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`user_id`),
  KEY `expires` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_auth`
--

LOCK TABLES `engine4_core_auth` WRITE;
/*!40000 ALTER TABLE `engine4_core_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedemails`
--

DROP TABLE IF EXISTS `engine4_core_bannedemails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedemails` (
  `bannedemail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedemail_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedemails`
--

LOCK TABLES `engine4_core_bannedemails` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedemails` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedemails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedips`
--

DROP TABLE IF EXISTS `engine4_core_bannedips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedips` (
  `bannedip_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start` varbinary(16) NOT NULL,
  `stop` varbinary(16) NOT NULL,
  PRIMARY KEY (`bannedip_id`),
  UNIQUE KEY `start` (`start`,`stop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedips`
--

LOCK TABLES `engine4_core_bannedips` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedips` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedusernames`
--

DROP TABLE IF EXISTS `engine4_core_bannedusernames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedusernames` (
  `bannedusername_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedusername_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedusernames`
--

LOCK TABLES `engine4_core_bannedusernames` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedusernames` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedusernames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_bannedwords`
--

DROP TABLE IF EXISTS `engine4_core_bannedwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_bannedwords` (
  `bannedword_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bannedword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_bannedwords`
--

LOCK TABLES `engine4_core_bannedwords` WRITE;
/*!40000 ALTER TABLE `engine4_core_bannedwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_bannedwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_comments`
--

DROP TABLE IF EXISTS `engine4_core_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_comments` (
  `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_comments`
--

LOCK TABLES `engine4_core_comments` WRITE;
/*!40000 ALTER TABLE `engine4_core_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_content`
--

DROP TABLE IF EXISTS `engine4_core_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_content` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'widget',
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_content_id` int(11) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `params` text COLLATE utf8_unicode_ci,
  `attribs` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`content_id`),
  KEY `page_id` (`page_id`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_content`
--

LOCK TABLES `engine4_core_content` WRITE;
/*!40000 ALTER TABLE `engine4_core_content` DISABLE KEYS */;
INSERT INTO `engine4_core_content` VALUES (100,1,'container','main',NULL,1,'',NULL),(110,1,'widget','core.menu-mini',100,1,'',NULL),(111,1,'widget','core.menu-logo',100,2,'',NULL),(112,1,'widget','core.menu-main',100,3,'',NULL),(200,2,'container','main',NULL,1,'',NULL),(210,2,'widget','core.menu-footer',200,2,'',NULL),(300,3,'container','main',NULL,1,'',NULL),(310,3,'container','left',300,1,'',NULL),(311,3,'container','right',300,2,'',NULL),(312,3,'container','middle',300,3,'',NULL),(320,3,'widget','user.login-or-signup',310,1,'',NULL),(321,3,'widget','user.list-online',310,2,'{\"title\":\"%s Members Online\"}',NULL),(322,3,'widget','core.statistics',310,3,'{\"title\":\"Network Stats\"}',NULL),(330,3,'widget','user.list-signups',311,1,'{\"title\":\"Newest Members\"}',NULL),(331,3,'widget','user.list-popular',311,2,'{\"title\":\"Popular Members\"}',NULL),(340,3,'widget','announcement.list-announcements',312,1,'',NULL),(341,3,'widget','activity.feed',312,2,'{\"title\":\"What\'s New\"}',NULL),(400,4,'container','main',NULL,1,'',NULL),(410,4,'container','left',400,1,'',NULL),(411,4,'container','right',400,2,'',NULL),(412,4,'container','middle',400,3,'',NULL),(420,4,'widget','user.home-photo',410,1,'',NULL),(421,4,'widget','user.home-links',410,2,'',NULL),(422,4,'widget','user.list-online',410,3,'{\"title\":\"%s Members Online\"}',NULL),(423,4,'widget','core.statistics',410,4,'{\"title\":\"Network Stats\"}',NULL),(430,4,'widget','activity.list-requests',411,1,'{\"title\":\"Requests\"}',NULL),(431,4,'widget','user.list-signups',411,2,'{\"title\":\"Newest Members\"}',NULL),(432,4,'widget','user.list-popular',411,3,'{\"title\":\"Popular Members\"}',NULL),(440,4,'widget','announcement.list-announcements',412,1,'',NULL),(441,4,'widget','activity.feed',412,2,'{\"title\":\"What\'s New\"}',NULL),(500,5,'container','main',NULL,1,'',NULL),(510,5,'container','left',500,1,'',NULL),(511,5,'container','middle',500,3,'',NULL),(520,5,'widget','user.profile-photo',510,1,'',NULL),(521,5,'widget','user.profile-options',510,2,'',NULL),(522,5,'widget','user.profile-friends-common',510,3,'{\"title\":\"Mutual Friends\"}',NULL),(523,5,'widget','user.profile-info',510,4,'{\"title\":\"Member Info\"}',NULL),(530,5,'widget','user.profile-status',511,1,'',NULL),(531,5,'widget','core.container-tabs',511,2,'{\"max\":\"6\"}',NULL),(540,5,'widget','activity.feed',531,1,'{\"title\":\"Updates\"}',NULL),(541,5,'widget','user.profile-fields',531,2,'{\"title\":\"Info\"}',NULL),(542,5,'widget','user.profile-friends',531,3,'{\"title\":\"Friends\",\"titleCount\":true}',NULL),(546,5,'widget','core.profile-links',531,7,'{\"title\":\"Links\",\"titleCount\":true}',NULL),(547,6,'container','main',NULL,1,NULL,NULL),(548,6,'container','middle',547,2,NULL,NULL),(549,6,'widget','core.content',548,1,NULL,NULL),(550,7,'container','main',NULL,1,NULL,NULL),(551,7,'container','middle',550,2,NULL,NULL),(552,7,'widget','core.content',551,1,NULL,NULL),(553,8,'container','main',NULL,1,NULL,NULL),(554,8,'container','middle',553,2,NULL,NULL),(555,8,'widget','core.content',554,1,NULL,NULL),(556,9,'container','main',NULL,1,NULL,NULL),(557,9,'container','middle',556,1,NULL,NULL),(558,9,'widget','core.content',557,1,NULL,NULL),(559,10,'container','main',NULL,1,NULL,NULL),(560,10,'container','middle',559,1,NULL,NULL),(561,10,'widget','core.content',560,1,NULL,NULL),(562,11,'container','main',NULL,1,NULL,NULL),(563,11,'container','middle',562,1,NULL,NULL),(564,11,'widget','core.content',563,1,NULL,NULL),(565,12,'container','main',NULL,1,NULL,NULL),(566,12,'container','middle',565,1,NULL,NULL),(567,12,'widget','core.content',566,1,NULL,NULL),(568,13,'container','main',NULL,1,NULL,NULL),(569,13,'container','middle',568,1,NULL,NULL),(570,13,'widget','core.content',569,1,NULL,NULL),(571,14,'container','top',NULL,1,NULL,NULL),(572,14,'container','main',NULL,2,NULL,NULL),(573,14,'container','middle',571,1,NULL,NULL),(574,14,'container','middle',572,2,NULL,NULL),(575,14,'widget','user.settings-menu',573,1,NULL,NULL),(576,14,'widget','core.content',574,1,NULL,NULL),(577,15,'container','top',NULL,1,NULL,NULL),(578,15,'container','main',NULL,2,NULL,NULL),(579,15,'container','middle',577,1,NULL,NULL),(580,15,'container','middle',578,2,NULL,NULL),(581,15,'widget','user.settings-menu',579,1,NULL,NULL),(582,15,'widget','core.content',580,1,NULL,NULL),(583,16,'container','top',NULL,1,NULL,NULL),(584,16,'container','main',NULL,2,NULL,NULL),(585,16,'container','middle',583,1,NULL,NULL),(586,16,'container','middle',584,2,NULL,NULL),(587,16,'widget','user.settings-menu',585,1,NULL,NULL),(588,16,'widget','core.content',586,1,NULL,NULL),(589,17,'container','top',NULL,1,NULL,NULL),(590,17,'container','main',NULL,2,NULL,NULL),(591,17,'container','middle',589,1,NULL,NULL),(592,17,'container','middle',590,2,NULL,NULL),(593,17,'widget','user.settings-menu',591,1,NULL,NULL),(594,17,'widget','core.content',592,1,NULL,NULL),(595,18,'container','top',NULL,1,NULL,NULL),(596,18,'container','main',NULL,2,NULL,NULL),(597,18,'container','middle',595,1,NULL,NULL),(598,18,'container','middle',596,2,NULL,NULL),(599,18,'widget','user.settings-menu',597,1,NULL,NULL),(600,18,'widget','core.content',598,1,NULL,NULL),(601,19,'container','top',NULL,1,NULL,NULL),(602,19,'container','main',NULL,2,NULL,NULL),(603,19,'container','middle',601,1,NULL,NULL),(604,19,'container','middle',602,2,NULL,NULL),(605,19,'widget','user.settings-menu',603,1,NULL,NULL),(606,19,'widget','core.content',604,1,NULL,NULL),(607,20,'container','main',NULL,1,NULL,NULL),(608,20,'container','middle',607,1,NULL,NULL),(609,20,'widget','core.content',608,1,NULL,NULL),(610,21,'container','main',NULL,1,NULL,NULL),(611,21,'container','middle',610,1,NULL,NULL),(612,21,'widget','core.content',611,2,NULL,NULL),(613,21,'widget','messages.menu',611,1,NULL,NULL),(614,22,'container','main',NULL,1,NULL,NULL),(615,22,'container','middle',614,1,NULL,NULL),(616,22,'widget','core.content',615,2,NULL,NULL),(617,22,'widget','messages.menu',615,1,NULL,NULL),(618,23,'container','main',NULL,1,NULL,NULL),(619,23,'container','middle',618,1,NULL,NULL),(620,23,'widget','core.content',619,2,NULL,NULL),(621,23,'widget','messages.menu',619,1,NULL,NULL),(622,24,'container','main',NULL,1,NULL,NULL),(623,24,'container','middle',622,1,NULL,NULL),(624,24,'widget','core.content',623,2,NULL,NULL),(625,24,'widget','messages.menu',623,1,NULL,NULL),(626,25,'container','main',NULL,1,NULL,NULL),(627,25,'container','middle',626,1,NULL,NULL),(628,25,'widget','core.content',627,2,NULL,NULL),(629,25,'widget','messages.menu',627,1,NULL,NULL),(630,26,'container','main',NULL,1,'',NULL),(631,26,'container','middle',630,2,'',NULL),(632,26,'widget','event.profile-status',631,3,'',NULL),(633,26,'widget','event.profile-photo',631,4,'',NULL),(634,26,'widget','event.profile-info',631,5,'',NULL),(635,26,'widget','event.profile-rsvp',631,6,'',NULL),(636,26,'widget','core.container-tabs',631,7,'{\"max\":6}',NULL),(637,26,'widget','activity.feed',636,8,'{\"title\":\"What\'s New\"}',NULL),(638,26,'widget','event.profile-members',636,9,'{\"title\":\"Guests\",\"titleCount\":true}',NULL),(639,27,'container','main',NULL,2,'[\"\"]',NULL),(640,27,'container','middle',639,6,'[\"\"]',NULL),(641,27,'container','left',639,4,'[\"\"]',NULL),(642,27,'widget','core.container-tabs',640,9,'{\"max\":\"6\"}',NULL),(643,27,'widget','event.profile-status',640,7,'[\"\"]',NULL),(644,27,'widget','event.profile-photo',641,3,'[\"\"]',NULL),(645,27,'widget','event.profile-options',641,4,'[\"\"]',NULL),(646,27,'widget','event.profile-info',641,5,'[\"\"]',NULL),(648,27,'widget','activity.feed',642,10,'{\"title\":\"Updates\"}',NULL),(649,27,'widget','event.profile-members',642,11,'{\"title\":\"Guests\",\"titleCount\":true}',NULL),(650,27,'widget','event.profile-photos',642,12,'{\"title\":\"Photos\",\"titleCount\":true}',NULL),(651,27,'widget','event.profile-discussions',642,13,'{\"title\":\"Discussions\",\"titleCount\":true}',NULL),(652,27,'widget','core.profile-links',642,14,'{\"title\":\"Links\",\"titleCount\":true}',NULL),(653,4,'widget','event.home-upcoming',411,1,'{\"title\":\"Upcoming Events\",\"titleCount\":true}',NULL),(654,5,'widget','event.profile-events',531,8,'{\"title\":\"Events\",\"titleCount\":true}',NULL),(655,28,'container','top',NULL,1,NULL,NULL),(656,28,'container','main',NULL,2,NULL,NULL),(657,28,'container','middle',655,1,NULL,NULL),(658,28,'container','middle',656,2,NULL,NULL),(659,28,'container','right',656,1,NULL,NULL),(660,28,'widget','event.browse-menu',657,1,NULL,NULL),(661,28,'widget','core.content',658,1,NULL,NULL),(662,28,'widget','event.browse-search',659,1,NULL,NULL),(663,28,'widget','event.browse-menu-quick',659,2,NULL,NULL),(664,29,'container','top',NULL,1,NULL,NULL),(665,29,'container','main',NULL,2,NULL,NULL),(666,29,'container','middle',664,1,NULL,NULL),(667,29,'container','middle',665,2,NULL,NULL),(668,29,'widget','event.browse-menu',666,1,NULL,NULL),(669,29,'widget','core.content',667,1,NULL,NULL),(670,30,'container','top',NULL,1,NULL,NULL),(671,30,'container','main',NULL,2,NULL,NULL),(672,30,'container','middle',670,1,NULL,NULL),(673,30,'container','middle',671,2,NULL,NULL),(674,30,'container','right',671,1,NULL,NULL),(675,30,'widget','event.browse-menu',672,1,NULL,NULL),(676,30,'widget','core.content',673,1,NULL,NULL),(677,30,'widget','event.browse-search',674,1,NULL,NULL),(678,30,'widget','event.browse-menu-quick',674,2,NULL,NULL),(679,27,'widget','event.profile-info-center',640,8,'{\"title\":\"\",\"name\":\"event.profile-info-center\"}',NULL);
/*!40000 ALTER TABLE `engine4_core_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_geotags`
--

DROP TABLE IF EXISTS `engine4_core_geotags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_geotags` (
  `geotag_id` int(11) unsigned NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`geotag_id`),
  KEY `latitude` (`latitude`,`longitude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_geotags`
--

LOCK TABLES `engine4_core_geotags` WRITE;
/*!40000 ALTER TABLE `engine4_core_geotags` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_geotags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_jobs`
--

DROP TABLE IF EXISTS `engine4_core_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_jobs` (
  `job_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `jobtype_id` int(10) unsigned NOT NULL,
  `state` enum('pending','active','sleeping','failed','cancelled','completed','timeout') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `is_complete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `progress` decimal(5,4) unsigned NOT NULL DEFAULT '0.0000',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `started_date` datetime DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `data` text COLLATE utf8_unicode_ci,
  `messages` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`job_id`),
  KEY `jobtype_id` (`jobtype_id`),
  KEY `state` (`state`),
  KEY `is_complete` (`is_complete`,`priority`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_jobs`
--

LOCK TABLES `engine4_core_jobs` WRITE;
/*!40000 ALTER TABLE `engine4_core_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_jobtypes`
--

DROP TABLE IF EXISTS `engine4_core_jobtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_jobtypes` (
  `jobtype_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `multi` tinyint(3) unsigned DEFAULT '1',
  PRIMARY KEY (`jobtype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_jobtypes`
--

LOCK TABLES `engine4_core_jobtypes` WRITE;
/*!40000 ALTER TABLE `engine4_core_jobtypes` DISABLE KEYS */;
INSERT INTO `engine4_core_jobtypes` VALUES (1,'Download File','file_download','core','Core_Plugin_Job_FileDownload','Core_Form_Admin_Job_FileDownload',1,100,1),(2,'Upload File','file_upload','core','Core_Plugin_Job_FileUpload','Core_Form_Admin_Job_FileUpload',1,100,1),(3,'Rebuild Activity Privacy','activity_maintenance_rebuild_privacy','activity','Activity_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1),(4,'Rebuild Member Privacy','user_maintenance_rebuild_privacy','user','User_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1),(5,'Rebuild Network Membership','network_maintenance_rebuild_membership','network','Network_Plugin_Job_Maintenance_RebuildMembership',NULL,1,50,1),(6,'Storage Transfer','storage_transfer','core','Storage_Plugin_Job_Transfer','Core_Form_Admin_Job_Generic',1,100,1),(7,'Storage Cleanup','storage_cleanup','core','Storage_Plugin_Job_Cleanup','Core_Form_Admin_Job_Generic',1,100,1),(8,'Rebuild Event Privacy','event_maintenance_rebuild_privacy','event','Event_Plugin_Job_Maintenance_RebuildPrivacy',NULL,1,50,1);
/*!40000 ALTER TABLE `engine4_core_jobtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_languages`
--

DROP TABLE IF EXISTS `engine4_core_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_languages` (
  `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fallback` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_languages`
--

LOCK TABLES `engine4_core_languages` WRITE;
/*!40000 ALTER TABLE `engine4_core_languages` DISABLE KEYS */;
INSERT INTO `engine4_core_languages` VALUES (1,'en','English','en',1);
/*!40000 ALTER TABLE `engine4_core_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_likes`
--

DROP TABLE IF EXISTS `engine4_core_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_likes` (
  `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`like_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `poster_type` (`poster_type`,`poster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_likes`
--

LOCK TABLES `engine4_core_likes` WRITE;
/*!40000 ALTER TABLE `engine4_core_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_links`
--

DROP TABLE IF EXISTS `engine4_core_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_links` (
  `link_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `view_count` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`link_id`),
  KEY `owner` (`owner_type`,`owner_id`),
  KEY `parent` (`parent_type`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_links`
--

LOCK TABLES `engine4_core_links` WRITE;
/*!40000 ALTER TABLE `engine4_core_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_listitems`
--

DROP TABLE IF EXISTS `engine4_core_listitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_listitems`
--

LOCK TABLES `engine4_core_listitems` WRITE;
/*!40000 ALTER TABLE `engine4_core_listitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_listitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_lists`
--

DROP TABLE IF EXISTS `engine4_core_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `child_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_type` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_lists`
--

LOCK TABLES `engine4_core_lists` WRITE;
/*!40000 ALTER TABLE `engine4_core_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_log`
--

DROP TABLE IF EXISTS `engine4_core_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_log` (
  `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `plugin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(2) NOT NULL DEFAULT '6',
  `priorityName` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INFO',
  PRIMARY KEY (`message_id`),
  KEY `domain` (`domain`,`timestamp`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_log`
--

LOCK TABLES `engine4_core_log` WRITE;
/*!40000 ALTER TABLE `engine4_core_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_mail`
--

DROP TABLE IF EXISTS `engine4_core_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_mail` (
  `mail_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('system','zend') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(3) DEFAULT '100',
  `recipient_count` int(11) unsigned DEFAULT '0',
  `recipient_total` int(10) NOT NULL DEFAULT '0',
  `creation_time` datetime NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `priority` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_mail`
--

LOCK TABLES `engine4_core_mail` WRITE;
/*!40000 ALTER TABLE `engine4_core_mail` DISABLE KEYS */;
INSERT INTO `engine4_core_mail` VALUES (1,'system','a:2:{s:4:\"type\";s:25:\"notify_message_system_new\";s:6:\"params\";a:13:{s:4:\"host\";s:26:\"happetite.newrosoftdev.com\";s:5:\"email\";s:15:\"admin@email.com\";s:4:\"date\";i:1414587149;s:15:\"recipient_title\";s:10:\"First Last\";s:14:\"recipient_link\";s:14:\"/profile/admin\";s:15:\"recipient_photo\";s:71:\"//application/modules/User/externals/images/nophoto_user_thumb_icon.png\";s:12:\"sender_title\";s:10:\"First Last\";s:11:\"sender_link\";s:14:\"/profile/admin\";s:12:\"sender_photo\";s:71:\"//application/modules/User/externals/images/nophoto_user_thumb_icon.png\";s:12:\"object_title\";s:0:\"\";s:11:\"object_link\";s:21:\"/messages/view/id/371\";s:12:\"object_photo\";N;s:18:\"object_description\";s:257:\"You have just recently held the Class <a href=\"/class/33\">New Class test</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/33/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>\";}}',100,1,0,'2014-10-29 12:52:30'),(2,'system','a:2:{s:4:\"type\";s:25:\"notify_message_system_new\";s:6:\"params\";a:13:{s:4:\"host\";s:26:\"happetite.newrosoftdev.com\";s:5:\"email\";s:15:\"admin@email.com\";s:4:\"date\";i:1414587150;s:15:\"recipient_title\";s:10:\"First Last\";s:14:\"recipient_link\";s:14:\"/profile/admin\";s:15:\"recipient_photo\";s:71:\"//application/modules/User/externals/images/nophoto_user_thumb_icon.png\";s:12:\"sender_title\";s:10:\"First Last\";s:11:\"sender_link\";s:14:\"/profile/admin\";s:12:\"sender_photo\";s:71:\"//application/modules/User/externals/images/nophoto_user_thumb_icon.png\";s:12:\"object_title\";s:0:\"\";s:11:\"object_link\";s:21:\"/messages/view/id/372\";s:12:\"object_photo\";N;s:18:\"object_description\";s:256:\"You have just recently held the Class <a href=\"/class/34\">Cupcake class</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/34/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>\";}}',100,1,0,'2014-10-29 12:52:30'),(3,'system','a:2:{s:4:\"type\";s:21:\"notify_friend_request\";s:6:\"params\";a:13:{s:4:\"host\";s:26:\"happetite.newrosoftdev.com\";s:5:\"email\";s:23:\"markus.liechti@local.ch\";s:4:\"date\";i:1415140831;s:15:\"recipient_title\";s:12:\"Markus Local\";s:14:\"recipient_link\";s:14:\"/profile/local\";s:15:\"recipient_photo\";s:36:\"/public/user/60/0060_49d3.jpg?c=110c\";s:12:\"sender_title\";s:14:\"Markus Liechti\";s:11:\"sender_link\";s:16:\"/profile/Jokaero\";s:12:\"sender_photo\";s:36:\"/public/user/20/0020_d1d4.jpg?c=3698\";s:12:\"object_title\";s:12:\"Markus Local\";s:11:\"object_link\";s:14:\"/profile/local\";s:12:\"object_photo\";s:36:\"/public/user/60/0060_49d3.jpg?c=110c\";s:18:\"object_description\";s:0:\"\";}}',100,1,0,'2014-11-04 22:40:31');
/*!40000 ALTER TABLE `engine4_core_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_mailrecipients`
--

DROP TABLE IF EXISTS `engine4_core_mailrecipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_mailrecipients` (
  `recipient_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `email` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`recipient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_mailrecipients`
--

LOCK TABLES `engine4_core_mailrecipients` WRITE;
/*!40000 ALTER TABLE `engine4_core_mailrecipients` DISABLE KEYS */;
INSERT INTO `engine4_core_mailrecipients` VALUES (1,1,1,NULL),(2,2,1,NULL),(3,3,13,NULL);
/*!40000 ALTER TABLE `engine4_core_mailrecipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_mailtemplates`
--

DROP TABLE IF EXISTS `engine4_core_mailtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_mailtemplates` (
  `mailtemplate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `vars` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`mailtemplate_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_mailtemplates`
--

LOCK TABLES `engine4_core_mailtemplates` WRITE;
/*!40000 ALTER TABLE `engine4_core_mailtemplates` DISABLE KEYS */;
INSERT INTO `engine4_core_mailtemplates` VALUES (1,'header','core',''),(2,'footer','core',''),(3,'header_member','core',''),(4,'footer_member','core',''),(5,'core_contact','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_name],[sender_email],[sender_link],[sender_photo],[message]'),(6,'core_verification','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),(7,'core_verification_password','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),(8,'core_welcome','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),(9,'core_welcome_password','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),(10,'notify_admin_user_signup','core','[host],[email],[date],[recipient_title],[object_title],[object_link]'),(11,'core_lostpassword','core','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),(12,'notify_commented','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(13,'notify_commented_commented','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(14,'notify_liked','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(15,'notify_liked_commented','activity','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(16,'user_account_approved','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo]'),(17,'notify_friend_accepted','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(18,'notify_friend_request','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(19,'notify_friend_follow_request','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(20,'notify_friend_follow_accepted','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(21,'notify_friend_follow','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(22,'notify_post_user','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(23,'notify_tagged','user','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(24,'notify_message_new','messages','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(25,'invite','invite','[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),(26,'invite_code','invite','[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),(27,'payment_subscription_active','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(28,'payment_subscription_cancelled','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(29,'payment_subscription_expired','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(30,'payment_subscription_overdue','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(31,'payment_subscription_pending','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(32,'payment_subscription_recurrence','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(33,'payment_subscription_refunded','payment','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),(34,'notify_event_accepted','event','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(35,'notify_event_approve','event','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(36,'notify_event_discussion_response','event','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(37,'notify_event_discussion_reply','event','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),(38,'notify_event_invite','event','[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]');
/*!40000 ALTER TABLE `engine4_core_mailtemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_menuitems`
--

DROP TABLE IF EXISTS `engine4_core_menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_menuitems` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `menu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `submenu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `custom` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `LOOKUP` (`name`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_menuitems`
--

LOCK TABLES `engine4_core_menuitems` WRITE;
/*!40000 ALTER TABLE `engine4_core_menuitems` DISABLE KEYS */;
INSERT INTO `engine4_core_menuitems` VALUES (1,'core_main_home','core','Home','User_Plugin_Menus','','core_main','',1,0,1),(2,'core_sitemap_home','core','Home','','{\"route\":\"default\"}','core_sitemap','',1,0,1),(3,'core_footer_privacy','core','Privacy','','{\"route\":\"default\",\"module\":\"core\",\"controller\":\"help\",\"action\":\"privacy\"}','core_footer','',1,0,1),(4,'core_footer_terms','core','Terms of Service','','{\"route\":\"default\",\"module\":\"core\",\"controller\":\"help\",\"action\":\"terms\"}','core_footer','',1,0,2),(5,'core_footer_contact','core','Contact','','{\"route\":\"default\",\"module\":\"core\",\"controller\":\"help\",\"action\":\"contact\"}','core_footer','',1,0,3),(6,'core_mini_admin','core','Admin','User_Plugin_Menus','','core_mini','',1,0,6),(7,'core_mini_profile','user','My Profile','User_Plugin_Menus','','core_mini','',1,0,5),(8,'core_mini_settings','user','Settings','User_Plugin_Menus','','core_mini','',1,0,3),(9,'core_mini_auth','user','Auth','User_Plugin_Menus','','core_mini','',1,0,2),(10,'core_mini_signup','user','Signup','User_Plugin_Menus','','core_mini','',1,0,1),(11,'core_admin_main_home','core','Home','','{\"route\":\"admin_default\"}','core_admin_main','',1,0,1),(12,'core_admin_main_manage','core','Manage','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_manage',1,0,2),(13,'core_admin_main_settings','core','Settings','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_settings',1,0,3),(14,'core_admin_main_plugins','core','Plugins','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_plugins',1,0,4),(15,'core_admin_main_layout','core','Layout','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_layout',1,0,5),(16,'core_admin_main_ads','core','Ads','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_ads',1,0,6),(17,'core_admin_main_stats','core','Stats','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_stats',1,0,8),(18,'core_admin_main_manage_levels','core','Member Levels','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\"}','core_admin_main_manage','',1,0,2),(19,'core_admin_main_manage_networks','network','Networks','','{\"route\":\"admin_default\",\"module\":\"network\",\"controller\":\"manage\"}','core_admin_main_manage','',1,0,3),(20,'core_admin_main_manage_announcements','announcement','Announcements','','{\"route\":\"admin_default\",\"module\":\"announcement\",\"controller\":\"manage\"}','core_admin_main_manage','',1,0,4),(21,'core_admin_message_mail','core','Email All Members','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"message\",\"action\":\"mail\"}','core_admin_main_manage','',1,0,5),(22,'core_admin_main_manage_reports','core','Abuse Reports','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"report\"}','core_admin_main_manage','',1,0,6),(23,'core_admin_main_manage_packages','core','Packages & Plugins','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"packages\"}','core_admin_main_manage','',1,0,7),(24,'core_admin_main_settings_general','core','General Settings','','{\"route\":\"core_admin_settings\",\"action\":\"general\"}','core_admin_main_settings','',1,0,1),(25,'core_admin_main_settings_locale','core','Locale Settings','','{\"route\":\"core_admin_settings\",\"action\":\"locale\"}','core_admin_main_settings','',1,0,1),(26,'core_admin_main_settings_fields','fields','Profile Questions','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"fields\"}','core_admin_main_settings','',1,0,2),(27,'core_admin_main_wibiya','core','Wibiya Integration','','{\"route\":\"admin_default\", \"action\":\"wibiya\", \"controller\":\"settings\", \"module\":\"core\"}','core_admin_main_settings','',1,0,4),(28,'core_admin_main_settings_spam','core','Spam & Banning Tools','','{\"route\":\"core_admin_settings\",\"action\":\"spam\"}','core_admin_main_settings','',1,0,5),(29,'core_admin_main_settings_mailtemplates','core','Mail Templates','','{\"route\":\"admin_default\",\"controller\":\"mail\",\"action\":\"templates\"}','core_admin_main_settings','',1,0,6),(30,'core_admin_main_settings_mailsettings','core','Mail Settings','','{\"route\":\"admin_default\",\"controller\":\"mail\",\"action\":\"settings\"}','core_admin_main_settings','',1,0,7),(31,'core_admin_main_settings_performance','core','Performance & Caching','','{\"route\":\"core_admin_settings\",\"action\":\"performance\"}','core_admin_main_settings','',1,0,8),(32,'core_admin_main_settings_password','core','Admin Password','','{\"route\":\"core_admin_settings\",\"action\":\"password\"}','core_admin_main_settings','',1,0,9),(33,'core_admin_main_settings_tasks','core','Task Scheduler','','{\"route\":\"admin_default\",\"controller\":\"tasks\"}','core_admin_main_settings','',1,0,10),(34,'core_admin_main_layout_content','core','Layout Editor','','{\"route\":\"admin_default\",\"controller\":\"content\"}','core_admin_main_layout','',1,0,1),(35,'core_admin_main_layout_themes','core','Theme Editor','','{\"route\":\"admin_default\",\"controller\":\"themes\"}','core_admin_main_layout','',1,0,2),(36,'core_admin_main_layout_files','core','File & Media Manager','','{\"route\":\"admin_default\",\"controller\":\"files\"}','core_admin_main_layout','',1,0,3),(37,'core_admin_main_layout_language','core','Language Manager','','{\"route\":\"admin_default\",\"controller\":\"language\"}','core_admin_main_layout','',1,0,4),(38,'core_admin_main_layout_menus','core','Menu Editor','','{\"route\":\"admin_default\",\"controller\":\"menus\"}','core_admin_main_layout','',1,0,5),(39,'core_admin_main_ads_manage','core','Manage Ad Campaigns','','{\"route\":\"admin_default\",\"controller\":\"ads\"}','core_admin_main_ads','',1,0,1),(40,'core_admin_main_ads_create','core','Create New Campaign','','{\"route\":\"admin_default\",\"controller\":\"ads\",\"action\":\"create\"}','core_admin_main_ads','',1,0,2),(41,'core_admin_main_ads_affiliate','core','SE Affiliate Program','','{\"route\":\"admin_default\",\"controller\":\"settings\",\"action\":\"affiliate\"}','core_admin_main_ads','',1,0,3),(42,'core_admin_main_ads_viglink','core','VigLink','','{\"route\":\"admin_default\",\"controller\":\"settings\",\"action\":\"viglink\"}','core_admin_main_ads','',1,0,4),(43,'core_admin_main_stats_statistics','core','Site-wide Statistics','','{\"route\":\"admin_default\",\"controller\":\"stats\"}','core_admin_main_stats','',1,0,1),(44,'core_admin_main_stats_url','core','Referring URLs','','{\"route\":\"admin_default\",\"controller\":\"stats\",\"action\":\"referrers\"}','core_admin_main_stats','',1,0,2),(45,'core_admin_main_stats_resources','core','Server Information','','{\"route\":\"admin_default\",\"controller\":\"system\"}','core_admin_main_stats','',1,0,3),(46,'core_admin_main_stats_logs','core','Log Browser','','{\"route\":\"admin_default\",\"controller\":\"log\",\"action\":\"index\"}','core_admin_main_stats','',1,0,3),(47,'core_admin_banning_general','core','Spam & Banning Tools','','{\"route\":\"core_admin_settings\",\"action\":\"spam\"}','core_admin_banning','',1,0,1),(48,'adcampaign_admin_main_edit','core','Edit Settings','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"ads\",\"action\":\"edit\"}','adcampaign_admin_main','',1,0,1),(49,'adcampaign_admin_main_manageads','core','Manage Advertisements','','{\"route\":\"admin_default\",\"module\":\"core\",\"controller\":\"ads\",\"action\":\"manageads\"}','adcampaign_admin_main','',1,0,2),(50,'core_admin_main_settings_activity','activity','Activity Feed Settings','','{\"route\":\"admin_default\",\"module\":\"activity\",\"controller\":\"settings\",\"action\":\"index\"}','core_admin_main_settings','',1,0,4),(51,'core_admin_main_settings_notifications','activity','Default Email Notifications','','{\"route\":\"admin_default\",\"module\":\"activity\",\"controller\":\"settings\",\"action\":\"notifications\"}','core_admin_main_settings','',1,0,11),(52,'authorization_admin_main_manage','authorization','View Member Levels','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\"}','authorization_admin_main','',1,0,1),(53,'authorization_admin_main_level','authorization','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\",\"action\":\"edit\"}','authorization_admin_main','',1,0,3),(54,'authorization_admin_level_main','authorization','Level Info','','{\"route\":\"admin_default\",\"module\":\"authorization\",\"controller\":\"level\",\"action\":\"edit\"}','authorization_admin_level','',1,0,1),(55,'core_main_user','user','Members','','{\"route\":\"user_general\",\"action\":\"browse\"}','core_main','',1,0,2),(56,'core_sitemap_user','user','Members','','{\"route\":\"user_general\",\"action\":\"browse\"}','core_sitemap','',1,0,2),(57,'user_home_updates','user','View Recent Updates','','{\"route\":\"recent_activity\",\"icon\":\"application/modules/User/externals/images/links/updates.png\"}','user_home','',1,0,1),(58,'user_home_view','user','View My Profile','User_Plugin_Menus','{\"route\":\"user_profile_self\",\"icon\":\"application/modules/User/externals/images/links/profile.png\"}','user_home','',1,0,2),(59,'user_home_edit','user','Edit My Profile','User_Plugin_Menus','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"profile\",\"icon\":\"application/modules/User/externals/images/links/edit.png\"}','user_home','',1,0,3),(60,'user_home_friends','user','Browse Members','','{\"route\":\"user_general\",\"controller\":\"index\",\"action\":\"browse\",\"icon\":\"application/modules/User/externals/images/links/search.png\"}','user_home','',1,0,4),(61,'user_profile_edit','user','Edit Profile','User_Plugin_Menus','','user_profile','',1,0,1),(62,'user_profile_friend','user','Friends','User_Plugin_Menus','','user_profile','',1,0,3),(63,'user_profile_block','user','Block','User_Plugin_Menus','','user_profile','',1,0,4),(64,'user_profile_report','user','Report User','User_Plugin_Menus','','user_profile','',1,0,5),(65,'user_profile_admin','user','Admin Settings','User_Plugin_Menus','','user_profile','',1,0,9),(66,'user_edit_profile','user','Personal Info','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"profile\"}','user_edit','',1,0,1),(67,'user_edit_photo','user','Edit My Photo','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"photo\"}','user_edit','',1,0,2),(68,'user_edit_style','user','Profile Style','User_Plugin_Menus','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"edit\",\"action\":\"style\"}','user_edit','',1,0,3),(69,'user_settings_general','user','General','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"general\"}','user_settings','',1,0,1),(70,'user_settings_privacy','user','Privacy','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"privacy\"}','user_settings','',1,0,2),(71,'user_settings_notifications','user','Notifications','','{\"route\":\"user_extended\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"notifications\"}','user_settings','',1,0,3),(72,'user_settings_password','user','Change Password','','{\"route\":\"user_extended\", \"module\":\"user\", \"controller\":\"settings\", \"action\":\"password\"}','user_settings','',1,0,5),(73,'user_settings_delete','user','Delete Account','User_Plugin_Menus::canDelete','{\"route\":\"user_extended\", \"module\":\"user\", \"controller\":\"settings\", \"action\":\"delete\"}','user_settings','',1,0,6),(74,'core_admin_main_manage_members','user','Members','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"manage\"}','core_admin_main_manage','',1,0,1),(75,'core_admin_main_signup','user','Signup Process','','{\"route\":\"admin_default\", \"controller\":\"signup\", \"module\":\"user\"}','core_admin_main_settings','',1,0,3),(76,'core_admin_main_facebook','user','Facebook Integration','','{\"route\":\"admin_default\", \"action\":\"facebook\", \"controller\":\"settings\", \"module\":\"user\"}','core_admin_main_settings','',1,0,4),(77,'core_admin_main_twitter','user','Twitter Integration','','{\"route\":\"admin_default\", \"action\":\"twitter\", \"controller\":\"settings\", \"module\":\"user\"}','core_admin_main_settings','',1,0,4),(78,'core_admin_main_janrain','user','Janrain Integration','','{\"route\":\"admin_default\", \"action\":\"janrain\", \"controller\":\"settings\", \"module\":\"user\"}','core_admin_main_settings','',1,0,4),(79,'core_admin_main_settings_friends','user','Friendship Settings','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"friends\"}','core_admin_main_settings','',1,0,6),(80,'user_admin_banning_logins','user','Login History','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"logins\",\"action\":\"index\"}','core_admin_banning','',1,0,2),(81,'authorization_admin_level_user','user','Members','','{\"route\":\"admin_default\",\"module\":\"user\",\"controller\":\"settings\",\"action\":\"level\"}','authorization_admin_level','',1,0,2),(82,'core_mini_messages','messages','Messages','Messages_Plugin_Menus','','core_mini','',1,0,4),(83,'user_profile_message','messages','Send Message','Messages_Plugin_Menus','','user_profile','',1,0,2),(84,'authorization_admin_level_messages','messages','Messages','','{\"route\":\"admin_default\",\"module\":\"messages\",\"controller\":\"settings\",\"action\":\"level\"}','authorization_admin_level','',1,0,3),(85,'messages_main_inbox','messages','Inbox','','{\"route\":\"messages_general\",\"action\":\"inbox\"}','messages_main','',1,0,1),(86,'messages_main_outbox','messages','Sent Messages','','{\"route\":\"messages_general\",\"action\":\"outbox\"}','messages_main','',1,0,2),(87,'messages_main_compose','messages','Compose Message','','{\"route\":\"messages_general\",\"action\":\"compose\"}','messages_main','',1,0,3),(88,'user_settings_network','network','Networks','','{\"route\":\"user_extended\", \"module\":\"user\", \"controller\":\"settings\", \"action\":\"network\"}','user_settings','',1,0,3),(89,'core_main_invite','invite','Invite','Invite_Plugin_Menus::canInvite','{\"route\":\"default\",\"module\":\"invite\"}','core_main','',1,0,1),(90,'user_home_invite','invite','Invite Your Friends','Invite_Plugin_Menus::canInvite','{\"route\":\"default\",\"module\":\"invite\",\"icon\":\"application/modules/Invite/externals/images/invite.png\"}','user_home','',1,0,5),(91,'core_admin_main_settings_storage','core','Storage System','','{\"route\":\"admin_default\",\"module\":\"storage\",\"controller\":\"services\",\"action\":\"index\"}','core_admin_main_settings','',1,0,11),(92,'user_settings_payment','user','Subscription','Payment_Plugin_Menus','{\"route\":\"default\", \"module\":\"payment\", \"controller\":\"settings\", \"action\":\"index\"}','user_settings','',1,0,4),(93,'core_admin_main_payment','payment','Billing','','{\"uri\":\"javascript:void(0);this.blur();\"}','core_admin_main','core_admin_main_payment',1,0,7),(94,'core_admin_main_payment_transactions','payment','Transactions','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"index\",\"action\":\"index\"}','core_admin_main_payment','',1,0,1),(95,'core_admin_main_payment_settings','payment','Settings','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"settings\",\"action\":\"index\"}','core_admin_main_payment','',1,0,2),(96,'core_admin_main_payment_gateways','payment','Gateways','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"gateway\",\"action\":\"index\"}','core_admin_main_payment','',1,0,3),(97,'core_admin_main_payment_packages','payment','Plans','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"package\",\"action\":\"index\"}','core_admin_main_payment','',1,0,4),(98,'core_admin_main_payment_subscriptions','payment','Subscriptions','','{\"route\":\"admin_default\",\"module\":\"payment\",\"controller\":\"subscription\",\"action\":\"index\"}','core_admin_main_payment','',1,0,5),(99,'core_main_event','event','Events','','{\"route\":\"event_general\"}','core_main','',1,0,6),(100,'core_sitemap_event','event','Events','','{\"route\":\"event_general\"}','core_sitemap','',1,0,6),(101,'event_main_upcoming','event','Upcoming Events','','{\"route\":\"event_upcoming\"}','event_main','',1,0,1),(102,'event_main_past','event','Past Events','','{\"route\":\"event_past\"}','event_main','',1,0,2),(103,'event_main_manage','event','My Events','Event_Plugin_Menus','{\"route\":\"event_general\",\"action\":\"manage\"}','event_main','',1,0,3),(104,'event_main_create','event','Create New Event','Event_Plugin_Menus','{\"route\":\"event_general\",\"action\":\"create\"}','event_main','',1,0,4),(105,'event_quick_create','event','Create New Event','Event_Plugin_Menus::canCreateEvents','{\"route\":\"event_general\",\"action\":\"create\",\"class\":\"buttonlink icon_event_new\"}','event_quick','',1,0,1),(106,'event_profile_edit','event','Edit Profile','Event_Plugin_Menus','','event_profile','',1,0,1),(107,'event_profile_style','event','Edit Styles','Event_Plugin_Menus','','event_profile','',0,0,2),(108,'event_profile_member','event','Member','Event_Plugin_Menus','','event_profile','',1,0,3),(109,'event_profile_report','event','Report Event','Event_Plugin_Menus','','event_profile','',0,0,4),(110,'event_profile_share','event','Share','Event_Plugin_Menus','','event_profile','',0,0,5),(111,'event_profile_invite','event','Invite','Event_Plugin_Menus','','event_profile','',0,0,6),(112,'event_profile_message','event','Message Members','Event_Plugin_Menus','','event_profile','',1,0,7),(113,'event_profile_delete','event','Delete Event','Event_Plugin_Menus','','event_profile','',1,0,8),(114,'core_admin_main_plugins_event','event','Events','','{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"manage\"}','core_admin_main_plugins','',1,0,999),(115,'event_admin_main_manage','event','Events','','{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"manage\"}','event_admin_main','',1,0,1),(116,'event_admin_main_settings','event','Global Settings','','{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"settings\"}','event_admin_main','',1,0,4),(117,'event_admin_main_level','event','Member Level Settings','','{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"settings\",\"action\":\"level\"}','event_admin_main','',1,0,5),(118,'event_admin_main_categories','event','Categories','','{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"settings\",\"action\":\"categories\"}','event_admin_main','',1,0,6),(119,'authorization_admin_level_event','event','Events','','{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"level\",\"action\":\"index\"}','authorization_admin_level','',1,0,999),(120,'mobi_browse_event','event','Events','','{\"route\":\"event_general\"}','mobi_browse','',1,0,7),(121,'event_admin_main_manage_users','event','Users',NULL,'{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"manage\",\"action\":\"users\"}','event_admin_main',NULL,1,0,2),(122,'event_admin_main_manage_transactions','event','Transactions',NULL,'{\"route\":\"admin_default\",\"module\":\"event\",\"controller\":\"manage\",\"action\":\"transactions\"}','event_admin_main',NULL,1,0,3),(123,'event_profile_cancel','event','Cancel Class','Event_Plugin_Menus','','event_profile','',1,0,999),(124,'event_profile_payment','event','Pay Now','Event_Plugin_Menus','','event_profile','',1,0,999),(125,'event_profile_members_full','event','Mark class as full booked','Event_Plugin_Menus','','event_profile','',1,0,999),(126,'event_profile_members_finish','event','Mark class as finished','Event_Plugin_Menus','','event_profile','',1,0,999);
/*!40000 ALTER TABLE `engine4_core_menuitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_menus`
--

DROP TABLE IF EXISTS `engine4_core_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_menus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `type` enum('standard','hidden','custom') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'standard',
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(3) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_menus`
--

LOCK TABLES `engine4_core_menus` WRITE;
/*!40000 ALTER TABLE `engine4_core_menus` DISABLE KEYS */;
INSERT INTO `engine4_core_menus` VALUES (1,'core_main','standard','Main Navigation Menu',1),(2,'core_mini','standard','Mini Navigation Menu',2),(3,'core_footer','standard','Footer Menu',3),(4,'core_sitemap','standard','Sitemap',4),(5,'user_home','standard','Member Home Quick Links Menu',999),(6,'user_profile','standard','Member Profile Options Menu',999),(7,'user_edit','standard','Member Edit Profile Navigation Menu',999),(8,'user_settings','standard','Member Settings Navigation Menu',999),(9,'messages_main','standard','Messages Main Navigation Menu',999),(10,'event_main','standard','Event Main Navigation Menu',999),(11,'event_profile','standard','Event Profile Options Menu',999);
/*!40000 ALTER TABLE `engine4_core_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_migrations`
--

DROP TABLE IF EXISTS `engine4_core_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_migrations` (
  `package` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `current` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_migrations`
--

LOCK TABLES `engine4_core_migrations` WRITE;
/*!40000 ALTER TABLE `engine4_core_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_modules`
--

DROP TABLE IF EXISTS `engine4_core_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_modules` (
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `version` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('core','standard','extra') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'extra',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_modules`
--

LOCK TABLES `engine4_core_modules` WRITE;
/*!40000 ALTER TABLE `engine4_core_modules` DISABLE KEYS */;
INSERT INTO `engine4_core_modules` VALUES ('activity','Activity','Activity','4.8.5',1,'core'),('announcement','Announcements','Announcements','4.8.0',1,'standard'),('authorization','Authorization','Authorization','4.7.0',1,'core'),('core','Core','Core','4.8.5',1,'core'),('event','Events','Events','4.8.5',1,'extra'),('fields','Fields','Fields','4.8.2',1,'core'),('invite','Invite','Invite','4.8.2',1,'standard'),('messages','Messages','Messages','4.8.5',1,'standard'),('network','Networks','Networks','4.8.2',1,'standard'),('payment','Payment','Payment','4.8.1',1,'standard'),('storage','Storage','Storage','4.8.5',1,'core'),('user','Members','Members','4.8.5',1,'core');
/*!40000 ALTER TABLE `engine4_core_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_nodes`
--

DROP TABLE IF EXISTS `engine4_core_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_nodes` (
  `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `signature` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `first_seen` datetime NOT NULL,
  `last_seen` datetime NOT NULL,
  PRIMARY KEY (`node_id`),
  UNIQUE KEY `signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_nodes`
--

LOCK TABLES `engine4_core_nodes` WRITE;
/*!40000 ALTER TABLE `engine4_core_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_pages`
--

DROP TABLE IF EXISTS `engine4_core_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_pages` (
  `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `custom` tinyint(1) NOT NULL DEFAULT '1',
  `fragment` tinyint(1) NOT NULL DEFAULT '0',
  `layout` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `levels` text COLLATE utf8_unicode_ci,
  `provides` text COLLATE utf8_unicode_ci,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_pages`
--

LOCK TABLES `engine4_core_pages` WRITE;
/*!40000 ALTER TABLE `engine4_core_pages` DISABLE KEYS */;
INSERT INTO `engine4_core_pages` VALUES (1,'header','Site Header',NULL,'','','',0,1,'',NULL,'header-footer',0,0),(2,'footer','Site Footer',NULL,'','','',0,1,'',NULL,'header-footer',0,0),(3,'core_index_index','Landing Page',NULL,'Landing Page','This is your site\'s landing page.','',0,0,'',NULL,'no-viewer;no-subject',0,0),(4,'user_index_home','Member Home Page',NULL,'Member Home Page','This is the home page for members.','',0,0,'',NULL,'viewer;no-subject',0,0),(5,'user_profile_index','Member Profile',NULL,'Member Profile','This is a member\'s profile.','',0,0,'',NULL,'subject=user',0,0),(6,'core_help_contact','Contact Page',NULL,'Contact Us','This is the contact page','',0,0,'',NULL,'no-viewer;no-subject',0,0),(7,'core_help_privacy','Privacy Page',NULL,'Privacy Policy','This is the privacy policy page','',0,0,'',NULL,'no-viewer;no-subject',0,0),(8,'core_help_terms','Terms of Service Page',NULL,'Terms of Service','This is the terms of service page','',0,0,'',NULL,'no-viewer;no-subject',0,0),(9,'core_error_requireuser','Sign-in Required Page',NULL,'Sign-in Required','','',0,0,'',NULL,NULL,0,0),(10,'core_search_index','Search Page',NULL,'Searc','','',0,0,'',NULL,NULL,0,0),(11,'user_auth_login','Sign-in Page',NULL,'Sign-in','This is the site sign-in page.','',0,0,'',NULL,NULL,0,0),(12,'user_signup_index','Sign-up Page',NULL,'Sign-up','This is the site sign-up page.','',0,0,'',NULL,NULL,0,0),(13,'user_auth_forgot','Forgot Password Page',NULL,'Forgot Password','This is the site forgot password page.','',0,0,'',NULL,NULL,0,0),(14,'user_settings_general','User General Settings Page',NULL,'General','This page is the user general settings page.','',0,0,'',NULL,NULL,0,0),(15,'user_settings_privacy','User Privacy Settings Page',NULL,'Privacy','This page is the user privacy settings page.','',0,0,'',NULL,NULL,0,0),(16,'user_settings_network','User Networks Settings Page',NULL,'Networks','This page is the user networks settings page.','',0,0,'',NULL,NULL,0,0),(17,'user_settings_notifications','User Notifications Settings Page',NULL,'Notifications','This page is the user notification settings page.','',0,0,'',NULL,NULL,0,0),(18,'user_settings_password','User Change Password Settings Page',NULL,'Change Password','This page is the change password page.','',0,0,'',NULL,NULL,0,0),(19,'user_settings_delete','User Delete Account Settings Page',NULL,'Delete Account','This page is the delete accout page.','',0,0,'',NULL,NULL,0,0),(20,'invite_index_index','Invite Page',NULL,'Invite','','',0,0,'',NULL,NULL,0,0),(21,'messages_messages_compose','Messages Compose Page',NULL,'Compose','','',0,0,'',NULL,NULL,0,0),(22,'messages_messages_inbox','Messages Inbox Page',NULL,'Inbox','','',0,0,'',NULL,NULL,0,0),(23,'messages_messages_outbox','Messages Outbox Page',NULL,'Inbox','','',0,0,'',NULL,NULL,0,0),(24,'messages_messages_search','Messages Search Page',NULL,'Search','','',0,0,'',NULL,NULL,0,0),(25,'messages_messages_view','Messages View Page',NULL,'My Message','','',0,0,'',NULL,NULL,0,0),(26,'mobi_event_profile','Mobile Event Profile',NULL,'Mobile Event Profile','This is the mobile verison of an event profile.','',0,0,'',NULL,NULL,0,0),(27,'event_profile_index','Event Profile',NULL,'Event Profile','This is the profile for an event.','',0,0,'',NULL,'subject=event',0,0),(28,'event_index_browse','Event Browse Page',NULL,'Event Browse','This page lists events.','',0,0,'',NULL,NULL,0,0),(29,'event_index_create','Event Create Page',NULL,'Event Create','This page allows users to create events.','',0,0,'',NULL,NULL,0,0),(30,'event_index_manage','Event Manage Page',NULL,'My Events','This page lists a user\'s events.','',0,0,'',NULL,NULL,0,0);
/*!40000 ALTER TABLE `engine4_core_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_processes`
--

DROP TABLE IF EXISTS `engine4_core_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_processes` (
  `pid` int(10) unsigned NOT NULL,
  `parent_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `system_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `started` int(10) unsigned NOT NULL,
  `timeout` mediumint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_processes`
--

LOCK TABLES `engine4_core_processes` WRITE;
/*!40000 ALTER TABLE `engine4_core_processes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_referrers`
--

DROP TABLE IF EXISTS `engine4_core_referrers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_referrers` (
  `host` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `query` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) unsigned NOT NULL,
  PRIMARY KEY (`host`,`path`,`query`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_referrers`
--

LOCK TABLES `engine4_core_referrers` WRITE;
/*!40000 ALTER TABLE `engine4_core_referrers` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_referrers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_reports`
--

DROP TABLE IF EXISTS `engine4_core_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `category` (`category`),
  KEY `user_id` (`user_id`),
  KEY `read` (`read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_reports`
--

LOCK TABLES `engine4_core_reports` WRITE;
/*!40000 ALTER TABLE `engine4_core_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_routes`
--

DROP TABLE IF EXISTS `engine4_core_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_routes` (
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_routes`
--

LOCK TABLES `engine4_core_routes` WRITE;
/*!40000 ALTER TABLE `engine4_core_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_search`
--

DROP TABLE IF EXISTS `engine4_core_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_search` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hidden` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`),
  FULLTEXT KEY `LOOKUP` (`title`,`description`,`keywords`,`hidden`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_search`
--

LOCK TABLES `engine4_core_search` WRITE;
/*!40000 ALTER TABLE `engine4_core_search` DISABLE KEYS */;
INSERT INTO `engine4_core_search` VALUES ('user',2,'user 1','','',''),('user',3,'user 2','','',''),('user',4,'user 3','','',''),('event',33,'New Class test','fhvfjvfhkvfk','',''),('user',1,'First Last','','',''),('event',5,'Event 2','sdf asdfa sdf d','',''),('event',35,'New Class test','test','',''),('event',34,'Cupcake class','We\'ll make cupcakes!','',''),('user',13,'Markus Local','','',''),('event',30,'Broccoly','Broccoly','',''),('user',12,'reto happetite','','',''),('user',7,'Markus Liechti','','',''),('event',18,'Bacon Strips','Learn how to make Bacon Strips out of Bacon\r\n\r\nI\'m happy to show you everything about Bacon. Bacon is my life.\r\n\r\nPigs beware! Bacon lovers on the move.','',''),('user',8,'Hulk Hogan','','',''),('user',9,'Reto Spescha','','',''),('event',28,'Saussage Party','We will cook saussage','',''),('event',20,'Hulk Hogan\'s Class','We just eat raw eggs to get the proteins we need to build up cool muscles.','',''),('event',29,'Peperoni Pizza','Pepperoni Pizza is the one and only!!','',''),('user',11,'Peter North','','',''),('event',26,'Pasta Party','pasta','',''),('event',25,'Sushi class','Sushi lalala','','');
/*!40000 ALTER TABLE `engine4_core_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_serviceproviders`
--

DROP TABLE IF EXISTS `engine4_core_serviceproviders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_serviceproviders` (
  `serviceprovider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceprovider_id`),
  UNIQUE KEY `type` (`type`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_serviceproviders`
--

LOCK TABLES `engine4_core_serviceproviders` WRITE;
/*!40000 ALTER TABLE `engine4_core_serviceproviders` DISABLE KEYS */;
INSERT INTO `engine4_core_serviceproviders` VALUES (1,'MySQL','database','mysql','Engine_ServiceLocator_Plugin_Database_Mysql',1),(2,'PDO MySQL','database','mysql_pdo','Engine_ServiceLocator_Plugin_Database_MysqlPdo',1),(3,'MySQLi','database','mysqli','Engine_ServiceLocator_Plugin_Database_Mysqli',1),(4,'File','cache','file','Engine_ServiceLocator_Plugin_Cache_File',1),(5,'APC','cache','apc','Engine_ServiceLocator_Plugin_Cache_Apc',1),(6,'Memcache','cache','memcached','Engine_ServiceLocator_Plugin_Cache_Memcached',1),(7,'Simple','captcha','image','Engine_ServiceLocator_Plugin_Captcha_Image',1),(8,'ReCaptcha','captcha','recaptcha','Engine_ServiceLocator_Plugin_Captcha_Recaptcha',1),(9,'SMTP','mail','smtp','Engine_ServiceLocator_Plugin_Mail_Smtp',1),(10,'Sendmail','mail','sendmail','Engine_ServiceLocator_Plugin_Mail_Sendmail',1),(11,'GD','image','gd','Engine_ServiceLocator_Plugin_Image_Gd',1),(12,'Imagick','image','imagick','Engine_ServiceLocator_Plugin_Image_Imagick',1),(13,'Akismet','akismet','standard','Engine_ServiceLocator_Plugin_Akismet',1);
/*!40000 ALTER TABLE `engine4_core_serviceproviders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_services`
--

DROP TABLE IF EXISTS `engine4_core_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `profile` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'default',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `type` (`type`,`profile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_services`
--

LOCK TABLES `engine4_core_services` WRITE;
/*!40000 ALTER TABLE `engine4_core_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_servicetypes`
--

DROP TABLE IF EXISTS `engine4_core_servicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `interface` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_servicetypes`
--

LOCK TABLES `engine4_core_servicetypes` WRITE;
/*!40000 ALTER TABLE `engine4_core_servicetypes` DISABLE KEYS */;
INSERT INTO `engine4_core_servicetypes` VALUES (1,'Database','database','Zend_Db_Adapter_Abstract',1),(2,'Cache','cache','Zend_Cache_Backend',1),(3,'Captcha','captcha','Zend_Captcha_Adapter',1),(4,'Mail Transport','mail','Zend_Mail_Transport_Abstract',1),(5,'Image','image','Engine_Image_Adapter_Abstract',1),(6,'Akismet','akismet','Zend_Service_Akismet',1);
/*!40000 ALTER TABLE `engine4_core_servicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_session`
--

DROP TABLE IF EXISTS `engine4_core_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_session` (
  `id` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_session`
--

LOCK TABLES `engine4_core_session` WRITE;
/*!40000 ALTER TABLE `engine4_core_session` DISABLE KEYS */;
INSERT INTO `engine4_core_session` VALUES ('01onvo4a1k365son07alu0uie5',1412337892,86400,'',NULL),('01rdqp3adca8e2e0hameoskpv6',1409063282,86400,'',NULL),('02qdpshkbo3qps273ujt1nk5i5',1411072943,86400,'',NULL),('02skko99vg8e04afs116duvih1',1409760804,86400,'',NULL),('0303ik494o8ht4f1qiu81uu883',1412247845,86400,'',NULL),('03qagi7c8opv3mq3keq7r35rv6',1409748648,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"06a34f50e67a01b7ff5b132092eb3a42\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"84\";twitter_lock|i:2;twitter_uid|b:0;',2),('05ala24qgk98ukv5r3a9alsp77',1409748746,86400,'',NULL),('05ocpj6h58v79h1e892227h6u1',1410996016,86400,'',NULL),('05q9h0mqfnjshd3d4ll9phe1n7',1408525232,86400,'',NULL),('06alseaucda8ap9du09fcf1i46',1408525635,86400,'',NULL),('06idf9add4offso1u4geqrdj65',1410649934,86400,'',NULL),('074ac7r75ck8qg67jfmn6vub76',1408526071,86400,'',NULL),('07b8msk602dh6fseqpnc0anpt5',1410735769,86400,'',NULL),('0828i1mo1pd6fjh1t71jn10uu4',1412254141,86400,'',NULL),('09sgpr2uti99e5apqidi5f83d1',1410994336,86400,'',NULL),('0a5k3527k58m41l6lef1nv3qi0',1409741359,86400,'',NULL),('0b5us6gl0ltfmmgbal8djttrg3',1409697759,86400,'',NULL),('0b6lcu5ulfut536r6c8puicnr1',1411500559,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5d3be838047c8e9d12d2880c5baf429c\";}twitter_uid|b:0;User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:2:\"98\";twitter_lock|i:7;',7),('0b7mndvitcn4heu7oicv339e05',1408368139,86400,'redirectURL|s:22:\"/?en4_maint_code=z7b9h\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5d9d431717cd531d77055fb8ca4d130f\";}',NULL),('0csbhgdaamivbtgp2p774r0te7',1409694761,86400,'',NULL),('0dgktitl8en507c5e568g5bb75',1412751620,86400,'',NULL),('0dsjtdotqmvce0pafjqhmr1so7',1409125720,86400,'',NULL),('0e0sg6bu9uhiil12fdeu06fmd7',1408539984,86400,'',NULL),('0eo0558kfurf8rgb990cf935k3',1410655779,86400,'',NULL),('0f8fp2hbfkghrk7ov8p3sdlsn4',1411073376,86400,'',NULL),('0fiqvu38dub0p72ao1dmkb2pp1',1408534634,86400,'',NULL),('0h368jlfbgbjs532ot4nuhd9k4',1408997053,86400,'',NULL),('0has28p0244ppu50ln8elu8cd2',1408574696,86400,'',NULL),('0hlec98nuhk3vh9m832bnojtv1',1412170172,86400,'',NULL),('0hnj9oa6m3j7itdp8pfbehomj1',1412349659,86400,'',NULL),('0khgl4td5i3kv6fjqhat7pova2',1412337127,86400,'',NULL),('0moam714pbd0h4l974cat9p7o2',1412259628,86400,'',NULL),('0mv1t0s6fm94om79a61g1b2pr6',1410647015,86400,'',NULL),('0nhg50mb1nim6jmlh7kgq60me6',1409753130,86400,'',NULL),('0oshdkc0hd6s2pfe9cgt5ocb55',1409065923,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"aca7ceafda6baabea6b1ecab58e46c78\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"64\";twitter_lock|i:3;twitter_uid|b:0;',3),('0ov9ke3fgp8j7u847gn3q3bo81',1408566563,86400,'',NULL),('0p274gi2n196pnl38n6dnc9hp0',1406898266,86400,'',NULL),('0p8t9oiavtojt50tkn6k9eah26',1408526244,86400,'',NULL),('0qd7f4av9qd2qt6lapuem0c0n6',1412324767,86400,'',NULL),('0qp0a4dp0d03srdqjvk9991ig7',1409730402,86400,'',NULL),('0qq9ubtcebutp25qiakjbk0782',1409735179,86400,'',NULL),('0quja5n5brgua3igie5j6lhfd3',1409059004,86400,'',NULL),('0rmn3c7214g8hjfa7lpp5hgs61',1409730046,86400,'',NULL),('0scvshcgnqi4jjmr115vr0kfj2',1410736823,86400,'',NULL),('0sh62qp8l22a84mn1c885map60',1410739371,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5819f9a4bb0c6deb050c004741cc59f6\";}Zend_Auth|a:1:{s:7:\"storage\";i:11;}login_id|s:2:\"94\";twitter_lock|i:11;twitter_uid|b:0;',11),('0srh10tapqivjkhukv8i140702',1408607758,86400,'',NULL),('0t0rc2le614tlunqnto4fnf722',1412692682,86400,'',NULL),('0t8ijac8ji18cil4o05uubap73',1406892768,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"279c33a8cfd4e1ed1d9a0c7ccc718938\";}Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:2:\"38\";twitter_lock|i:4;twitter_uid|b:0;',4),('0us3gri1abvfkhoq4lunf54d71',1410736642,86400,'',NULL),('0vldh50vmbdk8g09mm4a0r8ng1',1412688235,86400,'',NULL),('0vmjgsiegclpjvin5531qllgl1',1411074820,86400,'',NULL),('11ieolsd14a8gprnput2u8a5k3',1403968138,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"676fa507b0d863e151c45121e774668c\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"10\";twitter_lock|i:1;twitter_uid|b:0;',1),('13bakkb0er54loppcc74f2er17',1412751861,86400,'',NULL),('14h8smlhho66mal9bdq1kltlf7',1408888057,86400,'',NULL),('14kj56d4o76v936jquba4mlr67',1412590137,86400,'',NULL),('14q1ipq1s1c1gj9apu3ebn07u6',1409747708,86400,'',NULL),('15ldkiligou12mdnabffud4j93',1411080580,86400,'',NULL),('15qgb7uprov86sc0a6l3b5tb41',1406896374,86400,'',NULL),('17lfbj7eg67jaebnclkegssvm4',1409064122,86400,'',NULL),('17uvtrvl4hlompo09f50bpb872',1409738497,86400,'',NULL),('188gacnpf1stgsdh070kh9ja81',1412336879,86400,'',NULL),('18d1efpbu4apsjf433l80mooe1',1411342594,86400,'',NULL),('18f4e6if3m03la0eokshh8qko4',1409730764,86400,'',NULL),('19b0lv5ummf9b6ab6pa6ob9a84',1410655315,86400,'',NULL),('19il992birtj8po2hljbb66bu0',1410653468,86400,'',NULL),('19qpu11cggohn2b8k1nvioj786',1412867539,86400,'',NULL),('19vgqlmbpm4u9ut0l23itka7m3',1409748263,86400,'',NULL),('1ak0011p1aikromj1cg0ceg6l7',1410993170,86400,'',NULL),('1c068993dcsuh0t5lrbqqofs02',1408566260,86400,'',NULL),('1c83ekror2qbhpu4vhgfthhko4',1410901210,86400,'',NULL),('1cggfchboot3ds7q4vv90gtkq3',1408885656,86400,'',NULL),('1dg99um7582qab3779jda4aki7',1410994721,86400,'',NULL),('1dov01mtginbu7sgreba1351f2',1405087604,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"1d6b9ac04fd364ba39154ac5dd3f55df\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"22\";twitter_lock|i:3;twitter_uid|b:0;',3),('1ec7ajplom2nlr45hpf0nqncn1',1410738427,86400,'',NULL),('1ek0d057862j1t1tnuvmkv9nh6',1412865232,86400,'',NULL),('1enat7783ab8ec739mq1j1k1t4',1407244544,86400,'',NULL),('1ev5r245fal34umhofkv536jr1',1408542846,86400,'',NULL),('1fh4qb4m4bqsomqg74c41lb9q6',1412884768,86400,'',NULL),('1fqi2rjdlcihfkj5k5sf367676',1410650402,86400,'',NULL),('1fvo9715vukvs8bsjrh4up1n91',1410655167,86400,'',NULL),('1hohj1ht44b602g1d28jh3cr60',1411148654,86400,'',NULL),('1j8s6ti4vgu408o7palj0cp301',1409746998,86400,'',NULL),('1kjqupk4oj9cnq4jbtn92rt1m2',1412259182,86400,'',NULL),('1kr07faonin369u6ip218cp5s0',1412929567,86400,'',NULL),('1kvv02diejnu49egbart1c1s14',1412669617,86400,'',NULL),('1l3t6koolbbjui41btfg2sgs74',1408607637,86400,'',NULL),('1mbjoee5igrg4nedcp5e6uqq94',1410649786,86400,'',NULL),('1mc3o2707c4sr238r2qviqt5u7',1409746033,86400,'',NULL),('1nbbpmcc5bv0htamm16p1k39v2',1412342738,86400,'',NULL),('1njirbdo9kubptv6f8lm720v66',1411070954,86400,'',NULL),('1nriqohahp6dalqbql4tcqfra5',1411073024,86400,'',NULL),('1orlksq60nj049p321u06p7ke3',1412254795,86400,'',NULL),('1p0queo3l4csc0p7eu2hau96i2',1411342957,86400,'',NULL),('1p7iuhetp60d5v2baa6hfo3vn2',1412671779,86400,'',NULL),('1s6s89p8mmlmo9mmdt5879p4a3',1412318812,86400,'',NULL),('1tb6226puae9o8enakrrsfiqq5',1408527206,86400,'',NULL),('1tihuimdagcjah7ojirug6cik4',1412259748,86400,'',NULL),('1u6dkonsqbhcgvlee735ckd3a3',1409697158,86400,'',NULL),('1unbsrnatagosh2qst3susojg2',1409061396,86400,'',NULL),('1uqf8ppp2jhe2j80hgrad7k0q2',1412254707,86400,'',NULL),('20aah5v7nf6jokostct6tc8t67',1412254556,86400,'',NULL),('20ffsc325idg8k5j8hhvfckfo1',1408524925,86400,'',NULL),('20h4spa7aeetr1j43t9v40r3d6',1411109466,86400,'',NULL),('20qn6ldvi1g060v41sek0l77r3',1409746702,86400,'',NULL),('20sekgmfcvgm9upc22c4hab3i2',1409729798,86400,'',NULL),('2194upigf8ngtp2npgsg42e363',1409749366,86400,'',NULL),('22i8701cbl7dj39n1o8mr19v61',1409760534,86400,'',NULL),('22vigcj8goj2484mk6vj7roub5',1412769171,86400,'',NULL),('24ik18iceif5h73ucmt3s7ql14',1408539863,86400,'',NULL),('25h95pvgveq382c7augqadfdr7',1412342858,86400,'',NULL),('26gh8rou3juc16t6oof94u1hn6',1409134429,86400,'',NULL),('280osbmbj912tddfseehdp3vv5',1408541698,86400,'',NULL),('282ru2kkau317hl0r7nkinnhm7',1408893255,86400,'',NULL),('28gls7eode60il0ha4gethout5',1409747437,86400,'',NULL),('28pv5de3ujujb6u11lk1s7ulf7',1412884648,86400,'',NULL),('2aoofaomo5643ksae6gskop941',1408539143,86400,'',NULL),('2c53d62pruad06nphoha2eit13',1410898443,86400,'',NULL),('2ce2ua2su6bcqjs2t7m245ao36',1410646652,86400,'',NULL),('2fega4cr2rju0m4g2icg51u434',1410989993,86400,'',NULL),('2fo36ehtjktgedcsvk896uf5v3',1408269534,86400,'',NULL),('2fqrh2dgiaa89b78ed6prl2730',1409746163,86400,'',NULL),('2gjc9d9vue8o0ki6a6cfe04j14',1409731262,86400,'',NULL),('2hra8q77hjkv3m9k5af3u4reg5',1412332173,86400,'',NULL),('2i858k7db12ci039073f8k85n3',1408890723,86400,'',NULL),('2ihctct3k4ulnu04etk05gsq13',1406896301,86400,'',NULL),('2jecnk44asd0rbaqnua9i7ju54',1409065826,86400,'',NULL),('2jkbkisrn8oh6nptp1a5e8qsn5',1408565416,86400,'',NULL),('2lk618g3d6p0bhlromjm6ivfn4',1409063162,86400,'',NULL),('2mf9tlinm15lf9qo8aacr7bb01',1410898343,86400,'',NULL),('2namjhakoard990keog4d8b2d7',1408527067,86400,'',NULL),('2nqsgrm2kpl33sefkimegj1t67',1410995416,86400,'',NULL),('2nt7srnv15lgs4dhcso2tj8dt7',1412251312,86400,'',NULL),('2oa54a2vlbh9rj9mivanrf3oe2',1409061084,86400,'',NULL),('2oikp774ksg0i0vl6nvgj9cs76',1410993789,86400,'',NULL),('2p5rt1q12ptpmo621f6v7mpnd6',1405427304,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"6142292df4c1565bb9190487ec439401\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:2:\"28\";twitter_lock|i:4;',4),('2pbvdf236a047m8kab2qe87jk0',1409731152,86400,'',NULL),('2pt7hs3fp9ac7ivg0m3al02hq2',1411073679,86400,'',NULL),('2q642ldnhhl5dajgnkfdbulru2',1408527446,86400,'',NULL),('2qdh8nifjl14tk465f6obt7m52',1406893790,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5a2ed866823adb72a35987ce82a7ff34\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"37\";twitter_lock|i:3;twitter_uid|b:0;',3),('2qmfv7lv6k8vrjjmli7evkd0v3',1409061725,86400,'',NULL),('2u3job2enh60jqe9qlp5e14u56',1410900555,86400,'',NULL),('2uaeurbb1vfbufq3ppp7kuub72',1412864649,86400,'',NULL),('2v7q30leo150kpeh4s81mpcg42',1408574249,86400,'',NULL),('3010bnl83kqd3nblf2u92astp4',1412247483,86400,'',NULL),('30527te4vjbmnqgl3u7cseacg3',1412170293,86400,'',NULL),('30733q521lto3lu7bror1b56h5',1412674904,86400,'',NULL),('30plhu92l4sshri2tbm0mfg0o5',1410993547,86400,'',NULL),('30vd3m1453e8t8v29p4rnj4kf1',1408576289,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"18aa0db96e9720c523caabe2b49062df\";}Zend_Auth|a:1:{s:7:\"storage\";i:10;}login_id|s:2:\"59\";twitter_lock|i:10;twitter_uid|b:0;',10),('337qp4ne1uhnghcm3pcq8r5it0',1408525755,86400,'',NULL),('33ncfl1frnb00ovkrsg1flc645',1412589668,86400,'',NULL),('33oliv7id1nbb0hh9n203hmug2',1409703280,86400,'',NULL),('33ui53u2co722ih84ibnof9383',1411499469,86400,'',NULL),('34dkiosklacqacdpl1n7rpvl43',1412343081,86400,'',NULL),('3621vh4ffppj4qf6220ck4ndt0',1410992819,86400,'',NULL),('36aukadr01jgtlft1i8800fe70',1412866375,86400,'',NULL),('370hq6mubrm2pktctl8vrior43',1408274627,86400,'',NULL),('37bfp1shd45s5p2k23fjadi8d4',1409130564,86400,'',NULL),('37iju5a4ck5adcv1rot9f7rnt3',1412169811,86400,'',NULL),('37k2r9fp366376cnpo9ktrg6e6',1410652640,86400,'',NULL),('38npagvpp6aliitk9vrp477hn7',1409729100,86400,'',NULL),('38si4lk2vpsbencgbopvej84h2',1408884576,86400,'',NULL),('3980jo1e819uonudm0gvrr6km0',1409750570,86400,'redirectURL|s:6:\"/login\";login_id|s:2:\"85\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"4374c868fb25b7277a2c71bf231d1c23\";}twitter_lock|i:4;twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:4;}',4),('3agrq9n55dmr7oprk7icf877i4',1406900353,86400,'',NULL),('3apeck3t65o34k2bfc539njd03',1412259510,86400,'',NULL),('3b354vdgc40ktc5shj1i8r9861',1410655573,86400,'',NULL),('3cms04g83mvv3uopnmn6lq9c03',1412173780,86400,'',NULL),('3dpene2qqreec7hsgg2f3g4ko5',1412956207,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"40339c4744b9cdc1b58d46a5c0ab7482\";}Zend_Auth|a:1:{s:7:\"storage\";i:8;}login_id|s:3:\"121\";twitter_lock|i:8;twitter_uid|b:0;',8),('3e1m6b43hh7albp8eat5722574',1409740038,86400,'',NULL),('3ebenm5gog7k0u20olop7f6do5',1408368019,86400,'',NULL),('3elq1n3m5oegufhpir9kmhcbi5',1409749695,86400,'',NULL),('3ghpva9n2thu8sgqd2m51kebi4',1409742706,86400,'',NULL),('3h8pkhptov21qanq2mbbqbvct4',1408989759,86400,'',NULL),('3hben2k3m5rrkie812fg7a2714',1408541801,86400,'',NULL),('3ihst642gdrrhvupr1bo1hheq4',1408275162,86400,'',NULL),('3j15objjc21bdrt69q8qrbhe05',1409647930,86400,'',NULL),('3j57jk6sja0q2fnfqfa9u4mdf4',1409696060,86400,'',NULL),('3jkjsqmu9tvoi003296123nb81',1409065585,86400,'',NULL),('3k9i38vo8jqrii61anjqvt9mk5',1412254227,86400,'',NULL),('3lltaia34qgr19si0bqmstkb61',1412337809,86400,'',NULL),('3m8ibmlqu7kftd9j7v7bql3ej2',1412955966,86400,'',NULL),('3m8l89ekjgf74fhn9f7mi7ls77',1409129767,86400,'',NULL),('3n79gb3psbnbt98chc63mvljs2',1408268478,86400,'',NULL),('3p1f09jk5c9f422ricstenki93',1407277385,86400,'',NULL),('3pnskabppt19g6i9mva98avv24',1410992639,86400,'',NULL),('3ppk7vbjlmgbaku2uftifu8o96',1409732201,86400,'',NULL),('3qmrdjos762s2ec4po88no19j3',1412760752,86400,'',NULL),('3tgdug085k4f3am7jjl8ov1uf1',1409730947,86400,'',NULL),('3u585vn5d68cme9g1l30kgv4g2',1408570568,86400,'',NULL),('3v6v6trgbv3avi3d3edcb8bla4',1406898506,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"44fe629f3e824c3fc316adb7ea418174\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"42\";twitter_lock|i:2;twitter_uid|b:0;',2),('405c76d15c3c88f5531628db12f1e20e',1403024982,86400,'Zend_Auth|a:1:{s:7:\"storage\";i:1;}ActivityFormToken|a:1:{s:5:\"token\";s:32:\"be0a5f3418acf1a6fa2be99fe7cc98b3\";}twitter_lock|i:1;twitter_uid|b:0;',1),('40n4fg67kqe4iclspfh0c2bcd1',1408998434,86400,'',NULL),('434d02sv706t1halroo3bo6ac4',1411340661,86400,'',NULL),('44lr401fm9b0vj17f88sgrd7i5',1412260720,86400,'',NULL),('44rd2gpe6odtrtgpn38rok7564',1412695578,86400,'',NULL),('454t352c91m8e0lapt2f97beu0',1409741985,86400,'',NULL),('45b22u3ol8gibkisvv73gq1nq7',1412768929,86400,'',NULL),('45shrcoa6tuiejo5jmm6790ub5',1408571955,86400,'',NULL),('476jtfe8shp5hgsb524kfa13a1',1408566744,86400,'',NULL),('47bcip7v7b4gt82keg1lqsdnn3',1412332979,86400,'',NULL),('485eoap1k4prq20m8kk90hh295',1409133396,86400,'',NULL),('48k6fv3hs59s3pt19te0kclqv7',1412865470,86400,'',NULL),('49qhuv2riegu1vjhiq697tmba0',1408537200,86400,'',NULL),('4a7cuahta3diebhh7a49hr2mb2',1409732455,86400,'',NULL),('4b6cbt2v2ps7vkb7klkk9ndug6',1409129081,86400,'',NULL),('4baqaepi8ndc715al0h5fbhf16',1410647498,86400,'',NULL),('4be83oenm4lpvipacuq4mthhu7',1412341517,86400,'',NULL),('4bqei13c7l22ah7hmm52rhpco7',1412332499,86400,'',NULL),('4c9fpghjalv0q94d89142st9j7',1412766403,86400,'',NULL),('4chfbbgv3qf08cbqnir7iu4pl4',1410738061,86400,'',NULL),('4ct9kvdtn1dv412livo7p31e35',1411073617,86400,'',NULL),('4dpnbs0guibs9jbg1965m6hel3',1410906592,86400,'',NULL),('4f3kvf1f4i98cc39oem3jcl4u7',1412672141,86400,'',NULL),('4f3vsh141ee3vf90pm728kugp1',1412247604,86400,'',NULL),('4hckk32q0to7g89c3m4777h2p4',1412334986,86400,'',NULL),('4hsb3hgiglnu7rojg15tbq2lo3',1405348052,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"c5b2a4bce82a5548b35055d3fd58bc39\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"24\";twitter_lock|i:2;twitter_uid|b:0;',2),('4iq3gssgpft5ime2av9pujp1u5',1412259303,86400,'',NULL),('4jbhdagijj57gpd2l3dshns8v7',1409762621,86400,'',NULL),('4jf59t4ltqo0fqid99ns5fh125',1405146170,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"fc7362f3fb096feeb3c4f726387fb690\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"21\";twitter_lock|i:2;twitter_uid|b:0;',2),('4jhf57kj8d9pm8abtpo4esv392',1410649103,86400,'',NULL),('4kjmckegvu1ehaiqs4k1lcvd54',1408572075,86400,'',NULL),('4kq3qkamnqqjgibhmlruofh883',1409130707,86400,'',NULL),('4lc1dqodbh4q2d1amll91t7o84',1411148775,86400,'',NULL),('4m2kqs5dd3urmbbk9plbhdpv64',1409729648,86400,'',NULL),('4mee2k3f9ng8rqr9u1f81rch50',1410653801,86400,'',NULL),('4puq9ao24jal06edl09edl4qb4',1409126200,86400,'',NULL),('4rca8f0kses7hi1gd5rutbq6p2',1409730278,86400,'',NULL),('4sar7lkclheva6qe3ov04oapo2',1408574614,86400,'',NULL),('4u4cmkkhr2h0vkmh0g2jvshia3',1412885008,86400,'',NULL),('4ueedq8htd32i0m4cttv76ip72',1409734268,86400,'',NULL),('4vc6a7ji63iko26i4voc4hj4n7',1408543290,86400,'',NULL),('500i4sskfev6oj4eclimqt9nj5',1410739552,86400,'',NULL),('50d9kgbof4vqd5sj9mkac02kq0',1408890117,86400,'',NULL),('51c17in9m8je5u3kv80i8jl471',1412675265,86400,'',NULL),('51dmpml75085p5bt9e349g8kb3',1412596634,86400,'',NULL),('51rh4be67kgqc228va4c2khme3',1406901541,86400,'',NULL),('52caql93s6b0giqpf4t04erfu4',1410990580,86400,'',NULL),('52kkbp05gnvv4o8l9oa56g5683',1408534941,86400,'',NULL),('52r80mj20n69cagiff7m1a4n71',1409694942,86400,'',NULL),('537sts8s6ap5cbmvkash8bmsl3',1410895917,86400,'',NULL),('53d4asvt22cckrknu3ed5ktu47',1410739440,86400,'',NULL),('53jppdf91lslielmbqchdme1g5',1409731437,86400,'',NULL),('545b99dh6gr8pk0tfabg23hcm5',1405529906,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"d48068fdeb7c35e89250900722e3dee9\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"29\";twitter_lock|i:2;twitter_uid|b:0;',2),('54ac93ghqpqdkq7ae1bvklj090',1408542966,86400,'',NULL),('54oim2hok8jdu9u0n1oahq0rq7',1408889617,86400,'',NULL),('559ae6n3eg7ojdvk7ef3ghu4d7',1412776321,86400,'',NULL),('55uf089o1hhrmt5q4a7jahb317',1408268571,86400,'',NULL),('561g77qopvk2vc30tted6ds0b7',1410898683,86400,'',NULL),('56a09epavoogildju6259nf677',1410647135,86400,'',NULL),('56ctp24r87pk3h3o1a8q0527n2',1410899867,86400,'',NULL),('57r7ep60ekrb7msf9iv1ne4ht6',1408893375,86400,'',NULL),('58oor139lanp8614c92j0484a5',1412864708,86400,'',NULL),('58v6hv90mdl61n03tvoh5q9ab4',1408571005,86400,'',NULL),('59duok946dbjah1r86daufin67',1406130224,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"1ee76ee4e0786e28ef9494b38d7beb74\";}',NULL),('5ag3fov9eg597odv2lmoec6oh3',1409136516,86400,'',NULL),('5bcrf8tq41petjm241eaioioo2',1408998554,86400,'',NULL),('5bpbqsophl7g6i5807eq3462o4',1411073111,86400,'',NULL),('5c7uv4lfpfrf0dnk0gu4kernk7',1412253998,86400,'',NULL),('5dm7ljqrpeugek5jj2g3u3i2r5',1412929326,86400,'',NULL),('5ecdvg6gg6ou2ecbtlnrsu03b0',1407274782,86400,'',NULL),('5evtimpaejbg2asqtone2i3mk4',1415197604,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"c79e1dc3097541bf8613c6aa5dd73df0\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:3:\"126\";twitter_lock|i:1;',1),('5f4eajgtr7t08ic2ncdk9mf3j4',1410906350,86400,'',NULL),('5fn4jj6adgln9g61r48p7gp593',1409133227,86400,'',NULL),('5gbvikgnrsuo05p2rpv171d5h7',1412693526,86400,'',NULL),('5goqdrp44neuoibpvuguraf3g4',1407240462,86400,'',NULL),('5hi0nihv6m3lo4nkrle1mhm7s2',1408998315,86400,'',NULL),('5hunbomblbmb2i472eq4rl9jq2',1412325487,86400,'',NULL),('5i2dfmpm89rjtfhrh7fq8tjic4',1409731747,86400,'',NULL),('5icgncgatj2u5t3h8qm15e2k97',1408526992,86400,'',NULL),('5icvin0obibo6vep6359gp67a4',1410653661,86400,'',NULL),('5ii9jmc4ogjgd7e69f08p3f5n7',1410739636,86400,'',NULL),('5ip8m5mif2vtfsnibeba7tuso7',1410647722,86400,'',NULL),('5j333fuo3td04nd8dfn7r6lul3',1408566200,86400,'',NULL),('5j5umku6f5ppo46g822j5rrta6',1412954643,86400,'',NULL),('5jrmo7m95k86jrusc50m14gfl3',1410993350,86400,'',NULL),('5k4rhl2daeh5c8h4fbjmoetmk0',1409747948,86400,'',NULL),('5kiiokleaf56697u6ko14vnft3',1412247966,86400,'',NULL),('5kp520brefmjvs6kge4fke5s23',1406896904,86400,'',NULL),('5l1djp4m8usvmit7ohg2suq7h3',1412693044,86400,'',NULL),('5l83o4q0uhmuld7sjn9esgnhg3',1412867661,86400,'',NULL),('5lr2e2gs5ufl6f8d0c2piphes6',1409739010,86400,'',NULL),('5mcup34tv0l33dr2pg08board6',1410737272,86400,'',NULL),('5me09duk1m3i9654mj9joc6j02',1408567096,86400,'',NULL),('5mgrk6j2v37d96rs7c1af96bl1',1409125479,86400,'',NULL),('5o0aaaeo4glnk8qucapb9hruv1',1410740058,86400,'',NULL),('5oi7r56kdoc564kjqtmse23h07',1408996692,86400,'',NULL),('5qhgqrlssk4d2caravhofrm6j0',1411340540,86400,'',NULL),('5qpb8b70sb5c30fut9974ah740',1409745731,86400,'',NULL),('5r7lckpjikkvpm122rqi6jk145',1409003475,86400,'',NULL),('5r973bbk1du8qocejjkp6c9u22',1410900915,86400,'',NULL),('5rd2h7midk4jlv8m9p1ag2ur82',1410901035,86400,'',NULL),('5rf4t4dsmifcbmrfdak8fjcb64',1412930003,86400,'',NULL),('5s073r7nd5on7db8rsnfbeb690',1409059730,86400,'',NULL),('5t63gsrodrf3ha3kkg7h5sjcs1',1409733540,86400,'',NULL),('5tegpcj3ag8sc7pb3fgq06da56',1409732696,86400,'',NULL),('5tshmld99bv4nlo3m218818hm3',1410898200,86400,'',NULL),('5ttinqkku15n99bufaqjajttm0',1409728858,86400,'',NULL),('5uidbs4h7ap99ern8958qjqm94',1412339230,86400,'',NULL),('5vm9cg52l5iamvsg62kon82rf0',1409735059,86400,'',NULL),('601s76dobvanp5g8v0mk2hbg22',1412956208,86400,'',NULL),('6059uss7q4ms1p6jlcr5ogu4j0',1408566486,86400,'',NULL),('60hb23k7of7974quu81b3ju376',1411075665,86400,'',NULL),('6222ms6lp585ir90iv72fsn1l4',1409732389,86400,'',NULL),('625o8c2uka51blu5d7ukkh2m07',1412675506,86400,'',NULL),('654tlfdbkr2no4qrrlo9cvq8q5',1406897033,86400,'',NULL),('65hpp582jtnimtiun5q8quaip4',1409133854,86400,'',NULL),('65m1spahia4mh3tsj9oo3c6sc6',1412337607,86400,'',NULL),('66c3hcbj2tkspnijcsvkph5e93',1409738619,86400,'',NULL),('66gfb8drnloorcut41s786mmb1',1412864588,86400,'',NULL),('67198js3sj8806l2qu5a4jluo3',1411340782,86400,'',NULL),('67jsct4e7e4o6p9no2i4ehidv1',1410896264,86400,'',NULL),('68tn509lqlvdgolnnd9d8gibg3',1410650507,86400,'',NULL),('6a8s2uasgbu8rhmvgm8gegvg36',1408885896,86400,'',NULL),('6b00k1h91u55s3c4ef44lvues4',1408574129,86400,'',NULL),('6cnij649gqkkbo7duo2n1dl0r4',1409748659,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"ee0e8c2341ddfe8f376210a279036beb\";}Zend_Auth|a:1:{s:7:\"storage\";i:5;}login_id|s:2:\"77\";twitter_lock|i:5;twitter_uid|b:0;',5),('6dbnjcn34f5qs11nsile9ncig2',1408569737,86400,'',NULL),('6dd506v6r3nstnrjg9bupkqsh0',1412694250,86400,'',NULL),('6e3jesknj9ulcck6s4hs1uppg7',1412867781,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"3b4ac636a0c448356757bc01a466016f\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:3:\"118\";twitter_lock|i:1;twitter_uid|b:0;',1),('6fj53k03ve7gm2d7s1fa2bc9o3',1408534813,86400,'',NULL),('6g1m2odpkflsnm2stkluhi6404',1408274858,86400,'',NULL),('6g31eqpdsk4fvgs7nk2qmjigb6',1408543290,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"bc7305c675a44a05c06e212d5afac64e\";}Zend_Auth|a:1:{s:7:\"storage\";i:10;}login_id|s:2:\"55\";twitter_lock|i:10;twitter_uid|b:0;',10),('6g7kd4273f8ceu3gei4nt5sbc6',1409740451,86400,'',NULL),('6ho7sgdk118vmab5338gmdtai4',1409742945,86400,'',NULL),('6hr8vheprdboc41fbmur1o34n5',1407235348,86400,'',NULL),('6jcqvnesj8i5vkbfb7ccd885t6',1409729862,86400,'',NULL),('6jlvrk4alh82jir17vq405v8g4',1412340793,86400,'',NULL),('6lqs2nuoru4colnn9g6i9l7l93',1409736970,86400,'',NULL),('6m7kgmle5unrc5518t4c9ll4q1',1410896960,86400,'',NULL),('6mbtchrfvo9iru2bh0jj4cc9s3',1409729513,86400,'',NULL),('6mk2lo95g3f5hbvus3tq2boiu2',1410653124,86400,'',NULL),('6n85o2onqsr83s4lq7pltnva22',1406900662,86400,'',NULL),('6o1hb425qf99r0ds52ic0edfl3',1410899987,86400,'',NULL),('6o2123thtm4s08e8phnq2gma92',1410651007,86400,'',NULL),('6o2f6m33gt5jpsaoa9hq1jmqe6',1412842728,86400,'',NULL),('6ofh844e7dks37p4dcm7517tq4',1412254080,86400,'',NULL),('6ok4imh99kbtpa2pmg34l42g50',1406897764,86400,'',NULL),('6q18k0rs9njprlr98ou450bna7',1412324647,86400,'',NULL),('6qq2hj790214gsoeaiainjvt45',1407274654,86400,'',NULL),('6rad7t0v9n03aovo480fl66m93',1408537268,86400,'',NULL),('6s0ml0u42m1lj4ti6hpq4ajfj4',1407335478,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"a72bd597e12c563db5c78badb92e08f4\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"48\";twitter_lock|i:1;twitter_uid|b:0;',1),('6sn6a0lukalo20vsnkhgvl8gh0',1406897276,86400,'',NULL),('6snm5gia5a772esj4umudc4mg1',1410994096,86400,'',NULL),('6t5o5k3tpp77cuk6omqmokrgb6',1410648980,86400,'',NULL),('6u32avtog2rv56dbfp2oh7cuh7',1412866614,86400,'',NULL),('6u6pdiqkkqv2acn49dhrvmarc6',1406897096,86400,'',NULL),('6ug2tiu2esqe2881keq5uo7is6',1412335371,86400,'',NULL),('6ui3892o068q6i8mcn80i6hkc7',1410738002,86400,'',NULL),('6v8a6durn5bsgj0q1kbbhho6i6',1408542270,86400,'',NULL),('70hk4m8895i2tjm3t1srpj8ds0',1409729923,86400,'',NULL),('714gpim2ni9es3rbdh0nv9ov61',1406897353,86400,'',NULL),('71v7oal1pkcbnum4ja0gcvrk26',1412884165,86400,'',NULL),('727m918mconkun8b0cnee2n2r2',1408525834,86400,'',NULL),('72eu5ipm7emcavfud2h93q7hp6',1409699800,86400,'',NULL),('72i4itdqbic2sc8va78vnns4a1',1409730887,86400,'',NULL),('72t19t1d7e0dg5li0pnjclrbm2',1409748877,86400,'',NULL),('731mlgrltrc069v9jdu0ghqc50',1408569323,86400,'',NULL),('735a9bah0tespdmqmqnkmbggi2',1409746561,86400,'',NULL),('74bc8fv60gsaa2kclnbmrmk403',1408573889,86400,'',NULL),('751g4kitb4k5o1elabetn8f7m5',1412255463,86400,'',NULL),('754mv3qmqjrcd36fl14rgksk70',1407260991,86400,'',NULL),('765r796ddevc46ocu7dkbsd0l0',1409136637,86400,'',NULL),('768kb2it09k05r59iq0kfmevs3',1408537718,86400,'',NULL),('76m47sn81r9hsvh0gpulciqd20',1410648590,86400,'',NULL),('76oj09vlsr6mpu2tjbr2u114f3',1412335046,86400,'',NULL),('77qo262vr82qbs87i55hu9bp12',1410990456,86400,'',NULL),('78mrq03rg0hed9rl7uf6u2aki2',1409132505,86400,'',NULL),('7a9tqg5f39pkfq20b81lm8uds4',1410646740,86400,'',NULL),('7aol40mkl3qnpo7dpuj9ivmv90',1412864784,86400,'',NULL),('7blqcdkg4ncmgchpf0nh50od05',1409129321,86400,'',NULL),('7cd8i45ja336v1104f4u1ebao3',1412337005,86400,'',NULL),('7dbvnb5tf88v9vrlcta3r03fc2',1411499718,86400,'',NULL),('7drc8up5aq5mqs9822dp709hf3',1406896122,86400,'',NULL),('7e8feqsa8alv6m0a9d9ir2cuu3',1404211344,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"edd0715d856647d25d4537300e45c203\";}Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:2:\"13\";twitter_lock|i:4;twitter_uid|b:0;',4),('7egtgqcahhr57431ksrgnvke84',1407183696,86400,'',NULL),('7en7ratrspuc27f2d29qqrmbk4',1410896038,86400,'',NULL),('7fg7pejqu26p7bjo4r08d1k980',1410989332,86400,'',NULL),('7fv0grr34rteovjt3tmdhl4vh2',1410654602,86400,'',NULL),('7ied2bl9cok9f4abnatc8dvd10',1412319172,86400,'',NULL),('7ild6kpqr4i9a8bvp58m3svjq2',1409731626,86400,'',NULL),('7isti75mfisg3ea4l8nhpjlo67',1408566623,86400,'',NULL),('7jdmojbfnjdi8sjbrep486k5k6',1408571352,86400,'',NULL),('7jpot47m7b81n5m3g1ubsue7b0',1409125119,86400,'',NULL),('7lu6je2jk0bqirku6nl6veq954',1408572509,86400,'',NULL),('7lvhb80pfihf8fkoqirfd2uom6',1408889977,86400,'',NULL),('7me3vtmpqd5tfvuqpijrhph593',1408273810,86400,'',NULL),('7mfvhfldejjbfdg3uih0vltpc5',1412324407,86400,'',NULL),('7mj0tlnagm4rffo24a124epev3',1410899579,86400,'',NULL),('7morv76cogrfps9t2ucnolte76',1408541149,86400,'',NULL),('7n9ta4ukv05h87tnv4a6qgju44',1409130034,86400,'',NULL),('7nvn92ent5g4meop87h1agmsm4',1408526461,86400,'',NULL),('7oi9ei8tchialkj57s8ptkbu12',1409752009,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"fe575934ae11cc29494ae092f0c9fea1\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"86\";twitter_lock|i:1;',1),('7olma9lecgf88mtie4u11nkgp4',1410737790,86400,'',NULL),('7pef9fssgagj5c9p8k2e14jlh7',1412340853,86400,'',NULL),('7raadhqbuq359abeiglk6mbma6',1409129588,86400,'',NULL),('7rbhruuaa9n8bgdobier2d1it3',1408565767,86400,'',NULL),('7re02uklqobjutee755d4ktr86',1408367532,86400,'',NULL),('7t9cev5ema5ol9dq1onlq66uh7',1411072823,86400,'',NULL),('7tln52vi0rgllrl3u9qtcg5et2',1412865382,86400,'',NULL),('7tne813hhofsu30idjlpanc9q3',1408541215,86400,'',NULL),('7u3ulnmdd8pjbql6tb28o2tjj6',1406900067,86400,'',NULL),('82jb9s23ust644r7pq24fetlv5',1410788146,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"688d98cb52eacfb87e0adc49f1eb32d3\";}',NULL),('82t0g33ssuaa57fcr0m3vclm30',1408534875,86400,'',NULL),('834j0fq400443aqpva7uqcjqg3',1412260961,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"16b70491e682117eb620f858bcfc711d\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:3:\"111\";twitter_lock|i:2;twitter_uid|b:0;',2),('84cm12k5lqo89glun4d9ci8697',1409761765,86400,'',NULL),('84d3aqahdlm7tdss7vb7f16qn4',1412337455,86400,'',NULL),('858bbpe9cdhqv29svvje12f6v0',1409738694,86400,'',NULL),('859lot54ifvoinlsoa870201a5',1409740389,86400,'',NULL),('85uevu1oud7i3kol04cad9b3o3',1412596568,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"0f99ce380c689002a5f7fb418764c252\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:3:\"115\";twitter_lock|i:1;twitter_uid|b:0;',1),('86u77c8okqlbeel4pt0va3f8l3',1410994216,86400,'',NULL),('87he8unffg2cngagppbtpfim31',1406899688,86400,'',NULL),('87ps1gp9to4bggss7r5fif0o51',1412686072,86400,'',NULL),('881rrpkcrfuffroo2jfjufo8f4',1409139739,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"bcd644e26fec92a0146bc04fc3813464\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"63\";twitter_lock|i:1;twitter_uid|b:0;',1),('88airqk1nn6oa13kp16bv8mhb7',1409130391,86400,'',NULL),('88mran8pneesrupaorsj5jopa7',1410897438,86400,'',NULL),('894oh3bbevkqsf4fbqiiedfav6',1408570750,86400,'',NULL),('8amdlb8icv4l6acp9d796td7f4',1408566398,86400,'',NULL),('8bjmjqe8tvc6raea85h54vp377',1409747226,86400,'',NULL),('8bsif98cofljiueko02fih6op7',1411074578,86400,'',NULL),('8d6klaoa1ni9q7tlibi4l16464',1406892797,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"f80134693b68f2690e9358e67a411092\";}Zend_Auth|a:1:{s:7:\"storage\";i:5;}login_id|s:2:\"39\";twitter_lock|i:5;twitter_uid|b:0;',5),('8e77n5e10l9qm75ckfp74lffk1',1409728937,86400,'',NULL),('8ev4rivcspovhif1s13s3fo842',1409748384,86400,'',NULL),('8ft3q2v8qf22vo3qjrlsncumc4',1410656093,86400,'',NULL),('8g364d9ho9sbusqn511d5tocq5',1412694009,86400,'',NULL),('8gmtmu52b6s7q210b72n4eebl4',1409740998,86400,'',NULL),('8h3atrc4vs03cg657v0n56g1a3',1408571112,86400,'',NULL),('8hjr5jr6pgvrdd0hprk99c22p4',1412769291,86400,'',NULL),('8holll8ueclntkhj10e60aes20',1408367653,86400,'',NULL),('8ia883638vmafb3m8aq58pmih0',1412766524,86400,'',NULL),('8iok2v6lprmpstvne9sj1pp7t1',1408573649,86400,'',NULL),('8jr4sf955ep4d0g4cggrj9qbg1',1412258756,86400,'',NULL),('8jvcf3rmm20in74rtu2vg7sl74',1410646241,86400,'',NULL),('8l2jpfn7nubjiomtrdfvbeoh20',1412674543,86400,'',NULL),('8lfmrufi5lpl3c7rvbh17atc60',1411080940,86400,'',NULL),('8m07vv6hia78ermlmfbqfe4qs4',1407248191,86400,'',NULL),('8nl0284kqr8lredhvg16o4ofh4',1412775992,86400,'',NULL),('8omm4mdi0a9f7fmat2jcsjor44',1411342836,86400,'',NULL),('8p0f58v9tdu3g6k8539amrt1h3',1411141031,86400,'',NULL),('8peakuh9ss94kbnsasvh6ih2a0',1409740763,86400,'',NULL),('8podq31csfhf1ork746d6lkbg0',1406896824,86400,'',NULL),('8pro8o6h3orvocnis7j1gtptb6',1410737617,86400,'',NULL),('8q4olebb837losog1ha5j5cts3',1409745556,86400,'',NULL),('8qfq33gspnuoj8v5dbeu1npvr7',1412343563,86400,'',NULL),('8qvbmsj3b3pdt05ouoetgaueo3',1412251141,86400,'',NULL),('8r410htka2rk4g9rsnulsr1a16',1409749606,86400,'',NULL),('8rmcpfrdd32t1trvces2sjdpv2',1408524384,86400,'',NULL),('8rupouol7e942dvvqg4plafrg7',1403968134,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"0d68974aad8516364db94a11fe20efbe\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:1:\"9\";twitter_lock|i:1;twitter_uid|b:0;',1),('8set086r5am24pl5nof3kfbo44',1412691958,86400,'',NULL),('8snmtno301lfabsgat1ppej7h5',1408526912,86400,'',NULL),('8tvbn598e85o4db3rcoeel09j4',1407244664,86400,'',NULL),('906de1lcq9lklv1trfo2rmco36',1411071075,86400,'',NULL),('9103dopjrd2jgbd718ns663h85',1412757989,86400,'',NULL),('91tganhdf3t8dficbsau0uci01',1409745487,86400,'',NULL),('92e5ulmaic6o9pvbaqpqfko736',1409129460,86400,'',NULL),('93p67u2sgqo6v177389e3aqc36',1408542205,86400,'',NULL),('9462pl3ek6nu27q1648n9n8a12',1409744668,86400,'',NULL),('94fdj6hbjso5n86bgv4d5pb6j4',1409697608,86400,'',NULL),('94qmn4k291kmbe7a6hq4ku2eb1',1412324887,86400,'',NULL),('95l3kf04i8qj9kpn0nnq014l32',1406895817,86400,'',NULL),('96jee7n45a4433l59onf0o9gc0',1408575809,86400,'',NULL),('97bjrterd7t7tng2mvtbcdka80',1408523793,86400,'',NULL),('99t2duskt582snkrj5b757lme4',1408570935,86400,'',NULL),('9aae8kg8sf2ecrhduc82sulv87',1409735419,86400,'',NULL),('9babcu1p36e5ap0v8nqc52dmu0',1408275097,86400,'',NULL),('9d04s75tso96q5n263jv59ark7',1412341157,86400,'',NULL),('9dbc0avugs2oo4sg30nam3gkd6',1409730554,86400,'',NULL),('9ev5g70scjmumsrnnoprarpji2',1409061016,86400,'',NULL),('9gktdbagee7e1f5293knh2bo51',1408890376,86400,'',NULL),('9grrj776frsg9ho6bm0c0ngbc3',1412258343,86400,'',NULL),('9h8lv4787jab4bop983p059qn6',1411073184,86400,'',NULL),('9hhoham9nap9g1d213kce6qh13',1403552101,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"ab2b6d40424ab41f6ed2bdf772139cdd\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:1:\"4\";twitter_lock|i:2;twitter_uid|b:0;',2),('9kq26ik38i1952go21q9drq8b7',1412764360,86400,'',NULL),('9o23ufdom0oigpl8r0qdo9apv5',1409749486,86400,'',NULL),('9olb7etqda29cmku4hp271rv07',1409648234,86400,'',NULL),('9r55d5vbar810n5967pf66rnj4',1412260480,86400,'',NULL),('9rbqjbanov7ob8vft0bb8j65a3',1410900675,86400,'',NULL),('9s0ehaqbs1el36k6i2h9vtqi35',1411073254,86400,'',NULL),('9uqr0m3r1u33qrpkpq7cu828p4',1408283394,86400,'',NULL),('9v3uel8r1ims6mqd4bem9c45h6',1409135077,86400,'',NULL),('9v59l5p1jrl5usnq8qkur9ftp6',1412760874,86400,'',NULL),('9vdcdk3sjkpi19ickian9etev4',1409739975,86400,'',NULL),('9vipq2bnso0rjvdva5h1l9rhf5',1412595249,86400,'',NULL),('9viul99lg1kc9tqgd755q9cd22',1410990939,86400,'',NULL),('a04fl1qdkhouabf7gkbalvrlc4',1409126080,86400,'',NULL),('a0fsdhkso0uhcuus39600ic164',1411079500,86400,'',NULL),('a121vussam9mtmjs1cmg7utdr2',1412865775,86400,'',NULL),('a1up16glm4cda7bpgh3sans8i6',1408998074,86400,'',NULL),('a2bbgl4tsq9huo15e4tre3of23',1412693165,86400,'',NULL),('a348pum0eb13nq371nie1a5va0',1409732765,86400,'',NULL),('a35i2qt199l4vdfslovdt6u616',1408999034,86400,'',NULL),('a3cbae3os78hntne0pj93nd7l1',1409747588,86400,'',NULL),('a4h5smrt9j26tvk5hl6k93ddv0',1410653026,86400,'',NULL),('a4hdt9k6pse1j0n152e722ji05',1410647257,86400,'',NULL),('a4majr3ee0ffhcd01a6eopbsk5',1408571715,86400,'',NULL),('a5e5dvmjlvi66q1olcn9klpld5',1410740057,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5ecc20af35471670e668babd31b4a97e\";}Zend_Auth|a:1:{s:7:\"storage\";i:12;}twitter_lock|i:12;twitter_uid|b:0;',12),('a5r0loinknre6tut11rtmvgg04',1408571175,86400,'',NULL),('a8hfj9dlbm98m3plbn8tav2vt3',1406900972,86400,'',NULL),('a93870jft5olgl8i9cnr4rmvv5',1407240793,86400,'',NULL),('a98vfh6uk6q4stqvjoejf3p3p1',1408526788,86400,'',NULL),('a9h0ggn9utknk8audaa6scgt61',1411075908,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"fe6b31546bb12e65ab14c01caae57a26\";}Zend_Auth|a:1:{s:7:\"storage\";i:8;}login_id|s:3:\"104\";twitter_lock|i:8;twitter_uid|b:0;',8),('aa3b0csj4o96vpdj7a7t9qs8i4',1409064962,86400,'',NULL),('aaft9trhv5u2vlikrls8adoon4',1408367775,86400,'',NULL),('abgk10ecnsoh25gis5h0opg622',1412325127,86400,'',NULL),('aebcrdr6jkp6bu70v15sq67a37',1411077340,86400,'',NULL),('aegi245r33uaghlnn2paqpmst7',1409063044,86400,'',NULL),('aep5q45h5dmfhlibusbkthshn6',1403680403,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"62951d079e589dc2d39b798f205b2786\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:1:\"7\";twitter_lock|i:4;',4),('af3qoa52avju6lcavrrefncrc6',1406901614,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7191dfb0740d76c6655aa77ccdbd6364\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"41\";twitter_lock|i:1;twitter_uid|b:0;',1),('agcgrc0snvsmmchgtjagipjqn1',1409744428,86400,'',NULL),('ahim9gr604kd6m5r01l4vuk846',1406897827,86400,'',NULL),('ai80t5cbtl5g0i5e010tar3356',1411148897,86400,'',NULL),('aislb5q16arnhg951ctpjfs544',1410906229,86400,'',NULL),('ajgg759stv35jodn6r677ajtd6',1409063643,86400,'',NULL),('ak4hb6eog5s2t0svq08sc2dl57',1410995656,86400,'',NULL),('ak9imc50nugi0o56sgf8oms3s7',1409130227,86400,'',NULL),('akada6t1dhkop052jt4gaco5f3',1412596514,86400,'',NULL),('akid1sldqo8kj08ait5sebarc7',1412324527,86400,'',NULL),('al805motk4p0ionpau9n3f6ta1',1412685710,86400,'',NULL),('aln5398hpe74pl7r6111ejmeu0',1407274408,86400,'',NULL),('am4ds3t65gk59c548jedftpea2',1409694882,86400,'',NULL),('an9biitqi83t7328cnlrc0j9f3',1410899007,86400,'',NULL),('annoebf442qfnh82f5mrkeg623',1412864898,86400,'',NULL),('aour9pe4ie9ah2hdp6kcre35g6',1406897965,86400,'',NULL),('ap5osujq4kifbmpnfe98j65sm5',1412867781,86400,'',NULL),('ape8oduldgbv529gcajvdl5do7',1410735636,86400,'redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:9;}login_id|s:2:\"90\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"ee9ff16c6f3eaf87a8599fdbe7a3639c\";}twitter_lock|i:9;twitter_uid|b:0;',9),('aqpicbk8robksprolb2lcg5nf2',1409755174,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"f0d491766f25824038d6a622fc8205e3\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"78\";twitter_lock|i:1;twitter_uid|b:0;',1),('arta7c9tbfj69s2jevb3ah17b3',1412954284,86400,'',NULL),('asv5rrib6p3nj9vtiqjihk3hl2',1410992759,86400,'',NULL),('atsomqkmjuug8hbkgfujplhq23',1406897618,86400,'',NULL),('au7k0hrfhgsm8t8do5maethqf4',1410653730,86400,'',NULL),('auc7079448s2m9uf9eo8rdabb3',1409695093,86400,'',NULL),('autekb1lgr6tohtt6v6ujvl3b7',1408269354,86400,'',NULL),('avo31mku9tnjpelt754lhp0fc0',1409739130,86400,'',NULL),('b0mpm7adbgkm96cn0oqcfrs1m5',1408572329,86400,'',NULL),('b1i29178kkvbpgp7b2jetkl9e6',1412171015,86400,'',NULL),('b43aqs7i3o5ljkql166ie80oc4',1408989011,86400,'',NULL),('b4i46attvocrbo2gk6e0q3qcg1',1410647378,86400,'',NULL),('b4mabeq39dqp9aksjfdloo34r7',1408566036,86400,'',NULL),('b6b2ksunnh4mlf8kpp5lsguen4',1408274718,86400,'',NULL),('b7bougeicnthtk0jef7bjbb6q4',1411074941,86400,'',NULL),('b8pgpeqn7112cr1famc1np72e7',1412776599,86400,'',NULL),('b8vq7f8ssg23tcrjssij66as15',1410736349,86400,'',NULL),('b95h5rto1qe5ui3ilquf1mgi34',1409733738,86400,'',NULL),('ba4v3t8ro1ae1o99u5cq87cnm2',1412695337,86400,'',NULL),('bak6pl0eetnsnjlsr2hs5alqb7',1408996519,86400,'',NULL),('bb6e6ekh14f6gvl3ff0r5pnjn0',1412343938,86400,'',NULL),('bbptn3ka8e9uiq1j9ch7li7730',1409133459,86400,'',NULL),('bc08imvetqcdht8os1h1tfqc22',1408537556,86400,'',NULL),('bcds942ildva7p4vfejvmk2bt5',1409694428,86400,'',NULL),('bclhru6bnhfp8lbr3tku04ug44',1410902532,86400,'',NULL),('bd3qslfkghvf9gg9dtljs9inm0',1410654268,86400,'',NULL),('bdhbalulr16scapo157v58og36',1409729039,86400,'',NULL),('bduqppkemcc7r5h38ia439gj14',1412174021,86400,'',NULL),('bf52lc16gidno959fohhdu3na4',1412764601,86400,'',NULL),('bgcra3jffqp56o391do6aop0m7',1409737494,86400,'',NULL),('bgk4rfi3im46ggve2crkb6t3n7',1409129648,86400,'',NULL),('biij8n80rv7plhhpui1uihp7k0',1411073784,86400,'',NULL),('bio9dchmvk51568j45j539q7o0',1409728438,86400,'',NULL),('bj131mv810bhm4r3n7gsu64g90',1412338266,86400,'',NULL),('bk8ndsgmdsn2g53a76ptsv5ns0',1412169931,86400,'',NULL),('bmv9v3mt6o76bh1qfb4i81qmr4',1409744788,86400,'',NULL),('bmvk66gqs9mootbe2vidtfacd0',1408542333,86400,'',NULL),('bpmrtrme4dg5iocfi462r11fh2',1409748809,86400,'',NULL),('bruifgi788ora0cbsltptlngg5',1409061147,86400,'',NULL),('bscgsn6lapa70k41ohef5imel6',1411072683,86400,'',NULL),('bsmo39rfnr5c5epv475n3ifq13',1412341638,86400,'',NULL),('bsorig57cn7a7pfj7fs64gqq84',1409063522,86400,'',NULL),('bsuj7bkbb12letnnb8fms19hl2',1409003715,86400,'',NULL),('bt02j4hf7lmrhg0feru43qo5b1',1409738934,86400,'',NULL),('budel74km4etus7cqm7ta69no2',1406130357,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"c75e445abde9b7261234f1f0d3989073\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"31\";twitter_lock|i:3;twitter_uid|b:0;',3),('bv31409mc7oc06hul26ieji7e7',1408540207,86400,'',NULL),('bvgbka2qfhgebsejev7j7pskq6',1406899981,86400,'',NULL),('c14ebjenqag53u6kfh456056u1',1410650729,86400,'',NULL),('c23r1s10n5fp9ircbf09k99a70',1407244785,86400,'',NULL),('c2ev0n0dnfqvn1s62d7d4fguc0',1409135316,86400,'',NULL),('c5plb1oi255585hk4m07lh9vm5',1409751872,86400,'',NULL),('c6l68lqpoafn6v6qk024sicoj0',1409671032,86400,'',NULL),('c6uldcr2280q3ghtddljug0lu1',1411148896,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"605c9f1aad129a355d4ca78dc5b92cd4\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:13;}login_id|s:3:\"107\";twitter_lock|i:13;',13),('c70h9f9tucrjt5bej76b7bqa94',1412956087,86400,'',NULL),('c7teu4ehtegd96qt9klf8isr72',1409695791,86400,'',NULL),('c8smqjimle5iav2io7hdp4se85',1409003714,1209600,'User_Plugin_Signup_Account|a:2:{s:6:\"active\";b:1;s:4:\"data\";N;}User_Plugin_Signup_Fields|a:1:{s:6:\"active\";b:1;}User_Plugin_Signup_Photo|a:1:{s:6:\"active\";b:1;}redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"6aa125698660396d7002ebeea52675bb\";}Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:2:\"60\";twitter_lock|i:7;twitter_uid|b:0;',7),('c91ncb15m60djifeg8l7l3hv92',1410650886,86400,'',NULL),('cbb1a1b7anhf3claspmsi1pi32',1412349987,86400,'',NULL),('ccjejo3f886p7vr5hi3i19v5m6',1407241153,86400,'',NULL),('cdkc1eg2knbg9imfq70rbcnoa2',1412169682,86400,'',NULL),('cdq6m8tm5i33fmkptjup228p01',1412884406,86400,'',NULL),('cdua65a6j1lhp2ongadm5njfl1',1411080820,86400,'',NULL),('ce8ssodeicuqdl2lujj66enab1',1410648456,86400,'',NULL),('celverht0nl0621pd8t45mcmi6',1410896599,86400,'',NULL),('cep99r3a2fd29r8pvj0km4jub1',1409003114,86400,'',NULL),('cet3eo9a02suq2k9cslte2mae0',1410995176,86400,'',NULL),('cf920ct2voufo1rvhc1qf26931',1409125360,86400,'',NULL),('cfk5eqtfb19k4kn28830en42b2',1412776844,86400,'',NULL),('ch3ihcr28d2k5aurvleuv48li3',1409699200,86400,'',NULL),('ch4s3g70tiph4lqpe6p80pfc95',1408996933,86400,'',NULL),('chn97slastdbp3g8m1itm11nl3',1412335596,86400,'',NULL),('cid9kqeujps4ra96da82rtv126',1408490372,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"538374fa212983b8fae036043f3ca5fa\";}Zend_Auth|a:1:{s:7:\"storage\";i:9;}twitter_lock|i:9;twitter_uid|b:0;',9),('ciellncoo3000063bmo8fn49u4',1409699560,86400,'',NULL),('cilm5tu6aqlpnhd8thkcd0a4i1',1406723521,86400,'ActivityFormToken|a:1:{s:5:\"token\";s:32:\"4fe3750e6ced2a74f1cd683fea43bfd6\";}',NULL),('cj0on1le7gulatc6cs71r026v1',1410736762,86400,'',NULL),('cj4j6a60dnausdvjmb5hfebmi1',1410649337,86400,'',NULL),('cj60bmnm52f6q8gf0avpgrk9b0',1409648054,86400,'',NULL),('cjeb1tdb3kdhmp3hp8cmgso0k1',1409740878,86400,'',NULL),('cjjtom2c96a4lg1t1sposd0ps7',1409695015,86400,'',NULL),('ckbb27ta7i3qsln81jprmqnv43',1412239322,86400,'',NULL),('ckuetc18cl8kj30ijssgkod9a3',1412335491,86400,'',NULL),('cl0db92ivvm033gp28l23j4ju4',1412342073,86400,'',NULL),('cl6pl29r2mfk6e1qn6j28r4v64',1409733479,86400,'',NULL),('clv57o2akfg4454pmopovpo4c2',1412783925,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"84dd079e9f45b04922bee78a6f332ec6\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:3:\"117\";twitter_lock|i:2;twitter_uid|b:0;',2),('co1aakrlejdgk4p6soloqfh3v2',1410992497,86400,'',NULL),('coeduuld4sc35gbg3c4ntne167',1412173659,86400,'',NULL),('cokmu4cq7qgcqvfk9s7ehg94u5',1406897901,86400,'',NULL),('cpmb4vvnq3c6bup8bklgjpjq60',1406896544,86400,'',NULL),('cq4295tesqmvd2bmlnte3smjc4',1408888177,86400,'',NULL),('cqaju12u2sld1pjin0m9bue5s0',1409746812,86400,'',NULL),('cqj3v8tv6q9v3703issgghg9s5',1412325367,86400,'',NULL),('cr1nd0734vbht27murt7t6v9j7',1406896727,86400,'',NULL),('crn66aqv2tjvbd1lj4e023iu57',1408565573,86400,'',NULL),('csums3mfnjthapil5najjsi361',1410739917,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"c91a7cc217d5bdcfbe9da96f216fb97d\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"96\";',1),('cvcraa995m602a4bsq047p30b6',1408573529,86400,'',NULL),('cve1ppl0gc3coeclgp4rbar102',1408527742,86400,'',NULL),('d06h0ggjcdro1pfsm0h9nclli7',1410904547,86400,'',NULL),('d0f8rcei2bsb9j890iekkcd007',1412777084,86400,'',NULL),('d1aqgj3totvrvlelpujmlttgb2',1408539263,86400,'',NULL),('d1g09772kmlu35p7j1je76s7e7',1409133047,86400,'',NULL),('d1j1v200g20jiu0cdo6u7oi8h0',1411076980,86400,'',NULL),('d1j85ai7041mjkb3igngjpuc02',1412339110,86400,'',NULL),('d1vkv86iasbail8br497ek8is5',1412259235,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"b74db90cfce26e0b922e10a2a79ee79c\";}Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:3:\"112\";twitter_lock|i:4;twitter_uid|b:0;',4),('d22ou575o3i8vi8ulc1bk608i5',1409651209,86400,'',NULL),('d2raep9a44vcvireabqgb341d7',1408572715,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"b5d77836c9b4768bb5a9664e3a080081\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"62\";twitter_lock|i:1;twitter_uid|b:0;',1),('d3ggtt61eg1mr6ssp8tsm6i1f7',1409749799,86400,'',NULL),('d3hbeabpo6c7tbs3ppm2mepbb4',1409134669,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"6955242d3dbebfb8032db66bd89a95d8\";}Zend_Auth|a:1:{s:7:\"storage\";i:6;}login_id|s:2:\"65\";twitter_lock|i:6;twitter_uid|b:0;',6),('d41g8i59q0fg1evmrafaf0p462',1409737358,86400,'',NULL),('d6kvbl3b6ognk086bvh3lsfsg5',1412692320,86400,'',NULL),('d6qjg3vkkqvesltehu72hfpn37',1412929447,86400,'',NULL),('d79h56s7q4clkjeja21qc5aee0',1406895054,86400,'',NULL),('d88nl7f533mva28lj2hs2kos75',1411080700,86400,'',NULL),('d95n66voeqd9qvfflv7b8789e3',1412865855,86400,'',NULL),('d9ikbgv2l786161tm2ibrfau35',1412688596,86400,'',NULL),('d9j0okjp72gj838jq3s1u48bc3',1409749011,86400,'',NULL),('d9oai61p7hql6lgc1v6vqre9j7',1408541029,86400,'',NULL),('dakkbupgd91kdt971mfi5snvu4',1412954763,86400,'',NULL),('dd64gg8nsur79la7h35uncquq0',1409739640,86400,'',NULL),('ddhlq3iajen0jtu59nhku5tve0',1409755054,86400,'',NULL),('dffo0scsiqjiff475uq0ktr5v3',1410654789,86400,'',NULL),('dfgikdu2877nhvcurlsspk98q7',1409745643,86400,'',NULL),('dgq6kfk2boleh7jcm4epcuqun1',1408490373,86400,'',NULL),('dgtfgf5pdh40nsnjclbv0q3f87',1412251674,86400,'',NULL),('dhjpu4teqatpvufh9q1cjt34n7',1408524564,86400,'',NULL),('dhpcd010cjpfr07r1d5gbrt8q1',1412584871,86400,'',NULL),('di8svjhnrr9g1q0a2k7ler9c45',1412589789,86400,'',NULL),('dih4jb97hj1c4ltf1mnr7l3251',1410902652,86400,'',NULL),('dj18o6nhqjkut53rp84fcsr0n4',1410654117,86400,'',NULL),('dja1ecq66cddubhuqq1g9kojn1',1409696425,86400,'',NULL),('djn8f8lijldkq5m2lkj6tot055',1409735299,86400,'',NULL),('dkckkjo766nuq3lnihu4oulu35',1412929883,86400,'',NULL),('dkmv33q3oggfnpnfpcbm24ppi0',1412251762,86400,'',NULL),('dlju86535th62j6fduc9pdcn07',1410651812,86400,'',NULL),('dlmopefs7ssno26d6j0fl5tsv1',1409064002,86400,'',NULL),('dlvkap96tucq9ij36luiri8fr0',1409125600,86400,'',NULL),('dmdkg0lpakp55fb0cb137g4qi5',1409127760,86400,'',NULL),('dmiu65hcnj6nsmmln3ctdg7d66',1409730617,86400,'',NULL),('do6q7ehigo4l287ipevuip8in7',1410993668,86400,'',NULL),('dp02dmhcjasmu30ai7ps0vc3t2',1411109346,86400,'',NULL),('dp3ld3cbl8uaunnrqst5591r15',1410737013,86400,'',NULL),('dpdmb7snj0amie439vnssia1d5',1412764240,86400,'',NULL),('dpn10v109a1ga8q0k1s7i203r0',1410738788,86400,'',NULL),('drfcsdk5ab53tuu8nvpmved074',1410995546,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"ae8241f7ee100b876c96489ced2d068a\";}Zend_Auth|a:1:{s:7:\"storage\";i:13;}twitter_lock|i:13;twitter_uid|b:0;',13),('drfrg0e5suqgaqrkefin84lfp2',1408524178,86400,'',NULL),('ds6clapj4ppq3t9s64b8n00na2',1412339351,86400,'',NULL),('dsdjr227s81gp5m15lntvkn0j2',1408989132,86400,'',NULL),('dt1il72i1b3pgqu724l7tb5rb4',1414587150,86400,'',NULL),('dt61j8jb5jgftm38ikld6f3t74',1412692563,86400,'',NULL),('dttose1799m5017pcvt2sbr1q7',1409062863,86400,'',NULL),('du11dv865981kusqhsqin6d7p5',1412332619,86400,'',NULL),('dvlfns5nocmqs2ncadktfp0hr3',1409739277,86400,'',NULL),('e0moduqqpj310qiaa023lrouq6',1410655509,86400,'',NULL),('e2q057b29ft1i6sqit5i4a40t1',1412584750,86400,'',NULL),('e4896s62vjg57cqh7k5ito4ok6',1410994840,86400,'',NULL),('e4esjofpleqdffdvafr61dvqt2',1412783085,86400,'',NULL),('e57p1ong5k5mjjbo8i489vjud2',1409760354,86400,'',NULL),('e5cdi6bn50oerd82snsvn27r65',1411500078,86400,'',NULL),('e5q5cltvf6qa4ci4hlt50lqbv6',1409739789,86400,'',NULL),('e62t1qfg3qfc38rvi34r70ecg6',1408891363,86400,'',NULL),('e6755v0420mhe7ko3m5qvigjf7',1409127279,86400,'',NULL),('e6pdv8j5232vujh2et45bsokp0',1409734339,86400,'',NULL),('ecb69ohoapuor5eq61acvsfiv3',1407235237,86400,'',NULL),('ecj64d9ep1rjdvkgb97epeqbu1',1412261943,86400,'',NULL),('ecv5p3hfj2edcq0cm1uf4g1380',1410898268,86400,'',NULL),('efaonogkqfsm9eqta10scu7o40',1410649627,86400,'',NULL),('efs5n33evs7ngontkjqr25ndf3',1410990276,86400,'',NULL),('egl4n2pfed5khrnn0s7nekidi0',1406895631,86400,'',NULL),('ehtb61kjgkkin0a62mk7tqnue1',1412594885,86400,'',NULL),('ejqqj1mlo6ikf8t1128kfcpvv2',1409761945,86400,'',NULL),('ek0dv97e2137rdeh1lf4d7gtl3',1409739580,86400,'',NULL),('ek2i2pt8h68s23g8sjk1dtfeo0',1412674784,86400,'',NULL),('ekd0sq86ncudau0gs7g3j8rtu5',1409732139,86400,'',NULL),('ekdivcck24d07fnor3e6523816',1410738197,86400,'',NULL),('elfnj4f61p2ptbdu5rl2peon80',1411500559,86400,'',NULL),('emcva6qont7j30jcv4u6clhr14',1408368141,86400,'',NULL),('eo1pt25gnihvjj1498750lacv4',1409061636,86400,'',NULL),('epai4etg3pp7r5jub2ppdrvlf5',1412338133,86400,'',NULL),('er8jm1nq8frmcoflfs9u32jj72',1408535262,86400,'',NULL),('et2ur3cg5e2r83vjnqvlkpu2k7',1412596755,86400,'',NULL),('eusnfmp4se9nu6nppaqcodef94',1408274493,86400,'',NULL),('evfq9jefmhih10jal12gbg37k6',1412929566,86400,'ActivityFormToken|a:1:{s:5:\"token\";s:32:\"5cd004c851242388d1c8b92f2115364c\";}',NULL),('f06fmkn3kr4m5v5gffn4agf1o7',1412342250,86400,'',NULL),('f09v9sl0hd0md763pfqov2am42',1409696673,86400,'',NULL),('f0bc9h3lkn683iev24qbscee90',1412685951,86400,'',NULL),('f0la2vimruaa0fqkp9v4nsaag4',1411140071,86400,'',NULL),('f11bobtlillup9rmfpserfiul7',1405348081,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"6cd4c9cca786cbc54bc8d976a62fa7c3\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"25\";twitter_lock|i:3;twitter_uid|b:0;',3),('f12g779e41orlh4cnc1mk1r4q7',1408570630,86400,'',NULL),('f2r68rtp208npbn2o4497l1ai4',1408539623,86400,'',NULL),('f2ttlm452r4tgjh0noep0k5nr7',1409739914,86400,'',NULL),('f3l447cjf5vg6nk0av3qll4up0',1412349900,86400,'',NULL),('f4c0o19b5uolj1nss6sclt2ud7',1410902147,86400,'',NULL),('f4mlg6b1odlte0868u6odr2si6',1408565912,86400,'',NULL),('f4shu6lu1n5loqvbcuhqqu17u5',1412764480,86400,'',NULL),('f50qpm7mnhlkv6f0l1v9d9sqo2',1412584509,86400,'',NULL),('f5fo1jcui7d21qi7j2t1qrpi82',1408527139,86400,'',NULL),('f5fv0qlkbpn28ahbqlu5gnmd30',1412342343,86400,'',NULL),('f5sa4a2c7a3p5ek4q44eanfc87',1409740637,86400,'',NULL),('f5vhl55vvi57nm41ktueq7uli5',1410737165,86400,'',NULL),('f76aj44atsreq9qvfu21v68t00',1410901787,86400,'',NULL),('f7mio04be50i29fn7ih3blsg00',1412255222,86400,'',NULL),('f7pu884t8rksm2tihbs6skqgu6',1409730692,86400,'',NULL),('f7v8sd73q7s5qbpq87r2j7v945',1411074336,86400,'',NULL),('f9l4c5ftcqk0qgn8743lnn7484',1405011967,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"341d9478f41d00223960c70c1dca3d55\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"20\";twitter_lock|i:3;twitter_uid|b:0;',3),('fabio6ekg3samc8ailvu3pc1l3',1406901026,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"b35022250c002407a0c58df9db13fed5\";}Zend_Auth|a:1:{s:7:\"storage\";i:5;}login_id|s:2:\"44\";twitter_lock|i:5;twitter_uid|b:0;',5),('fao71ol6f9sochcqp13rn3m4l5',1412260600,86400,'',NULL),('fblqp0cdd3oh5kvb60mmv3inq0',1410652129,86400,'',NULL),('fd7ive8krhhkk71tvsbndkfto6',1412760995,86400,'',NULL),('felf7se3hbtcuamt8l17gebu41',1408565975,86400,'',NULL),('feshi9i23leb8rb2ue3ttt7c16',1412335111,86400,'',NULL),('ff0a2ndg4iki4bfm43bu9j7in6',1409129021,86400,'',NULL),('ffgd2fkobap9lnrc9jh91l4te6',1411109226,86400,'',NULL),('fg6tsdfl2mfmursdtbevi44gb4',1408489923,86400,'',NULL),('fi2crq20au5o4ib5h6jqgv55p3',1412334905,86400,'',NULL),('fi7mpn64047jddplbiggcvoep1',1410738123,86400,'',NULL),('fjd25qsr5p7tge5vdgn30ts892',1409733101,86400,'',NULL),('fjk7g6ptkhejemkc3ichls6q15',1412255343,86400,'',NULL),('fkb1t41b03tjajcltjokibjgf1',1411140910,86400,'',NULL),('fkj8jjfrf9edtjd76ubg59agi2',1409130467,86400,'',NULL),('fl38k1e48vqqmusricdnp6n1n0',1408893615,86400,'',NULL),('fl3r111gp4sdiuiva8icgs7k96',1408566323,86400,'',NULL),('fm7vvks4ag5gmd4013cft9i2t4',1412590029,86400,'',NULL),('fmidcvi6bikmhfi3hgmsdfeep7',1408570445,86400,'',NULL),('fnurkjbiih7vfeqivcqvvm0nh7',1409699320,86400,'',NULL),('fo3bf83c3en9m1nccrtjhcil62',1408541301,86400,'',NULL),('fppeij0b7i87hhhnpjuikl4sb0',1409733954,86400,'',NULL),('fptcak0ined13shvserks03fi0',1406899760,86400,'',NULL),('fr3l47kspmod39n22et41sqgm5',1410896460,86400,'',NULL),('fsgi5amnrjuq3n6o5pvcdv8k21',1412343322,86400,'',NULL),('fsm1t6h9u9st27g3k4guf280f2',1410736552,86400,'',NULL),('fu2vttvhnct0u6fet0a7k7ojn3',1410994600,86400,'',NULL),('fud8qv0pfcutm97egu7296rd22',1410901907,86400,'',NULL),('futkr2j17a3ld31g8obt57je10',1408542125,86400,'',NULL),('fv1foagihs3ut2ui2nqj08d0v2',1408537436,86400,'',NULL),('g0laaneogrsicbcbh9oni1ove6',1412335980,86400,'',NULL),('g0qsp77t3qqlqr0cigl69kh373',1408523731,86400,'',NULL),('g2k1ugpr1h7pg3nb7t0k4lomo1',1412688476,86400,'',NULL),('g2lh1j17e6h7lto2r7ptn1amo2',1409747872,86400,'',NULL),('g3t05c9uf10tfho8lbom3fp6a0',1406898123,86400,'',NULL),('g53i32gikju6qivgote4s6cpb3',1412930123,86400,'ActivityFormToken|a:1:{s:5:\"token\";s:32:\"70aa9907e918f4f290c9a43cf7495dc2\";}redirectURL|s:1:\"/\";',NULL),('g5rqshrbsnf2vj06v5253ka683',1409134957,86400,'',NULL),('g63l3bv7k09ct2dfirjdhbde04',1408569496,86400,'',NULL),('g7e56n8806sus5lfs3mro0hu90',1409740180,86400,'',NULL),('g9elkds5681oc85aupf1cntfl6',1408540742,86400,'',NULL),('gciaab0n9ceqau6fvosfgu7ls1',1411071196,86400,'',NULL),('gcl0nu4k2ugboaifvlm8c8qqr6',1408543651,86400,'',NULL),('gcpba4bartcfb4cf7ibcrat7b4',1409748637,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"bb146a4575e02b7da2c04373bb4c1c17\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"82\";twitter_lock|i:3;',3),('gd841j3dr7pp81leu564ltir33',1408527622,86400,'',NULL),('gd9k7tgm8i65l183hrm1sjrsf0',1409136876,86400,'',NULL),('ge5as078mfp2ubrb7f4acp4so0',1410651561,86400,'',NULL),('gf202suq852h2n6ve4on314jh6',1408571426,86400,'',NULL),('gfe3d3ibcggsp8ln0rq6iejh25',1407260744,86400,'',NULL),('ggr6sht888ug18m1s55l280k31',1409746637,86400,'',NULL),('gie9idooumm8n3gqemc6qq4db7',1411499598,86400,'',NULL),('gima86ib8clpnfv3k9rd3uutp4',1412885488,86400,'',NULL),('gin0ab5ft0eal1s4qbrul88583',1409660809,86400,'',NULL),('ginl0s44kahbkqgac6sc1714a2',1411340904,86400,'',NULL),('ginlnagg64nn6ndf64bvl900h5',1410654530,86400,'',NULL),('gint4hqlnhtick9irmlvpt5ep5',1408526728,86400,'',NULL),('gitmln6ih9r8btl9i5or0iiq60',1412885727,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"baae45de7bce2f284821cd0e6c05ac5e\";}Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"120\";twitter_lock|i:7;twitter_uid|b:0;',7),('gjnsva7knqdl5dhi9kn61qs7u0',1408574761,86400,'',NULL),('gjteb00fd6u3tga45ge61ete85',1409059378,86400,'',NULL),('gkbkg74g1re4ohdmgq5tjbtmp4',1410896324,86400,'',NULL),('gktaih33n0r7jf16f2a4q5ps90',1410993852,86400,'',NULL),('glmivjnjud1udp27sks6ber9u0',1410905627,86400,'',NULL),('gmnn6idr45t58qhk0j6k4s0310',1406896059,86400,'',NULL),('gosqddh3hkhlektshf52ag29k1',1412867858,86400,'ActivityFormToken|a:1:{s:5:\"token\";s:32:\"230ed80a1c543f7c30e4c38e235980fa\";}',NULL),('gp2o0mgbvg8qbtbk62rt62vot3',1408524796,86400,'',NULL),('gpfpflbcs5a38m03n5qb2aqoc4',1408893496,86400,'',NULL),('gqn5s18e8pv8pepe7cg78fq5i6',1411072885,86400,'',NULL),('gr45kjp3uuilu7apb71c9o4as4',1409736611,86400,'',NULL),('gr7supc9tle67o2ldp39jphvl2',1409745906,86400,'',NULL),('grfadfj40u4kn1cbdf29ivikk6',1412341759,86400,'',NULL),('gsnbcq0pdgchr7jaig9e52k6k0',1406894370,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"20981430e9d39486588f3976b9506819\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"35\";twitter_lock|i:1;twitter_uid|b:0;',1),('gtterr6bkg6cv0df6j48702347',1409696198,86400,'',NULL),('gucogp9v1vvfm30sui2hoj6io7',1410651690,86400,'',NULL),('gugfd7l5ic8ogbu7bf7j1f97l6',1412694130,86400,'',NULL),('gvp9unu0umoj9eao8osgaq9gg4',1408571595,86400,'',NULL),('gvvkukhpg6bgl2mqh8bu32dku2',1411139830,86400,'',NULL),('h0609tgjt5123tdsl9gucjadc0',1408989252,86400,'',NULL),('h07h09ugmalir3csabmkp50tf6',1412865654,86400,'',NULL),('h0e6gipvics4h1dqclj5an0863',1410898128,86400,'',NULL),('h0mrln0o4lhjpeibeoab0jd876',1408539503,86400,'',NULL),('h1r63d7gnvobbu8kqgm54kn815',1412769050,86400,'',NULL),('h1u6jtsvr0rgfq6pmski28g023',1409753251,86400,'',NULL),('h1vbooscejncgho49og9664vh0',1412337367,86400,'',NULL),('h3jjq3keehqralavpchm4a06t3',1410736484,86400,'',NULL),('h4g83mkveoflv5dvpm2jn0dul1',1408575094,86400,'',NULL),('h5fem8jhfvi2e350na0vj0o9b3',1409737944,86400,'',NULL),('h5n6daet1in7t3sihb73hof9v0',1412251031,86400,'',NULL),('h5o4fhs6jsr2kgspasuk844mh6',1408543169,86400,'',NULL),('h636gv8d2dqcgs23ljargch446',1412785809,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"d859926f087938b283216d1a295d82e6\";}Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:3:\"116\";twitter_lock|i:4;twitter_uid|b:0;',4),('h6lpn8rk73sejucbagloek1s05',1410899068,86400,'',NULL),('h769n9k97c027q4lvh89ncdir2',1412171498,86400,'',NULL),('h7mio99teqc12jg0bvcb82fr05',1404213305,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"aa65b0ad2743c49a9bc3fec87c6b8c67\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:1:\"8\";twitter_lock|i:1;twitter_uid|b:0;',1),('h7ucqkeh20f8msdeplcsib82h5',1408565014,86400,'',NULL),('h7vjhktfndmk1spurptdb7heq5',1409134836,86400,'',NULL),('h8iqtc1q6bslb0iu4ppbrpgk74',1409061536,86400,'',NULL),('h8ughsecbt8il90he81gveto45',1406896967,86400,'',NULL),('h9asp3bmlbreokh5fq08rrjfh7',1412885609,86400,'',NULL),('ha247fk3p6smhi1d42gtpl44g4',1409064483,86400,'',NULL),('haljasm6d5uhtu0b62h1une5i3',1409745972,86400,'',NULL),('hc1b8bbk96p1l13ke2ld5uqsq6',1410650022,86400,'',NULL),('hcpdovd2cgo0cvb1rfqcu2a4q6',1406900805,86400,'',NULL),('hdgtdk0nnce85dbs2e1foglq95',1406823674,86400,'redirectURL|s:27:\"/classes/edit/3/ref/profile\";',NULL),('he8bhb4qqit176kcdpgdm8m8c3',1409736730,86400,'',NULL),('hek4j1bqaue1r61e4fp7s6ktr5',1409063763,86400,'',NULL),('hg8cdjk4bfek0lppggcc481us6',1408524864,86400,'',NULL),('hgag32tv7ese9mpafpdu8ukij4',1407240913,86400,'',NULL),('hgibic4uudfvgld5nbtuab59h7',1412344127,86400,'',NULL),('hh0b59il0n5eipe46faftunab5',1410736944,86400,'',NULL),('hihur82s0f1pjdjoalbtgqe922',1409743065,86400,'',NULL),('hj6kc4edrsbqv5i2v2134iqq22',1408523672,86400,'',NULL),('hjbo6g3p9lgglhlf15gl61nn27',1409125239,86400,'',NULL),('hjf2eokiohmkf4nvoedbinnb87',1408884936,86400,'',NULL),('hk1pk913cuhk8epbhiv6tcdho0',1406899827,86400,'',NULL),('hkh9s3jej973fuu3qinnvir9u2',1411079620,86400,'',NULL),('hlcme9n7718eelssqnmh1do0d6',1406900905,86400,'',NULL),('hlu7dr2jesgf6514lstohh1nr7',1410651881,86400,'',NULL),('hm0r4nvc0lkoa8q6l42sph60g2',1406898386,86400,'',NULL),('hm9s9lnqtjr2r0nbh655ekh1t5',1408891002,86400,'',NULL),('hmslon5ahpq2tlhir0kn7ecoa5',1412340714,86400,'',NULL),('hn7vqgl28r6t0mg8devuf2m601',1412336189,86400,'',NULL),('hnba8barn5ophdeiukg5hvfhg4',1412693286,86400,'',NULL),('hoaffpihm4ggos8108o7ukdsk1',1409687282,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"99894b68d34946232085b4d220538c51\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"68\";twitter_lock|i:1;twitter_uid|b:0;',1),('hqa0u4jepm186mu8nk7fcbvb27',1412685831,86400,'',NULL),('hqimrieab47a1nbmft0esosvh1',1410898862,86400,'',NULL),('ht28tt543eu26iu78qirc7sm16',1403267265,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"dabaa8d60c623a41350a06930220973d\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:1:\"1\";twitter_lock|i:1;twitter_uid|b:0;',1),('hug39c86lu18hva57bsa1rai86',1406898025,86400,'',NULL),('hvbo4ect18ulb4hrriuhk6nb33',1404301362,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"8e6a694cf80e5ee59d9a701594fe7d56\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"14\";twitter_lock|i:1;twitter_uid|b:0;',1),('hvg5g9k1egcco5i947vooitmd2',1408543530,86400,'',NULL),('hvub3e3fqrehep4r4ffnp4a717',1412885248,86400,'',NULL),('i0aqn0qi7dpalc1psuprpurqj2',1409061275,86400,'',NULL),('i0p10mrp041197rnso2gvjtsr1',1409732077,86400,'',NULL),('i0p9unms2vbhuodpunn5drhft6',1409134670,86400,'',NULL),('i26gstnppvjiom1kvl56d4ho61',1408274788,86400,'',NULL),('i2uspbe33v5gadliombhsjn793',1409751033,86400,'',NULL),('i4092cpl5f0ijeci280vnv06f2',1412239080,86400,'',NULL),('i55tai4qid8u7unnpr7j348ct4',1407274922,86400,'',NULL),('i69n4it8938c306gulud1n5a62',1411140311,86400,'',NULL),('i6kie0d5d833c65ogfbc238jc0',1412239201,86400,'',NULL),('i6s8vmjn3n2b8geg5g2p1geip1',1408885058,86400,'',NULL),('i7apirojj4q3j8lk2oe0uq3mb0',1409749219,86400,'',NULL),('i7el2sngl0qepf54u7sorccq64',1408570509,86400,'',NULL),('i8brkqbj950hrjtuhedpd20m35',1409133734,86400,'',NULL),('i8hhguluf7tqsq68s57jm9am55',1408889857,86400,'',NULL),('i96af5ge6ofa7v017uautijmv5',1410652882,86400,'',NULL),('ia8pfhet1lq0mgmqm48maei4b0',1410652517,86400,'',NULL),('ib08pofgsg9eu6phhr4alfb3j2',1407240587,86400,'',NULL),('ibk1ltblduasej7pvf18bh6v55',1408573169,86400,'',NULL),('icnivrmh76tu5djlfroig0fbr2',1409750566,86400,'',NULL),('icrb73qtvh7bl60qirnp4imho2',1409696547,86400,'',NULL),('id1pfsrvoep82bfs9sbhg10k42',1412954523,86400,'',NULL),('idflap0fm1tajp49pqk2puod03',1409747316,86400,'',NULL),('idqq2lek96kmtt4hkoj6lmsqu3',1409660929,86400,'',NULL),('idv5jsvc9nktib7325jbap6m12',1412758109,86400,'',NULL),('idva4ipqeivp2tmetqn1oiokt3',1409136757,86400,'',NULL),('if59ksc1jfeej8qdlkpm44klo2',1410991879,86400,'',NULL),('igms3fp1o757tkssmcqhl99hi1',1409062668,86400,'',NULL),('igoeg2sudvid2f8rhesneoffg2',1410901570,86400,'',NULL),('ihc3cnl45p98uasl0ok74locq6',1412259988,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7fd370541b2bd41d775b50448d13b9ca\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:3:\"110\";twitter_lock|i:3;twitter_uid|b:0;',3),('ihlmb6n3rt10lqn1oh3obdpf34',1410652751,86400,'',NULL),('iiemf52kerq6qilv331seeedt4',1409064842,86400,'',NULL),('iigcn4sc4b1arlvldh7k07oih0',1409734165,86400,'',NULL),('ij0vtup0e3ljmd21unkcq4mu91',1412173901,86400,'',NULL),('ijamd2df2nbbu1tn1a08s8k8e0',1412589516,86400,'',NULL),('ilhekcknlfmgq360ljiq6863l0',1409650759,86400,'',NULL),('imkgh8qru3i8tc1vjvrohjnam0',1408489803,86400,'',NULL),('imv5r067jbcg32646b0hghk7m3',1408540865,86400,'',NULL),('in1i5q9a8u9c8s7ln3t2f22ob0',1410995535,86400,'',NULL),('infc9hk8992ln4ih27esv2le37',1410995056,86400,'',NULL),('inm7g7qcgvat0d2k0ifercrpv5',1408488510,86400,'',NULL),('io8njgh0lermgontg3ssijjne6',1409064242,86400,'',NULL),('ip28vl2dv3so5ma40mrd9am436',1408540271,86400,'',NULL),('iqinfgsugskj8gklf8aicto9s2',1412343562,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"937baa14aee494fa2ecba25f0f985eb2\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:3:\"114\";twitter_lock|i:2;twitter_uid|b:0;',2),('iqomg2u5jdb5r8ee0iu70lov60',1406899886,86400,'',NULL),('ir48hdu684ilqnmcrj3alkhp56',1409744291,86400,'',NULL),('iri1kd84q3quqi6j1c29eciiv7',1409059550,86400,'',NULL),('is8bfp9aboh4ra5soos9nbrjp0',1410992137,86400,'',NULL),('it2sqfl6792a4oh1clpqdnhct0',1409741091,86400,'',NULL),('iv2jskcd0da4dg1sqs6aeo6gr6',1408607880,86400,'',NULL),('iveqrnd51nksrv7ju7cdnkfrs0',1411139951,86400,'',NULL),('ivotl43bdgvdtfo8u5378tkaj4',1409747527,86400,'',NULL),('j0ttdp9765b6igjad0hv1p3s23',1412340916,86400,'',NULL),('j1a2k8846s3naho2et6a1k44j0',1409745274,86400,'',NULL),('j1khkmn8bj9n9rj3kc2j9ktfp6',1410897200,86400,'',NULL),('j1r12o8qthbhnj4oe6v693h2e0',1404208186,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"e928006859aae14b70acf464b1a811fb\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"12\";twitter_lock|i:3;twitter_uid|b:0;',3),('j2b47eeosldf3fa4ftjdpnqif7',1409739728,86400,'',NULL),('j3odua6296468fcfj3726siud5',1412254382,86400,'',NULL),('j4adra5imbr25sdp5ql8a308p3',1410899387,86400,'',NULL),('j4g2hfnt8rqset34bji5k96863',1410739737,86400,'',NULL),('j4lj5gmjstamvp65gm581t6cb2',1409129973,86400,'',NULL),('j6vseetmerfi6vsootr3uhosr1',1415139842,86400,'redirectURL|s:22:\"/?en4_maint_code=z7b9h\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"d188bd7ed8be99cc4052f3e6b3f2f230\";}',NULL),('j731lskva1ca9vshhf92qn37g1',1406895336,86400,'',NULL),('j74p76gtevgbu4ghhbatkbf0t7',1412332233,86400,'',NULL),('j7jh0g0dbfcme7rbr25ie2nm72',1408571504,86400,'',NULL),('j8f757n33duj0mmjm8oe164kc7',1412761477,86400,'',NULL),('j8q4uic50bqh89fi88mi0k3qq7',1412255584,86400,'',NULL),('jat0nh15r977874tu4sci4fe40',1410991679,86400,'',NULL),('jcnbvb769sf87m4ekg784em9m7',1407248319,86400,'',NULL),('jctrr6d9k0clvsbiihold18fe0',1408542726,86400,'',NULL),('jd5f67r1nn92oqsl2qa5r1ovr5',1407271609,86400,'',NULL),('jegv6fn0ob141bp9o7f58pq824',1412867416,86400,'',NULL),('jf610ag11tq8qfg7f7kf3ac6u3',1409132626,86400,'',NULL),('jfbkf9buitqval175fm7u9j8i1',1410738928,86400,'',NULL),('jfk88qvrmtf0nhbr5887s0un74',1410646020,86400,'',NULL),('jioh23th1dnf0vjjr251e0p9m6',1412335838,86400,'',NULL),('jjbmahtr447mj8piktornbst01',1410739054,86400,'',NULL),('jjcm6fup7ma34k1vsdt61ujuk5',1412344608,86400,'',NULL),('jjg2tl7enmhvv9hdost1k9rlu6',1408999154,86400,'',NULL),('jji7sue9el3bls573032vc7co4',1410989452,86400,'',NULL),('jjv293ci0dl3k94bslooor45a5',1409746938,86400,'',NULL),('jkdr1i07ik7jtlc9099dmme1f7',1410735635,86400,'',NULL),('jke8cgbqp5q53rmajci9tmlg82',1409745846,86400,'',NULL),('jkpvncso11ltu91bnq0rsbr2h0',1409129202,86400,'',NULL),('jlmagi95j2g0lh460n38ob3jk2',1409695360,86400,'',NULL),('jmauddinafc84aufmnism633d7',1412692080,86400,'',NULL),('jmbitbe0u20nmrehg6nvhkb0q6',1412170053,86400,'',NULL),('jn0cv1i7uflm7jfa1ja1e0p3s5',1410646530,86400,'',NULL),('jqj3ksp50ub4t4osahmvppcar2',1411148412,86400,'',NULL),('jqrsdmvffivhdqau5sn27ntdj1',1409740113,86400,'',NULL),('jr53sn8j3m69b6brhodurcitt0',1412884285,86400,'',NULL),('jr6d0hath1mpjjre6neftgtv05',1409748324,86400,'',NULL),('jr9qv319jfh2t0ci6q7n56jg33',1408890856,86400,'',NULL),('jra4e38qus652380vrc0tpt2t2',1409729360,86400,'',NULL),('js6mcauitu92rdrvgvc9uqr2e1',1408576327,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"dd45c2c9b0bc6f1bcfc0c1908f4ee092\";}Zend_Auth|a:1:{s:7:\"storage\";i:8;}login_id|s:2:\"61\";twitter_lock|i:8;twitter_uid|b:0;',8),('jsqq2sviklvkn7anqvo2tv3kc0',1412865142,86400,'',NULL),('jtnvo3uj393lkokih0bd0u21c1',1409754933,86400,'',NULL),('junt7ak5vpt26rvhs47u7dlmd2',1406130298,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"31ebd7e11ad5e383468cc6e42c4ecce4\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"33\";twitter_lock|i:3;twitter_uid|b:0;',3),('juo4puonnn9bvjakoge86ass20',1407261262,86400,'',NULL),('jv1dv73jqg2n3fpm92bivaou90',1409697400,86400,'',NULL),('jv2co5rh2hlf6cdr9trl86h0e7',1410900107,86400,'',NULL),('jv8jc2sik9ms7hi9r4khkpkuo6',1412775769,86400,'',NULL),('jvpqjhvtuppfrupmgiog1minv2',1408268571,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"e2f318c7db4d77dae9c7c715f290dd6d\";}Zend_Auth|a:1:{s:7:\"storage\";i:7;}twitter_lock|i:7;twitter_uid|b:0;',7),('k0f7ejtqci8bb1lka9u7ldeks4',1408275789,86400,'',NULL),('k0kajsa8qsm8rpkh8jlpforpj4',1409697020,86400,'',NULL),('k0vq1h975gvomhucrrjs8cbko0',1412324255,86400,'',NULL),('k2ibqq8omvgo12hujg42b0c1q1',1409134066,86400,'',NULL),('k2j2gack368oacq855m5mf8l71',1412761236,86400,'',NULL),('k2ql6himn7f9oa6iv592avvc36',1408535181,86400,'',NULL),('k3hb84pvrd5r7ibcctullelit3',1409744549,86400,'',NULL),('k3rr09560rh6ic0tp0cll1hre2',1410650636,86400,'',NULL),('k43pdfj47agvnp3to6o8b8l9m0',1408565513,86400,'',NULL),('k4i2fve8n60tabasn4o6rcsva7',1409703159,86400,'',NULL),('k5emmmve7jl3ueersb4e9id672',1411074698,86400,'',NULL),('k5h34m262tfguhc64gl57lkff7',1409003355,86400,'',NULL),('k5rq9vkp4g035mvc67nae31cr2',1412866495,86400,'',NULL),('k60i63g8p4b9q9ro74optvcu71',1410652195,86400,'',NULL),('k6po6v2s6v9do5ld368gqhl7c1',1410737432,86400,'',NULL),('k75v5cjugh0n3jt84l8dskajg5',1409733612,86400,'',NULL),('k8buikjj77e7quu6b2dl6nup51',1408535061,86400,'',NULL),('k8sijjobbrjvdl1d0bvojp9om3',1409695490,86400,'',NULL),('k9pd7062n62mtuv0nnpotcn550',1409670909,86400,'',NULL),('kb519qg15cmboggs46i5nl4nh1',1412343201,86400,'',NULL),('kbfm3lv2srtuhenq53lqspr6t2',1408575215,86400,'',NULL),('kbmeb8ji3oke19e52bov9sh1n5',1406897680,86400,'',NULL),('kbr5m2l4noea8cadgac3s46791',1412782964,86400,'',NULL),('kcg760qrpf0u6q464b8sduvlk2',1410651342,86400,'',NULL),('kdr2ks1aagt552ah338usl0674',1410648740,86400,'',NULL),('kfj835hl1gn7n8fdiolaamo876',1408570875,86400,'',NULL),('kgkm08i2298ohqbe32r00ksbs3',1410899447,86400,'',NULL),('khf8ofqrmaulmb0f5p8j73qot4',1408565345,86400,'',NULL),('khvh3hnq3h7gkhm63v4e1vvmp6',1412694371,86400,'',NULL),('kil81f633kh9vihiie0soe3cj0',1412595128,86400,'',NULL),('kjlkn1mvgjvtdjpjt7est3cpv1',1409130294,86400,'',NULL),('kjmnjlj5k6an0f2nirj1ev0di4',1410990820,86400,'',NULL),('kjph0nh0d60qe76058do4kkjg0',1408996813,86400,'',NULL),('kk82mato73jg8o294i8qj08n13',1412342373,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"206eefc3f19a4718a0a476b171832c50\";}Zend_Auth|a:1:{s:7:\"storage\";i:4;}login_id|s:3:\"113\";twitter_lock|i:4;twitter_uid|b:0;',4),('kko7bo6dttbcgso89rp5uvrum6',1408576290,86400,'',NULL),('kl6865qroeojepu5n4smdsjo13',1409751724,86400,'',NULL),('kmcd4c6nshsrhelms15o3m02h4',1409670786,86400,'',NULL),('kn2vbinl6dirp8qm6qukagddb5',1412253918,86400,'',NULL),('ksnr49d5fbtgl4m70fvcgjuji0',1412693406,86400,'',NULL),('ktuqbue9136l6vu69qte1pgp65',1408274990,86400,'',NULL),('ku47t93vcga6umrmdtf71tch41',1412171618,86400,'',NULL),('l0fljvb9dnpmmehegi8kfs72b2',1411342716,86400,'',NULL),('l1vlkh5aag7s930dshld3pd147',1409062802,86400,'',NULL),('l29vpsgbd653v1fh938u4coeg1',1408571835,86400,'',NULL),('l2omuntjt4efdkf10dninr20n0',1409661108,86400,'',NULL),('l3jct862sa71t2bonq0h9ilq07',1408534701,86400,'',NULL),('l56439ns7uirlv77fupksfefo5',1408997173,86400,'',NULL),('l5rpn57ejurqv707kr292vanr4',1408525519,86400,'',NULL),('l6sphrs1t29uvi96401db670b3',1410990637,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"b60b8f791f14fd2aaf9b54dcaf30acee\";}Zend_Auth|a:1:{s:7:\"storage\";i:8;}login_id|s:3:\"103\";twitter_lock|i:8;twitter_uid|b:0;',8),('l782o3eojlc4g5fo35kjbb1hu0',1412258102,86400,'',NULL),('l7cfujp7dd2j56o4rhom92top2',1409132926,86400,'',NULL),('l7vplt7sjq3uu1dposi431i9p2',1410737918,86400,'',NULL),('laiar7pi9o99re2ph2unelpr82',1410648849,86400,'',NULL),('larmlu97vlqe33o8ojih1ji2b0',1406742064,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"1b4723e64af42559ed65dea6f46dcb18\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"34\";twitter_lock|i:1;twitter_uid|b:0;',1),('lc2om2pf9fpja20tjl94an4s25',1410656053,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"a9f5bd2a4fcd4f09c88ab8e8a2fa563f\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:9;}login_id|s:2:\"89\";twitter_lock|i:9;',9),('ld2ujq7hhvispp02nv695r31q4',1407234878,86400,'',NULL),('lebgja6m4k3uq4pjmmea6j1qq6',1409732634,86400,'',NULL),('lee00iadit9n0ek130st11qj64',1410653372,86400,'',NULL),('lefdhabalhmgiusal8fis8gkn5',1408565634,86400,'',NULL),('lf7nrb4qo63f33t7s7cf1p6r92',1412867856,86400,'',NULL),('lfrn6b3pqjds7fsdgbe91dhl40',1410904667,86400,'',NULL),('lg5c77vkhn9i9teairo7af0nr1',1410990396,86400,'',NULL),('lgd83q4f3ilh5ia4g3ru72tdp5',1412337202,86400,'',NULL),('lgom5n85arfguojgk1l7mrbgd7',1407241539,86400,'',NULL),('lhbliemkaneb6amlvk6arods56',1408434920,86400,'redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:2:\"51\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"aaa50bce34be646dc83f92c7711af1ef\";}twitter_lock|i:7;twitter_uid|b:0;',7),('lhchh5j4af8ov48r393r0tsav0',1406895989,86400,'',NULL),('lifulpj54trduokk74h47s8sk5',1412251553,86400,'',NULL),('lihuoknh70bddkfm26hb5ubjv7',1408890255,86400,'',NULL),('liqhpvej8rqfnsvmclvmq436q4',1408539023,86400,'',NULL),('lkr1lmv48554irbi9dooh65ph3',1410896840,86400,'',NULL),('lkrgkvntcbr6feqpd5ao11sp51',1409748573,86400,'',NULL),('ll1mf07asmavcd2tu9rmj95el2',1408524110,86400,'',NULL),('llit51v16uhflvlr2q0ids7jv1',1412672020,86400,'',NULL),('lm4tcdton1kr1bob3bt8gid0d0',1408524257,86400,'',NULL),('lmbjba0gifmn3ltje97snc9md4',1410649697,86400,'',NULL),('lmdpnsbfjdsv5svg9hvh0uo4a5',1408367897,86400,'',NULL),('lmp0bsnv552ups4v79sl9uo1l1',1409661049,86400,'',NULL),('ln1oo40l95oif3scrjjg5c0r74',1409731957,86400,'',NULL),('lnjd2tvdvgc1det7rl5vh1sec2',1410991559,86400,'',NULL),('los75cs28d8079p3su5hd4mte1',1408566865,86400,'',NULL),('lp9cnq30ln0jck055f8qotkav6',1409694820,86400,'',NULL),('lpnhu1864c184ultlk8la65ct4',1409129527,86400,'',NULL),('lps3i74gni0qh028c7eodpvk16',1406897156,86400,'',NULL),('lq9eibek7jjbc36s8q3cqg7uf6',1412349537,86400,'',NULL),('lqli94g1pcvkj6u63gmqq21ks5',1409734939,86400,'',NULL),('lru265o7u4oopd14ct8gcmnvn6',1410736044,86400,'',NULL),('lsbe2j575h06hu5a46rhetd9f4',1409754616,86400,'',NULL),('lsvlhi7kmgjmv9g4d8j9een822',1412332379,86400,'',NULL),('lt4hqre0ru296vjlg1vl6iusk2',1410654983,86400,'',NULL),('lt9udqj48ocg4gd5dtj5r5cnc4',1410652364,86400,'',NULL),('ltgae7v9j288hkmtb1e8rutts1',1412338477,86400,'',NULL),('lubi8d69e1kbt23n4ssof2p3l6',1409746222,86400,'',NULL),('lv7b4tv9bbcru5rvem6po1e8q1',1409731823,86400,'',NULL),('lvrr44utuo29sle6hv7jtlfg13',1409127880,86400,'',NULL),('m12jhs0hrp26995ucmje8jv6g2',1410645954,86400,'redirectURL|s:22:\"/?en4_maint_code=z7b9h\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"9b396e3c8e15237b33afe8e0dd421446\";}',NULL),('m1nldpen3c97hmb1rpggppk2b4',1412783445,86400,'',NULL),('m1oqh2vvlphrvgqelt1hpfgb85',1408542414,86400,'',NULL),('m23r34njj6f4i31rrc87ntupb7',1412686313,86400,'',NULL),('m335836p6c8nia054n6q19bi70',1408542605,86400,'',NULL),('m372ml1i2rck2ilsqb7ecfbna6',1409742105,86400,'',NULL),('m3bq17c19cl05cvimr1698jhj0',1412260383,86400,'',NULL),('m4ir3fbauo43eva220tnhhfd25',1408527534,86400,'',NULL),('m6kvvl2kvumpujfe4edmhv1m05',1408891243,86400,'',NULL),('m6q1b6or3kooghbphehmo3jac6',1409751992,86400,'',NULL),('m8egsd3hpv7afa50nni5coe010',1412318932,86400,'',NULL),('m8f1e9q671d987pophvt2dvlu3',1411077100,86400,'',NULL),('m96de38f02q80rg952eo6fcrk2',1410654193,86400,'',NULL),('m9j7j1nru1djalt8u6b42o71t7',1410735837,86400,'',NULL),('ma4cqud4u0aumqrsrpijs0ss70',1409730826,86400,'',NULL),('mb5um1lnsob7u44nco2vrv07b5',1412783324,86400,'',NULL),('mbh12jj84t8kkmbjvo1rtt65v2',1412332859,86400,'',NULL),('mcgt1uqhd4mp0okjc5ogg23773',1410906108,86400,'',NULL),('mcj3apad32mpfr2cdgfl4jb590',1412335919,86400,'',NULL),('md82srtpijp4pgs7ll03ftprn1',1409732980,86400,'',NULL),('mdde2l20nr6p790e9s2kgjagp6',1410993107,86400,'',NULL),('mdh220cboih5q3jni2sdamq7v6',1409742345,86400,'',NULL),('mdopemh7r38k5cg87nodq4jfc2',1410654728,86400,'',NULL),('mdr15m5dm4vb689mri8ds7u846',1408884816,86400,'',NULL),('mdtm0un8m0chpk7k4fm5toc4g6',1407248070,86400,'',NULL),('meeaia1oumqpjv754fbl4jj6i7',1412340640,86400,'',NULL),('mejga4m0chr7h9c4lr8vre7cb3',1409740320,86400,'',NULL),('mfsev0kqbt32srhtbeudeh0cf6',1410995296,86400,'',NULL),('mjtrur78k46lt7r3bs0hsap3q5',1408275519,86400,'',NULL),('mkfionhalqasct0ip97252m700',1412253858,86400,'',NULL),('mlol054vqkou3sbs40l12th7c1',1412929762,86400,'',NULL),('mn1668le9f7uf0pan0pii5kja2',1409731562,86400,'',NULL),('mn7atggf5mm4cges8b74vnej25',1408998194,86400,'',NULL),('mnj6lvrq62sqibvivabvhcqd50',1409127639,86400,'',NULL),('mnp81pkj373u2q1ilhimth0e56',1406900418,86400,'',NULL),('momfffms32uhmr5g9v79qg9bn5',1407275437,86400,'',NULL),('mpnvn38e5ermjp9n9pgeq1i131',1412171136,86400,'',NULL),('mr0uk3omudaiks5me0vb1sa8f2',1410899747,86400,'',NULL),('mrcfdjntviiqgn54k8bm5m59p1',1412867886,86400,'ActivityFormToken|a:1:{s:5:\"token\";s:32:\"014ce62197b0c4610dc9b62a6205c4e1\";}',NULL),('mrpvn3fu0irausqbev6nlhbbm0',1408885536,86400,'',NULL),('ms7gvv61faf3g73qnikij2qkf0',1410649461,86400,'',NULL),('msdjssa8omc4mttoaovs4242n2',1410902027,86400,'',NULL),('msll2fcumbaq52nl61gjrr43o5',1409731019,86400,'',NULL),('mt4tfmps2ekqmmd3nel6hj0d24',1412258822,86400,'',NULL),('mtfg4j49t0ncv0g43a6ejqf6i1',1409731371,86400,'',NULL),('mth3fj6elh5h9d74nvpjjejfr7',1410736277,86400,'',NULL),('mvcpdj93r7hcttiai4311tu4u4',1411140791,86400,'',NULL),('mvrv3ttk70fqbho58833sr9b91',1410989210,86400,'',NULL),('n01jr38p13g9a7fah7oa0fojf7',1409695611,86400,'',NULL),('n02idls0h0evmqnfamsddcnae2',1412669497,86400,'',NULL),('n0421tk6ajevic7sdecsearal1',1409687278,86400,'',NULL),('n0gku54q1q46g2p6nceed7f2g1',1408565262,86400,'',NULL),('n1ig0vahq09nlt73hu7mmd81q5',1412885128,86400,'',NULL),('n2fq1hqm3e571ij9s61sj08fo7',1410899267,86400,'',NULL),('n2pv2q28oet4pq9u7d2qign2b5',1412783564,86400,'',NULL),('n3nn6s7ncceve4julbsl7p3vl0',1409748950,86400,'',NULL),('n50lq4ip6t80djlan8pk3vo0a7',1408540525,86400,'',NULL),('n5f31ulvpg2jr6hgut4m5j82s4',1408570813,86400,'',NULL),('n5pbmkh6anq9gqv33959jaqlp7',1410656122,86400,'redirectURL|s:30:\"/activity/notifications/update\";twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:11;}twitter_lock|i:11;ActivityFormToken|a:1:{s:5:\"token\";s:32:\"d2df48b1ed93aece09d27b4a3238b95c\";}',11),('n7tefj0916bifp2555o62f3nl6',1412675747,86400,'',NULL),('na0d3e9dleos58ah8pbmv2f5u6',1411499958,86400,'',NULL),('ncdhu0hdiln74ib8k9i0b18p75',1410738555,86400,'',NULL),('ncitjukeo67bhrqblc3uh2gjs4',1407260870,86400,'',NULL),('ncsbtqhu210r9dgrpqtibiqrt0',1408575335,86400,'',NULL),('ncu6hpk43ru9a3b63n60s5tql4',1407277010,86400,'',NULL),('ne4qvemod0p9ihfr1vvvrgheu7',1409746311,86400,'',NULL),('nfh388m4o7jn455vq8j1hlkub6',1409695153,86400,'',NULL),('ngd8ec2br319l5sh3nt97vtfd2',1408524324,86400,'',NULL),('nguh8u3b8ndqvtrb9bjj2hfdg4',1406900190,86400,'',NULL),('nh1jft92iqhtopqic26ujfcp74',1412865534,86400,'',NULL),('nhb2jvhttvmsv9ucdr7e1qv1s2',1408289994,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"e62f270880fcbd0e9d6fe29d38d43486\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:2:\"50\";twitter_lock|i:7;',7),('nhi45ct9fri8fikagragesamd4',1412885368,86400,'',NULL),('nhl8uvajolhf2usvhb94e7u8u6',1410649869,86400,'',NULL),('nhlh9ag2lt0db2iiatuial4nl3',1410652301,86400,'',NULL),('ni2sflbii7925kum8ao216n4v3',1410652425,86400,'',NULL),('nicp3et3eu7c13mkq0uucts6d3',1409132745,86400,'',NULL),('njenj5egcermn6mo1ns8ch3in7',1410900227,86400,'',NULL),('njq793ee6uubjjsh7gb6frus27',1411140190,86400,'',NULL),('njs72p1k0j6dmiee36hpd1kvd5',1409746875,86400,'',NULL),('njsq1u6k6lbf3fa5e4e23r7r37',1408541634,86400,'',NULL),('nkho6l54qecbkl6ph61c151tj7',1408525103,86400,'',NULL),('nkr99fh4e96in12drm305mutj1',1412260263,86400,'',NULL),('nkvmb487j9mvka427792886go4',1409064602,86400,'',NULL),('nl0anec3i99j1u49sa0r3d3b96',1410649175,86400,'',NULL),('nmhv3pd43edupbp1rhb9ji92a1',1407271488,86400,'',NULL),('nmme54bbpmurq8q0cdntse5q25',1410645952,86400,'',NULL),('nn7lt858t6moqrjbqnj0klnlq2',1412692442,86400,'',NULL),('nnq78p39ab11h7nf7uc38lq917',1412342135,86400,'',NULL),('no7bmphimtblc4893egi8lb417',1412671900,86400,'',NULL),('noj51stvcv7v9ktgp28o2iqtv6',1409650882,86400,'',NULL),('nqleff36spmgh2mho1nbfcfrq0',1409064723,86400,'',NULL),('nr3ptavhld75u38e3r1bhvi7p7',1410738492,86400,'',NULL),('nrk7aehe9di1n63ca4gl8ncm96',1408574494,86400,'',NULL),('nroorl554i6iuk2rni3ds5q4v2',1410902267,86400,'',NULL),('nt1g5hf1vh0f801bqoopdovi26',1410735980,86400,'',NULL),('nt2p59gqlhul72k6n9688le6c6',1410901667,86400,'',NULL),('nu20a5stasq8l72v7q61mgn4u7',1409747797,86400,'',NULL),('nvh0klitp770mh342s01qqvtn2',1407416181,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"03dcc779d6ef8d9cef629a76d8fffa05\";}',NULL),('nvmom1i9ein0sjl3o50i9jcq46',1410901330,86400,'',NULL),('o030qbg86dfaso2r95hs451u05',1408989519,86400,'',NULL),('o0618igh4lpibdqkn0og2502u4',1407271234,86400,'',NULL),('o0qnvlb9ebsdldr1r0onk92qf3',1410653244,86400,'',NULL),('o2n48nrbljc0i07j31lvq7fbj4',1408989639,86400,'',NULL),('o2n7g0j8to472q6pn4a54p60d0',1409696486,86400,'',NULL),('o3bjhfafjmvaijpinpd8qho0o0',1411075787,86400,'',NULL),('o403jfevq8qmngtcluesfrpjk5',1407275559,86400,'',NULL),('o42r52kt03tq369d0pppp66l15',1409729384,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"f8f0ca12772ecef90cf37b21f3d9f459\";}Zend_Auth|a:1:{s:7:\"storage\";i:6;}login_id|s:2:\"75\";twitter_lock|i:6;twitter_uid|b:0;',6),('o45rl3r1mkfjlmgkn8nslv1ij1',1410905987,86400,'',NULL),('o6eln0scc163tht3dn99k5v6f7',1412319051,86400,'',NULL),('o6nmtdvae3areibmg25pdv9ok6',1406900479,86400,'',NULL),('o71o8a2etihv8hl3f4cijrg9u4',1412342000,86400,'',NULL),('o7qidgrln0ceohrj0vlddrcdi0',1412669256,86400,'',NULL),('o8mlrpq9e67lk06pcpbprec645',1409746436,86400,'',NULL),('oambmosudf1pjpg36la4n2a701',1409746376,86400,'',NULL),('ob6bq37nq02p0oishm5jq114p4',1407277263,86400,'',NULL),('ob7pvut4fr3f8oig6m1qo96i63',1412261703,86400,'',NULL),('oclk265d874tnlsvtu8qa92c45',1412339471,86400,'',NULL),('ocvgbp0s773bb0e70nqcd4a8k5',1410655102,86400,'',NULL),('od33f9ev0557shlk9k726q5hh5',1407241033,86400,'',NULL),('odi2f98algoh6dhemi9kc8sq71',1408537139,86400,'',NULL),('odoc2rnioj8vuof2ajjlhmafn6',1411148533,86400,'',NULL),('oe0akpfq40kqbvjefvjlnkk4j3',1409130107,86400,'',NULL),('oe4bs6reebpre0gi4vpbtr6mk0',1409730120,86400,'',NULL),('ofv4hpv6suks62ppua2c20al83',1410993023,86400,'',NULL),('ogaj7esjrfkppkh0rme8k66140',1412776964,86400,'',NULL),('oh096rmisq1uebq1v824i3jhg1',1407241360,86400,'',NULL),('ohbj5upkscelsu943ofb596vl1',1407277138,86400,'',NULL),('ohfksc64m1ddknqtf4gbnsra47',1408608001,86400,'',NULL),('ohkmsl5dnd6t2edd6v145i4s52',1408573289,86400,'',NULL),('ohmpj8kkfvenj8vqpaqpt4ajm6',1409745392,86400,'',NULL),('ohvev7bbn0o27e198c21chti44',1412332739,86400,'',NULL),('oih09qv7grem5213add8v32kl1',1409651122,86400,'',NULL),('oil0eep8pkfk3qh2oskf7io3p6',1412693888,86400,'',NULL),('ojkt875h0eugs3nlv9qiin9bg2',1410735819,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"978477e9afd7c18d559a04cc9f65c79e\";}twitter_uid|b:0;',11),('oko89nvht6jmrsfavnho07kt45',1408569389,86400,'',NULL),('olcg395ebtsucbeqcpegfjag36',1412239442,86400,'',NULL),('olhb3bg6ch9bbidt7jbh6c9i24',1409060706,86400,'',NULL),('on91ja8q5fiq2pbn2p0segg880',1409737738,86400,'',NULL),('onb022smi6887icc6bmhu1df25',1409699440,86400,'',NULL),('onl1rctm2qhf12i35qqp2d24r3',1409698000,86400,'',NULL),('oo3103vpose3dg8ua3uqud9bg7',1412777204,86400,'',NULL),('oopma41ltvmdotdscbkpsp07p3',1406896230,86400,'',NULL),('oot6it7t4vavsai8s3iqanmsa4',1410654407,86400,'',NULL),('oqu4l8lll6fb3tb8da2e246aj3',1408525163,86400,'',NULL),('or3kk8sdmujenia1hsdrc366m2',1409753321,86400,'',NULL),('orhbll6hkj232amefmnnuhds43',1409750853,86400,'',NULL),('os3epe62uhh7dv278i7th62v33',1410651497,86400,'',NULL),('osgablk1vh6apjm8g5ula9tkt6',1408989372,86400,'',NULL),('ospcqsb8fs4peraalsqrq795h6',1409738798,86400,'',NULL),('osrq4anb5icrj5og3tlpa13d84',1412766766,86400,'',NULL),('ouvg6khvcronj0bthb9ukavtb0',1409742466,86400,'',NULL),('p07sqb09ipj25kcef3aei2e843',1408526668,86400,'',NULL),('p1evmrljdeuaa7mk1u485gja83',1409736279,86400,'',NULL),('p1k40821bajs76hjaqpfgn1ig4',1406823705,86400,'redirectURL|s:1:\"/\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"395a9457ea67e70e1dedf9e4921eca46\";}',NULL),('p1mm6sf8id2gevtvrgmegulvu0',1408541365,86400,'',NULL),('p1u0rpi768j3qfhco7c5vo5ht2',1409741478,86400,'',NULL),('p3103bl04tju1t5unv0l71guf3',1408572689,86400,'',NULL),('p4jgs7qhop28n8j8tihdjfij10',1410991274,86400,'',NULL),('p6cifq8efur6o376jt4od7f6t1',1409743306,86400,'',NULL),('p6oq6kal3ak8ululhr563cfff4',1412584630,86400,'',NULL),('p7ioo1cf9240hb0b0otmc9ceb7',1412170895,86400,'',NULL),('p87mfmklos9dccjop0hqno88c0',1410655435,86400,'',NULL),('p8kdr1u90a9vnebjp4i1e9brl2',1412318691,86400,'',NULL),('p8tcgbd7p4hl1vpf2mcag6ltn2',1409749966,86400,'',NULL),('p90ddb4bueh2rcvk0tvkr8kq50',1409739517,86400,'',NULL),('pa4m3tef9tp29to10e8fptvp66',1410897081,86400,'',NULL),('pacqn8nb6oc1kurf7b04lkbn72',1409734401,86400,'',NULL),('pb1cogjohnoii9ulgdu46aih84',1412344729,86400,'',NULL),('pb9t19qt8a4iujbto0ki47qo02',1408608000,1209600,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"1ca2476f9baa958b0a3c48cea58282f9\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:8;}login_id|s:2:\"57\";twitter_lock|i:8;',8),('pbcpl6t6ag3mu3t3n1qe3hc380',1408567206,86400,'',NULL),('pbe97t0b9tv46qe4j2ndsbkiq2',1412171257,86400,'',NULL),('pc2k2qr87pllvkp0pkfbd4v473',1409733041,86400,'',NULL),('pd8c9j5gpi8m83kn24a8g7qsq1',1409733396,86400,'',NULL),('pd90unbnipvm9saq07s0831v56',1412342618,86400,'',NULL),('pdk9eicnasa4c7lt6pgalio665',1410739830,86400,'',NULL),('peabth3gpla90k0nj8keru5fn2',1412775704,86400,'',NULL),('pfermikdra3rs68jfilrhnj540',1410898008,86400,'',NULL),('pfr2m1vmvgvekfgro91q6jfjr0',1410905747,86400,'',NULL),('pfu5kr8iad1dofi19gko7m52i3',1404910923,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7ee851cb0c4f3ce592ee3090b55cf09a\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"18\";twitter_lock|i:2;twitter_uid|b:0;',2),('pgrtrph45dib4suqsiag4p89l4',1408574854,86400,'',NULL),('phgmdrgmge5eoeeeod387t73f1',1412262063,86400,'',NULL),('phhqkt19ftqn3tl8g1conhg541',1411500438,86400,'',NULL),('pi59u9iu88058h7l5hs4kb3k26',1409748192,86400,'',NULL),('pif130fng3u9g3jfd5ddlhan71',1412757745,86400,'',NULL),('pipu6f7o4cr6rnh9o9r2gagoi4',1409738558,86400,'',NULL),('pktepumonp0milobmbrtehsvt6',1412595335,86400,'',NULL),('plqn1rhk4e82u3l0dsc73jor81',1410899147,86400,'',NULL),('pntu7keob9rsjgiljk9jqugg21',1409753492,86400,'',NULL),('pore9q9e8u26ert50ieorphhk2',1409697520,86400,'',NULL),('pp0i16rpcnqj8hig8ti5qfc8a3',1412954403,86400,'',NULL),('pp7hmufoh8hs343haqnpqrj4l1',1415220425,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"d188bd7ed8be99cc4052f3e6b3f2f230\";}Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:3:\"124\";twitter_lock|i:7;twitter_uid|b:0;',7),('pqumoh6rbn6lugd7bsri88rjh4',1408525695,86400,'',NULL),('prhdcd38fimkbjskc9k5cfeva6',1409133943,86400,'',NULL),('prmc624g08ait58ibebupojri1',1412929637,86400,'',NULL),('prrhfnjkals9fkebqqnup21l32',1409125840,86400,'',NULL),('ptcl29ikne74eij3dcn2tdq1f2',1412692923,86400,'',NULL),('puhq9ugbkh6bolbbg2bmiprm55',1408889737,86400,'',NULL),('puobo8gjuqlcail2ei18trt1i0',1409728681,86400,'',NULL),('pv3est387147d2qou0dns5kab6',1412345023,86400,'',NULL),('pv6n67nr8mrco1f0a99bbaaer5',1412955845,86400,'',NULL),('pvtclusp139otqgrg5s8d0bqh6',1410991398,86400,'',NULL),('q012r9iidn7bq2gkf1lns959q2',1408525460,86400,'',NULL),('q030vbe4qmj39lag74qt42juv2',1409060828,86400,'',NULL),('q0ia82706lj1o6ph465geo1av3',1406480640,86400,'ActivityFormToken|a:1:{s:5:\"token\";s:32:\"20bfa70c5f8e99c906f58d2821ae3e33\";}',NULL),('q18bejtrdgln79qb9ttojgi125',1409732328,86400,'',NULL),('q1h7n0mjpss5tomkn4vuct0610',1411075908,86400,'',NULL),('q1kiv4ng1kktp5109aafkgkfk4',1412688356,86400,'',NULL),('q2hkqlek3j5l74plc9irc0s5v4',1412783205,86400,'',NULL),('q3hi85abr8dah4otqc752elqp1',1407235053,86400,'',NULL),('q3u6qj8hvj2usoq9hh2ocak455',1412338013,86400,'',NULL),('q45fqfirteolrm7hfgki0m31b3',1408540463,86400,'',NULL),('q49q0ciir3lc6apbscnqckdvj7',1408274924,86400,'',NULL),('q4mvp7ulm8k8t546e89si6pkq4',1412254314,86400,'',NULL),('q535ko9pcfudf98r47smvr3f70',1406895509,86400,'',NULL),('q60c6qp620drqlahqosi8fbdv1',1412775871,86400,'',NULL),('q6tq3t9jk7i81js5f1n8nv5dm2',1408572929,86400,'',NULL),('q7650u2s70ma8u7sa2669df4o2',1409748509,86400,'',NULL),('q7l3odjvg1h6jgq9vrvo1ejl13',1406896449,86400,'',NULL),('q7s61lfbd0tv4ss75n6bhribc6',1410990151,86400,'',NULL),('q83sca3e8935kqn8iphd4ji3d2',1412761115,86400,'',NULL),('q857ial7t8gru6bfc82igt4g15',1412335171,86400,'',NULL),('q870g8vc65dmvermbqgehifin3',1410653305,86400,'',NULL),('q8cua94ggekj13rrip889kgeo2',1409059125,86400,'',NULL),('q99rf0qrvo7dh54uci2dfqp2r2',1412884527,86400,'',NULL),('q99vtqer24i1dknaskr8dunf16',1410738725,86400,'',NULL),('qa7val41fr9bu79cl8ocic6to0',1412338388,86400,'',NULL),('qag5u0uhdt48j5j6drrdslgq47',1409129396,86400,'',NULL),('qasd2ddi471u9afj35hq7n6ai0',1412595008,86400,'',NULL),('qb70nqd53rtuku0jqcfa1l0pe1',1409697880,86400,'',NULL),('qbamvm7r143734e6ln2f210iu2',1412864261,86400,'',NULL),('qbfm409ta85cljschfcm4ig1v2',1412344489,86400,'',NULL),('qbjl3m5p4bbh1s2nj9h52qik95',1409732516,86400,'',NULL),('qbkq4apqrlnan5021ec00jlhb5',1411499838,86400,'',NULL),('qct8av3huksbhkg63593s3lqj4',1412341879,86400,'',NULL),('qf4jvk19hds0vbi6o5p2n6n0m0',1409739427,86400,'',NULL),('qgj1fhnr9h1mlb3a3kpf1ldku3',1409728774,86400,'',NULL),('qgs6j7m30htp650d0pliehmmv6',1412695458,86400,'',NULL),('qgvm6ld56ftcdebeduvq7s0j20',1408885776,86400,'',NULL),('qh2j3odhptflgnmch01089hu06',1406898987,86400,'',NULL),('qif1qd13sovtpfp83mtj7mh8c1',1409734578,86400,'',NULL),('qiit3cfa1l89l6umf58otl3773',1408565176,86400,'',NULL),('qirm2knqvpqs4tb2kh9p25mrf6',1409763219,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"bee28d0c856316d9e16c371231ffb71b\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"83\";twitter_lock|i:1;',1),('qisffgofp3j4f9jmir86gfsvd6',1408569564,86400,'',NULL),('qjtv1tg1ofjbrgi5di7pcbf7l4',1412253736,86400,'',NULL),('qke8bom0474ms3q5jidm6aho26',1409216893,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"eb8e139cd7cddee58855827c8ddcb46c\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"66\";twitter_lock|i:1;twitter_uid|b:0;',1),('qknqjocb3skhulvcgp71t1u7c4',1409062922,86400,'',NULL),('qkv16utld2jfdt8tc2blimgj15',1409065706,86400,'',NULL),('ql590e15tpi0k2rg5dv963g3j3',1414673690,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"b58463267cfe61a18fb8abd895b4873e\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:3:\"123\";twitter_lock|i:1;twitter_uid|b:0;',1),('qmao7be1ehdbigkenooml2cnt6',1410739335,86400,'',NULL),('qmjkn5qscl4gvr65sklnpthh66',1412752103,86400,'',NULL),('qmq5af2c0rf42ik8anje25ac53',1404227752,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"0c9bf6745e97e7808519d9c18ea0af42\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"11\";twitter_lock|i:2;twitter_uid|b:0;',2),('qn0ba8lfnqee8voidks7b70370',1411140551,86400,'',NULL),('qodpcla0vt4o3ln9u00otmh6b7',1409741864,86400,'',NULL),('qottcjk0nccf4024rtubbads94',1410992880,86400,'',NULL),('qov3g71nrdhmr47fdv845abt65',1408888297,86400,'',NULL),('qp4ev0v79d6mvom3ovljle8i85',1412344058,86400,'',NULL),('qp71mdqppc6fp79s7s9hhobf20',1409748633,86400,'',NULL),('qpa2geq9fvsjomq2v7nqusgbi0',1408269804,86400,'',NULL),('qq2pdobg2pd9hi8995nbggvga1',1412866254,86400,'',NULL),('qqkvrl904hchet1idl9mr2sku2',1412865294,86400,'',NULL),('qqmt1ulpr9sn2jqdtdqsf0acr1',1411075545,86400,'',NULL),('qqua4ks98o1ainu14q7rslhva5',1408525896,86400,'',NULL),('qr2a9rs5hdrimqh6eb6dmq07l2',1410653599,86400,'',NULL),('qrbaktlmmcequoo7a5errd75t1',1411500198,86400,'',NULL),('qs0ddrs1fg139lopfeqop2u5d6',1411343078,86400,'',NULL),('qs3rqfoqiqj4gakhajlc2ena50',1409743425,86400,'',NULL),('qt3qps5nb8up86o33v7qg0din2',1412776232,86400,'',NULL),('qtldvfeboqu0gi5okftf1sifv2',1410647317,86400,'',NULL),('qu2ah6gqntqirrjb0e7kjo7gv4',1410995776,86400,'',NULL),('qua4bvbot1p8sthcat1g0rh7a4',1412584268,86400,'',NULL),('quc37ujaa3eh7kg6gseb9vr4f1',1406901368,86400,'',NULL),('quhaiishfurtcc1vcbkjomt7l0',1412262184,86400,'',NULL),('quqrfd5pl4nm74ps0532cpn625',1410897768,86400,'',NULL),('quuhsbm9a70hbi91ouods5ibr4',1409734097,86400,'',NULL),('qvvr9jt5skkdfp9a609inmsva2',1403859308,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"c3e242595db35d69770cae564d26342e\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:1:\"3\";twitter_lock|i:1;',1),('r0c0rl5bpmarg3eq3sv0dl60s6',1412751982,86400,'',NULL),('r1dio3amm5o7911iv0rmu4bq64',1412254467,86400,'',NULL),('r1glh9muv12qqba3jo7jn75316',1406898196,86400,'',NULL),('r1qh7s92obrsbgs1pgi7iigho4',1406897453,86400,'',NULL),('r2ehtcnj1237u7d17kmtmr04k2',1408540334,86400,'',NULL),('r4a6mkl96ka0t5l26urhti63b0',1408524700,86400,'',NULL),('r56g58ievg0t65ntvc81hikqk6',1410991801,86400,'',NULL),('r5vcmvmtq7a2ruh1ld716e8cj2',1407183480,86400,'',NULL),('r68i4e06hmqj9c0nvdakefc3q2',1412885728,86400,'',NULL),('r6f7h2pb6mh88b00q47qksvmm2',1409733284,86400,'',NULL),('r72sm2md5b4iaen9u1okcg5md6',1410897888,86400,'',NULL),('r762kc3p47ll3b0ic3ce8m33g2',1408573409,86400,'',NULL),('r7ctsm2p2pss3f2ck3fmnge5o2',1409729426,86400,'',NULL),('r7ghn2243661jpb1v1tcpkkt11',1410647620,86400,'',NULL),('r7jr5dk0681ss44vvkkdhmd696',1408576050,86400,'',NULL),('r8frsk1nlcu0g2u22o0ppnsto5',1410897559,86400,'',NULL),('r8keeq2gm1luvd8uj4pahihi02',1409134516,86400,'',NULL),('r8nm9k05k7j3s5dpecnaaj7ei5',1409651002,86400,'',NULL),('r8oe17qrl35gujs0m8qu39ihp6',1411140431,86400,'',NULL),('rb31ejktrgc7cahlr7nnp3dtv7',1408888417,86400,'',NULL),('rb6sthpsah4ctl00l7oiinpaj0',1410737695,86400,'',NULL),('rbs6s0t5g7gcuck6v994ki7b66',1408890616,86400,'',NULL),('rc2epmnhk2mv7rer89sbg7u8o2',1407235478,86400,'',NULL),('rc991sf32114mk6c8gg8pqc7i6',1411079740,86400,'',NULL),('rdpfjdu9mso7pkun0qmb8cj054',1409739850,86400,'',NULL),('re77qguf6rt9216dp1a4rou7e1',1409748443,86400,'',NULL),('rf9tej189pij7idcntropgsqc7',1411074216,86400,'',NULL),('rfsjui0tbof02tiumtvel23cm6',1410655249,86400,'',NULL),('rg3fn1ums3hq964bdrhdvs2r53',1408565077,86400,'',NULL),('rg4rnfhdfhmlgbmj8cbi831k06',1409731499,86400,'',NULL),('rga06gl5jf4s6m7ghck3et7v71',1412674663,86400,'',NULL),('rgfksgidko6aan7p2nfr3tv5e1',1408268310,86400,'',NULL),('rhh87uis7fqiu6oepgp658qa42',1412169561,86400,'',NULL),('rhi5rndmu90d065a6dt1965784',1409744027,86400,'',NULL),('rijh28u9uedk1vp9869on9ml21',1408566097,86400,'',NULL),('rj335iko8eg4gppkkg4v649ha5',1407241781,86400,'',NULL),('rj6lk927csqkjjk43q4c8cb1k1',1407271362,86400,'',NULL),('rkjtlusjsrf30tpo667j2k1pf1',1409742826,86400,'',NULL),('rlqreru7t4spshkt1aj1cjj322',1409063882,86400,'',NULL),('rmokn8onlck5e49945dg5svu21',1410736155,86400,'',NULL),('rn19thpbm9d7dhsdrnou0tu781',1408999394,86400,'',NULL),('rn77dcjrd89es2blo5uejjthn6',1408572449,86400,'',NULL),('rndrqco32db6d0n2ed3ko37h15',1412776725,86400,'',NULL),('ro9ns7a5i6u3sfbutgmkk9bok2',1412761357,86400,'',NULL),('roe02glg7q2td7lainrui4sg30',1409750330,86400,'',NULL),('roef3pj425giluee2gjtqntt23',1407235931,86400,'',NULL),('rqbeo8fg4lbi2g08mrd0c463l1',1408542002,86400,'',NULL),('rquqjs71ral8vr35lo8m11beg1',1409737677,86400,'',NULL),('rrctnilmqj5o3qh63eu5g22bf7',1412776112,86400,'',NULL),('rrhssdfm9c37s909molt9a2qr2',1409136996,86400,'',NULL),('rri1fc7atbfr3h1qs8ttdka1v5',1412259063,86400,'',NULL),('rrjfoq04l6mdvnv3as08c9joa3',1409732825,86400,'',NULL),('rtec8kr3v92noa8ip7f1t5ctb2',1409761635,86400,'',NULL),('rteq1s8hsqa1ui26f9tb6quu62',1411077220,86400,'',NULL),('ru8kqdgt06sds45p0a5fim0i71',1409133327,86400,'',NULL),('rubacai2nj213kcjlfgskn89k5',1410650280,86400,'',NULL),('s07u29k9ipc2e3tckmd9fitpk0',1411074091,86400,'',NULL),('s1gn83gqefjh66kmc56s8pg3h0',1412253798,86400,'',NULL),('s1oothj0k3hr5idviv9ii0v541',1406892743,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"da21b5afac9d0e7734c324eb7e6d0175\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"36\";twitter_lock|i:2;twitter_uid|b:0;',2),('s4cjt1br7uie4qnbiusfut8v41',1409730479,86400,'',NULL),('s60bcnlh6sueri32p85j14sm40',1405021619,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"56bc6c432fc46f64105f94e6fb458214\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:2:\"19\";twitter_lock|i:2;twitter_uid|b:0;',2),('s61uuf18f8ugbjham01n7rt6r7',1412341243,86400,'',NULL),('s7m7s8rtt0tvh461jqm5rf4014',1408576170,86400,'',NULL),('s8cs89tk0dctjap8gcd8d5qam0',1410992377,86400,'',NULL),('s9q5allrraha7lcd1snoc40754',1409003235,86400,'',NULL),('sb00ttljrl03ntl9g2iljvq8p5',1412584991,86400,'',NULL),('sb7bgaufoffoedlam216och5q5',1409734508,86400,'',NULL),('sb9na3e1b5kn1p8hviuhikh6u5',1410651135,86400,'',NULL),('sbs1l43245q5lm9kidu0u5h0s5',1412864529,86400,'',NULL),('sd172kq577e79t4jivun77lqc2',1410737104,86400,'',NULL),('sd1e6s9jfo2apcneghvsmb09l5',1410737506,86400,'',NULL),('sd8nfk6hpu0h0oi8l2o24hq8s7',1412336100,86400,'',NULL),('sdev7jmmc3qeu0cu2su1qf7la3',1407275175,86400,'',NULL),('sdnm7c58va0l6gqi4ja0n26tr1',1410736883,86400,'',NULL),('sf6d6uo33au8duvju4k5h8fth2',1410993470,86400,'',NULL),('sf8o5bjuqv72s4e0rbi3vjjqo4',1410897280,86400,'',NULL),('sfg2v9lmh7f1e310kk35lsibb5',1409729295,86400,'',NULL),('sficgqmis0ofnp8nertddu7b23',1410898923,86400,'',NULL),('sfloe654na83p0kmg272abce27',1409065923,86400,'',NULL),('sg2av6ifu5noks3khsl00o68m6',1408569256,86400,'',NULL),('sia2o0uoca5498qlisoel3muu1',1409755175,86400,'',NULL),('sibo7hs0ptab9aqgps9vlabeg2',1410990699,86400,'',NULL),('sjfeqmsc7fci0plst6puv2ner1',1411079860,86400,'',NULL),('sjql10sqt3hp7f8i9fl4j7csn0',1412686193,86400,'',NULL),('sjsj11dcsvf7tbit4daqk8jfe5',1412349780,86400,'',NULL),('sjtj04sru240jqcccgdmavd3b2',1412866125,86400,'',NULL),('sk1hv4pmc5jqifrrla0v23e611',1412692200,86400,'',NULL),('sknqneooqqd5u1b88jii6kf9u1',1408526604,86400,'',NULL),('slafd3vei8so31ke942ck075n4',1412884045,86400,'',NULL),('slruq3aut4vopfsbt9pgmu34a3',1409062595,86400,'',NULL),('smne78lkq9ido79gl0l2rd8f45',1412596875,86400,'',NULL),('smp03pda3apd82tubch0l6vfq5',1408541440,86400,'',NULL),('sn61navg8vs6p15idqrump3i43',1410989573,86400,'',NULL),('spmg1cr18le9sekcumvmijj300',1407240673,86400,'',NULL),('sq632auir53piivs81tkjvq8i3',1409737617,86400,'',NULL),('sqa9jv7293mi4adj3cn6vn1ss3',1408539383,86400,'',NULL),('sr0qi1t1lq79sj0h5qmf4ap4r1',1412247363,86400,'',NULL),('ss3q28i3crhjb3s04ubvl5amp6',1409132385,86400,'',NULL),('ssil6jg0sakve9nkttv8k29dd5',1408884696,86400,'',NULL),('st5cq4j28efqtgpfomvpqb43f1',1412248086,86400,'',NULL),('t0gmi1ihjldbv3hr707tn5rjd1',1412776531,86400,'',NULL),('t12vps2tgdtiapr0qjp2fmurg7',1410646406,86400,'',NULL),('t39r7lkpaer2gf3o9dpdg1k0s3',1412325247,86400,'',NULL),('t51g265568c6g5i4lrv0mcnf22',1410654030,86400,'',NULL),('t5bf3jvkbi39bqp3gp2pgfqdo1',1409734028,86400,'',NULL),('t5h5c2tgvi63018s30cf9hvih6',1412685590,86400,'',NULL),('t6l43ke26j9ssid14im686qmk6',1408566976,86400,'',NULL),('t6mf3486irdo1cacjh7mgtuaj7',1412669377,86400,'',NULL),('t6ph3o50bds6444annm1evfao7',1412766645,86400,'',NULL),('t752ptodpish62s9ekkb0f7nu7',1408565703,86400,'',NULL),('t83c1prehu0qs1ul5j81lk9so0',1407183420,86400,'',NULL),('t86hf035m14gbef14u9lvipqa1',1406901242,86400,'',NULL),('t9egvu5stuf3l5jf6cpt0o3jg6',1410738853,86400,'',NULL),('t9sijosod9s6qfq5fpjbil4io6',1408526140,86400,'',NULL),('ta491nem3ofms9h5mgi8h8uuq2',1409744915,86400,'',NULL),('ta8t1aoep2jd8eiu7nfsai64n1',1409750451,86400,'',NULL),('tam35heva831dj1dtb6r0iklg6',1408538952,86400,'',NULL),('tc5s8osg3ktmngsc9bj9dt81i5',1406900128,86400,'',NULL),('tdqeoqo538vp3mdltvj44c5rf3',1410739899,86400,'',NULL),('tdqf6u3278tim019ocvadh5ah0',1409754806,86400,'',NULL),('tdrv9levfa7q1bah8c9h7d1bk2',1412251433,86400,'',NULL),('teb2rroj34res1uccebqik7pc3',1408542064,86400,'',NULL),('tf5dnau42m9ouiul44d04j00v4',1411072752,86400,'',NULL),('tfea3k6lpuuumg534tnbih4qg5',1407274533,86400,'',NULL),('tg935ads72f3o7t502ecmuc871',1409695227,86400,'',NULL),('th3h7aihj3nkuhmgmj4au9qi22',1412255703,86400,'',NULL),('thfpe6smno1fq8d4goh7fpfh51',1409695425,86400,'',NULL),('thhepcilhh7p4ifcn95q8hb211',1409750637,86400,'',NULL),('tj4qfacl8jfqdfur8r9ffvajr7',1407248439,86400,'',NULL),('tj9mem39ioc847qpd9r42uu613',1411075302,86400,'',NULL),('tjgqkhcjjqck2hfs3tc1nssr82',1412344248,86400,'',NULL),('tjkj70r519l0v4ipfe2b10eeb5',1412170774,86400,'',NULL),('tlab8ao62vpf3nap2159gaaql0',1409703039,86400,'',NULL),('tm2hi9gu84jogpoogevr8q3ui4',1409745035,86400,'',NULL),('tm6a1qi69d4o497to3nuaqp2m1',1408569631,86400,'',NULL),('tn1hr7f4ocii5qf0l8br7v9203',1409694581,86400,'',NULL),('tns12kp8g121rp60e35g99pol2',1404290562,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"eeffb1cebbd00094eddae4e669868997\";}Zend_Auth|a:1:{s:7:\"storage\";i:6;}login_id|s:2:\"15\";twitter_lock|i:6;twitter_uid|b:0;',6),('tojdo220mb9ctkr6m4hv3v2716',1410904787,86400,'',NULL),('tp29oittd5i9ihu94h92l2egb2',1410739174,86400,'',NULL),('tp2cvv257dn4t858gb0ictngt6',1412341036,86400,'',NULL),('tp3onqmut25pu7fdt4lduh00b6',1412589867,86400,'',NULL),('tpjh5s5h8dgmqj945do1rsfc80',1410900795,86400,'',NULL),('tpsj133m248l0id6kjq22h5961',1408891123,86400,'',NULL),('tqsd5npg5ltqvn9npc45v0cnc3',1409062983,86400,'',NULL),('trao9luuegn05h23qrbgm3gle1',1410904907,86400,'',NULL),('trta6tt886pcgfolkt80rp25e1',1406900741,86400,'',NULL),('trthp4q7ghljnrs6qtlo33pmi5',1412694491,86400,'',NULL),('tshmiip78cjdha77dhpcst3rt2',1410990517,86400,'',NULL),('tsn98tub3jksv1cgjprc9opc42',1410993231,86400,'',NULL),('tso6ru33nc07vdq0l3blt4rsm4',1409134309,86400,'',NULL),('tu3630ugljus8n9b9pvjq1vam5',1409133612,86400,'',NULL),('tusve0d409nggt7jjtobuked85',1412338716,86400,'',NULL),('tvbgjf3t0e63224u75hdmqr2h4',1408525293,86400,'',NULL),('tvs5ljl0m03getcibhemespdo3',1412335241,86400,'',NULL),('u0gcik54indr01abs33l3n09f3',1409754693,86400,'',NULL),('u28d1b5mvedig10c583fst4nt1',1408572575,86400,'',NULL),('u354chdfgk4l2bae6h5locgpr7',1410992257,86400,'',NULL),('u3to2oqqt4a0rv7ka1cnktf040',1410646130,86400,'',NULL),('u5mhg01afbenftbs1d53n0lci3',1412864406,86400,'',NULL),('u6auqquje83ju5ebebvbd77d71',1410896152,86400,'',NULL),('u6s42ij4g206rhiqsm9qomeae6',1411073980,86400,'',NULL),('u6trcslqiffmpt79ceoq9b3oq2',1406897828,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"ebb7d42f726501f7d72a2d71a2e9dbba\";}Zend_Auth|a:1:{s:7:\"storage\";i:3;}login_id|s:2:\"43\";twitter_lock|i:3;twitter_uid|b:0;',3),('u72t71qeauu4g7894tg6h7bsh0',1408570689,86400,'',NULL),('u81bhvktgn0vkiiqj75jenhhg3',1408572206,86400,'',NULL),('u8d7vld3usirq7pcvv9foh9406',1412324132,86400,'',NULL),('u97ao3vr63kk986aakt409h7b0',1410651256,86400,'',NULL),('u9hpdb4rm88hlgb1h3ipiuue02',1410994456,86400,'',NULL),('ucb8annc3jgmdvm0gequs9mhl0',1407183544,86400,'',NULL),('ucdthlm7mnlsn8iupns11r9ug3',1410653531,86400,'',NULL),('ud8ck7g6d30kf2i9uj6sep9ae0',1412865501,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"a57958797936057506bc676212c69967\";}Zend_Auth|a:1:{s:7:\"storage\";i:2;}login_id|s:3:\"119\";twitter_lock|i:2;twitter_uid|b:0;',2),('udg14s7tcake4e3f7ke33eoof5',1412341331,86400,'',NULL),('ue173ccs1rckeru4gmu16p21k7',1406895246,86400,'',NULL),('ued5g8ref87r1igs83s6ub6275',1408999274,86400,'',NULL),('uem2i03tgqqsgvge57nhnntd85',1409746497,86400,'',NULL),('uemd1mh4crumlkinqk1m06gfh2',1412260143,86400,'',NULL),('ufuhus6gq5ahqfo0s54fm8nlc0',1407241660,86400,'',NULL),('ugb9pdkp7lscmmskkj3t26h0c7',1408543650,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"7c3520f5da404436965ff6d66f8f8a93\";}twitter_uid|b:0;Zend_Auth|a:1:{s:7:\"storage\";i:7;}login_id|s:2:\"58\";twitter_lock|i:7;',7),('ughadlkqp4pa7pb8pd084r8k74',1409728560,86400,'',NULL),('ugpj7gldg4jq8mujsih1vluuv1',1409062741,86400,'',NULL),('ui4ih7ttl13vk0h4bloth0ptf1',1410648651,86400,'',NULL),('uic25e82pke8p2fc59h8jc9i46',1409648504,86400,'',NULL),('uii8g4q9g2q29ja5sn98gon495',1408488370,86400,'',NULL),('uini4mfj31aus99etl9iaakml7',1412589928,86400,'',NULL),('ujp7udehvh53ha045lvfktjn87',1409751663,86400,'',NULL),('ul18nsbvsat9tvk7n2tf170rl6',1410650101,86400,'',NULL),('ul96mdl2gga5gl71o7m53sjlm2',1412258462,86400,'',NULL),('ulj0h79av7a262hr8dcvscv6k3',1409737859,86400,'',NULL),('un9934jkb9427cmrim0lnbuv83',1411071317,86400,'',NULL),('unn1gr87ai08smq4nbajgd2im6',1410653860,86400,'',NULL),('uopa0st04l8f30e56s3hb1hja3',1407277385,86400,'redirectURL|s:6:\"/login\";Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"46\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"752940f771f4e2687de0ef1400effba5\";}twitter_lock|i:1;twitter_uid|b:0;',1),('uoq75ug6bbq8471jejmeve5un7',1406901602,86400,'',NULL),('uot0thjeujgu3nl6dpe63ikrv0',1412260961,86400,'',NULL),('up2dudodfdeshukkumgq6q6060',1408490103,86400,'',NULL),('up5elnfefsbkmdqikc6q1k0vq3',1408523578,86400,'',NULL),('up862koqil7qedet60snhd73k4',1408566682,86400,'',NULL),('uphmprb3k8lgegtj4op3am8320',1410905867,86400,'',NULL),('uq0556v53vtassl04nsddfj0e6',1407241901,86400,'',NULL),('uq47u6m8qfsp344u5eu4p2t314',1408541905,86400,'',NULL),('uq53rlkdvhc5mdj8ro18729ne3',1406901607,86400,'redirectURL|s:6:\"/login\";ActivityFormToken|a:1:{s:5:\"token\";s:32:\"e07a633677029561b96247c617bf2645\";}Zend_Auth|a:1:{s:7:\"storage\";i:1;}login_id|s:2:\"40\";twitter_lock|i:1;twitter_uid|b:0;',1),('uqvsft13r7n2l0k8e1an1ud061',1408525985,86400,'',NULL),('ur4uft2pcpf6k0npsjapb1nop5',1406895179,86400,'',NULL),('ur8chj6dfmjsso29htp0869ld6',1411109586,86400,'',NULL),('usjtk6g4v56c5ts448ui712sm0',1410655675,86400,'',NULL),('ut148dc1b0hitcu9udvti79bp6',1408537076,86400,'',NULL),('ut5nt4nni50e7roirdsevnbpk1',1410651436,86400,'',NULL),('uvmo08cduo8b6ro52948m778q4',1407240524,86400,'',NULL),('v0fs66kro04vnm0t25rv49lvc3',1412675627,86400,'',NULL),('v1edacghflnrl9gc1ohmqo9tv6',1409003595,86400,'',NULL),('v25v3844es0gu7898lhqa0eng0',1409730337,86400,'',NULL),('v2vgoq1106u6vr7goefcop7ja3',1409733162,86400,'',NULL),('v3314cfe9fbjlr7jt7rmhdhv53',1412247724,86400,'',NULL),('v37bfo2ct9t6hspcb0lvb307i3',1409127520,86400,'',NULL),('v3oacfs97ls0p53rv281v96645',1409132866,86400,'',NULL),('v4046ldhm6jcr96h6nc8jftt32',1412259988,86400,'',NULL),('v46k1njmflpoh0m7rvbonfhg97',1407261124,86400,'',NULL),('v4bgjkoigj1mealbh54gglet95',1409729738,86400,'',NULL),('v5o6u79lguf5o95ino81qtk3s5',1409750704,86400,'',NULL),('v6j445igos6a0f40ci0ginkau1',1408572809,86400,'',NULL),('v7a7b5e78jq8cprngldemlu4a5',1408538854,86400,'',NULL),('v7tb61i5ed7o4ecl6jjfrr59o7',1408527382,86400,'',NULL),('v8io31u5s3mvcgo9qsrvi40sn2',1412757867,86400,'',NULL),('vakonjgg2ipnp97bjif1qbeq74',1412258223,86400,'',NULL),('vasaqhdn2m9499eg3hp92681l2',1408574374,86400,'',NULL),('vat72uu8nng4fjh2pe039emqn4',1409129847,86400,'',NULL),('vb1vb12e1s111qmhi1qqs15kk7',1410900347,86400,'',NULL),('vbk8tb7msb6jom5d2k1ckjonq3',1408538794,86400,'',NULL),('vcfbtbb6fqrnilcigcm6jbl9b2',1412751741,86400,'',NULL),('vcin1v6jfoteb3ktmbo43do036',1409732268,86400,'',NULL),('vd3pa0fdpp3lus6puefco26rj7',1411073859,86400,'',NULL),('vdju124ge5i139np4vnb9f3hn2',1409739203,86400,'',NULL),('veg3deau4gakh3q9f4grm95k31',1409736851,86400,'',NULL),('veqa3871crfpd2mmbbunsvet51',1412584389,86400,'',NULL),('vf231jg9h6rve05ap5d50i97t6',1410898798,86400,'',NULL),('vffj8igeuq3kuvc494lfmk62l3',1406897217,86400,'',NULL),('vfpm7o3ivjc893vkr8kejecc25',1412340470,86400,'',NULL),('vgc0g0vl23lk3vlsa3mrgaioi5',1408573769,86400,'',NULL),('vgo4vstdvl2j76t8091661rud0',1410654850,86400,'',NULL),('vh7paqqpcvfv8komfq8ro0ok97',1410991473,86400,'',NULL),('vhc0f42nhapg4nsopgmmkj51m0',1410899667,86400,'',NULL),('vicn2a9fqp5rp1r63p36oh7br1',1410648383,86400,'',NULL),('vka749tdj33je3o6a3c46onra5',1409061475,86400,'',NULL),('vlfkn8ure0cmrbmr2inktb7h15',1409742585,86400,'',NULL),('vlpk5i2arb3eqiri8t89647qe3',1409699680,86400,'',NULL),('vlu1av66t5es2ng6k01hlud471',1410991336,86400,'',NULL),('vngog2thd123gho8fga5m7sae6',1408540103,86400,'',NULL),('vp3uh23fe9ivbulknpbjgvtlt1',1409127400,86400,'',NULL),('vrro18ns7p4c5lvdti0sdo7io1',1412325607,86400,'',NULL);
/*!40000 ALTER TABLE `engine4_core_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_settings`
--

DROP TABLE IF EXISTS `engine4_core_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_settings` (
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_settings`
--

LOCK TABLES `engine4_core_settings` WRITE;
/*!40000 ALTER TABLE `engine4_core_settings` DISABLE KEYS */;
INSERT INTO `engine4_core_settings` VALUES ('activity.content','everyone'),('activity.disallowed','N'),('activity.filter','1'),('activity.length','15'),('activity.liveupdate','120000'),('activity.publish','1'),('activity.userdelete','1'),('activity.userlength','5'),('core.admin.mode','none'),('core.admin.password',''),('core.admin.reauthenticate','0'),('core.admin.timeout','600'),('core.doctype','XHTML1_STRICT'),('core.facebook.enable','none'),('core.facebook.key',''),('core.facebook.secret',''),('core.general.browse','1'),('core.general.commenthtml',''),('core.general.notificationupdate','120000'),('core.general.portal','1'),('core.general.profile','1'),('core.general.quota','0'),('core.general.search','1'),('core.general.site.title','My Community'),('core.license.email','email@domain.com'),('core.license.key','0708-8721-8374-0672'),('core.license.statistics','0'),('core.locale.locale','auto'),('core.locale.timezone','Europe/Athens'),('core.log.adapter','file'),('core.mail.count','25'),('core.mail.enabled','1'),('core.mail.from','email@domain.com'),('core.mail.name','Site Admin'),('core.mail.queueing','1'),('core.secret','a56fb737dc73511e64cc1ca2a82374c8beb873ca'),('core.site.counter','14'),('core.site.creation','2014-06-17 07:41:35'),('core.site.title','Social Network'),('core.spam.censor',''),('core.spam.comment','0'),('core.spam.contact','0'),('core.spam.invite','0'),('core.spam.ipbans',''),('core.spam.login','0'),('core.spam.signup','0'),('core.tasks.count','1'),('core.tasks.interval','60'),('core.tasks.jobs','2'),('core.tasks.key','507d167d'),('core.tasks.last','1415220425'),('core.tasks.mode','curl'),('core.tasks.pid',''),('core.tasks.processes','3'),('core.tasks.time','120'),('core.tasks.timeout','900'),('core.thumbnails.icon.height','48'),('core.thumbnails.icon.mode','crop'),('core.thumbnails.icon.width','48'),('core.thumbnails.main.height','720'),('core.thumbnails.main.mode','resize'),('core.thumbnails.main.width','720'),('core.thumbnails.normal.height','160'),('core.thumbnails.normal.mode','resize'),('core.thumbnails.normal.width','140'),('core.thumbnails.profile.height','400'),('core.thumbnails.profile.mode','resize'),('core.thumbnails.profile.width','200'),('core.translate.adapter','csv'),('core.twitter.enable','none'),('core.twitter.key',''),('core.twitter.secret',''),('event.bbcode','1'),('event.billing.environment','sandbox'),('event.billing.merchant.id','987gh2rm4k6jpxqm'),('event.billing.private.key','42fc55d49446dc7b37dfe656182aeb15'),('event.billing.public.key','834r6526cdhd9g5z'),('event.html','1'),('event.percent','7'),('invite.allowCustomMessage','1'),('invite.fromEmail',''),('invite.fromName',''),('invite.max','10'),('invite.message','You are being invited to join our social network.'),('invite.subject','Join Us'),('merchant.account.chf','NewroSoftMods_CHF'),('merchant.account.eur','NewroSoftMods_EUR'),('merchant.account.gbp','NewroSoftMods_GBP'),('merchant.account.usd','ycxxdndc7rzjwvh8'),('payment.benefit','all'),('payment.currency','USD'),('payment.secret','64624f2c1098b2497c9200601fa27aa6'),('storage.service.mirrored.counter','0'),('storage.service.mirrored.index','0'),('storage.service.roundrobin.counter','0'),('user.friends.direction','1'),('user.friends.eligible','2'),('user.friends.lists','1'),('user.friends.verification','1'),('user.signup.approve','1'),('user.signup.checkemail','1'),('user.signup.inviteonly','0'),('user.signup.random','0'),('user.signup.terms','1'),('user.signup.username','1'),('user.signup.verifyemail','0'),('user.support.links','0');
/*!40000 ALTER TABLE `engine4_core_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_statistics`
--

DROP TABLE IF EXISTS `engine4_core_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_statistics` (
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_statistics`
--

LOCK TABLES `engine4_core_statistics` WRITE;
/*!40000 ALTER TABLE `engine4_core_statistics` DISABLE KEYS */;
INSERT INTO `engine4_core_statistics` VALUES ('core.emails','2014-07-02 10:00:00',16),('core.emails','2014-08-01 12:00:00',29),('core.emails','2014-08-17 09:00:00',1),('core.emails','2014-08-17 11:00:00',1),('core.emails','2014-08-20 08:00:00',2),('core.emails','2014-08-20 09:00:00',4),('core.emails','2014-08-20 12:00:00',1),('core.emails','2014-08-20 13:00:00',1),('core.emails','2014-08-20 20:00:00',1),('core.emails','2014-08-20 21:00:00',2),('core.emails','2014-08-27 08:00:00',3),('core.emails','2014-09-13 22:00:00',1),('core.emails','2014-09-14 23:00:00',1),('core.emails','2014-09-17 22:00:00',1),('core.views','2014-06-17 07:00:00',1),('core.views','2014-06-17 09:00:00',3),('core.views','2014-06-17 10:00:00',6),('core.views','2014-06-17 14:00:00',3),('core.views','2014-06-17 16:00:00',10),('core.views','2014-06-19 15:00:00',7),('core.views','2014-06-20 06:00:00',1),('core.views','2014-06-20 12:00:00',1),('core.views','2014-06-22 15:00:00',7),('core.views','2014-06-22 16:00:00',3),('core.views','2014-06-23 06:00:00',1),('core.views','2014-06-23 07:00:00',28),('core.views','2014-06-23 08:00:00',94),('core.views','2014-06-23 11:00:00',13),('core.views','2014-06-23 14:00:00',4),('core.views','2014-06-23 15:00:00',7),('core.views','2014-06-24 07:00:00',18),('core.views','2014-06-24 08:00:00',1),('core.views','2014-06-24 09:00:00',11),('core.views','2014-06-24 10:00:00',19),('core.views','2014-06-24 12:00:00',2),('core.views','2014-06-25 13:00:00',5),('core.views','2014-06-26 08:00:00',1),('core.views','2014-06-26 10:00:00',1),('core.views','2014-06-28 14:00:00',5),('core.views','2014-06-28 15:00:00',5),('core.views','2014-06-29 09:00:00',2),('core.views','2014-06-29 14:00:00',1),('core.views','2014-06-30 10:00:00',12),('core.views','2014-06-30 11:00:00',29),('core.views','2014-07-01 09:00:00',55),('core.views','2014-07-01 20:00:00',13),('core.views','2014-07-01 21:00:00',28),('core.views','2014-07-01 22:00:00',2),('core.views','2014-07-02 06:00:00',2),('core.views','2014-07-02 07:00:00',28),('core.views','2014-07-02 08:00:00',42),('core.views','2014-07-02 09:00:00',5),('core.views','2014-07-02 10:00:00',37),('core.views','2014-07-02 11:00:00',6),('core.views','2014-07-05 06:00:00',4),('core.views','2014-07-05 14:00:00',2),('core.views','2014-07-07 08:00:00',1),('core.views','2014-07-07 18:00:00',6),('core.views','2014-07-07 19:00:00',9),('core.views','2014-07-08 07:00:00',5),('core.views','2014-07-08 08:00:00',17),('core.views','2014-07-08 09:00:00',40),('core.views','2014-07-08 10:00:00',41),('core.views','2014-07-08 12:00:00',2),('core.views','2014-07-08 13:00:00',14),('core.views','2014-07-08 14:00:00',6),('core.views','2014-07-08 19:00:00',1),('core.views','2014-07-09 06:00:00',1),('core.views','2014-07-09 07:00:00',4),('core.views','2014-07-09 08:00:00',1),('core.views','2014-07-09 09:00:00',14),('core.views','2014-07-09 10:00:00',13),('core.views','2014-07-09 11:00:00',2),('core.views','2014-07-09 12:00:00',20),('core.views','2014-07-09 14:00:00',17),('core.views','2014-07-09 15:00:00',49),('core.views','2014-07-09 19:00:00',16),('core.views','2014-07-10 08:00:00',124),('core.views','2014-07-10 09:00:00',55),('core.views','2014-07-10 10:00:00',33),('core.views','2014-07-10 11:00:00',41),('core.views','2014-07-10 12:00:00',60),('core.views','2014-07-10 13:00:00',9),('core.views','2014-07-10 15:00:00',12),('core.views','2014-07-10 16:00:00',64),('core.views','2014-07-10 17:00:00',2),('core.views','2014-07-10 18:00:00',1),('core.views','2014-07-10 19:00:00',39),('core.views','2014-07-10 20:00:00',8),('core.views','2014-07-10 21:00:00',1),('core.views','2014-07-11 07:00:00',19),('core.views','2014-07-11 08:00:00',53),('core.views','2014-07-11 09:00:00',9),('core.views','2014-07-11 11:00:00',23),('core.views','2014-07-11 12:00:00',42),('core.views','2014-07-11 13:00:00',33),('core.views','2014-07-11 14:00:00',2),('core.views','2014-07-11 17:00:00',3),('core.views','2014-07-11 18:00:00',1),('core.views','2014-07-11 20:00:00',2),('core.views','2014-07-11 22:00:00',14),('core.views','2014-07-11 23:00:00',7),('core.views','2014-07-12 06:00:00',3),('core.views','2014-07-13 08:00:00',6),('core.views','2014-07-13 09:00:00',30),('core.views','2014-07-13 11:00:00',10),('core.views','2014-07-13 12:00:00',64),('core.views','2014-07-13 17:00:00',2),('core.views','2014-07-13 18:00:00',42),('core.views','2014-07-13 19:00:00',2),('core.views','2014-07-13 20:00:00',4),('core.views','2014-07-14 08:00:00',1),('core.views','2014-07-14 11:00:00',3),('core.views','2014-07-14 12:00:00',30),('core.views','2014-07-14 13:00:00',66),('core.views','2014-07-14 14:00:00',32),('core.views','2014-07-15 09:00:00',1),('core.views','2014-07-15 10:00:00',3),('core.views','2014-07-15 12:00:00',30),('core.views','2014-07-15 22:00:00',5),('core.views','2014-07-16 16:00:00',21),('core.views','2014-07-23 13:00:00',4),('core.views','2014-07-23 14:00:00',2),('core.views','2014-07-23 15:00:00',44),('core.views','2014-07-23 16:00:00',10),('core.views','2014-07-23 17:00:00',10),('core.views','2014-07-23 18:00:00',17),('core.views','2014-07-24 08:00:00',6),('core.views','2014-07-24 09:00:00',33),('core.views','2014-07-24 10:00:00',42),('core.views','2014-07-24 14:00:00',1),('core.views','2014-07-25 07:00:00',1),('core.views','2014-07-25 08:00:00',29),('core.views','2014-07-25 09:00:00',47),('core.views','2014-07-25 11:00:00',1),('core.views','2014-07-25 13:00:00',3),('core.views','2014-07-27 17:00:00',1),('core.views','2014-07-30 12:00:00',1),('core.views','2014-07-30 13:00:00',19),('core.views','2014-07-30 17:00:00',5),('core.views','2014-07-31 10:00:00',2),('core.views','2014-07-31 12:00:00',6),('core.views','2014-07-31 16:00:00',4),('core.views','2014-08-01 06:00:00',3),('core.views','2014-08-01 10:00:00',45),('core.views','2014-08-01 11:00:00',12),('core.views','2014-08-01 12:00:00',103),('core.views','2014-08-01 13:00:00',32),('core.views','2014-08-04 20:00:00',7),('core.views','2014-08-05 10:00:00',5),('core.views','2014-08-05 12:00:00',13),('core.views','2014-08-05 20:00:00',1),('core.views','2014-08-06 14:00:00',3),('core.views','2014-08-07 12:00:00',1),('core.views','2014-08-17 09:00:00',20),('core.views','2014-08-17 11:00:00',33),('core.views','2014-08-18 13:00:00',1),('core.views','2014-08-19 07:00:00',4),('core.views','2014-08-19 22:00:00',5),('core.views','2014-08-19 23:00:00',10),('core.views','2014-08-20 08:00:00',62),('core.views','2014-08-20 09:00:00',77),('core.views','2014-08-20 11:00:00',9),('core.views','2014-08-20 12:00:00',16),('core.views','2014-08-20 13:00:00',36),('core.views','2014-08-20 20:00:00',71),('core.views','2014-08-20 21:00:00',41),('core.views','2014-08-20 22:00:00',13),('core.views','2014-08-21 16:00:00',1),('core.views','2014-08-24 12:00:00',1),('core.views','2014-08-24 14:00:00',9),('core.views','2014-08-25 19:00:00',5),('core.views','2014-08-25 20:00:00',3),('core.views','2014-08-26 13:00:00',24),('core.views','2014-08-26 14:00:00',8),('core.views','2014-08-27 07:00:00',1),('core.views','2014-08-27 08:00:00',42),('core.views','2014-08-27 09:00:00',10),('core.views','2014-08-27 10:00:00',4),('core.views','2014-08-27 11:00:00',1),('core.views','2014-08-28 09:00:00',2),('core.views','2014-09-02 08:00:00',6),('core.views','2014-09-02 09:00:00',1),('core.views','2014-09-02 12:00:00',1),('core.views','2014-09-02 15:00:00',1),('core.views','2014-09-02 17:00:00',2),('core.views','2014-09-02 19:00:00',8),('core.views','2014-09-02 21:00:00',29),('core.views','2014-09-02 22:00:00',29),('core.views','2014-09-03 07:00:00',101),('core.views','2014-09-03 08:00:00',98),('core.views','2014-09-03 09:00:00',2),('core.views','2014-09-03 10:00:00',77),('core.views','2014-09-03 11:00:00',30),('core.views','2014-09-03 12:00:00',156),('core.views','2014-09-03 13:00:00',15),('core.views','2014-09-03 16:00:00',6),('core.views','2014-09-13 22:00:00',34),('core.views','2014-09-13 23:00:00',36),('core.views','2014-09-14 00:00:00',82),('core.views','2014-09-14 22:00:00',4),('core.views','2014-09-14 23:00:00',117),('core.views','2014-09-15 00:00:00',31),('core.views','2014-09-15 13:00:00',1),('core.views','2014-09-16 19:00:00',24),('core.views','2014-09-16 20:00:00',21),('core.views','2014-09-17 21:00:00',5),('core.views','2014-09-17 22:00:00',59),('core.views','2014-09-18 20:00:00',29),('core.views','2014-09-18 21:00:00',2),('core.views','2014-09-23 19:00:00',8),('core.views','2014-10-01 13:00:00',5),('core.views','2014-10-02 08:00:00',1),('core.views','2014-10-02 11:00:00',10),('core.views','2014-10-02 12:00:00',34),('core.views','2014-10-03 06:00:00',1),('core.views','2014-10-03 08:00:00',9),('core.views','2014-10-03 10:00:00',14),('core.views','2014-10-03 11:00:00',40),('core.views','2014-10-03 12:00:00',28),('core.views','2014-10-03 13:00:00',10),('core.views','2014-10-03 14:00:00',1),('core.views','2014-10-03 15:00:00',1),('core.views','2014-10-06 08:00:00',1),('core.views','2014-10-06 09:00:00',12),('core.views','2014-10-06 11:00:00',1),('core.views','2014-10-07 08:00:00',1),('core.views','2014-10-08 06:00:00',1),('core.views','2014-10-08 13:00:00',18),('core.views','2014-10-08 15:00:00',2),('core.views','2014-10-08 16:00:00',5),('core.views','2014-10-09 08:00:00',3),('core.views','2014-10-09 14:00:00',45),('core.views','2014-10-09 15:00:00',3),('core.views','2014-10-09 19:00:00',4),('core.views','2014-10-10 08:00:00',2),('core.views','2014-10-10 15:00:00',4),('core.views','2014-10-29 12:00:00',7),('core.views','2014-10-29 13:00:00',3),('core.views','2014-10-29 14:00:00',9),('core.views','2014-10-29 15:00:00',8),('core.views','2014-10-29 16:00:00',6),('core.views','2014-10-30 10:00:00',1),('core.views','2014-10-30 12:00:00',12),('core.views','2014-11-04 22:00:00',29),('core.views','2014-11-05 13:00:00',13),('core.views','2014-11-05 14:00:00',2),('messages.creations','2014-08-20 13:00:00',1),('user.creations','2014-06-23 08:00:00',5),('user.creations','2014-08-17 09:00:00',1),('user.creations','2014-08-17 11:00:00',1),('user.creations','2014-08-19 23:00:00',1),('user.creations','2014-08-20 08:00:00',1),('user.creations','2014-09-13 22:00:00',1),('user.creations','2014-09-14 23:00:00',1),('user.creations','2014-09-17 22:00:00',1),('user.friendships','2014-08-20 09:00:00',1),('user.friendships','2014-08-20 11:00:00',1),('user.friendships','2014-08-27 08:00:00',1),('user.logins','2014-06-19 15:00:00',1),('user.logins','2014-06-22 15:00:00',1),('user.logins','2014-06-23 08:00:00',2),('user.logins','2014-06-24 07:00:00',3),('user.logins','2014-06-28 14:00:00',1),('user.logins','2014-06-28 15:00:00',2),('user.logins','2014-06-30 10:00:00',3),('user.logins','2014-07-01 20:00:00',2),('user.logins','2014-07-05 06:00:00',1),('user.logins','2014-07-07 08:00:00',1),('user.logins','2014-07-08 13:00:00',1),('user.logins','2014-07-09 15:00:00',2),('user.logins','2014-07-11 07:00:00',1),('user.logins','2014-07-11 08:00:00',1),('user.logins','2014-07-13 08:00:00',1),('user.logins','2014-07-13 09:00:00',2),('user.logins','2014-07-15 12:00:00',3),('user.logins','2014-07-16 16:00:00',1),('user.logins','2014-07-23 13:00:00',1),('user.logins','2014-07-23 15:00:00',3),('user.logins','2014-07-30 13:00:00',1),('user.logins','2014-07-31 10:00:00',1),('user.logins','2014-08-01 10:00:00',4),('user.logins','2014-08-01 12:00:00',5),('user.logins','2014-08-04 20:00:00',1),('user.logins','2014-08-05 10:00:00',1),('user.logins','2014-08-05 12:00:00',1),('user.logins','2014-08-06 14:00:00',1),('user.logins','2014-08-17 09:00:00',1),('user.logins','2014-08-17 11:00:00',1),('user.logins','2014-08-19 07:00:00',1),('user.logins','2014-08-20 08:00:00',2),('user.logins','2014-08-20 09:00:00',2),('user.logins','2014-08-20 13:00:00',3),('user.logins','2014-08-20 20:00:00',4),('user.logins','2014-08-26 13:00:00',2),('user.logins','2014-08-27 08:00:00',1),('user.logins','2014-08-28 09:00:00',1),('user.logins','2014-09-02 08:00:00',1),('user.logins','2014-09-02 17:00:00',1),('user.logins','2014-09-02 21:00:00',3),('user.logins','2014-09-02 22:00:00',3),('user.logins','2014-09-03 07:00:00',3),('user.logins','2014-09-03 08:00:00',5),('user.logins','2014-09-03 09:00:00',1),('user.logins','2014-09-03 10:00:00',1),('user.logins','2014-09-03 12:00:00',1),('user.logins','2014-09-03 13:00:00',1),('user.logins','2014-09-13 22:00:00',3),('user.logins','2014-09-14 22:00:00',1),('user.logins','2014-09-14 23:00:00',4),('user.logins','2014-09-15 00:00:00',1),('user.logins','2014-09-16 19:00:00',2),('user.logins','2014-09-16 20:00:00',2),('user.logins','2014-09-17 21:00:00',1),('user.logins','2014-09-17 22:00:00',1),('user.logins','2014-09-18 20:00:00',2),('user.logins','2014-10-02 11:00:00',1),('user.logins','2014-10-02 12:00:00',3),('user.logins','2014-10-03 11:00:00',2),('user.logins','2014-10-06 09:00:00',1),('user.logins','2014-10-08 13:00:00',2),('user.logins','2014-10-09 08:00:00',1),('user.logins','2014-10-09 14:00:00',1),('user.logins','2014-10-09 19:00:00',1),('user.logins','2014-10-10 15:00:00',1),('user.logins','2014-10-29 12:00:00',1),('user.logins','2014-11-04 22:00:00',1),('user.logins','2014-11-05 13:00:00',2);
/*!40000 ALTER TABLE `engine4_core_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_status`
--

DROP TABLE IF EXISTS `engine4_core_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_status` (
  `status_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_status`
--

LOCK TABLES `engine4_core_status` WRITE;
/*!40000 ALTER TABLE `engine4_core_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_styles`
--

DROP TABLE IF EXISTS `engine4_core_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_styles` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `style` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_styles`
--

LOCK TABLES `engine4_core_styles` WRITE;
/*!40000 ALTER TABLE `engine4_core_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_tagmaps`
--

DROP TABLE IF EXISTS `engine4_core_tagmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_tagmaps` (
  `tagmap_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `tagger_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tagger_id` int(11) unsigned NOT NULL,
  `tag_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `extra` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`tagmap_id`),
  KEY `resource_type` (`resource_type`,`resource_id`),
  KEY `tagger_type` (`tagger_type`,`tagger_id`),
  KEY `tag_type` (`tag_type`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_tagmaps`
--

LOCK TABLES `engine4_core_tagmaps` WRITE;
/*!40000 ALTER TABLE `engine4_core_tagmaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_tagmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_tags`
--

DROP TABLE IF EXISTS `engine4_core_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_tags` (
  `tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_tags`
--

LOCK TABLES `engine4_core_tags` WRITE;
/*!40000 ALTER TABLE `engine4_core_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_core_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_tasks`
--

DROP TABLE IF EXISTS `engine4_core_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_tasks` (
  `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `timeout` int(11) unsigned NOT NULL DEFAULT '60',
  `processes` smallint(3) unsigned NOT NULL DEFAULT '1',
  `semaphore` smallint(3) NOT NULL DEFAULT '0',
  `started_last` int(11) NOT NULL DEFAULT '0',
  `started_count` int(11) unsigned NOT NULL DEFAULT '0',
  `completed_last` int(11) NOT NULL DEFAULT '0',
  `completed_count` int(11) unsigned NOT NULL DEFAULT '0',
  `failure_last` int(11) NOT NULL DEFAULT '0',
  `failure_count` int(11) unsigned NOT NULL DEFAULT '0',
  `success_last` int(11) NOT NULL DEFAULT '0',
  `success_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `plugin` (`plugin`),
  KEY `module` (`module`),
  KEY `started_last` (`started_last`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_tasks`
--

LOCK TABLES `engine4_core_tasks` WRITE;
/*!40000 ALTER TABLE `engine4_core_tasks` DISABLE KEYS */;
INSERT INTO `engine4_core_tasks` VALUES (1,'Job Queue','core','Core_Plugin_Task_Jobs',5,1,0,1412956207,1730,1412956207,1730,0,0,1412956207,1730),(2,'Background Mailer','core','Core_Plugin_Task_Mail',15,1,1,1412955724,262,1406895630,6,0,0,1406895630,6),(3,'Cache Prefetch','core','Core_Plugin_Task_Prefetch',300,1,0,1412956207,523,1412956208,523,0,0,1412956208,523),(4,'Statistics','core','Core_Plugin_Task_Statistics',43200,1,0,1412929446,32,1412929446,32,0,0,1412929446,32),(5,'Log Rotation','core','Core_Plugin_Task_LogRotation',7200,1,0,1412954402,70,1412954402,70,0,0,1412954402,70),(6,'Member Data Maintenance','user','User_Plugin_Task_Cleanup',60,1,0,1412956086,859,1412956087,859,0,0,1412956087,859),(7,'Payment Maintenance','user','Payment_Plugin_Task_Cleanup',43200,1,0,1412929566,32,1412929567,32,0,0,1412929567,32),(9,'Refresh Class Status','event','Event_Plugin_Task_RefreshStatus',60,1,0,1412956087,825,1412956087,825,0,0,1412956087,825);
/*!40000 ALTER TABLE `engine4_core_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_core_themes`
--

DROP TABLE IF EXISTS `engine4_core_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_core_themes` (
  `theme_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`theme_id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_core_themes`
--

LOCK TABLES `engine4_core_themes` WRITE;
/*!40000 ALTER TABLE `engine4_core_themes` DISABLE KEYS */;
INSERT INTO `engine4_core_themes` VALUES (1,'default','Default','',0),(2,'midnight','Midnight','',0),(3,'clean','Clean','',0),(4,'modern','Modern','',0),(5,'bamboo','Bamboo','',0),(6,'digita','Digita','',0),(7,'grid-blue','Grid Blue','',0),(8,'grid-brown','Grid Brown','',0),(9,'grid-dark','Grid Dark','',0),(10,'grid-gray','Grid Gray','',0),(11,'grid-green','Grid Green','',0),(12,'grid-pink','Grid Pink','',0),(13,'grid-purple','Grid Purple','',0),(14,'grid-red','Grid Red','',0),(15,'kandy-cappuccino','Kandy Cappuccino','',0),(16,'kandy-limeorange','Kandy Limeorange','',0),(17,'kandy-mangoberry','Kandy Mangoberry','',0),(18,'kandy-watermelon','Kandy Watermelon','',0),(19,'musicbox-blue','Musicbox Blue','',0),(20,'musicbox-brown','Musicbox Brown','',0),(21,'musicbox-gray','Musicbox Gray','',0),(22,'musicbox-green','Musicbox Green','',0),(23,'musicbox-pink','Musicbox Pink','',0),(24,'musicbox-purple','Musicbox Purple','',0),(25,'musicbox-red','Musicbox Red','',0),(26,'musicbox-yellow','Musicbox Yellow','',0),(27,'quantum-beige','Quantum Beige','',0),(28,'quantum-blue','Quantum Blue','',1),(29,'quantum-gray','Quantum Gray','',0),(30,'quantum-green','Quantum Green','',0),(31,'quantum-orange','Quantum Orange','',0),(32,'quantum-pink','Quantum Pink','',0),(33,'quantum-purple','Quantum Purple','',0),(34,'quantum-red','Quantum Red','',0),(35,'slipstream','Slipstream','',0),(36,'snowbot','Snowbot','',0);
/*!40000 ALTER TABLE `engine4_core_themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_albums`
--

DROP TABLE IF EXISTS `engine4_event_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_albums` (
  `album_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  `collectible_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`album_id`),
  KEY `event_id` (`event_id`),
  KEY `search` (`search`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_albums`
--

LOCK TABLES `engine4_event_albums` WRITE;
/*!40000 ALTER TABLE `engine4_event_albums` DISABLE KEYS */;
INSERT INTO `engine4_event_albums` VALUES (5,5,'','','2014-07-14 14:05:07','2014-07-14 14:05:07',1,0,0,0,0),(18,18,'','','2014-08-17 11:23:46','2014-08-17 11:23:46',1,0,0,0,1),(20,20,'','','2014-08-20 09:14:47','2014-08-20 09:14:47',1,0,0,0,1),(25,25,'','','2014-09-03 07:28:14','2014-09-03 07:28:14',1,0,0,0,1),(26,26,'','','2014-09-03 12:05:04','2014-09-03 12:05:04',1,0,0,0,1),(28,28,'','','2014-09-13 22:45:25','2014-09-13 22:45:25',1,0,0,0,1),(29,29,'','','2014-09-14 23:12:27','2014-09-14 23:12:27',1,0,0,0,1),(30,30,'','','2014-09-14 23:57:31','2014-09-14 23:57:31',1,0,0,0,1),(33,33,'','','2014-10-03 12:50:39','2014-10-03 12:50:39',1,0,0,0,0),(34,34,'','','2014-10-09 14:20:05','2014-10-09 14:20:05',1,0,0,0,1),(35,35,'','','2014-11-05 13:27:31','2014-11-05 13:27:31',1,0,0,0,0);
/*!40000 ALTER TABLE `engine4_event_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_categories`
--

DROP TABLE IF EXISTS `engine4_event_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_categories` (
  `category_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_categories`
--

LOCK TABLES `engine4_event_categories` WRITE;
/*!40000 ALTER TABLE `engine4_event_categories` DISABLE KEYS */;
INSERT INTO `engine4_event_categories` VALUES (1,'Arts'),(2,'Business'),(3,'Conferences'),(4,'Festivals'),(5,'Food'),(6,'Fundraisers'),(7,'Galleries'),(8,'Health'),(9,'Just For Fun'),(10,'Kids'),(11,'Learning'),(12,'Literary'),(13,'Movies'),(14,'Museums'),(15,'Neighborhood'),(16,'Networking'),(17,'Nightlife'),(18,'On Campus'),(19,'Organizations'),(20,'Outdoors'),(21,'Pets'),(22,'Politics'),(23,'Sales'),(24,'Science'),(25,'Spirituality'),(26,'Sports'),(27,'Technology'),(28,'Theatre'),(29,'Other');
/*!40000 ALTER TABLE `engine4_event_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_events`
--

DROP TABLE IF EXISTS `engine4_event_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_events` (
  `event_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `parent_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `host` varchar(115) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(115) COLLATE utf8_unicode_ci NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `approval` tinyint(1) NOT NULL DEFAULT '0',
  `invite` tinyint(1) NOT NULL DEFAULT '0',
  `photo_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `price` decimal(12,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `bank_iban` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bank_bic` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bank_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bank_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bank_country` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `class_starter` text COLLATE utf8_unicode_ci NOT NULL,
  `class_main` text COLLATE utf8_unicode_ci NOT NULL,
  `class_dessert` text COLLATE utf8_unicode_ci NOT NULL,
  `class_beverages` text COLLATE utf8_unicode_ci NOT NULL,
  `class_takeaways` text COLLATE utf8_unicode_ci NOT NULL,
  `max_users` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('open','closed','verified','canceled','finished') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',
  PRIMARY KEY (`event_id`),
  KEY `user_id` (`user_id`),
  KEY `parent_type` (`parent_type`,`parent_id`),
  KEY `starttime` (`starttime`),
  KEY `search` (`search`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_events`
--

LOCK TABLES `engine4_event_events` WRITE;
/*!40000 ALTER TABLE `engine4_event_events` DISABLE KEYS */;
INSERT INTO `engine4_event_events` VALUES (5,'Event 2','sdf asdfa sdf d',2,'user',2,1,'2014-07-14 14:05:06','2014-07-14 14:05:06','2014-07-21 08:00:00','2014-07-31 08:00:00','user 1','London',5,2,1,0,0,6,254.00,'USD','6546sf4','','','','','a:1:{i:0;s:17:\"as df asdf asdf a\";}','a:1:{i:0;s:20:\"asd fasdf adsf asdf \";}','a:0:{}','a:1:{i:0;s:29:\"sdf asdf asdfadsf asdfasf asf\";}','','','finished'),(18,'Bacon Strips','Learn how to make Bacon Strips out of Bacon\r\n\r\nI\'m happy to show you everything about Bacon. Bacon is my life.\r\n\r\nPigs beware! Bacon lovers on the move. ',7,'user',7,1,'2014-08-17 11:23:45','2014-08-17 11:26:26','2014-08-31 16:00:00','2014-08-31 21:00:00','Markus Liechti','Zürich',12,1,1,0,33,5,34.00,'CHF','CH123456789000000','BIC123456','Markus Liechti','Gubelstrasse 34','CH','a:2:{i:0;s:11:\"Bacon Salad\";i:1;s:10:\"Cheese Dip\";}','a:2:{i:0;s:21:\"Bacon Strips Surpreme\";i:1;s:22:\"Spagghetti à la Bacon\";}','a:3:{i:0;s:15:\"Chocolate Dream\";i:1;s:16:\"Bacon Ice Cream \";i:2;s:29:\"Milk Shake with Bacon Chunks \";}','a:2:{i:0;s:5:\"Water\";i:1;s:8:\"Red Wine\";}','You will learn a lot. \r\nAnd I mean a lot.\r\nBelieve me!','2','finished'),(20,'Hulk Hogan\'s Class','We just eat raw eggs to get the proteins we need to build up cool muscles. ',8,'user',8,1,'2014-08-20 09:14:47','2014-08-20 09:14:47','2014-09-25 17:00:00','2014-09-25 21:00:00','Hulk Hogan','Konradstrasse 12, Zürich',48,4,1,0,53,20,2.00,'CHF','132324','341235','Hulk Hogan','1','BS','','a:1:{i:0;s:4:\"eggs\";}','','','','2','finished'),(25,'Sushi class','Sushi lalala',1,'user',1,1,'2014-09-03 07:28:13','2014-09-03 12:54:35','2014-09-01 15:00:00','2014-09-01 18:00:00','First Last','New York',64,2,1,0,65,5,100.00,'EUR','4111111111111111','CHAS - US - 33 - 555','Name','4 NEW YORK PLAZA FLOOR 15','US','a:1:{i:0;s:10:\"California\";}','a:1:{i:0;s:12:\"Philadelphia\";}','a:1:{i:0;s:12:\"Banana sushi\";}','','','2','finished'),(26,'Pasta Party','pasta',1,'user',1,1,'2014-09-03 12:05:04','2014-09-03 12:14:17','2014-09-02 12:00:00','2014-09-02 13:30:00','First Last','New York',23,1,1,0,69,5,100.00,'CHF','4111111111111111','CHAS - US - 33 - 555','Test Name','4 NEW YORK PLAZA FLOOR 15','US','a:1:{i:0;s:7:\"Ravioli\";}','a:1:{i:0;s:10:\"Fettuchini\";}','','','','2','finished'),(28,'Saussage Party','We will cook saussage',11,'user',11,1,'2014-09-13 22:45:24','2014-09-13 22:47:47','2014-09-24 16:00:00','2014-09-24 18:00:00','Peter North','My home',45,3,1,0,77,5,60.00,'CHF','345345','345345','Reto Spescha','Seestrasse 49','LU','a:2:{i:0;s:5:\"Salad\";i:1;s:4:\"Soup\";}','a:2:{i:0;s:26:\"Saussage with Tomato Sauce\";i:1;s:6:\"6 Eggs\";}','a:1:{i:0;s:8:\"Brownies\";}','a:1:{i:0;s:4:\"Wine\";}','you will learn how to cook Saussage','5','finished'),(29,'Peperoni Pizza','Pepperoni Pizza is the one and only!!',11,'user',11,1,'2014-09-14 23:12:27','2014-09-14 23:54:00','1970-01-01 00:00:00','1969-12-31 22:00:00','Peter North','home',18,2,1,0,81,5,80.00,'CHF','345345','345345','Reto Spescha','Seestrasse 49','CH','a:4:{i:0;s:5:\"Pizza\";i:1;s:5:\"Pizza\";i:2;s:5:\"Pizza\";i:3;s:5:\"Pizza\";}','a:3:{i:0;s:5:\"Pizza\";i:1;s:5:\"Pizza\";i:2;s:5:\"Pizza\";}','a:2:{i:0;s:5:\"Pizza\";i:1;s:5:\"Pizza\";}','a:1:{i:0;s:5:\"Pizza\";}','Pizza','','canceled'),(30,'Broccoly','Broccoly',11,'user',11,1,'2014-09-14 23:57:31','2014-09-14 23:57:31','2014-09-14 14:00:00','2014-09-14 16:00:00','Peter North','iu',8,1,1,0,89,3,66.00,'CHF','345345','345345','Reto Spescha','Seestrasse 49','AL','a:1:{i:0;s:8:\"Broccoly\";}','a:1:{i:0;s:8:\"Broccoly\";}','a:1:{i:0;s:8:\"Broccoly\";}','a:1:{i:0;s:8:\"Broccoly\";}','','','verified'),(33,'New Class test','fhvfjvfhkvfk',1,'user',1,1,'2014-10-03 12:50:38','2014-10-03 12:50:38','2014-10-13 00:00:00','2014-10-13 01:30:00','First Last','New York',10,3,1,0,0,5,50.00,'EUR','313233313333313','CHAS - US - 33 - 555','ghcj','4 NEW YORK PLAZA FLOOR 15','US','a:1:{i:0;s:5:\"ghvfh\";}','a:1:{i:0;s:5:\"vbkhv\";}','','','','2','finished'),(34,'Cupcake class','We\'ll make cupcakes!',1,'user',1,1,'2014-10-09 14:20:04','2014-10-09 14:20:05','2014-10-11 16:00:00','2014-10-11 18:00:00','First Last','New York',9,2,1,0,109,5,100.00,'EUR','313233313333313','CHAS - US - 33 - 555','Test Name','4 NEW YORK PLAZA FLOOR 15','US','a:1:{i:0;s:17:\"Chocolate cupcake\";}','a:1:{i:0;s:18:\"Strawberry cupcake\";}','a:1:{i:0;s:13:\"Lemon cupcake\";}','a:1:{i:0;s:8:\"Mint tea\";}','Cupcakes!!!','4','finished'),(35,'New Class test','test',1,'user',1,1,'2014-11-05 13:27:30','2014-11-05 13:27:30','2014-11-07 13:00:00','2014-11-07 15:00:00','First Last','New York',1,1,1,0,0,5,100.00,'CHF','5458897897070','CHAS - US - 33 - 555','Test Name','4 NEW YORK PLAZA FLOOR 15','US','a:1:{i:0;s:4:\"Test\";}','a:1:{i:0;s:4:\"Test\";}','','','','','open');
/*!40000 ALTER TABLE `engine4_event_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_membership`
--

DROP TABLE IF EXISTS `engine4_event_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `rsvp` tinyint(3) NOT NULL DEFAULT '0',
  `rsvp_update` datetime NOT NULL,
  `title` text COLLATE utf8_unicode_ci,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_membership`
--

LOCK TABLES `engine4_event_membership` WRITE;
/*!40000 ALTER TABLE `engine4_event_membership` DISABLE KEYS */;
INSERT INTO `engine4_event_membership` VALUES (5,2,1,1,1,NULL,10,'2014-07-14 14:05:06',NULL,'2014-07-14 14:05:06'),(5,3,1,1,1,NULL,3,'2014-07-14 14:07:58',NULL,'2014-07-14 14:07:16'),(18,7,1,1,1,NULL,10,'2014-08-17 11:23:45',NULL,'2014-08-17 11:23:45'),(20,7,1,1,1,NULL,3,'2014-09-17 22:29:35',NULL,'2014-09-17 22:02:29'),(20,8,1,1,1,NULL,10,'2014-08-20 09:14:47',NULL,'2014-08-20 09:14:47'),(20,13,1,1,1,NULL,3,'2014-09-18 20:57:05',NULL,'2014-09-17 22:43:13'),(25,1,1,1,1,NULL,10,'2014-09-03 07:28:13',NULL,'2014-09-03 07:28:13'),(26,1,1,1,1,NULL,10,'2014-09-03 12:05:04',NULL,'2014-09-03 12:05:04'),(28,11,1,1,1,NULL,10,'2014-09-13 22:45:24',NULL,'2014-09-13 22:45:24'),(29,9,1,1,1,NULL,4,'2014-09-14 23:43:54',NULL,'2014-09-14 23:40:26'),(29,11,1,1,1,NULL,10,'2014-09-14 23:12:27',NULL,'2014-09-14 23:12:27'),(30,11,1,1,1,NULL,10,'2014-09-14 23:57:31',NULL,'2014-09-14 23:57:31'),(33,1,1,1,1,NULL,10,'2014-10-03 12:50:38',NULL,'2014-10-03 12:50:38'),(33,2,1,1,1,NULL,3,'2014-10-08 13:56:38',NULL,'2014-10-08 13:55:46'),(33,4,0,1,1,NULL,4,'2014-10-03 13:09:28',NULL,'2014-10-03 12:50:50'),(34,1,1,1,1,NULL,10,'2014-10-09 14:20:04',NULL,'2014-10-09 14:20:04'),(34,2,0,1,1,NULL,4,'2014-10-09 14:26:30',NULL,'2014-10-09 14:24:20'),(35,1,1,1,1,NULL,10,'2014-11-05 13:27:30',NULL,'2014-11-05 13:27:30');
/*!40000 ALTER TABLE `engine4_event_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_photos`
--

DROP TABLE IF EXISTS `engine4_event_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_photos` (
  `photo_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL,
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  KEY `album_id` (`album_id`),
  KEY `event_id` (`event_id`),
  KEY `collection_id` (`collection_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_photos`
--

LOCK TABLES `engine4_event_photos` WRITE;
/*!40000 ALTER TABLE `engine4_event_photos` DISABLE KEYS */;
INSERT INTO `engine4_event_photos` VALUES (8,18,18,7,'','',18,33,'2014-08-17 11:26:26','2014-08-17 11:26:26',0,0),(10,20,20,8,'','',20,53,'2014-08-20 09:14:47','2014-08-20 09:14:47',0,0),(13,25,25,1,'','',25,65,'2014-09-03 07:28:14','2014-09-03 07:28:14',0,0),(14,26,26,1,'','',26,69,'2014-09-03 12:05:04','2014-09-03 12:05:04',0,0),(15,28,28,11,'','',28,77,'2014-09-13 22:47:47','2014-09-13 22:47:47',0,0),(16,29,29,11,'','',29,81,'2014-09-14 23:12:27','2014-09-14 23:12:27',0,0),(17,30,30,11,'','',30,89,'2014-09-14 23:57:31','2014-09-14 23:57:31',0,0),(21,34,34,1,'','',34,109,'2014-10-09 14:20:05','2014-10-09 14:20:05',0,0);
/*!40000 ALTER TABLE `engine4_event_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_posts`
--

DROP TABLE IF EXISTS `engine4_event_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_posts` (
  `post_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL,
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `topic_id` (`topic_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_posts`
--

LOCK TABLES `engine4_event_posts` WRITE;
/*!40000 ALTER TABLE `engine4_event_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_event_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_topics`
--

DROP TABLE IF EXISTS `engine4_event_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_topics` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastpost_id` int(11) unsigned NOT NULL,
  `lastposter_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`topic_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_topics`
--

LOCK TABLES `engine4_event_topics` WRITE;
/*!40000 ALTER TABLE `engine4_event_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_event_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_topicwatches`
--

DROP TABLE IF EXISTS `engine4_event_topicwatches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_topicwatches` (
  `resource_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `watch` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`resource_id`,`topic_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_topicwatches`
--

LOCK TABLES `engine4_event_topicwatches` WRITE;
/*!40000 ALTER TABLE `engine4_event_topicwatches` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_event_topicwatches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_event_transactions`
--

DROP TABLE IF EXISTS `engine4_event_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_event_transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `event_title` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_title` varchar(255) NOT NULL,
  `user_status` varchar(64) NOT NULL DEFAULT 'Guest',
  `status` enum('pending','completed','failed','refunded') NOT NULL DEFAULT 'pending',
  `price` decimal(12,2) NOT NULL,
  `price_service_fee` decimal(12,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `tid` varchar(64) NOT NULL,
  `ttype` varchar(64) NOT NULL,
  `tstatus` varchar(64) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_event_transactions`
--

LOCK TABLES `engine4_event_transactions` WRITE;
/*!40000 ALTER TABLE `engine4_event_transactions` DISABLE KEYS */;
INSERT INTO `engine4_event_transactions` VALUES (38,4,'',2,'','Guest','completed',160.50,0.00,'USD','2014-07-14 14:01:02','2014-07-14 14:01:02','2j2x5m','sale',''),(39,4,'',3,'','Guest','completed',160.50,0.00,'USD','2014-07-14 14:03:08','2014-07-14 14:03:08','244jvm','sale',''),(40,5,'',3,'','Guest','completed',271.78,0.00,'USD','2014-07-14 14:07:58','2014-07-14 14:07:58','fdk9fm','sale',''),(41,4,'',3,'','Guest','completed',-160.50,0.00,'USD','2014-07-15 10:54:24','2014-07-15 10:54:26','3b3zv2','credit',''),(44,3,'',4,'','Guest','completed',123.05,0.00,'USD','2014-07-15 12:09:07','2014-07-15 12:09:07','hwr9v2','sale',''),(47,3,'',2,'','Guest','completed',123.05,0.00,'CHF','2014-07-16 16:48:20','2014-07-16 16:48:20','2t44sb','sale','authorized'),(52,14,'',2,'','Guest','completed',164.78,0.00,'USD','2014-08-01 10:11:58','2014-08-01 10:11:58','9yc2xm','sale','authorized'),(53,14,'',3,'','Guest','completed',164.78,0.00,'USD','2014-08-01 10:16:22','2014-08-01 10:16:22','d7gf9w','sale','authorized'),(54,3,'',1,'','Guest','completed',-228.87,0.00,'CHF','2014-08-01 10:43:43','2014-08-01 10:43:43','','',''),(55,15,'',2,'','Guest','completed',107.00,0.00,'USD','2014-08-01 12:44:48','2014-08-01 12:44:48','h9g64r','sale','authorized'),(56,15,'',2,'','Guest','completed',107.00,0.00,'USD','2014-08-01 12:53:55','2014-08-01 12:53:55','33tvvw','sale','authorized'),(57,15,'',3,'','Guest','completed',107.00,0.00,'USD','2014-08-01 12:56:53','2014-08-01 12:56:53','dk4mcm','sale','authorized'),(58,16,'',5,'','Guest','completed',214.00,0.00,'GBP','2014-08-01 13:40:16','2014-08-01 13:40:16','br7t5w','sale','authorized'),(59,16,'',1,'','Guest','completed',-200.00,0.00,'GBP','2014-08-01 13:59:51','2014-08-01 13:59:51','','',''),(61,19,'',8,'','Guest','completed',267.50,0.00,'EUR','2014-08-20 09:23:58','2014-08-20 09:23:58','32jxrg','sale','authorized'),(62,19,'',7,'','Guest','completed',267.50,0.00,'EUR','2014-08-20 09:30:18','2014-08-20 09:30:18','9s5dt6','sale','authorized'),(63,20,'',10,'','Guest','completed',2.14,0.00,'CHF','2014-08-20 13:30:09','2014-08-20 13:30:09','9f9rxm','sale','authorized'),(64,21,'',10,'','Guest','completed',107.00,0.00,'USD','2014-08-20 20:19:16','2014-08-20 20:19:16','hzq886','sale','authorized'),(65,21,'',10,'','Guest','completed',107.00,0.00,'USD','2014-08-20 20:21:36','2014-08-20 20:21:36','cyppwg','sale','authorized'),(66,22,'',8,'','Guest','completed',58.85,0.00,'GBP','2014-08-20 21:39:06','2014-08-20 21:39:06','298jyr','sale','authorized'),(67,22,'',8,'','Guest','completed',58.85,0.00,'GBP','2014-08-20 21:39:08','2014-08-20 21:39:08','66fmzw','sale','authorized'),(68,22,'',1,'','Guest','completed',58.85,0.00,'GBP','2014-08-20 21:39:36','2014-08-20 21:39:36','hbbnfb','sale','authorized'),(69,22,'',10,'','Guest','completed',-165.00,0.00,'GBP','2014-08-20 22:07:59','2014-08-20 22:07:59','','',''),(70,17,'',3,'','Guest','completed',107.00,0.00,'EUR','2014-08-26 14:17:46','2014-08-26 14:17:46','3ktjt6','sale','authorized'),(71,25,'',6,'','Guest','completed',107.00,7.00,'EUR','2014-09-03 07:46:49','2014-09-03 07:46:49','66s4fw','sale','authorized'),(72,21,'Chocolate Dream',10,'Frank Stein','Guest','completed',-100.00,-7.00,'USD','2014-09-03 10:02:14','2014-09-03 10:02:15','76p65w','credit',''),(73,20,'Hulk Hogan\'s Class',10,'Frank Stein','Guest','completed',-2.00,-0.14,'CHF','2014-09-03 10:31:25','2014-09-03 10:31:26','9qbrnm','credit',''),(74,28,'Saussage Party',9,'Reto Spescha','Guest','completed',64.20,4.20,'CHF','2014-09-13 23:20:53','2014-09-13 23:20:53','gtz3sm','sale','authorized'),(77,28,'Saussage Party',9,'Reto Spescha','Guest','completed',64.20,4.20,'CHF','2014-09-14 00:17:47','2014-09-14 00:17:47','3bg6h2','sale','authorized'),(78,28,'Saussage Party',9,'Reto Spescha','Guest','completed',64.20,4.20,'CHF','2014-09-14 00:36:22','2014-09-14 00:36:22','3hchqb','sale','authorized'),(79,29,'Peperoni Pizza',9,'Reto Spescha','Guest','completed',85.60,5.60,'CHF','2014-09-14 23:42:10','2014-09-14 23:42:10','fdz8zw','sale','authorized'),(80,20,'Hulk Hogan\'s Class',7,'Markus Liechti','Guest','completed',2.14,0.14,'CHF','2014-09-17 22:29:35','2014-09-17 22:29:35','hmrpj6','sale','authorized'),(81,20,'Hulk Hogan\'s Class',13,'Markus Local','Guest','completed',2.14,0.14,'CHF','2014-09-18 20:57:05','2014-09-18 20:57:05','89hd2g','sale','authorized'),(82,31,'New Class test',3,'user 2','Guest','completed',21.40,1.40,'EUR','2014-10-02 12:47:59','2014-10-02 12:47:59','k48xn2','sale','authorized'),(83,31,'New Class test',4,'user 3','Guest','completed',21.40,1.40,'EUR','2014-10-03 11:20:00','2014-10-03 11:20:00','jcq8fw','sale','authorized'),(84,33,'New Class test',4,'user 3','Guest','completed',53.50,3.50,'EUR','2014-10-03 12:51:53','2014-10-03 12:51:53','7tqfc2','sale','authorized'),(85,33,'New Class test',2,'user 1','Guest','completed',53.50,3.50,'EUR','2014-10-08 13:56:38','2014-10-08 13:56:38','jbh3s2','sale','authorized'),(86,34,'Cupcake class',2,'user 1','Guest','completed',107.00,7.00,'EUR','2014-10-09 14:25:44','2014-10-09 14:25:44','fk2vwg','sale','authorized');
/*!40000 ALTER TABLE `engine4_event_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_invites`
--

DROP TABLE IF EXISTS `engine4_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `recipient` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `send_request` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `new_user_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `user_id` (`user_id`),
  KEY `recipient` (`recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_invites`
--

LOCK TABLES `engine4_invites` WRITE;
/*!40000 ALTER TABLE `engine4_invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_messages_conversations`
--

DROP TABLE IF EXISTS `engine4_messages_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_messages_conversations` (
  `conversation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) unsigned NOT NULL,
  `recipients` int(11) unsigned NOT NULL,
  `modified` datetime NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `resource_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `resource_id` int(11) unsigned NOT NULL DEFAULT '0',
  `system` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`conversation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_messages_conversations`
--

LOCK TABLES `engine4_messages_conversations` WRITE;
/*!40000 ALTER TABLE `engine4_messages_conversations` DISABLE KEYS */;
INSERT INTO `engine4_messages_conversations` VALUES (1,'',1,1,'2014-07-09 12:51:58',1,NULL,0,'1'),(2,'',1,1,'2014-07-09 15:49:08',1,NULL,0,'1'),(3,'',1,1,'2014-07-10 09:05:52',1,NULL,0,'1'),(4,'',1,1,'2014-07-10 09:07:02',1,NULL,0,'1'),(5,'',3,1,'2014-07-10 09:09:48',1,NULL,0,'1'),(6,'',3,1,'2014-07-10 09:14:13',1,NULL,0,'1'),(7,'',3,1,'2014-07-10 09:40:44',1,NULL,0,'1'),(8,'',2,1,'2014-07-10 09:59:29',1,NULL,0,'1'),(9,'',2,1,'2014-07-10 10:00:22',1,NULL,0,'1'),(10,'',3,1,'2014-07-10 10:03:41',1,NULL,0,'1'),(11,'',3,1,'2014-07-10 12:10:13',1,NULL,0,'1'),(13,'',3,1,'2014-07-10 12:13:24',1,NULL,0,'1'),(14,'',1,1,'2014-07-10 12:27:22',1,NULL,0,'1'),(15,'',3,1,'2014-07-10 12:30:56',1,NULL,0,'1'),(16,'',1,1,'2014-07-10 12:32:09',1,NULL,0,'1'),(17,'',3,1,'2014-07-10 12:58:40',1,NULL,0,'1'),(18,'',1,1,'2014-07-10 12:59:52',1,NULL,0,'1'),(19,'',1,1,'2014-07-10 12:59:52',1,NULL,0,'1'),(20,'',1,1,'2014-07-10 15:36:55',1,NULL,0,'1'),(21,'',2,1,'2014-07-10 15:38:32',1,NULL,0,'1'),(22,'',2,1,'2014-07-10 16:04:16',1,NULL,0,'1'),(23,'',1,1,'2014-07-10 16:13:47',1,NULL,0,'1'),(24,'',1,1,'2014-07-10 16:13:47',1,NULL,0,'1'),(25,'',1,1,'2014-07-10 16:13:47',1,NULL,0,'1'),(26,'',1,1,'2014-07-10 16:13:47',1,NULL,0,'1'),(27,'',2,1,'2014-07-10 16:13:48',1,NULL,0,'1'),(28,'',1,1,'2014-07-10 16:13:48',1,NULL,0,'1'),(29,'',1,1,'2014-07-10 16:13:48',1,NULL,0,'1'),(30,'',1,1,'2014-07-10 16:13:48',1,NULL,0,'1'),(31,'',1,1,'2014-07-10 16:13:49',1,NULL,0,'1'),(32,'',1,1,'2014-07-10 16:13:49',1,NULL,0,'1'),(33,'',2,1,'2014-07-10 16:26:01',1,NULL,0,'1'),(34,'',1,1,'2014-07-10 16:48:59',1,NULL,0,'1'),(35,'',2,1,'2014-07-10 16:56:26',1,NULL,0,'1'),(36,'',1,1,'2014-07-10 19:47:01',1,NULL,0,'1'),(37,'',1,1,'2014-07-10 19:47:55',1,NULL,0,'1'),(38,'',1,1,'2014-07-11 08:20:44',1,NULL,0,'1'),(39,'',3,1,'2014-07-11 08:26:22',1,NULL,0,'1'),(40,'',2,1,'2014-07-11 08:36:01',1,NULL,0,'1'),(41,'The Class has been cancelled',2,1,'2014-07-11 08:36:09',1,NULL,0,'1'),(42,'The Class has been cancelled',3,1,'2014-07-11 08:36:09',1,NULL,0,'1'),(43,'The Class has been cancelled',2,1,'2014-07-11 08:42:00',1,NULL,0,'1'),(44,'The Class has been cancelled',3,1,'2014-07-11 08:42:00',1,NULL,0,'1'),(45,'',3,1,'2014-07-11 08:55:17',1,NULL,0,'1'),(46,'',1,1,'2014-07-11 09:14:19',1,NULL,0,'1'),(47,'',3,1,'2014-07-11 13:12:07',1,NULL,0,'1'),(48,'',1,1,'2014-07-11 13:42:20',1,NULL,0,'1'),(49,'',2,1,'2014-07-12 06:10:27',1,NULL,0,'1'),(50,'',3,1,'2014-07-13 09:01:18',1,NULL,0,'1'),(51,'',1,1,'2014-07-13 09:03:10',1,NULL,0,'1'),(52,'',3,1,'2014-07-13 09:03:53',1,NULL,0,'1'),(53,'',3,1,'2014-07-13 12:01:09',1,NULL,0,'1'),(54,'',1,1,'2014-07-13 12:04:17',1,NULL,0,'1'),(55,'',1,1,'2014-07-13 12:04:18',1,NULL,0,'1'),(56,'',1,1,'2014-07-13 12:05:13',1,NULL,0,'1'),(57,'',3,1,'2014-07-13 12:05:28',1,NULL,0,'1'),(58,'',3,1,'2014-07-13 12:10:14',1,NULL,0,'1'),(59,'',1,1,'2014-07-13 12:29:57',1,NULL,0,'1'),(60,'',1,1,'2014-07-13 12:29:57',1,NULL,0,'1'),(61,'',1,1,'2014-07-13 12:31:53',1,NULL,0,'1'),(62,'',1,1,'2014-07-13 12:31:53',1,NULL,0,'1'),(63,'',1,1,'2014-07-13 12:37:58',1,NULL,0,'1'),(64,'',1,1,'2014-07-13 12:37:58',1,NULL,0,'1'),(65,'',1,1,'2014-07-13 12:39:14',1,NULL,0,'1'),(66,'',1,1,'2014-07-13 12:39:14',1,NULL,0,'1'),(67,'',1,1,'2014-07-13 12:43:17',1,NULL,0,'1'),(68,'',1,1,'2014-07-13 12:45:04',1,NULL,0,'1'),(69,'',1,1,'2014-07-13 18:04:20',1,NULL,0,'1'),(70,'',3,1,'2014-07-13 18:04:20',1,NULL,0,'1'),(71,'',1,1,'2014-07-13 18:10:47',1,NULL,0,'1'),(72,'',1,1,'2014-07-13 18:11:07',1,NULL,0,'1'),(73,'',1,1,'2014-07-13 18:13:59',1,NULL,0,'1'),(74,'',1,1,'2014-07-13 18:24:00',1,NULL,0,'1'),(75,'',2,1,'2014-07-13 20:56:52',1,NULL,0,'1'),(76,'',1,1,'2014-07-14 12:52:41',1,NULL,0,'1'),(77,'',2,1,'2014-07-14 12:53:02',1,NULL,0,'1'),(78,'',2,1,'2014-07-14 12:54:56',1,NULL,0,'1'),(79,'',1,1,'2014-07-14 12:56:25',1,NULL,0,'1'),(80,'',1,1,'2014-07-14 12:56:25',1,NULL,0,'1'),(81,'',1,1,'2014-07-14 13:13:46',1,NULL,0,'1'),(82,'',2,1,'2014-07-14 13:13:54',1,NULL,0,'1'),(83,'',2,1,'2014-07-14 13:14:27',1,NULL,0,'1'),(84,'',1,1,'2014-07-14 13:14:42',1,NULL,0,'1'),(85,'',1,1,'2014-07-14 13:14:42',1,NULL,0,'1'),(86,'',1,1,'2014-07-14 13:25:39',1,NULL,0,'1'),(87,'',1,1,'2014-07-14 13:34:51',1,NULL,0,'1'),(88,'',1,1,'2014-07-14 13:35:02',1,NULL,0,'1'),(89,'',1,1,'2014-07-14 13:36:13',1,NULL,0,'1'),(90,'',2,1,'2014-07-14 13:59:39',1,NULL,0,'1'),(91,'',2,1,'2014-07-14 14:01:02',1,NULL,0,'1'),(92,'',1,1,'2014-07-14 14:01:44',1,NULL,0,'1'),(93,'',3,1,'2014-07-14 14:02:14',1,NULL,0,'1'),(94,'',3,1,'2014-07-14 14:03:08',1,NULL,0,'1'),(95,'',2,1,'2014-07-14 14:07:16',1,NULL,0,'1'),(96,'',3,1,'2014-07-14 14:07:28',1,NULL,0,'1'),(97,'',3,1,'2014-07-14 14:07:58',1,NULL,0,'1'),(98,'',1,1,'2014-07-14 14:17:58',1,NULL,0,'1'),(99,'',1,1,'2014-07-14 14:17:58',1,NULL,0,'1'),(100,'',1,1,'2014-07-15 12:05:30',1,NULL,0,'1'),(101,'',4,1,'2014-07-15 12:05:44',1,NULL,0,'1'),(102,'',4,1,'2014-07-15 12:09:07',1,NULL,0,'1'),(103,'',1,1,'2014-07-15 12:10:49',1,NULL,0,'1'),(104,'',5,1,'2014-07-15 12:11:01',1,NULL,0,'1'),(105,'',1,1,'2014-07-15 12:18:19',1,NULL,0,'1'),(106,'',1,1,'2014-07-15 12:18:19',1,NULL,0,'1'),(107,'',1,1,'2014-07-15 12:35:42',1,NULL,0,'1'),(108,'',1,1,'2014-07-16 16:42:27',1,NULL,0,'1'),(109,'',2,1,'2014-07-16 16:42:45',1,NULL,0,'1'),(110,'',2,1,'2014-07-16 16:48:20',1,NULL,0,'1'),(111,'',1,1,'2014-07-23 15:42:37',1,NULL,0,'1'),(112,'',3,1,'2014-07-23 15:42:45',1,NULL,0,'1'),(113,'',1,1,'2014-08-01 10:07:44',1,NULL,0,'1'),(114,'',2,1,'2014-08-01 10:08:01',1,NULL,0,'1'),(115,'',2,1,'2014-08-01 10:11:58',1,NULL,0,'1'),(116,'',1,1,'2014-08-01 10:15:42',1,NULL,0,'1'),(117,'',3,1,'2014-08-01 10:15:57',1,NULL,0,'1'),(118,'',3,1,'2014-08-01 10:16:22',1,NULL,0,'1'),(119,'',1,1,'2014-08-01 10:16:44',1,NULL,0,'1'),(120,'',4,1,'2014-08-01 10:16:54',1,NULL,0,'1'),(121,'',1,1,'2014-08-01 10:17:12',1,NULL,0,'1'),(122,'',1,1,'2014-08-01 10:18:19',1,NULL,0,'1'),(123,'',1,1,'2014-08-01 10:18:19',1,NULL,0,'1'),(124,'',5,1,'2014-08-01 10:19:07',1,NULL,0,'1'),(125,'',1,1,'2014-08-01 10:36:45',1,NULL,0,'1'),(126,'',2,1,'2014-08-01 10:36:45',1,NULL,0,'1'),(127,'',1,1,'2014-08-01 10:36:46',1,NULL,0,'1'),(128,'',1,1,'2014-08-01 10:36:46',1,NULL,0,'1'),(129,'',1,1,'2014-08-01 10:36:46',1,NULL,0,'1'),(130,'',1,1,'2014-08-01 10:36:46',1,NULL,0,'1'),(131,'',1,1,'2014-08-01 10:36:47',1,NULL,0,'1'),(132,'',1,1,'2014-08-01 10:36:47',1,NULL,0,'1'),(133,'',1,1,'2014-08-01 10:36:47',1,NULL,0,'1'),(134,'',1,1,'2014-08-01 10:36:47',1,NULL,0,'1'),(135,'',1,1,'2014-08-01 10:36:48',1,NULL,0,'1'),(136,'',5,1,'2014-08-01 10:36:48',1,NULL,0,'1'),(137,'',3,1,'2014-08-01 10:36:48',1,NULL,0,'1'),(138,'',5,1,'2014-08-01 10:36:49',1,NULL,0,'1'),(139,'',1,1,'2014-08-01 10:36:49',1,NULL,0,'1'),(140,'',3,1,'2014-08-01 10:36:49',1,NULL,0,'1'),(141,'',1,1,'2014-08-01 10:36:49',1,NULL,0,'1'),(142,'',1,1,'2014-08-01 10:36:59',1,NULL,0,'1'),(143,'',1,1,'2014-08-01 12:34:41',1,NULL,0,'1'),(144,'',1,1,'2014-08-01 12:42:20',1,NULL,0,'1'),(145,'',2,1,'2014-08-01 12:43:07',1,NULL,0,'1'),(146,'',3,1,'2014-08-01 12:43:24',1,NULL,0,'1'),(147,'',2,1,'2014-08-01 12:44:48',1,NULL,0,'1'),(148,'',2,1,'2014-08-01 12:46:32',1,NULL,0,'1'),(149,'',1,1,'2014-08-01 12:47:09',1,NULL,0,'1'),(150,'',2,1,'2014-08-01 12:47:31',1,NULL,0,'1'),(151,'',2,1,'2014-08-01 12:53:55',1,NULL,0,'1'),(152,'',3,1,'2014-08-01 12:56:53',1,NULL,0,'1'),(153,'',1,1,'2014-08-01 12:58:19',1,NULL,0,'1'),(154,'',1,1,'2014-08-01 12:58:19',1,NULL,0,'1'),(155,'',1,1,'2014-08-01 13:00:25',1,NULL,0,'1'),(156,'',1,1,'2014-08-01 13:00:44',1,NULL,0,'1'),(157,'',1,1,'2014-08-01 13:39:34',1,NULL,0,'1'),(158,'',5,1,'2014-08-01 13:39:48',1,NULL,0,'1'),(159,'',5,1,'2014-08-01 13:40:16',1,NULL,0,'1'),(160,'',1,1,'2014-08-01 13:41:19',1,NULL,0,'1'),(161,'',1,1,'2014-08-01 13:41:29',1,NULL,0,'1'),(162,'',4,1,'2014-08-04 20:21:36',1,NULL,0,'1'),(163,'',4,1,'2014-08-05 10:44:38',1,NULL,0,'1'),(164,'',1,1,'2014-08-05 10:44:38',1,NULL,0,'1'),(165,'',7,1,'2014-08-17 11:29:49',1,NULL,0,'1'),(166,'',7,1,'2014-08-17 11:30:31',1,NULL,0,'1'),(167,'',7,1,'2014-08-17 11:30:38',1,NULL,0,'1'),(168,'',8,1,'2014-08-18 13:20:18',1,NULL,0,'1'),(169,'',7,1,'2014-08-20 08:42:08',1,NULL,0,'1'),(170,'',7,1,'2014-08-20 08:42:43',1,NULL,0,'1'),(171,'',7,1,'2014-08-20 08:42:57',1,NULL,0,'1'),(172,'',7,1,'2014-08-20 08:46:37',1,NULL,0,'1'),(173,'',10,1,'2014-08-20 08:59:25',1,NULL,0,'1'),(174,'',10,1,'2014-08-20 09:01:05',1,NULL,0,'1'),(175,'',8,1,'2014-08-20 09:01:37',1,NULL,0,'1'),(176,'',10,1,'2014-08-20 09:03:17',1,NULL,0,'1'),(177,'',10,1,'2014-08-20 09:03:26',1,NULL,0,'1'),(178,'',10,1,'2014-08-20 09:10:04',1,NULL,0,'1'),(179,'',7,1,'2014-08-20 09:10:42',1,NULL,0,'1'),(180,'',8,1,'2014-08-20 09:10:57',1,NULL,0,'1'),(181,'',8,1,'2014-08-20 09:23:58',1,NULL,0,'1'),(182,'',8,1,'2014-08-20 09:27:03',1,NULL,0,'1'),(183,'',7,1,'2014-08-20 09:30:18',1,NULL,0,'1'),(184,'',8,1,'2014-08-20 09:32:30',1,NULL,0,'1'),(185,'',8,1,'2014-08-20 12:46:38',1,NULL,0,'1'),(186,'',10,1,'2014-08-20 12:47:54',1,NULL,0,'1'),(187,'',7,1,'2014-08-20 12:48:03',1,NULL,0,'1'),(188,'Hallo',8,1,'2014-08-20 13:15:24',0,NULL,0,'0'),(189,'',10,1,'2014-08-20 13:30:09',1,NULL,0,'1'),(190,'',8,1,'2014-08-20 13:40:01',1,NULL,0,'1'),(191,'',1,1,'2014-08-20 13:40:01',1,NULL,0,'1'),(192,'',8,1,'2014-08-20 13:47:58',1,NULL,0,'1'),(193,'',10,1,'2014-08-20 20:09:51',1,NULL,0,'1'),(194,'',7,1,'2014-08-20 20:18:06',1,NULL,0,'1'),(195,'',10,1,'2014-08-20 20:18:31',1,NULL,0,'1'),(196,'',10,1,'2014-08-20 20:19:16',1,NULL,0,'1'),(197,'',7,1,'2014-08-20 20:20:01',1,NULL,0,'1'),(198,'',10,1,'2014-08-20 20:20:01',1,NULL,0,'1'),(199,'',7,1,'2014-08-20 20:20:48',1,NULL,0,'1'),(200,'',10,1,'2014-08-20 20:21:04',1,NULL,0,'1'),(201,'',10,1,'2014-08-20 20:21:36',1,NULL,0,'1'),(202,'The Class has been cancelled',10,1,'2014-08-20 20:22:02',1,NULL,0,'1'),(203,'The Class has been cancelled',1,1,'2014-08-20 20:22:02',1,NULL,0,'1'),(204,'',7,1,'2014-08-20 21:35:22',1,NULL,0,'1'),(205,'',7,1,'2014-08-20 21:35:22',1,NULL,0,'1'),(206,'',8,1,'2014-08-20 21:35:22',1,NULL,0,'1'),(207,'',8,1,'2014-08-20 21:35:23',1,NULL,0,'1'),(208,'',10,1,'2014-08-20 21:36:05',1,NULL,0,'1'),(209,'',1,1,'2014-08-20 21:36:41',1,NULL,0,'1'),(210,'',10,1,'2014-08-20 21:37:37',1,NULL,0,'1'),(211,'',8,1,'2014-08-20 21:38:12',1,NULL,0,'1'),(212,'',8,1,'2014-08-20 21:39:06',1,NULL,0,'1'),(213,'',8,1,'2014-08-20 21:39:08',1,NULL,0,'1'),(214,'',1,1,'2014-08-20 21:39:36',1,NULL,0,'1'),(215,'',10,1,'2014-08-20 21:51:44',1,NULL,0,'1'),(216,'',1,1,'2014-08-20 22:03:25',1,NULL,0,'1'),(217,'',8,1,'2014-08-24 12:57:36',1,NULL,0,'1'),(218,'',10,1,'2014-08-24 12:57:37',1,NULL,0,'1'),(219,'',8,1,'2014-08-24 12:57:37',1,NULL,0,'1'),(220,'',7,1,'2014-08-24 12:57:37',1,NULL,0,'1'),(221,'',10,1,'2014-08-24 12:57:38',1,NULL,0,'1'),(222,'',7,1,'2014-08-24 12:57:38',1,NULL,0,'1'),(223,'',1,1,'2014-08-26 13:51:46',1,NULL,0,'1'),(224,'',1,1,'2014-08-26 13:52:30',1,NULL,0,'1'),(225,'',1,1,'2014-08-26 14:16:41',1,NULL,0,'1'),(226,'',3,1,'2014-08-26 14:16:57',1,NULL,0,'1'),(227,'',3,1,'2014-08-26 14:17:46',1,NULL,0,'1'),(228,'',6,1,'2014-08-27 08:52:46',1,NULL,0,'1'),(229,'',1,1,'2014-08-27 08:57:31',1,NULL,0,'1'),(230,'',1,1,'2014-08-27 08:59:00',1,NULL,0,'1'),(231,'',1,1,'2014-08-27 08:59:18',1,NULL,0,'1'),(232,'',6,1,'2014-08-27 08:59:43',1,NULL,0,'1'),(233,'',1,1,'2014-08-27 09:00:25',1,NULL,0,'1'),(234,'',1,1,'2014-09-02 09:41:21',1,NULL,0,'1'),(235,'',7,1,'2014-09-02 09:41:21',1,NULL,0,'1'),(236,'',8,1,'2014-09-02 21:55:37',1,NULL,0,'1'),(237,'',8,1,'2014-09-02 22:01:53',1,NULL,0,'1'),(238,'',1,1,'2014-09-02 22:22:06',1,NULL,0,'1'),(239,'',6,1,'2014-09-02 22:22:33',1,NULL,0,'1'),(240,'',1,1,'2014-09-03 07:29:40',1,NULL,0,'1'),(241,'',1,1,'2014-09-03 07:42:46',1,NULL,0,'1'),(242,'',1,1,'2014-09-03 07:45:04',1,NULL,0,'1'),(243,'',6,1,'2014-09-03 07:45:33',1,NULL,0,'1'),(244,'',6,1,'2014-09-03 07:46:49',1,NULL,0,'1'),(245,'',1,1,'2014-09-03 07:51:52',1,NULL,0,'1'),(246,'',1,1,'2014-09-03 07:54:44',1,NULL,0,'1'),(247,'',1,1,'2014-09-03 07:54:44',1,NULL,0,'1'),(248,'',1,1,'2014-09-03 08:13:42',1,NULL,0,'1'),(249,'',1,1,'2014-09-03 08:15:41',1,NULL,0,'1'),(250,'',5,1,'2014-09-03 08:16:27',1,NULL,0,'1'),(251,'',1,1,'2014-09-03 08:18:53',1,NULL,0,'1'),(252,'',3,1,'2014-09-03 08:19:15',1,NULL,0,'1'),(253,'',4,1,'2014-09-03 08:19:25',1,NULL,0,'1'),(254,'',1,1,'2014-09-03 08:24:58',1,NULL,0,'1'),(255,'',1,1,'2014-09-03 08:26:13',1,NULL,0,'1'),(256,'',1,1,'2014-09-03 08:26:57',1,NULL,0,'1'),(257,'',1,1,'2014-09-03 08:30:40',1,NULL,0,'1'),(258,'',1,1,'2014-09-03 08:44:33',1,NULL,0,'1'),(259,'',1,1,'2014-09-03 10:19:22',1,NULL,0,'1'),(260,'',5,1,'2014-09-03 10:19:48',1,NULL,0,'1'),(261,'',3,1,'2014-09-03 10:20:31',1,NULL,0,'1'),(262,'',1,1,'2014-09-03 10:23:12',1,NULL,0,'1'),(263,'',1,1,'2014-09-03 10:23:36',1,NULL,0,'1'),(264,'',5,1,'2014-09-03 10:23:49',1,NULL,0,'1'),(265,'',1,1,'2014-09-03 12:07:10',1,NULL,0,'1'),(266,'',1,1,'2014-09-03 12:07:19',1,NULL,0,'1'),(267,'',1,1,'2014-09-03 12:08:24',1,NULL,0,'1'),(268,'',1,1,'2014-09-03 12:08:36',1,NULL,0,'1'),(269,'',3,1,'2014-09-03 12:08:54',1,NULL,0,'1'),(270,'',5,1,'2014-09-03 12:09:02',1,NULL,0,'1'),(271,'',1,1,'2014-09-03 12:09:52',1,NULL,0,'1'),(272,'',1,1,'2014-09-03 12:10:08',1,NULL,0,'1'),(273,'',1,1,'2014-09-03 12:10:18',1,NULL,0,'1'),(274,'',1,1,'2014-09-03 12:10:35',1,NULL,0,'1'),(275,'',2,1,'2014-09-03 12:10:47',1,NULL,0,'1'),(276,'',1,1,'2014-09-03 12:11:52',1,NULL,0,'1'),(277,'',1,1,'2014-09-03 12:12:18',1,NULL,0,'1'),(278,'',1,1,'2014-09-03 12:14:56',1,NULL,0,'1'),(279,'',1,1,'2014-09-03 12:50:04',1,NULL,0,'1'),(280,'',1,1,'2014-09-03 12:55:49',1,NULL,0,'1'),(281,'',8,1,'2014-09-03 13:41:28',1,NULL,0,'1'),(282,'',1,1,'2014-09-03 13:42:11',1,NULL,0,'1'),(283,'',2,1,'2014-09-13 22:10:40',1,NULL,0,'1'),(284,'',1,1,'2014-09-13 22:10:40',1,NULL,0,'1'),(285,'',1,1,'2014-09-13 22:10:40',1,NULL,0,'1'),(286,'',8,1,'2014-09-13 22:10:41',1,NULL,0,'1'),(287,'',11,1,'2014-09-13 22:52:20',1,NULL,0,'1'),(288,'',11,1,'2014-09-13 23:02:58',1,NULL,0,'1'),(289,'',11,1,'2014-09-13 23:14:07',1,NULL,0,'1'),(290,'',9,1,'2014-09-13 23:15:55',1,NULL,0,'1'),(291,'',9,1,'2014-09-13 23:20:53',1,NULL,0,'1'),(292,'',11,1,'2014-09-13 23:39:24',1,NULL,0,'1'),(293,'',1,1,'2014-09-13 23:39:24',1,NULL,0,'1'),(294,'',11,1,'2014-09-14 00:02:41',1,NULL,0,'1'),(295,'',11,1,'2014-09-14 00:08:21',1,NULL,0,'1'),(296,'',9,1,'2014-09-14 00:09:02',1,NULL,0,'1'),(297,'',11,1,'2014-09-14 00:11:38',1,NULL,0,'1'),(298,'',11,1,'2014-09-14 00:14:00',1,NULL,0,'1'),(299,'',9,1,'2014-09-14 00:14:22',1,NULL,0,'1'),(300,'',9,1,'2014-09-14 00:17:47',1,NULL,0,'1'),(301,'',9,1,'2014-09-14 00:23:11',1,NULL,0,'1'),(302,'',11,1,'2014-09-14 00:24:42',1,NULL,0,'1'),(303,'',9,1,'2014-09-14 00:30:03',1,NULL,0,'1'),(304,'',11,1,'2014-09-14 00:33:45',1,NULL,0,'1'),(305,'',11,1,'2014-09-14 00:34:09',1,NULL,0,'1'),(306,'',11,1,'2014-09-14 00:35:24',1,NULL,0,'1'),(307,'',9,1,'2014-09-14 00:35:45',1,NULL,0,'1'),(308,'',9,1,'2014-09-14 00:36:22',1,NULL,0,'1'),(309,'',11,1,'2014-09-14 00:39:44',1,NULL,0,'1'),(310,'',1,1,'2014-09-14 00:39:44',1,NULL,0,'1'),(311,'',11,1,'2014-09-14 00:53:33',1,NULL,0,'1'),(312,'',11,1,'2014-09-14 23:13:16',1,NULL,0,'1'),(313,'',9,1,'2014-09-14 23:14:20',1,NULL,0,'1'),(314,'',11,1,'2014-09-14 23:31:48',1,NULL,0,'1'),(315,'',11,1,'2014-09-14 23:40:26',1,NULL,0,'1'),(316,'',9,1,'2014-09-14 23:41:13',1,NULL,0,'1'),(317,'',9,1,'2014-09-14 23:42:10',1,NULL,0,'1'),(318,'The Class has been cancelled',9,1,'2014-09-14 23:43:54',1,NULL,0,'1'),(319,'The Class has been cancelled',1,1,'2014-09-14 23:43:54',1,NULL,0,'1'),(320,'',11,1,'2014-09-14 23:57:33',1,NULL,0,'1'),(321,'',1,1,'2014-09-15 00:02:47',1,NULL,0,'1'),(322,'',8,1,'2014-09-16 20:00:44',1,NULL,0,'1'),(323,'',8,1,'2014-09-16 20:23:43',1,NULL,0,'1'),(325,'',7,1,'2014-09-17 21:42:30',1,NULL,0,'1'),(326,'',11,1,'2014-09-17 22:02:04',1,NULL,0,'1'),(327,'',8,1,'2014-09-17 22:02:29',1,NULL,0,'1'),(328,'',7,1,'2014-09-17 22:03:55',1,NULL,0,'1'),(329,'',7,1,'2014-09-17 22:29:35',1,NULL,0,'1'),(330,'',8,1,'2014-09-17 22:43:13',1,NULL,0,'1'),(331,'',13,1,'2014-09-17 22:44:11',1,NULL,0,'1'),(332,'',11,1,'2014-09-18 20:54:20',1,NULL,0,'1'),(333,'',13,1,'2014-09-18 20:57:05',1,NULL,0,'1'),(334,'',7,1,'2014-09-18 22:35:40',1,NULL,0,'1'),(335,'',13,1,'2014-09-21 23:38:35',1,NULL,0,'1'),(336,'',8,1,'2014-10-01 13:27:32',1,NULL,0,'1'),(337,'',1,1,'2014-10-01 13:27:32',1,NULL,0,'1'),(338,'',11,1,'2014-10-01 13:27:32',1,NULL,0,'1'),(339,'',1,1,'2014-10-02 12:43:32',1,NULL,0,'1'),(340,'',1,1,'2014-10-02 12:43:50',1,NULL,0,'1'),(341,'',2,1,'2014-10-02 12:44:17',1,NULL,0,'1'),(342,'',3,1,'2014-10-02 12:44:24',1,NULL,0,'1'),(343,'',1,1,'2014-10-02 12:45:02',1,NULL,0,'1'),(344,'',1,1,'2014-10-02 12:47:14',1,NULL,0,'1'),(345,'',3,1,'2014-10-02 12:47:29',1,NULL,0,'1'),(346,'',3,1,'2014-10-02 12:47:59',1,NULL,0,'1'),(347,'',1,1,'2014-10-02 12:48:23',1,NULL,0,'1'),(348,'',1,1,'2014-10-02 12:48:23',1,NULL,0,'1'),(349,'',1,1,'2014-10-03 11:12:49',1,NULL,0,'1'),(350,'',1,1,'2014-10-03 11:18:54',1,NULL,0,'1'),(351,'',4,1,'2014-10-03 11:19:14',1,NULL,0,'1'),(352,'',4,1,'2014-10-03 11:20:00',1,NULL,0,'1'),(353,'',1,1,'2014-10-03 11:20:47',1,NULL,0,'1'),(354,'',1,1,'2014-10-03 11:20:47',1,NULL,0,'1'),(355,'The Class has been cancelled',2,1,'2014-10-03 11:48:02',1,NULL,0,'1'),(356,'The Class has been cancelled',4,1,'2014-10-03 11:48:02',1,NULL,0,'1'),(357,'',1,1,'2014-10-03 12:04:51',1,NULL,0,'1'),(358,'',1,1,'2014-10-03 12:50:50',1,NULL,0,'1'),(359,'',4,1,'2014-10-03 12:51:05',1,NULL,0,'1'),(360,'',4,1,'2014-10-03 12:51:53',1,NULL,0,'1'),(361,'',1,1,'2014-10-03 13:09:28',1,NULL,0,'1'),(362,'',1,1,'2014-10-03 13:09:28',1,NULL,0,'1'),(363,'',1,1,'2014-10-08 13:55:46',1,NULL,0,'1'),(364,'',2,1,'2014-10-08 13:56:01',1,NULL,0,'1'),(365,'',2,1,'2014-10-08 13:56:38',1,NULL,0,'1'),(366,'',1,1,'2014-10-09 14:24:20',1,NULL,0,'1'),(367,'',2,1,'2014-10-09 14:24:53',1,NULL,0,'1'),(368,'',2,1,'2014-10-09 14:25:44',1,NULL,0,'1'),(369,'',1,1,'2014-10-09 14:26:30',1,NULL,0,'1'),(370,'',1,1,'2014-10-09 14:26:30',1,NULL,0,'1'),(371,'',1,1,'2014-10-29 12:52:29',1,NULL,0,'1'),(372,'',1,1,'2014-10-29 12:52:30',1,NULL,0,'1');
/*!40000 ALTER TABLE `engine4_messages_conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_messages_messages`
--

DROP TABLE IF EXISTS `engine4_messages_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_messages_messages` (
  `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `attachment_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `attachment_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `CONVERSATIONS` (`conversation_id`,`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_messages_messages`
--

LOCK TABLES `engine4_messages_messages` WRITE;
/*!40000 ALTER TABLE `engine4_messages_messages` DISABLE KEYS */;
INSERT INTO `engine4_messages_messages` VALUES (1,1,1,'','You have recently accepted Peter to attend the class <a href=\"/profile/user1\">user 1</a>. He has cancelled his attendance.','2014-07-09 12:51:58','',0),(2,2,1,'','You have just recently held the Class <a href=\"/class/5\">Event 5</a>. Please confirm that the class has successfully taken place by clicking the button below.','2014-07-09 15:49:08','',0),(3,3,1,'','Unfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-07-10 09:05:52','',0),(4,4,1,'','Unfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-07-10 09:07:02','',0),(5,5,3,'','Unfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-07-10 09:09:48','',0),(6,6,3,'','Unfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-07-10 09:14:13','',0),(7,7,3,'','Unfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-07-10 09:40:44','',0),(8,8,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group Markus is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.','2014-07-10 09:59:29','',0),(9,9,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group Markus is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.','2014-07-10 10:00:22','',0),(10,10,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group Markus is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.','2014-07-10 10:03:41','',0),(11,11,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group Markus is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.','2014-07-10 12:10:13','',0),(13,13,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment/index\">Pay Now</a>','2014-07-10 12:13:24','',0),(14,14,1,'','You have recently accepted Peter to attend the class <a href=\"/profile/user2\">user 2</a>. He has cancelled his attendance.','2014-07-10 12:27:23','',0),(15,15,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment\">Pay Now</a>','2014-07-10 12:30:56','',0),(16,16,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/3\">Event 3</a>. He has cancelled his attendance.','2014-07-10 12:32:09','',0),(17,17,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment\">Pay Now</a>','2014-07-10 12:58:40','',0),(18,18,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user2\">user 2</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user2\">user 2</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.','2014-07-10 12:59:52','',0),(19,19,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.','2014-07-10 12:59:52','',0),(20,20,1,'','You have recently accepted <a href=\"/profile/user1\">user 1</a> to attend the class <a href=\"/class/3\">Event 3</a>. He has cancelled his attendance.','2014-07-10 15:36:55','',0),(21,21,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment\">Pay Now</a>','2014-07-10 15:38:32','',0),(22,22,2,'','Dear user 1, you were accepted for the class <a href=\"/class/3\">Event 3</a>. We would like to kindly remind you to pay the class fee of 100.00 USD by 07.11.2014.','2014-07-10 16:04:16','',0),(23,23,1,'','Dear First Last, you were accepted for the class <a href=\"/class/1\">Event 1</a>. Unfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-07-10 16:13:47','',0),(24,24,1,'','You have recently accepted <a href=\"/profile/admin\">First Last</a> to the class <a href=\"/class/1\">Event 1</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-07-10 16:13:47','',0),(25,25,1,'','Dear First Last, you were accepted for the class <a href=\"/class/2\">Event 2</a>. Unfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-07-10 16:13:47','',0),(26,26,1,'','You have recently accepted <a href=\"/profile/admin\">First Last</a> to the class <a href=\"/class/2\">Event 2</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-07-10 16:13:47','',0),(27,27,2,'','Dear user 1, you were accepted for the class <a href=\"/class/3\">Event 3</a>. Unfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-07-10 16:13:48','',0),(28,28,1,'','You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/user1\">user 1</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-07-10 16:13:48','',0),(29,29,1,'','Dear First Last, you were accepted for the class <a href=\"/class/4\">Event 4</a>. Unfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-07-10 16:13:48','',0),(30,30,1,'','You have recently accepted <a href=\"/profile/admin\">First Last</a> to the class <a href=\"/class/4\">Event 4</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-07-10 16:13:48','',0),(31,31,1,'','Dear First Last, you were accepted for the class <a href=\"/class/5\">Event 5</a>. Unfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-07-10 16:13:49','',0),(32,32,1,'','You have recently accepted <a href=\"/profile/admin\">First Last</a> to the class <a href=\"/class/5\">Event 5</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-07-10 16:13:49','',0),(33,33,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment\">Pay Now</a>','2014-07-10 16:26:01','',0),(34,34,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/3\">Event 3</a>. He has cancelled his attendance.','2014-07-10 16:48:59','',0),(35,35,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment\">Pay Now</a>','2014-07-10 16:56:26','',0),(36,36,1,'','You have just recently held the Class <a href=\"/class/3\">Event 3</a>. Please confirm that the class has successfully taken place by clicking the button below.','2014-07-10 19:47:01','',0),(37,37,1,'','The class <a href=\"/class/3\">Event 3</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-07-10 19:47:55','',0),(38,38,1,'','You have recently accepted <a href=\"/profile/user1\">user 1</a> to attend the class <a href=\"/class/3\">Event 3</a>. He has cancelled his attendance.\nReason 1','2014-07-11 08:20:44','',0),(39,39,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group Markus is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\nReason 2','2014-07-11 08:26:22','',0),(40,40,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 100.00 USD. <a href=\"/classes/payment\">Pay Now</a>','2014-07-11 08:36:01','',0),(41,41,2,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.','2014-07-11 08:36:09','',0),(42,42,3,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.','2014-07-11 08:36:09','',0),(43,43,2,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.\nReason 3','2014-07-11 08:42:00','',0),(44,44,3,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.\nReason 3','2014-07-11 08:42:00','',0),(45,45,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group Markus is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\nReason 3','2014-07-11 08:55:17','',0),(46,46,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">event page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 12, 2014 2:14 AM PDT.','2014-07-11 09:14:19','',0),(47,47,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group <a href=\"/profile/admin\">First Last</a> is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\n','2014-07-11 13:12:07','',0),(48,48,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 12, 2014 6:42 AM PDT.','2014-07-11 13:42:20','',0),(49,49,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-12 06:10:27','',0),(50,50,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-07-13 09:01:18','',0),(51,51,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 14, 2014 2:03 AM PDT.','2014-07-13 09:03:10','',0),(52,52,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 115.00 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-13 09:03:53','',0),(53,53,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-13 12:01:09','',0),(54,54,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user2\">user 2</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user2\">user 2</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 1','2014-07-13 12:04:17','',0),(55,55,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.','2014-07-13 12:04:18','',0),(56,56,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 14, 2014 5:05 AM PDT.','2014-07-13 12:05:13','',0),(57,57,3,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 115.00 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-13 12:05:28','',0),(58,58,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-13 12:10:14','',0),(59,59,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.Reason 1;ladsjf; asdf;asjd;fj djasf;jdslfj jzx;cvzdsfnj\r\nadsf dsjv;zkxjv;zjxc;vjdvjasldjc;l cv\r\ns D ;jzv;lzcxv;js;lefj zdjc;lzxjcv;lzsjd','2014-07-13 12:29:57','',0),(60,60,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.','2014-07-13 12:29:57','',0),(61,61,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 2\nBank Information: sdf sd fadsf adsf adsf sdvs d as\r\ndvs dvas dfasvzsx vasv\r\nsd vasdvs \r\ndva sdv asdv zsdv','2014-07-13 12:31:53','',0),(62,62,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.','2014-07-13 12:31:53','',0),(63,63,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 3','2014-07-13 12:37:58','',0),(64,64,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.','2014-07-13 12:37:58','',0),(65,65,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 2','2014-07-13 12:39:14','',0),(66,66,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Information: dsf dsfadsfasdf sdfas f\r\nd asdf asfadsf asdf\r\nds fadsf asdfas fadsf\r\nkjjjjjjjj','2014-07-13 12:39:14','',0),(67,67,1,'','You have just recently held the Class <a href=\"/class/3\">Event 3</a>. Please confirm that the class has successfully taken place by clicking the button below.','2014-07-13 12:43:17','',0),(68,68,1,'','The class <a href=\"/class/3\">Event 3</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-07-13 12:45:04','',0),(69,69,1,'','Guest has paid but cancelled late. You have recently accepted <a href=\"/profile/user2\">user 2</a> to the class <a href=\"/class/3\">Event 3</a>. Unfortunately <a href=\"/profile/user2\">user 2</a> has cancelled his attendance. Since he cancelled in such a short notice, you will still receive your money.\nReason 1','2014-07-13 18:04:20','',0),(70,70,3,'','Your cancellation was late. You have recently booked the class <a href=\"/class/3\">Event 3</a>. Unfortunately your cancellation was on short notice and your money will be paid to the host nevertheless.','2014-07-13 18:04:20','',0),(71,71,1,'','You have just recently held the Class <a href=\"/class/3\">Event 3</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/3/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-07-13 18:10:47','',0),(72,72,1,'','The class <a href=\"/class/3\">Event 3</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-07-13 18:11:07','',0),(73,73,1,'','The class <a href=\"/class/3\">Event 3</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-07-13 18:13:59','',0),(74,74,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 14, 2014 11:24 AM PDT.','2014-07-13 18:24:00','',0),(75,75,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-13 20:56:52','',0),(76,76,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 5:52 AM PDT.','2014-07-14 12:52:41','',0),(77,77,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 115.00 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-14 12:53:02','',0),(78,78,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-14 12:54:56','',0),(79,79,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 2','2014-07-14 12:56:25','',0),(80,80,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: ;laskf asfasjdf; jas;fj asdfj asjdfasdf;j asdf\r\nads fasd;fj dsjf;as jdf;lkj d\r\nasd faskdf adfjd asj','2014-07-14 12:56:25','',0),(81,81,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 6:13 AM PDT.','2014-07-14 13:13:46','',0),(82,82,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 123.05 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-14 13:13:54','',0),(83,83,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-14 13:14:27','',0),(84,84,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 2','2014-07-14 13:14:42','',0),(85,85,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: asdf asdf asdfa dsfas dfasdf\r\nas dfas df as fasdf asdf','2014-07-14 13:14:42','',0),(86,86,1,'','You have a new applicant for your Class <a href=\"/class/4\">Event 1</a>. Please go to the <a href=\"/class/4\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 6:25 AM PDT.','2014-07-14 13:25:39','',0),(87,87,1,'','You have a new applicant for your Class <a href=\"/class/4\">Event 1</a>. Please go to the <a href=\"/class/4\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 6:34 AM PDT.','2014-07-14 13:34:51','',0),(88,88,1,'','You have recently accepted <a href=\"/profile/user1\">user 1</a> to attend the class <a href=\"/class/4\">Event 1</a>. He has cancelled his attendance.\n','2014-07-14 13:35:02','',0),(89,89,1,'','You have a new applicant for your Class <a href=\"/class/4\">Event 1</a>. Please go to the <a href=\"/class/4\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 6:36 AM PDT.','2014-07-14 13:36:13','',0),(90,90,2,'','You have recently applied to the class <a href=\"/class/4\">Event 1</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 160.5 USD. <a href=\"/classes/payment/pay/id/4/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-14 13:59:39','',0),(91,91,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/4\">Event 1</a>.','2014-07-14 14:01:02','',0),(92,92,1,'','You have a new applicant for your Class <a href=\"/class/4\">Event 1</a>. Please go to the <a href=\"/class/4\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 7:01 AM PDT.','2014-07-14 14:01:44','',0),(93,93,3,'','You have recently applied to the class <a href=\"/class/4\">Event 1</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 160.5 USD. <a href=\"/classes/payment/pay/id/4/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-14 14:02:14','',0),(94,94,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/4\">Event 1</a>.','2014-07-14 14:03:08','',0),(95,95,2,'','You have a new applicant for your Class <a href=\"/class/5\">Event 2</a>. Please go to the <a href=\"/class/5\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 15, 2014 7:07 AM PDT.','2014-07-14 14:07:16','',0),(96,96,3,'','You have recently applied to the class <a href=\"/class/5\">Event 2</a>.\n<a href=\"/profile/user1\">user 1</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 271.78 USD. <a href=\"/classes/payment/pay/id/5/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-14 14:07:28','',0),(97,97,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/5\">Event 2</a>.','2014-07-14 14:07:58','',0),(98,98,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user2\">user 2</a> to the class <a href=\"/class/4\">Event 1</a>. <a href=\"/profile/user2\">user 2</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 2','2014-07-14 14:17:58','',0),(99,99,1,'','Guest has paid for class <a href=\"/class/4\">Event 1</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information:  asd asdf adsf\r\nas dfadsf adsf asdfas f\r\nadsf adsf asdf asdf asdf','2014-07-14 14:17:58','',0),(100,100,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 16, 2014 5:05 AM PDT.','2014-07-15 12:05:30','',0),(101,101,4,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 123.05 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-15 12:05:44','',0),(102,102,4,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-15 12:09:07','',0),(103,103,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 16, 2014 5:10 AM PDT.','2014-07-15 12:10:49','',0),(104,104,5,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 123.05 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-15 12:11:01','',0),(105,105,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user3\">user 3</a> to the class <a href=\"/class/3\">Event 3</a>. <a href=\"/profile/user3\">user 3</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 3','2014-07-15 12:18:19','',0),(106,106,1,'','Guest has paid for class <a href=\"/class/3\">Event 3</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: sdfa sdfa f','2014-07-15 12:18:19','',0),(107,107,1,'','The class <a href=\"/class/3\">Event 3</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-07-15 12:35:42','',0),(108,108,1,'','You have a new applicant for your Class <a href=\"/class/3\">Event 3</a>. Please go to the <a href=\"/class/3\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 17, 2014 9:42 AM PDT.','2014-07-16 16:42:27','',0),(109,109,2,'','You have recently applied to the class <a href=\"/class/3\">Event 3</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 123.05 USD. <a href=\"/classes/payment/pay/id/3/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-16 16:42:45','',0),(110,110,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/3\">Event 3</a>.','2014-07-16 16:48:20','',0),(111,111,1,'','You have a new applicant for your Class <a href=\"/class/6\">Event 5</a>. Please go to the <a href=\"/class/6\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until July 24, 2014 8:42 AM PDT.','2014-07-23 15:42:37','',0),(112,112,3,'','You have recently applied to the class <a href=\"/class/6\">Event 5</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 USD. <a href=\"/classes/payment/pay/id/6/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-07-23 15:42:45','',0),(113,113,1,'','You have a new applicant for your Class <a href=\"/class/14\">Event 20</a>. Please go to the <a href=\"/class/14\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 3:07 AM PDT.','2014-08-01 10:07:44','',0),(114,114,2,'','You have recently applied to the class <a href=\"/class/14\">Event 20</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 164.78 USD. <a href=\"/classes/payment/pay/id/14/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 10:08:01','',0),(115,115,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/14\">Event 20</a>.','2014-08-01 10:11:58','',0),(116,116,1,'','You have a new applicant for your Class <a href=\"/class/14\">Event 20</a>. Please go to the <a href=\"/class/14\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 3:15 AM PDT.','2014-08-01 10:15:42','',0),(117,117,3,'','You have recently applied to the class <a href=\"/class/14\">Event 20</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 164.78 USD. <a href=\"/classes/payment/pay/id/14/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 10:15:57','',0),(118,118,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/14\">Event 20</a>.','2014-08-01 10:16:22','',0),(119,119,1,'','You have a new applicant for your Class <a href=\"/class/14\">Event 20</a>. Please go to the <a href=\"/class/14\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 3:16 AM PDT.','2014-08-01 10:16:44','',0),(120,120,4,'','You have recently applied to the class <a href=\"/class/14\">Event 20</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 164.78 USD. <a href=\"/classes/payment/pay/id/14/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 10:16:54','',0),(121,121,1,'','You have a new applicant for your Class <a href=\"/class/14\">Event 20</a>. Please go to the <a href=\"/class/14\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 3:17 AM PDT.','2014-08-01 10:17:12','',0),(122,122,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/14\">Event 20</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 1','2014-08-01 10:18:19','',0),(123,123,1,'','Guest has paid for class <a href=\"/class/14\">Event 20</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: asdf asdfa sdf asdfa sdf adsf af a','2014-08-01 10:18:19','',0),(124,124,5,'','You have recently applied to the class <a href=\"/class/14\">Event 20</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group <a href=\"/profile/admin\">First Last</a> is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\n','2014-08-01 10:19:07','',0),(125,125,1,'','You have just recently held the Class <a href=\"/class/4\">Event 1</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/4/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:45','',0),(126,126,2,'','You have just recently held the Class <a href=\"/class/5\">Event 2</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/5/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:45','',0),(127,127,1,'','You have just recently held the Class <a href=\"/class/6\">Event 5</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/6/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:46','',0),(128,128,1,'','You have just recently held the Class <a href=\"/class/7\">Event 2</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/7/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:46','',0),(129,129,1,'','You have just recently held the Class <a href=\"/class/8\">Event 7</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/8/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:46','',0),(130,130,1,'','You have just recently held the Class <a href=\"/class/9\">Event 8</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/9/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:46','',0),(131,131,1,'','You have just recently held the Class <a href=\"/class/10\">Event 9</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/10/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:47','',0),(132,132,1,'','You have just recently held the Class <a href=\"/class/11\">Event 10</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/11/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:47','',0),(133,133,1,'','You have just recently held the Class <a href=\"/class/12\">Event 11</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/12/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:47','',0),(134,134,1,'','You have just recently held the Class <a href=\"/class/13\">Event 2</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/13/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:47','',0),(135,135,1,'','You have just recently held the Class <a href=\"/class/14\">Event 20</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/14/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 10:36:48','',0),(136,136,5,'','Dear user 4, you were accepted for the class <a href=\"/class/3\">Event 3</a>. We would like to kindly remind you to pay the class fee of 115.00 CHF by 08.02.2014.','2014-08-01 10:36:48','',0),(137,137,3,'','Dear user 2, you were accepted for the class <a href=\"/class/6\">Event 5</a>. We would like to kindly remind you to pay the class fee of 100.00 USD by 08.02.2014.','2014-08-01 10:36:48','',0),(138,138,5,'','Dear user 4, you were accepted for the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-08-01 10:36:49','',0),(139,139,1,'','You have recently accepted <a href=\"/profile/user4\">user 4</a> to the class <a href=\"/class/3\">Event 3</a>.\nUnfortunately <a href=\"/profile/user4\">user 4</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-08-01 10:36:49','',0),(140,140,3,'','Dear user 2, you were accepted for the class <a href=\"/class/6\">Event 5</a>.\nUnfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-08-01 10:36:49','',0),(141,141,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to the class <a href=\"/class/6\">Event 5</a>.\nUnfortunately <a href=\"/profile/user2\">user 2</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-08-01 10:36:49','',0),(142,142,1,'','The class <a href=\"/class/14\">Event 20</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-08-01 10:36:59','',0),(143,143,1,'','You have a new applicant for your Class <a href=\"/class/15\">New Class</a>. Please go to the <a href=\"/class/15\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 5:34 AM PDT.','2014-08-01 12:34:41','',0),(144,144,1,'','You have a new applicant for your Class <a href=\"/class/15\">New Class</a>. Please go to the <a href=\"/class/15\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 5:42 AM PDT.','2014-08-01 12:42:20','',0),(145,145,2,'','You have recently applied to the class <a href=\"/class/15\">New Class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 USD. <a href=\"/classes/payment/pay/id/15/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 12:43:07','',0),(146,146,3,'','You have recently applied to the class <a href=\"/class/15\">New Class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 USD. <a href=\"/classes/payment/pay/id/15/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 12:43:24','',0),(147,147,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/15\">New Class</a>.','2014-08-01 12:44:48','',0),(148,148,2,'','You have recently applied to the class <a href=\"/class/15\">New Class</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group <a href=\"/profile/admin\">First Last</a> is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\n','2014-08-01 12:46:32','',0),(149,149,1,'','You have a new applicant for your Class <a href=\"/class/15\">New Class</a>. Please go to the <a href=\"/class/15\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 5:47 AM PDT.','2014-08-01 12:47:09','',0),(150,150,2,'','You have recently applied to the class <a href=\"/class/15\">New Class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 USD. <a href=\"/classes/payment/pay/id/15/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 12:47:31','',0),(151,151,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/15\">New Class</a>.','2014-08-01 12:53:55','',0),(152,152,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/15\">New Class</a>.','2014-08-01 12:56:53','',0),(153,153,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/15\">New Class</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\n','2014-08-01 12:58:19','',0),(154,154,1,'','Guest has paid for class <a href=\"/class/15\">New Class</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: 5262626626252626','2014-08-01 12:58:19','',0),(155,155,1,'','You have just recently held the Class <a href=\"/class/15\">New Class</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/15/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 13:00:25','',0),(156,156,1,'','The class <a href=\"/class/15\">New Class</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-08-01 13:00:44','',0),(157,157,1,'','You have a new applicant for your Class <a href=\"/class/16\">Test</a>. Please go to the <a href=\"/class/16\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 2, 2014 6:39 AM PDT.','2014-08-01 13:39:34','',0),(158,158,5,'','You have recently applied to the class <a href=\"/class/16\">Test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 214 GBP. <a href=\"/classes/payment/pay/id/16/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-01 13:39:48','',0),(159,159,5,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/16\">Test</a>.','2014-08-01 13:40:16','',0),(160,160,1,'','You have just recently held the Class <a href=\"/class/16\">Test</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/16/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-01 13:41:19','',0),(161,161,1,'','The class <a href=\"/class/16\">Test</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-08-01 13:41:29','',0),(162,162,4,'','Dear user 3, you were accepted for the class <a href=\"/class/14\">Event 20</a>. We would like to kindly remind you to pay the class fee of 154.00 USD by 08.05.2014.','2014-08-04 20:21:36','',0),(163,163,4,'','Dear user 3, you were accepted for the class <a href=\"/class/14\">Event 20</a>.\nUnfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-08-05 10:44:38','',0),(164,164,1,'','You have recently accepted <a href=\"/profile/user3\">user 3</a> to the class <a href=\"/class/14\">Event 20</a>.\nUnfortunately <a href=\"/profile/user3\">user 3</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-08-05 10:44:38','',0),(165,165,7,'','You have a new applicant for your Class <a href=\"/class/18\">Bacon Strips</a>. Please go to the <a href=\"/class/18\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 18, 2014 1:29 PM CEST.','2014-08-17 11:29:49','',0),(166,166,7,'','You have recently accepted <a href=\"/profile/Hulk\">Hulk Hogan</a> to attend the class <a href=\"/class/18\">Bacon Strips</a>. He has cancelled his attendance.\n','2014-08-17 11:30:31','',0),(167,167,7,'','You have a new applicant for your Class <a href=\"/class/18\">Bacon Strips</a>. Please go to the <a href=\"/class/18\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 18, 2014 1:30 PM CEST.','2014-08-17 11:30:38','',0),(168,168,8,'','You have recently applied to the class <a href=\"/class/18\">Bacon Strips</a>.\nUnfortunately <a href=\"/profile/Jokaero\">Markus Liechti</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-18 13:20:18','',0),(169,169,7,'','You have a new applicant for your Class <a href=\"/class/18\">Bacon Strips</a>. Please go to the <a href=\"/class/18\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:42 AM CEST.','2014-08-20 08:42:08','',0),(170,170,7,'','You have recently accepted <a href=\"/profile/Hulk\">Hulk Hogan</a> to attend the class <a href=\"/class/18\">Bacon Strips</a>. He has cancelled his attendance.\n','2014-08-20 08:42:43','',0),(171,171,7,'','You have a new applicant for your Class <a href=\"/class/18\">Bacon Strips</a>. Please go to the <a href=\"/class/18\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:42 AM CEST.','2014-08-20 08:42:57','',0),(172,172,7,'','You have a new applicant for your Class <a href=\"/class/18\">Bacon Strips</a>. Please go to the <a href=\"/class/18\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:46 AM CEST.','2014-08-20 08:46:37','',0),(173,173,10,'','You have a new applicant for your Class <a href=\"/class/19\">Guinea Pig</a>. Please go to the <a href=\"/class/19\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:59 AM CEST.','2014-08-20 08:59:25','',0),(174,174,10,'','You have recently applied to the class <a href=\"/class/18\">Bacon Strips</a>.\n<a href=\"/profile/Jokaero\">Markus Liechti</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 36.38 CHF. <a href=\"/classes/payment/pay/id/18/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 09:01:05','',0),(175,175,8,'','You have recently applied to the class <a href=\"/class/18\">Bacon Strips</a>.\n<a href=\"/profile/Jokaero\">Markus Liechti</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 36.38 CHF. <a href=\"/classes/payment/pay/id/18/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 09:01:37','',0),(176,176,10,'','You have recently accepted <a href=\"/profile/Jokaero\">Markus Liechti</a> to attend the class <a href=\"/class/19\">Guinea Pig</a>. He has cancelled his attendance.\n','2014-08-20 09:03:17','',0),(177,177,10,'','You have a new applicant for your Class <a href=\"/class/19\">Guinea Pig</a>. Please go to the <a href=\"/class/19\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 11:03 AM CEST.','2014-08-20 09:03:26','',0),(178,178,10,'','You have a new applicant for your Class <a href=\"/class/19\">Guinea Pig</a>. Please go to the <a href=\"/class/19\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 11:10 AM CEST.','2014-08-20 09:10:04','',0),(179,179,7,'','You have recently applied to the class <a href=\"/class/19\">Guinea Pig</a>.\n<a href=\"/profile/Frankenstein\">Frank Stein</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 267.5 EUR. <a href=\"/classes/payment/pay/id/19/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 09:10:42','',0),(180,180,8,'','You have recently applied to the class <a href=\"/class/19\">Guinea Pig</a>.\n<a href=\"/profile/Frankenstein\">Frank Stein</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 267.5 EUR. <a href=\"/classes/payment/pay/id/19/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 09:10:57','',0),(181,181,8,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/19\">Guinea Pig</a>.','2014-08-20 09:23:58','',0),(182,182,8,'','You have recently applied to the class <a href=\"/class/19\">Guinea Pig</a>.\nUnfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group <a href=\"/profile/Frankenstein\">Frank Stein</a> is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\nReason 2','2014-08-20 09:27:03','',0),(183,183,7,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/19\">Guinea Pig</a>.','2014-08-20 09:30:18','',0),(184,184,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 11:32 AM CEST.','2014-08-20 09:32:30','',0),(185,185,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 2:46 PM CEST.','2014-08-20 12:46:38','',0),(186,186,10,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\n<a href=\"/profile/Hulk\">Hulk Hogan</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 2.14 CHF. <a href=\"/classes/payment/pay/id/20/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 12:47:54','',0),(187,187,7,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\n<a href=\"/profile/Hulk\">Hulk Hogan</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 2.14 CHF. <a href=\"/classes/payment/pay/id/20/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 12:48:03','',0),(188,188,8,'Hallo','Little Text','2014-08-20 13:15:24','',0),(189,189,10,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.','2014-08-20 13:30:09','',0),(190,190,8,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/Frankenstein\">Frank Stein</a> to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. <a href=\"/profile/Frankenstein\">Frank Stein</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 3','2014-08-20 13:40:01','',0),(191,191,1,'','Guest has paid for class <a href=\"/class/20\">Hulk Hogan\'s Class</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: Frank Stein\r\nCH123124123\r\n213123\r\nZürich','2014-08-20 13:40:01','',0),(192,192,8,'','You have recently accepted <a href=\"/profile/Jokaero\">Markus Liechti</a> to attend the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. He has cancelled his attendance.\nReason 2','2014-08-20 13:47:58','',0),(193,193,10,'','You have recently applied to the class <a href=\"/class/21\">Chocolate Dream</a>.\nUnfortunately <a href=\"/profile/Jokaero\">Markus Liechti</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-20 20:09:52','',0),(194,194,7,'','You have a new applicant for your Class <a href=\"/class/21\">Chocolate Dream</a>. Please go to the <a href=\"/class/21\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:18 PM CEST.','2014-08-20 20:18:06','',0),(195,195,10,'','You have recently applied to the class <a href=\"/class/21\">Chocolate Dream</a>.\n<a href=\"/profile/Jokaero\">Markus Liechti</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 USD. <a href=\"/classes/payment/pay/id/21/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 20:18:31','',0),(196,196,10,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/21\">Chocolate Dream</a>.','2014-08-20 20:19:16','',0),(197,197,7,'','Guest has paid but cancelled late. You have recently accepted <a href=\"/profile/Frankenstein\">Frank Stein</a> to the class <a href=\"/class/21\">Chocolate Dream</a>. Unfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> has cancelled his attendance. Since he cancelled in such a short notice, you will still receive your money.\nReason 2','2014-08-20 20:20:01','',0),(198,198,10,'','Your cancellation was late. You have recently booked the class <a href=\"/class/21\">Chocolate Dream</a>. Unfortunately your cancellation was on short notice and your money will be paid to the host nevertheless.','2014-08-20 20:20:01','',0),(199,199,7,'','You have a new applicant for your Class <a href=\"/class/21\">Chocolate Dream</a>. Please go to the <a href=\"/class/21\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:20 PM CEST.','2014-08-20 20:20:48','',0),(200,200,10,'','You have recently applied to the class <a href=\"/class/21\">Chocolate Dream</a>.\n<a href=\"/profile/Jokaero\">Markus Liechti</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 USD. <a href=\"/classes/payment/pay/id/21/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 20:21:04','',0),(201,201,10,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/21\">Chocolate Dream</a>.','2014-08-20 20:21:36','',0),(202,202,10,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/21\">Chocolate Dream</a>. Unfortunately <a href=\"/profile/Jokaero\">Markus Liechti</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.\nReason 2','2014-08-20 20:22:02','',0),(203,203,1,'The Class has been cancelled','The Class <a href=\"/class/21\">Chocolate Dream</a> has been cancelled. Please start the refund process.','2014-08-20 20:22:02','',0),(204,204,7,'','You have recently applied to the class <a href=\"/class/22\">Pasta Plausch</a>.\nUnfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-20 21:35:22','',0),(205,205,7,'','You have recently applied to the class <a href=\"/class/22\">Pasta Plausch</a>.\nUnfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-20 21:35:22','',0),(206,206,8,'','You have recently applied to the class <a href=\"/class/22\">Pasta Plausch</a>.\nUnfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-20 21:35:23','',0),(207,207,8,'','You have recently applied to the class <a href=\"/class/22\">Pasta Plausch</a>.\nUnfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-20 21:35:23','',0),(208,208,10,'','You have a new applicant for your Class <a href=\"/class/22\">Pasta Plausch</a>. Please go to the <a href=\"/class/22\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 10:36 PM BST.','2014-08-20 21:36:05','',0),(209,209,1,'','You have recently applied to the class <a href=\"/class/22\">Pasta Plausch</a>.\n<a href=\"/profile/Frankenstein\">Frank Stein</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 58.85 GBP. <a href=\"/classes/payment/pay/id/22/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 21:36:41','',0),(210,210,10,'','You have a new applicant for your Class <a href=\"/class/22\">Pasta Plausch</a>. Please go to the <a href=\"/class/22\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 21, 2014 11:37 PM CEST.','2014-08-20 21:37:37','',0),(211,211,8,'','You have recently applied to the class <a href=\"/class/22\">Pasta Plausch</a>.\n<a href=\"/profile/Frankenstein\">Frank Stein</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 58.85 GBP. <a href=\"/classes/payment/pay/id/22/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-20 21:38:12','',0),(212,212,8,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/22\">Pasta Plausch</a>.','2014-08-20 21:39:06','',0),(213,213,8,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/22\">Pasta Plausch</a>.','2014-08-20 21:39:08','',0),(214,214,1,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/22\">Pasta Plausch</a>.','2014-08-20 21:39:36','',0),(215,215,10,'','You have just recently held the Class <a href=\"/class/22\">Pasta Plausch</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/22/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-08-20 21:51:44','',0),(216,216,1,'','The class <a href=\"/class/22\">Pasta Plausch</a> led by <a href=\"/profile/Frankenstein\">Frank Stein</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-08-20 22:03:25','',0),(217,217,8,'','Dear Hulk Hogan, you were accepted for the class <a href=\"/class/18\">Bacon Strips</a>. We would like to kindly remind you to pay the class fee of 34.00 CHF by 08.25.2014.','2014-08-24 12:57:36','',0),(218,218,10,'','Dear Frank Stein, you were accepted for the class <a href=\"/class/18\">Bacon Strips</a>. We would like to kindly remind you to pay the class fee of 34.00 CHF by 08.25.2014.','2014-08-24 12:57:37','',0),(219,219,8,'','Dear Hulk Hogan, you were accepted for the class <a href=\"/class/18\">Bacon Strips</a>.\nUnfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-08-24 12:57:37','',0),(220,220,7,'','You have recently accepted <a href=\"/profile/Hulk\">Hulk Hogan</a> to the class <a href=\"/class/18\">Bacon Strips</a>.\nUnfortunately <a href=\"/profile/Hulk\">Hulk Hogan</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-08-24 12:57:37','',0),(221,221,10,'','Dear Frank Stein, you were accepted for the class <a href=\"/class/18\">Bacon Strips</a>.\nUnfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-08-24 12:57:38','',0),(222,222,7,'','You have recently accepted <a href=\"/profile/Frankenstein\">Frank Stein</a> to the class <a href=\"/class/18\">Bacon Strips</a>.\nUnfortunately <a href=\"/profile/Frankenstein\">Frank Stein</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-08-24 12:57:38','',0),(223,223,1,'','You have a new applicant for your Class <a href=\"/class/17\">Test Class</a>. Please go to the <a href=\"/class/17\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 27, 2014 6:51 AM PDT.','2014-08-26 13:51:46','',0),(224,224,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/17\">Test Class</a>. He has cancelled his attendance.\n','2014-08-26 13:52:30','',0),(225,225,1,'','You have a new applicant for your Class <a href=\"/class/17\">Test Class</a>. Please go to the <a href=\"/class/17\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 27, 2014 7:16 AM PDT.','2014-08-26 14:16:41','',0),(226,226,3,'','You have recently applied to the class <a href=\"/class/17\">Test Class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/17/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-26 14:16:57','',0),(227,227,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/17\">Test Class</a>.','2014-08-26 14:17:46','',0),(228,228,6,'','You have recently applied to the class <a href=\"/class/17\">Test Class</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-08-27 08:52:46','',0),(229,229,1,'','You have a new applicant for your Class <a href=\"/class/17\">Test Class</a>. Please go to the <a href=\"/class/17\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 28, 2014 1:57 AM PDT.','2014-08-27 08:57:31','',0),(230,230,1,'','You have recently accepted <a href=\"/profile/user5\">user 5</a> to attend the class <a href=\"/class/17\">Test Class</a>. He has cancelled his attendance.\n','2014-08-27 08:59:00','',0),(231,231,1,'','You have a new applicant for your Class <a href=\"/class/17\">Test Class</a>. Please go to the <a href=\"/class/17\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until August 28, 2014 1:59 AM PDT.','2014-08-27 08:59:18','',0),(232,232,6,'','You have recently applied to the class <a href=\"/class/17\">Test Class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/17/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-08-27 08:59:43','',0),(233,233,1,'','You have recently accepted <a href=\"/profile/user5\">user 5</a> to attend the class <a href=\"/class/17\">Test Class</a>. He has cancelled his attendance.\n','2014-08-27 09:00:25','',0),(234,234,1,'','You have just recently held the Class <a href=\"/class/17\">Test Class</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/17/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-09-02 09:41:21','',0),(235,235,7,'','You have just recently held the Class <a href=\"/class/18\">Bacon Strips</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/18/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-09-02 09:41:22','',0),(236,236,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 3, 2014 2:55 PM PDT.','2014-09-02 21:55:37','',0),(237,237,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 3, 2014 3:01 PM PDT.','2014-09-02 22:01:53','',0),(238,238,1,'','You have a new applicant for your Class <a href=\"/class/24\">Test Class</a>. Please go to the <a href=\"/class/24\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 3, 2014 3:22 PM PDT.','2014-09-02 22:22:06','',0),(239,239,6,'','You have recently applied to the class <a href=\"/class/24\">Test Class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/24/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-02 22:22:33','',0),(240,240,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 12:29 AM PDT.','2014-09-03 07:29:40','',0),(241,241,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 12:42 AM PDT.','2014-09-03 07:42:46','',0),(242,242,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 12:45 AM PDT.','2014-09-03 07:45:04','',0),(243,243,6,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/25/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 07:45:33','',0),(244,244,6,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/25\">Sushi class</a>.','2014-09-03 07:46:49','',0),(245,245,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 12:51 AM PDT.','2014-09-03 07:51:52','',0),(246,246,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user5\">user 5</a> to the class <a href=\"/class/25\">Sushi class</a>. <a href=\"/profile/user5\">user 5</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 1','2014-09-03 07:54:44','',0),(247,247,1,'','Guest has paid for class <a href=\"/class/25\">Sushi class</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: 4111111111111111','2014-09-03 07:54:44','',0),(248,248,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 1:13 AM PDT.','2014-09-03 08:13:42','',0),(249,249,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 1:15 AM PDT.','2014-09-03 08:15:41','',0),(250,250,5,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/25/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 08:16:27','',0),(251,251,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 1:18 AM PDT.','2014-09-03 08:18:53','',0),(252,252,3,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/25/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 08:19:15','',0),(253,253,4,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group <a href=\"/profile/admin\">First Last</a> is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\n','2014-09-03 08:19:25','',0),(254,254,1,'','You have recently accepted <a href=\"/profile/user4\">user 4</a> to attend the class <a href=\"/class/25\">Sushi class</a>. He has cancelled his attendance.\n','2014-09-03 08:24:58','',0),(255,255,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/25\">Sushi class</a>. He has cancelled his attendance.\n','2014-09-03 08:26:13','',0),(256,256,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 1:26 AM PDT.','2014-09-03 08:26:57','',0),(257,257,1,'','You have just recently held the Class <a href=\"/class/23\">Test</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/23/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-09-03 08:30:40','',0),(258,258,1,'','The class <a href=\"/class/23\">Test</a> led by <a href=\"/profile/admin\">First Last</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-09-03 08:44:33','',0),(259,259,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 3:19 AM PDT.','2014-09-03 10:19:22','',0),(260,260,5,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/25/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 10:19:48','',0),(261,261,3,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/25/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 10:20:31','',0),(262,262,1,'','You have recently accepted <a href=\"/profile/user4\">user 4</a> to attend the class <a href=\"/class/25\">Sushi class</a>. He has cancelled his attendance.\n','2014-09-03 10:23:12','',0),(263,263,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 3:23 AM PDT.','2014-09-03 10:23:36','',0),(264,264,5,'','You have recently applied to the class <a href=\"/class/25\">Sushi class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/25/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 10:23:49','',0),(265,265,1,'','You have a new applicant for your Class <a href=\"/class/26\">Pasta Party</a>. Please go to the <a href=\"/class/26\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:07 AM PDT.','2014-09-03 12:07:10','',0),(266,266,1,'','You have a new applicant for your Class <a href=\"/class/26\">Pasta Party</a>. Please go to the <a href=\"/class/26\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:07 AM PDT.','2014-09-03 12:07:19','',0),(267,267,1,'','You have a new applicant for your Class <a href=\"/class/26\">Pasta Party</a>. Please go to the <a href=\"/class/26\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:08 AM PDT.','2014-09-03 12:08:24','',0),(268,268,1,'','You have a new applicant for your Class <a href=\"/class/26\">Pasta Party</a>. Please go to the <a href=\"/class/26\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:08 AM PDT.','2014-09-03 12:08:36','',0),(269,269,3,'','You have recently applied to the class <a href=\"/class/26\">Pasta Party</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 CHF. <a href=\"/classes/payment/pay/id/26/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 12:08:54','',0),(270,270,5,'','You have recently applied to the class <a href=\"/class/26\">Pasta Party</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 CHF. <a href=\"/classes/payment/pay/id/26/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 12:09:02','',0),(271,271,1,'','You have recently accepted <a href=\"/profile/user4\">user 4</a> to attend the class <a href=\"/class/25\">Sushi class</a>. He has cancelled his attendance.\n','2014-09-03 12:09:52','',0),(272,272,1,'','You have recently accepted <a href=\"/profile/user4\">user 4</a> to attend the class <a href=\"/class/26\">Pasta Party</a>. He has cancelled his attendance.\n','2014-09-03 12:10:08','',0),(273,273,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/26\">Pasta Party</a>. He has cancelled his attendance.\n','2014-09-03 12:10:18','',0),(274,274,1,'','You have a new applicant for your Class <a href=\"/class/26\">Pasta Party</a>. Please go to the <a href=\"/class/26\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:10 AM PDT.','2014-09-03 12:10:35','',0),(275,275,2,'','You have recently applied to the class <a href=\"/class/26\">Pasta Party</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 CHF. <a href=\"/classes/payment/pay/id/26/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 12:10:47','',0),(276,276,1,'','You have a new applicant for your Class <a href=\"/class/26\">Pasta Party</a>. Please go to the <a href=\"/class/26\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:11 AM PDT.','2014-09-03 12:11:52','',0),(277,277,1,'','You have recently accepted <a href=\"/profile/user1\">user 1</a> to attend the class <a href=\"/class/26\">Pasta Party</a>. He has cancelled his attendance.\n','2014-09-03 12:12:18','',0),(278,278,1,'','You have just recently held the Class <a href=\"/class/26\">Pasta Party</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/26/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-09-03 12:14:56','',0),(279,279,1,'','You have a new applicant for your Class <a href=\"/class/25\">Sushi class</a>. Please go to the <a href=\"/class/25\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 5:50 AM PDT.','2014-09-03 12:50:04','',0),(280,280,1,'','You have just recently held the Class <a href=\"/class/25\">Sushi class</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/25/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-09-03 12:55:50','',0),(281,281,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 4, 2014 2:41 PM BST.','2014-09-03 13:41:28','',0),(282,282,1,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\n<a href=\"/profile/Hulk\">Hulk Hogan</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 2.14 CHF. <a href=\"/classes/payment/pay/id/20/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-03 13:42:11','',0),(283,283,2,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\nUnfortunately <a href=\"/profile/Hulk\">Hulk Hogan</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-09-13 22:10:40','',0),(284,284,1,'','Dear First Last, you were accepted for the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. We would like to kindly remind you to pay the class fee of 2.00 CHF by 09.14.2014.','2014-09-13 22:10:40','',0),(285,285,1,'','Dear First Last, you were accepted for the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\nUnfortunately we have not received the payment of the class fee so far. If you still would like to join the class, you will have to apply again. You are most welcome to apply for any other class you desire to join.','2014-09-13 22:10:40','',0),(286,286,8,'','You have recently accepted <a href=\"/profile/admin\">First Last</a> to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\nUnfortunately <a href=\"/profile/admin\">First Last</a> has not paid within the given timeframe of three days. He was notified that he has not paid and that he has to apply for the class again if he still wants to join.','2014-09-13 22:10:41','',0),(287,287,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 1:52 AM EEST.','2014-09-13 22:52:20','',0),(288,288,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 2:02 AM EEST.','2014-09-13 23:02:58','',0),(289,289,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 2:14 AM EEST.','2014-09-13 23:14:07','',0),(290,290,9,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 64.2 CHF. <a href=\"/classes/payment/pay/id/28/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-13 23:15:55','',0),(291,291,9,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/28\">Saussage Party</a>.','2014-09-13 23:20:53','',0),(292,292,11,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to the class <a href=\"/class/28\">Saussage Party</a>. <a href=\"/profile/reto\">Reto Spescha</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 1','2014-09-13 23:39:24','',0),(293,293,1,'','Guest has paid for class <a href=\"/class/28\">Saussage Party</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: sdf','2014-09-13 23:39:24','',0),(294,294,11,'','You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to attend the class <a href=\"/class/28\">Saussage Party</a>. He has cancelled his attendance.\nReason 1','2014-09-14 00:02:41','',0),(295,295,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 3:08 AM EEST.','2014-09-14 00:08:21','',0),(296,296,9,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 64.2 CHF. <a href=\"/classes/payment/pay/id/28/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-14 00:09:02','',0),(297,297,11,'','You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to attend the class <a href=\"/class/28\">Saussage Party</a>. He has cancelled his attendance.\nReason 1','2014-09-14 00:11:38','',0),(298,298,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 3:14 AM EEST.','2014-09-14 00:14:00','',0),(299,299,9,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 64.2 CHF. <a href=\"/classes/payment/pay/id/28/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-14 00:14:22','',0),(300,300,9,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/28\">Saussage Party</a>.','2014-09-14 00:17:47','',0),(301,301,9,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\nUnfortunately <a href=\"/profile/PeterNorth\">Peter North</a> could not accept you for this class, there can be multiple reasons for that, mostly because the class is already fully booked or you would not fit into the group <a href=\"/profile/PeterNorth\">Peter North</a> is trying to invite. But don’t be discouraged, there are many more classes out there for you to join.\nReason 2','2014-09-14 00:23:11','',0),(302,302,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 3:24 AM EEST.','2014-09-14 00:24:42','',0),(303,303,9,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 64.2 CHF. <a href=\"/classes/payment/pay/id/28/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-14 00:30:03','',0),(304,304,11,'','You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to attend the class <a href=\"/class/28\">Saussage Party</a>. He has cancelled his attendance.\nReason 1','2014-09-14 00:33:45','',0),(305,305,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 3:34 AM EEST.','2014-09-14 00:34:09','',0),(306,306,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 15, 2014 3:35 AM EEST.','2014-09-14 00:35:24','',0),(307,307,9,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 64.2 CHF. <a href=\"/classes/payment/pay/id/28/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-14 00:35:45','',0),(308,308,9,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/28\">Saussage Party</a>.','2014-09-14 00:36:22','',0),(309,309,11,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to the class <a href=\"/class/28\">Saussage Party</a>. <a href=\"/profile/reto\">Reto Spescha</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 1','2014-09-14 00:39:44','',0),(310,310,1,'','Guest has paid for class <a href=\"/class/28\">Saussage Party</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: tg6yuj','2014-09-14 00:39:44','',0),(311,311,11,'','You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to attend the class <a href=\"/class/28\">Saussage Party</a>. He has cancelled his attendance.\n','2014-09-14 00:53:33','',0),(312,312,11,'','You have a new applicant for your Class <a href=\"/class/29\">Peperoni Pizza</a>. Please go to the <a href=\"/class/29\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 16, 2014 2:13 AM EEST.','2014-09-14 23:13:16','',0),(313,313,9,'','You have recently applied to the class <a href=\"/class/29\">Peperoni Pizza</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 85.6 CHF. <a href=\"/classes/payment/pay/id/29/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-14 23:14:20','',0),(314,314,11,'','You have recently accepted <a href=\"/profile/reto\">Reto Spescha</a> to attend the class <a href=\"/class/29\">Peperoni Pizza</a>. He has cancelled his attendance.\n','2014-09-14 23:31:48','',0),(315,315,11,'','You have a new applicant for your Class <a href=\"/class/29\">Peperoni Pizza</a>. Please go to the <a href=\"/class/29\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 16, 2014 2:40 AM EEST.','2014-09-14 23:40:26','',0),(316,316,9,'','You have recently applied to the class <a href=\"/class/29\">Peperoni Pizza</a>.\n<a href=\"/profile/PeterNorth\">Peter North</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 85.6 CHF. <a href=\"/classes/payment/pay/id/29/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-14 23:41:13','',0),(317,317,9,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/29\">Peperoni Pizza</a>.','2014-09-14 23:42:10','',0),(318,318,9,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/29\">Peperoni Pizza</a>. Unfortunately <a href=\"/profile/PeterNorth\">Peter North</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.\nReason 1','2014-09-14 23:43:54','',0),(319,319,1,'The Class has been cancelled','The Class <a href=\"/class/29\">Peperoni Pizza</a> has been cancelled. Please start the refund process.','2014-09-14 23:43:54','',0),(320,320,11,'','You have just recently held the Class <a href=\"/class/30\">Broccoly</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/30/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-09-14 23:57:33','',0),(321,321,1,'','The class <a href=\"/class/30\">Broccoly</a> led by <a href=\"/profile/PeterNorth\">Peter North</a> has successfully ended and has been verified by the host. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) and pay the host.','2014-09-15 00:02:47','',0),(322,322,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 17, 2014 10:00 PM CEST.','2014-09-16 20:00:44','',0),(323,323,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 17, 2014 10:23 PM CEST.','2014-09-16 20:23:43','',0),(325,325,7,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\nUnfortunately <a href=\"/profile/Hulk\">Hulk Hogan</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-09-17 21:42:31','',0),(326,326,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 19, 2014 12:02 AM CEST.','2014-09-17 22:02:04','',0),(327,327,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 19, 2014 12:02 AM CEST.','2014-09-17 22:02:29','',0),(328,328,7,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\n<a href=\"/profile/Hulk\">Hulk Hogan</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 2.14 CHF. <a href=\"/classes/payment/pay/id/20/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-17 22:03:55','',0),(329,329,7,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.','2014-09-17 22:29:35','',0),(330,330,8,'','You have a new applicant for your Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please go to the <a href=\"/class/20\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 19, 2014 1:43 AM EEST.','2014-09-17 22:43:13','',0),(331,331,13,'','You have recently applied to the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.\n<a href=\"/profile/Hulk\">Hulk Hogan</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 2.14 CHF. <a href=\"/classes/payment/pay/id/20/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-09-17 22:44:11','',0),(332,332,11,'','You have a new applicant for your Class <a href=\"/class/28\">Saussage Party</a>. Please go to the <a href=\"/class/28\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until September 19, 2014 11:54 PM EEST.','2014-09-18 20:54:20','',0),(333,333,13,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/20\">Hulk Hogan\'s Class</a>.','2014-09-18 20:57:05','',0),(334,334,7,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\nUnfortunately <a href=\"/profile/PeterNorth\">Peter North</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-09-18 22:35:40','',0),(335,335,13,'','You have recently applied to the class <a href=\"/class/28\">Saussage Party</a>.\nUnfortunately <a href=\"/profile/PeterNorth\">Peter North</a> was not able to react to your application within 24 hours, you are most welcome to try and apply again to this class or choose any other class you desire to join.','2014-09-21 23:38:35','',0),(336,336,8,'','You have just recently held the Class <a href=\"/class/20\">Hulk Hogan\'s Class</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/20/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-10-01 13:27:32','',0),(337,337,1,'','You have just recently held the Class <a href=\"/class/27\">test</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/27/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-10-01 13:27:32','',0),(338,338,11,'','You have just recently held the Class <a href=\"/class/28\">Saussage Party</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/28/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-10-01 13:27:32','',0),(339,339,1,'','You have a new applicant for your Class <a href=\"/class/31\">New Class test</a>. Please go to the <a href=\"/class/31\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 3, 2014 5:43 AM PDT.','2014-10-02 12:43:32','',0),(340,340,1,'','You have a new applicant for your Class <a href=\"/class/31\">New Class test</a>. Please go to the <a href=\"/class/31\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 3, 2014 5:43 AM PDT.','2014-10-02 12:43:50','',0),(341,341,2,'','You have recently applied to the class <a href=\"/class/31\">New Class test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 21.4 EUR. <a href=\"/classes/payment/pay/id/31/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-02 12:44:17','',0),(342,342,3,'','You have recently applied to the class <a href=\"/class/31\">New Class test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 21.4 EUR. <a href=\"/classes/payment/pay/id/31/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-02 12:44:24','',0),(343,343,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/31\">New Class test</a>. He has cancelled his attendance.\n','2014-10-02 12:45:02','',0),(344,344,1,'','You have a new applicant for your Class <a href=\"/class/31\">New Class test</a>. Please go to the <a href=\"/class/31\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 3, 2014 5:47 AM PDT.','2014-10-02 12:47:14','',0),(345,345,3,'','You have recently applied to the class <a href=\"/class/31\">New Class test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 21.4 EUR. <a href=\"/classes/payment/pay/id/31/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-02 12:47:29','',0),(346,346,3,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/31\">New Class test</a>.','2014-10-02 12:47:59','',0),(347,347,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user2\">user 2</a> to the class <a href=\"/class/31\">New Class test</a>. <a href=\"/profile/user2\">user 2</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\n','2014-10-02 12:48:23','',0),(348,348,1,'','Guest has paid for class <a href=\"/class/31\">New Class test</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: jb knlkmnlm;16161333','2014-10-02 12:48:23','',0),(349,349,1,'','You have recently accepted <a href=\"/profile/user2\">user 2</a> to attend the class <a href=\"/class/31\">New Class test</a>. He has cancelled his attendance.\n','2014-10-03 11:12:49','',0),(350,350,1,'','You have a new applicant for your Class <a href=\"/class/31\">New Class test</a>. Please go to the <a href=\"/class/31\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 4, 2014 4:18 AM PDT.','2014-10-03 11:18:54','',0),(351,351,4,'','You have recently applied to the class <a href=\"/class/31\">New Class test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 21.4 EUR. <a href=\"/classes/payment/pay/id/31/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-03 11:19:14','',0),(352,352,4,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/31\">New Class test</a>.','2014-10-03 11:20:00','',0),(353,353,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user3\">user 3</a> to the class <a href=\"/class/31\">New Class test</a>. <a href=\"/profile/user3\">user 3</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\n','2014-10-03 11:20:47','',0),(354,354,1,'','Guest has paid for class <a href=\"/class/31\">New Class test</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: hcvhvjv14651463163163','2014-10-03 11:20:47','',0),(355,355,2,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/31\">New Class test</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.\n','2014-10-03 11:48:02','',0),(356,356,4,'The Class has been cancelled','Host has cancelled the Event. You have recently applied for the class <a href=\"/class/31\">New Class test</a>. Unfortunately <a href=\"/profile/admin\">First Last</a> has cancelled the class. There are several reasons why this might have happened. We hope you are able to enjoy another class with Happetite.\n','2014-10-03 11:48:02','',0),(357,357,1,'','You have just recently held the Class <a href=\"/class/32\">New Class test Test</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/32/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-10-03 12:04:51','',0),(358,358,1,'','You have a new applicant for your Class <a href=\"/class/33\">New Class test</a>. Please go to the <a href=\"/class/33\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 4, 2014 5:50 AM PDT.','2014-10-03 12:50:50','',0),(359,359,4,'','You have recently applied to the class <a href=\"/class/33\">New Class test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 53.5 EUR. <a href=\"/classes/payment/pay/id/33/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-03 12:51:05','',0),(360,360,4,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/33\">New Class test</a>.','2014-10-03 12:51:53','',0),(361,361,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user3\">user 3</a> to the class <a href=\"/class/33\">New Class test</a>. <a href=\"/profile/user3\">user 3</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\n','2014-10-03 13:09:28','',0),(362,362,1,'','Guest has paid for class <a href=\"/class/33\">New Class test</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: dbzhbzdxhzx','2014-10-03 13:09:28','',0),(363,363,1,'','You have a new applicant for your Class <a href=\"/class/33\">New Class test</a>. Please go to the <a href=\"/class/33\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 9, 2014 6:55 AM PDT.','2014-10-08 13:55:46','',0),(364,364,2,'','You have recently applied to the class <a href=\"/class/33\">New Class test</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 53.5 EUR. <a href=\"/classes/payment/pay/id/33/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-08 13:56:01','',0),(365,365,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/33\">New Class test</a>.','2014-10-08 13:56:38','',0),(366,366,1,'','You have a new applicant for your Class <a href=\"/class/34\">Cupcake class</a>. Please go to the <a href=\"/class/34\">class page</a> and approve/reject the applicant within the next 24 hours, i.e. until October 10, 2014 7:24 AM PDT.','2014-10-09 14:24:20','',0),(367,367,2,'','You have recently applied to the class <a href=\"/class/34\">Cupcake class</a>.\n<a href=\"/profile/admin\">First Last</a> has accepted your request and would be happy to welcoming you to his event.\nAll that is left is the payment. Please click the link below in order to pay the full amount of 107 EUR. <a href=\"/classes/payment/pay/id/34/format/smoothbox\" class=\"smoothbox\">Pay Now</a>','2014-10-09 14:24:53','',0),(368,368,2,'','Thank you for your payment. You are now fully approved for the class <a href=\"/class/34\">Cupcake class</a>.','2014-10-09 14:25:44','',0),(369,369,1,'','Guest has paid but cancelled early. You have recently accepted <a href=\"/profile/user1\">user 1</a> to the class <a href=\"/class/34\">Cupcake class</a>. <a href=\"/profile/user1\">user 1</a> has cancelled his attendance. Since he cancelled early enough, we will refund his money and you’re free to accept another guest instead.\nReason 2','2014-10-09 14:26:30','',0),(370,370,1,'','Guest has paid for class <a href=\"/class/34\">Cupcake class</a> but cancelled and gets refunded. Please go to the admin panel (<a href=\"/admin/event/manage\">link</a>) to refund his money.\nBank Account Information: ghcvjhvvk','2014-10-09 14:26:30','',0),(371,371,1,'','You have just recently held the Class <a href=\"/class/33\">New Class test</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/33/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-10-29 12:52:29','',0),(372,372,1,'','You have just recently held the Class <a href=\"/class/34\">Cupcake class</a>. Please confirm that the class has successfully taken place by clicking the button below.\n<a href=\"/classes/finish/34/format/smoothbox\" class=\"smoothbox\">Mark class as finished</a>','2014-10-29 12:52:30','',0);
/*!40000 ALTER TABLE `engine4_messages_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_messages_recipients`
--

DROP TABLE IF EXISTS `engine4_messages_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_messages_recipients` (
  `user_id` int(11) unsigned NOT NULL,
  `conversation_id` int(11) unsigned NOT NULL,
  `inbox_message_id` int(11) unsigned DEFAULT NULL,
  `inbox_updated` datetime DEFAULT NULL,
  `inbox_read` tinyint(1) DEFAULT NULL,
  `inbox_deleted` tinyint(1) DEFAULT NULL,
  `outbox_message_id` int(11) unsigned DEFAULT NULL,
  `outbox_updated` datetime DEFAULT NULL,
  `outbox_deleted` tinyint(1) DEFAULT NULL,
  `system` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`conversation_id`,`system`),
  KEY `INBOX_UPDATED` (`user_id`,`conversation_id`,`inbox_updated`),
  KEY `OUTBOX_UPDATED` (`user_id`,`conversation_id`,`outbox_updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_messages_recipients`
--

LOCK TABLES `engine4_messages_recipients` WRITE;
/*!40000 ALTER TABLE `engine4_messages_recipients` DISABLE KEYS */;
INSERT INTO `engine4_messages_recipients` VALUES (1,1,1,'2014-07-09 12:51:58',1,1,0,NULL,1,'0'),(1,1,NULL,NULL,1,1,1,'2014-07-09 12:51:58',1,'1'),(1,2,2,'2014-07-09 15:49:08',1,1,0,NULL,1,'0'),(1,2,NULL,NULL,1,1,2,'2014-07-09 15:49:08',1,'1'),(1,3,3,'2014-07-10 09:05:52',0,1,0,NULL,1,'0'),(1,3,NULL,NULL,1,1,3,'2014-07-10 09:05:52',1,'1'),(1,4,4,'2014-07-10 09:07:02',1,1,0,NULL,1,'0'),(1,4,NULL,NULL,1,1,4,'2014-07-10 09:07:02',1,'1'),(1,14,14,'2014-07-10 12:27:23',1,1,0,NULL,1,'0'),(1,14,NULL,NULL,1,1,14,'2014-07-10 12:27:23',1,'1'),(1,16,16,'2014-07-10 12:32:09',1,1,0,NULL,1,'0'),(1,16,NULL,NULL,1,1,16,'2014-07-10 12:32:09',1,'1'),(1,18,18,'2014-07-10 12:59:52',0,1,0,NULL,1,'0'),(1,18,NULL,NULL,1,1,18,'2014-07-10 12:59:52',1,'1'),(1,19,19,'2014-07-10 12:59:52',0,1,0,NULL,1,'0'),(1,19,NULL,NULL,1,1,19,'2014-07-10 12:59:52',1,'1'),(1,20,20,'2014-07-10 15:36:55',0,1,0,NULL,1,'0'),(1,20,NULL,NULL,1,1,20,'2014-07-10 15:36:55',1,'1'),(1,23,23,'2014-07-10 16:13:47',0,1,0,NULL,1,'0'),(1,23,NULL,NULL,1,1,23,'2014-07-10 16:13:47',1,'1'),(1,24,24,'2014-07-10 16:13:47',0,1,0,NULL,1,'0'),(1,24,NULL,NULL,1,1,24,'2014-07-10 16:13:47',1,'1'),(1,25,25,'2014-07-10 16:13:47',0,1,0,NULL,1,'0'),(1,25,NULL,NULL,1,1,25,'2014-07-10 16:13:47',1,'1'),(1,26,26,'2014-07-10 16:13:47',0,1,0,NULL,1,'0'),(1,26,NULL,NULL,1,1,26,'2014-07-10 16:13:47',1,'1'),(1,28,28,'2014-07-10 16:13:48',0,1,0,NULL,1,'0'),(1,28,NULL,NULL,1,1,28,'2014-07-10 16:13:48',1,'1'),(1,29,29,'2014-07-10 16:13:48',0,1,0,NULL,1,'0'),(1,29,NULL,NULL,1,1,29,'2014-07-10 16:13:48',1,'1'),(1,30,30,'2014-07-10 16:13:48',0,1,0,NULL,1,'0'),(1,30,NULL,NULL,1,1,30,'2014-07-10 16:13:48',1,'1'),(1,31,31,'2014-07-10 16:13:49',0,1,0,NULL,1,'0'),(1,31,NULL,NULL,1,1,31,'2014-07-10 16:13:49',1,'1'),(1,32,32,'2014-07-10 16:13:49',0,1,0,NULL,1,'0'),(1,32,NULL,NULL,1,1,32,'2014-07-10 16:13:49',1,'1'),(1,34,34,'2014-07-10 16:48:59',0,1,0,NULL,1,'0'),(1,34,NULL,NULL,1,1,34,'2014-07-10 16:48:59',1,'1'),(1,36,36,'2014-07-10 19:47:01',1,1,0,NULL,1,'0'),(1,36,NULL,NULL,1,1,36,'2014-07-10 19:47:01',1,'1'),(1,37,37,'2014-07-10 19:47:55',1,1,0,NULL,1,'0'),(1,37,NULL,NULL,1,1,37,'2014-07-10 19:47:55',1,'1'),(1,38,38,'2014-07-11 08:20:44',1,1,0,NULL,1,'0'),(1,38,NULL,NULL,1,1,38,'2014-07-11 08:20:44',1,'1'),(1,46,46,'2014-07-11 09:14:19',1,1,0,NULL,1,'0'),(1,46,NULL,NULL,1,1,46,'2014-07-11 09:14:19',1,'1'),(1,48,48,'2014-07-11 13:42:20',0,1,0,NULL,1,'0'),(1,48,NULL,NULL,1,1,48,'2014-07-11 13:42:20',1,'1'),(1,51,51,'2014-07-13 09:03:10',0,1,0,NULL,1,'0'),(1,51,NULL,NULL,1,1,51,'2014-07-13 09:03:10',1,'1'),(1,54,54,'2014-07-13 12:04:17',0,1,0,NULL,1,'0'),(1,54,NULL,NULL,1,1,54,'2014-07-13 12:04:17',1,'1'),(1,55,55,'2014-07-13 12:04:18',0,1,0,NULL,1,'0'),(1,55,NULL,NULL,1,1,55,'2014-07-13 12:04:18',1,'1'),(1,56,56,'2014-07-13 12:05:13',0,1,0,NULL,1,'0'),(1,56,NULL,NULL,1,1,56,'2014-07-13 12:05:13',1,'1'),(1,59,59,'2014-07-13 12:29:57',1,1,0,NULL,1,'0'),(1,59,NULL,NULL,1,1,59,'2014-07-13 12:29:57',1,'1'),(1,60,60,'2014-07-13 12:29:57',0,1,0,NULL,1,'0'),(1,60,NULL,NULL,1,1,60,'2014-07-13 12:29:57',1,'1'),(1,61,61,'2014-07-13 12:31:53',1,1,0,NULL,1,'0'),(1,61,NULL,NULL,1,1,61,'2014-07-13 12:31:53',1,'1'),(1,62,62,'2014-07-13 12:31:53',1,1,0,NULL,1,'0'),(1,62,NULL,NULL,1,1,62,'2014-07-13 12:31:53',1,'1'),(1,63,63,'2014-07-13 12:37:58',1,1,0,NULL,1,'0'),(1,63,NULL,NULL,1,1,63,'2014-07-13 12:37:58',1,'1'),(1,64,64,'2014-07-13 12:37:58',1,1,0,NULL,1,'0'),(1,64,NULL,NULL,1,1,64,'2014-07-13 12:37:58',1,'1'),(1,65,65,'2014-07-13 12:39:14',0,1,0,NULL,1,'0'),(1,65,NULL,NULL,1,1,65,'2014-07-13 12:39:14',1,'1'),(1,66,66,'2014-07-13 12:39:14',1,1,0,NULL,1,'0'),(1,66,NULL,NULL,1,1,66,'2014-07-13 12:39:14',1,'1'),(1,67,67,'2014-07-13 12:43:17',0,1,0,NULL,1,'0'),(1,67,NULL,NULL,1,1,67,'2014-07-13 12:43:17',1,'1'),(1,68,68,'2014-07-13 12:45:04',1,1,0,NULL,1,'0'),(1,68,NULL,NULL,1,1,68,'2014-07-13 12:45:04',1,'1'),(1,69,69,'2014-07-13 18:04:20',1,1,0,NULL,1,'0'),(1,69,NULL,NULL,1,1,69,'2014-07-13 18:04:20',1,'1'),(1,71,71,'2014-07-13 18:10:47',1,1,0,NULL,1,'0'),(1,71,NULL,NULL,1,1,71,'2014-07-13 18:10:47',1,'1'),(1,72,72,'2014-07-13 18:11:07',1,1,0,NULL,1,'0'),(1,72,NULL,NULL,1,1,72,'2014-07-13 18:11:07',1,'1'),(1,73,73,'2014-07-13 18:13:59',1,1,0,NULL,1,'0'),(1,73,NULL,NULL,1,1,73,'2014-07-13 18:13:59',1,'1'),(1,74,74,'2014-07-13 18:24:00',0,1,0,NULL,1,'0'),(1,74,NULL,NULL,1,1,74,'2014-07-13 18:24:00',1,'1'),(1,76,76,'2014-07-14 12:52:41',1,1,0,NULL,1,'0'),(1,76,NULL,NULL,1,1,76,'2014-07-14 12:52:41',1,'1'),(1,79,79,'2014-07-14 12:56:25',1,1,0,NULL,1,'0'),(1,79,NULL,NULL,1,1,79,'2014-07-14 12:56:25',1,'1'),(1,80,80,'2014-07-14 12:56:25',1,1,0,NULL,1,'0'),(1,80,NULL,NULL,1,1,80,'2014-07-14 12:56:25',1,'1'),(1,81,81,'2014-07-14 13:13:46',1,1,0,NULL,1,'0'),(1,81,NULL,NULL,1,1,81,'2014-07-14 13:13:46',1,'1'),(1,84,84,'2014-07-14 13:14:42',1,1,0,NULL,1,'0'),(1,84,NULL,NULL,1,1,84,'2014-07-14 13:14:42',1,'1'),(1,85,85,'2014-07-14 13:14:42',1,1,0,NULL,1,'0'),(1,85,NULL,NULL,1,1,85,'2014-07-14 13:14:42',1,'1'),(1,86,86,'2014-07-14 13:25:39',0,1,0,NULL,1,'0'),(1,86,NULL,NULL,1,1,86,'2014-07-14 13:25:39',1,'1'),(1,87,87,'2014-07-14 13:34:51',0,1,0,NULL,1,'0'),(1,87,NULL,NULL,1,1,87,'2014-07-14 13:34:51',1,'1'),(1,88,88,'2014-07-14 13:35:02',0,1,0,NULL,1,'0'),(1,88,NULL,NULL,1,1,88,'2014-07-14 13:35:02',1,'1'),(1,89,89,'2014-07-14 13:36:13',0,1,0,NULL,1,'0'),(1,89,NULL,NULL,1,1,89,'2014-07-14 13:36:13',1,'1'),(1,92,92,'2014-07-14 14:01:44',0,1,0,NULL,1,'0'),(1,92,NULL,NULL,1,1,92,'2014-07-14 14:01:44',1,'1'),(1,98,98,'2014-07-14 14:17:58',0,1,0,NULL,1,'0'),(1,98,NULL,NULL,1,1,98,'2014-07-14 14:17:58',1,'1'),(1,99,99,'2014-07-14 14:17:58',0,1,0,NULL,1,'0'),(1,99,NULL,NULL,1,1,99,'2014-07-14 14:17:58',1,'1'),(1,100,100,'2014-07-15 12:05:30',0,1,0,NULL,1,'0'),(1,100,NULL,NULL,1,1,100,'2014-07-15 12:05:30',1,'1'),(1,103,103,'2014-07-15 12:10:49',0,1,0,NULL,1,'0'),(1,103,NULL,NULL,1,1,103,'2014-07-15 12:10:49',1,'1'),(1,105,105,'2014-07-15 12:18:19',0,1,0,NULL,1,'0'),(1,105,NULL,NULL,1,1,105,'2014-07-15 12:18:19',1,'1'),(1,106,106,'2014-07-15 12:18:20',0,1,0,NULL,1,'0'),(1,106,NULL,NULL,1,1,106,'2014-07-15 12:18:20',1,'1'),(1,107,107,'2014-07-15 12:35:42',0,1,0,NULL,1,'0'),(1,107,NULL,NULL,1,1,107,'2014-07-15 12:35:42',1,'1'),(1,108,108,'2014-07-16 16:42:27',1,0,0,NULL,1,'0'),(1,108,NULL,NULL,1,1,108,'2014-07-16 16:42:27',0,'1'),(1,111,111,'2014-07-23 15:42:37',0,0,0,NULL,1,'0'),(1,111,NULL,NULL,1,1,111,'2014-07-23 15:42:37',0,'1'),(1,113,113,'2014-08-01 10:07:44',0,0,0,NULL,1,'0'),(1,113,NULL,NULL,1,1,113,'2014-08-01 10:07:44',0,'1'),(1,116,116,'2014-08-01 10:15:42',0,0,0,NULL,1,'0'),(1,116,NULL,NULL,1,1,116,'2014-08-01 10:15:42',0,'1'),(1,119,119,'2014-08-01 10:16:44',0,0,0,NULL,1,'0'),(1,119,NULL,NULL,1,1,119,'2014-08-01 10:16:44',0,'1'),(1,121,121,'2014-08-01 10:17:12',0,0,0,NULL,1,'0'),(1,121,NULL,NULL,1,1,121,'2014-08-01 10:17:12',0,'1'),(1,122,122,'2014-08-01 10:18:19',0,0,0,NULL,1,'0'),(1,122,NULL,NULL,1,1,122,'2014-08-01 10:18:19',0,'1'),(1,123,123,'2014-08-01 10:18:19',0,0,0,NULL,1,'0'),(1,123,NULL,NULL,1,1,123,'2014-08-01 10:18:19',0,'1'),(1,125,125,'2014-08-01 10:36:45',0,0,0,NULL,1,'0'),(1,125,NULL,NULL,1,1,125,'2014-08-01 10:36:45',0,'1'),(1,127,127,'2014-08-01 10:36:46',0,0,0,NULL,1,'0'),(1,127,NULL,NULL,1,1,127,'2014-08-01 10:36:46',0,'1'),(1,128,128,'2014-08-01 10:36:46',0,0,0,NULL,1,'0'),(1,128,NULL,NULL,1,1,128,'2014-08-01 10:36:46',0,'1'),(1,129,129,'2014-08-01 10:36:46',0,0,0,NULL,1,'0'),(1,129,NULL,NULL,1,1,129,'2014-08-01 10:36:46',0,'1'),(1,130,130,'2014-08-01 10:36:46',0,0,0,NULL,1,'0'),(1,130,NULL,NULL,1,1,130,'2014-08-01 10:36:46',0,'1'),(1,131,131,'2014-08-01 10:36:47',0,0,0,NULL,1,'0'),(1,131,NULL,NULL,1,1,131,'2014-08-01 10:36:47',0,'1'),(1,132,132,'2014-08-01 10:36:47',0,0,0,NULL,1,'0'),(1,132,NULL,NULL,1,1,132,'2014-08-01 10:36:47',0,'1'),(1,133,133,'2014-08-01 10:36:47',0,0,0,NULL,1,'0'),(1,133,NULL,NULL,1,1,133,'2014-08-01 10:36:47',0,'1'),(1,134,134,'2014-08-01 10:36:47',0,0,0,NULL,1,'0'),(1,134,NULL,NULL,1,1,134,'2014-08-01 10:36:47',0,'1'),(1,135,135,'2014-08-01 10:36:48',0,0,0,NULL,1,'0'),(1,135,NULL,NULL,1,1,135,'2014-08-01 10:36:48',0,'1'),(1,139,139,'2014-08-01 10:36:49',0,0,0,NULL,1,'0'),(1,139,NULL,NULL,1,1,139,'2014-08-01 10:36:49',0,'1'),(1,141,141,'2014-08-01 10:36:49',0,0,0,NULL,1,'0'),(1,141,NULL,NULL,1,1,141,'2014-08-01 10:36:49',0,'1'),(1,142,142,'2014-08-01 10:36:59',0,0,0,NULL,1,'0'),(1,142,NULL,NULL,1,1,142,'2014-08-01 10:36:59',0,'1'),(1,143,143,'2014-08-01 12:34:41',0,0,0,NULL,1,'0'),(1,143,NULL,NULL,1,1,143,'2014-08-01 12:34:41',0,'1'),(1,144,144,'2014-08-01 12:42:20',0,0,0,NULL,1,'0'),(1,144,NULL,NULL,1,1,144,'2014-08-01 12:42:20',0,'1'),(1,149,149,'2014-08-01 12:47:09',0,0,0,NULL,1,'0'),(1,149,NULL,NULL,1,1,149,'2014-08-01 12:47:09',0,'1'),(1,153,153,'2014-08-01 12:58:19',1,0,0,NULL,1,'0'),(1,153,NULL,NULL,1,1,153,'2014-08-01 12:58:19',0,'1'),(1,154,154,'2014-08-01 12:58:19',1,0,0,NULL,1,'0'),(1,154,NULL,NULL,1,1,154,'2014-08-01 12:58:19',0,'1'),(1,155,155,'2014-08-01 13:00:25',1,0,0,NULL,1,'0'),(1,155,NULL,NULL,1,1,155,'2014-08-01 13:00:25',0,'1'),(1,156,156,'2014-08-01 13:00:44',1,0,0,NULL,1,'0'),(1,156,NULL,NULL,1,1,156,'2014-08-01 13:00:44',0,'1'),(1,157,157,'2014-08-01 13:39:34',1,0,0,NULL,1,'0'),(1,157,NULL,NULL,1,1,157,'2014-08-01 13:39:34',0,'1'),(1,160,160,'2014-08-01 13:41:19',1,0,0,NULL,1,'0'),(1,160,NULL,NULL,1,1,160,'2014-08-01 13:41:19',0,'1'),(1,161,161,'2014-08-01 13:41:29',1,0,0,NULL,1,'0'),(1,161,NULL,NULL,1,1,161,'2014-08-01 13:41:29',0,'1'),(1,164,164,'2014-08-05 10:44:38',1,0,0,NULL,1,'0'),(1,164,NULL,NULL,1,1,164,'2014-08-05 10:44:38',0,'1'),(1,191,191,'2014-08-20 13:40:01',1,0,0,NULL,1,'0'),(1,191,NULL,NULL,1,1,191,'2014-08-20 13:40:01',0,'1'),(1,203,203,'2014-08-20 20:22:02',0,0,0,NULL,1,'0'),(1,203,NULL,NULL,1,1,203,'2014-08-20 20:22:02',0,'1'),(1,209,209,'2014-08-20 21:36:41',0,0,0,NULL,1,'0'),(1,209,NULL,NULL,1,1,209,'2014-08-20 21:36:41',0,'1'),(1,214,214,'2014-08-20 21:39:36',0,0,0,NULL,1,'0'),(1,214,NULL,NULL,1,1,214,'2014-08-20 21:39:36',0,'1'),(1,216,216,'2014-08-20 22:03:25',0,0,0,NULL,1,'0'),(1,216,NULL,NULL,1,1,216,'2014-08-20 22:03:25',0,'1'),(1,223,223,'2014-08-26 13:51:46',1,0,0,NULL,1,'0'),(1,223,NULL,NULL,1,1,223,'2014-08-26 13:51:46',0,'1'),(1,224,224,'2014-08-26 13:52:30',1,0,0,NULL,1,'0'),(1,224,NULL,NULL,1,1,224,'2014-08-26 13:52:30',0,'1'),(1,225,225,'2014-08-26 14:16:41',0,0,0,NULL,1,'0'),(1,225,NULL,NULL,1,1,225,'2014-08-26 14:16:41',0,'1'),(1,229,229,'2014-08-27 08:57:31',0,0,0,NULL,1,'0'),(1,229,NULL,NULL,1,1,229,'2014-08-27 08:57:31',0,'1'),(1,230,230,'2014-08-27 08:59:00',0,0,0,NULL,1,'0'),(1,230,NULL,NULL,1,1,230,'2014-08-27 08:59:00',0,'1'),(1,231,231,'2014-08-27 08:59:18',0,0,0,NULL,1,'0'),(1,231,NULL,NULL,1,1,231,'2014-08-27 08:59:18',0,'1'),(1,233,233,'2014-08-27 09:00:25',0,0,0,NULL,1,'0'),(1,233,NULL,NULL,1,1,233,'2014-08-27 09:00:25',0,'1'),(1,234,234,'2014-09-02 09:41:21',0,0,0,NULL,1,'0'),(1,234,NULL,NULL,1,1,234,'2014-09-02 09:41:21',0,'1'),(1,238,238,'2014-09-02 22:22:06',1,0,0,NULL,1,'0'),(1,238,NULL,NULL,1,1,238,'2014-09-02 22:22:06',0,'1'),(1,240,240,'2014-09-03 07:29:40',1,0,0,NULL,1,'0'),(1,240,NULL,NULL,1,1,240,'2014-09-03 07:29:40',0,'1'),(1,241,241,'2014-09-03 07:42:46',1,0,0,NULL,1,'0'),(1,241,NULL,NULL,1,1,241,'2014-09-03 07:42:46',0,'1'),(1,242,242,'2014-09-03 07:45:04',1,0,0,NULL,1,'0'),(1,242,NULL,NULL,1,1,242,'2014-09-03 07:45:04',0,'1'),(1,245,245,'2014-09-03 07:51:52',1,0,0,NULL,1,'0'),(1,245,NULL,NULL,1,1,245,'2014-09-03 07:51:52',0,'1'),(1,246,246,'2014-09-03 07:54:44',1,0,0,NULL,1,'0'),(1,246,NULL,NULL,1,1,246,'2014-09-03 07:54:44',0,'1'),(1,247,247,'2014-09-03 07:54:44',1,0,0,NULL,1,'0'),(1,247,NULL,NULL,1,1,247,'2014-09-03 07:54:44',0,'1'),(1,248,248,'2014-09-03 08:13:42',1,0,0,NULL,1,'0'),(1,248,NULL,NULL,1,1,248,'2014-09-03 08:13:42',0,'1'),(1,249,249,'2014-09-03 08:15:41',1,0,0,NULL,1,'0'),(1,249,NULL,NULL,1,1,249,'2014-09-03 08:15:41',0,'1'),(1,251,251,'2014-09-03 08:18:53',1,0,0,NULL,1,'0'),(1,251,NULL,NULL,1,1,251,'2014-09-03 08:18:53',0,'1'),(1,254,254,'2014-09-03 08:24:58',1,0,0,NULL,1,'0'),(1,254,NULL,NULL,1,1,254,'2014-09-03 08:24:58',0,'1'),(1,255,255,'2014-09-03 08:26:13',0,0,0,NULL,1,'0'),(1,255,NULL,NULL,1,1,255,'2014-09-03 08:26:13',0,'1'),(1,256,256,'2014-09-03 08:26:57',0,0,0,NULL,1,'0'),(1,256,NULL,NULL,1,1,256,'2014-09-03 08:26:57',0,'1'),(1,257,257,'2014-09-03 08:30:40',1,0,0,NULL,1,'0'),(1,257,NULL,NULL,1,1,257,'2014-09-03 08:30:40',0,'1'),(1,258,258,'2014-09-03 08:44:33',1,0,0,NULL,1,'0'),(1,258,NULL,NULL,1,1,258,'2014-09-03 08:44:33',0,'1'),(1,259,259,'2014-09-03 10:19:22',0,0,0,NULL,1,'0'),(1,259,NULL,NULL,1,1,259,'2014-09-03 10:19:22',0,'1'),(1,262,262,'2014-09-03 10:23:12',1,0,0,NULL,1,'0'),(1,262,NULL,NULL,1,1,262,'2014-09-03 10:23:12',0,'1'),(1,263,263,'2014-09-03 10:23:36',1,0,0,NULL,1,'0'),(1,263,NULL,NULL,1,1,263,'2014-09-03 10:23:36',0,'1'),(1,265,265,'2014-09-03 12:07:10',0,0,0,NULL,1,'0'),(1,265,NULL,NULL,1,1,265,'2014-09-03 12:07:10',0,'1'),(1,266,266,'2014-09-03 12:07:19',0,0,0,NULL,1,'0'),(1,266,NULL,NULL,1,1,266,'2014-09-03 12:07:19',0,'1'),(1,267,267,'2014-09-03 12:08:24',0,0,0,NULL,1,'0'),(1,267,NULL,NULL,1,1,267,'2014-09-03 12:08:24',0,'1'),(1,268,268,'2014-09-03 12:08:36',0,0,0,NULL,1,'0'),(1,268,NULL,NULL,1,1,268,'2014-09-03 12:08:36',0,'1'),(1,271,271,'2014-09-03 12:09:52',0,0,0,NULL,1,'0'),(1,271,NULL,NULL,1,1,271,'2014-09-03 12:09:52',0,'1'),(1,272,272,'2014-09-03 12:10:08',0,0,0,NULL,1,'0'),(1,272,NULL,NULL,1,1,272,'2014-09-03 12:10:08',0,'1'),(1,273,273,'2014-09-03 12:10:18',0,0,0,NULL,1,'0'),(1,273,NULL,NULL,1,1,273,'2014-09-03 12:10:18',0,'1'),(1,274,274,'2014-09-03 12:10:35',0,0,0,NULL,1,'0'),(1,274,NULL,NULL,1,1,274,'2014-09-03 12:10:35',0,'1'),(1,276,276,'2014-09-03 12:11:52',0,0,0,NULL,1,'0'),(1,276,NULL,NULL,1,1,276,'2014-09-03 12:11:52',0,'1'),(1,277,277,'2014-09-03 12:12:18',1,0,0,NULL,1,'0'),(1,277,NULL,NULL,1,1,277,'2014-09-03 12:12:18',0,'1'),(1,278,278,'2014-09-03 12:14:56',1,0,0,NULL,1,'0'),(1,278,NULL,NULL,1,1,278,'2014-09-03 12:14:56',0,'1'),(1,279,279,'2014-09-03 12:50:04',0,0,0,NULL,1,'0'),(1,279,NULL,NULL,1,1,279,'2014-09-03 12:50:04',0,'1'),(1,280,280,'2014-09-03 12:55:50',1,0,0,NULL,1,'0'),(1,280,NULL,NULL,1,1,280,'2014-09-03 12:55:50',0,'1'),(1,282,282,'2014-09-03 13:42:11',0,0,0,NULL,1,'0'),(1,282,NULL,NULL,1,1,282,'2014-09-03 13:42:11',0,'1'),(1,284,284,'2014-09-13 22:10:40',0,0,0,NULL,1,'0'),(1,284,NULL,NULL,1,1,284,'2014-09-13 22:10:40',0,'1'),(1,285,285,'2014-09-13 22:10:40',0,0,0,NULL,1,'0'),(1,285,NULL,NULL,1,1,285,'2014-09-13 22:10:40',0,'1'),(1,293,293,'2014-09-13 23:39:24',0,0,0,NULL,1,'0'),(1,293,NULL,NULL,1,1,293,'2014-09-13 23:39:24',0,'1'),(1,310,310,'2014-09-14 00:39:44',0,0,0,NULL,1,'0'),(1,310,NULL,NULL,1,1,310,'2014-09-14 00:39:44',0,'1'),(1,319,319,'2014-09-14 23:43:54',0,0,0,NULL,1,'0'),(1,319,NULL,NULL,1,1,319,'2014-09-14 23:43:54',0,'1'),(1,321,321,'2014-09-15 00:02:47',0,0,0,NULL,1,'0'),(1,321,NULL,NULL,1,1,321,'2014-09-15 00:02:47',0,'1'),(1,337,337,'2014-10-01 13:27:32',0,0,0,NULL,1,'0'),(1,337,NULL,NULL,1,1,337,'2014-10-01 13:27:32',0,'1'),(1,339,339,'2014-10-02 12:43:32',0,0,0,NULL,1,'0'),(1,339,NULL,NULL,1,1,339,'2014-10-02 12:43:32',0,'1'),(1,340,340,'2014-10-02 12:43:50',0,0,0,NULL,1,'0'),(1,340,NULL,NULL,1,1,340,'2014-10-02 12:43:50',0,'1'),(1,343,343,'2014-10-02 12:45:02',1,0,0,NULL,1,'0'),(1,343,NULL,NULL,1,1,343,'2014-10-02 12:45:02',0,'1'),(1,344,344,'2014-10-02 12:47:14',0,0,0,NULL,1,'0'),(1,344,NULL,NULL,1,1,344,'2014-10-02 12:47:14',0,'1'),(1,347,347,'2014-10-02 12:48:23',0,0,0,NULL,1,'0'),(1,347,NULL,NULL,1,1,347,'2014-10-02 12:48:23',0,'1'),(1,348,348,'2014-10-02 12:48:23',0,0,0,NULL,1,'0'),(1,348,NULL,NULL,1,1,348,'2014-10-02 12:48:23',0,'1'),(1,349,349,'2014-10-03 11:12:49',1,0,0,NULL,1,'0'),(1,349,NULL,NULL,1,1,349,'2014-10-03 11:12:49',0,'1'),(1,350,350,'2014-10-03 11:18:54',1,0,0,NULL,1,'0'),(1,350,NULL,NULL,1,1,350,'2014-10-03 11:18:54',0,'1'),(1,353,353,'2014-10-03 11:20:47',1,0,0,NULL,1,'0'),(1,353,NULL,NULL,1,1,353,'2014-10-03 11:20:47',0,'1'),(1,354,354,'2014-10-03 11:20:47',1,0,0,NULL,1,'0'),(1,354,NULL,NULL,1,1,354,'2014-10-03 11:20:47',0,'1'),(1,357,357,'2014-10-03 12:04:52',1,0,0,NULL,1,'0'),(1,357,NULL,NULL,1,1,357,'2014-10-03 12:04:51',0,'1'),(1,358,358,'2014-10-03 12:50:50',0,0,0,NULL,1,'0'),(1,358,NULL,NULL,1,1,358,'2014-10-03 12:50:50',0,'1'),(1,361,361,'2014-10-03 13:09:28',0,0,0,NULL,1,'0'),(1,361,NULL,NULL,1,1,361,'2014-10-03 13:09:28',0,'1'),(1,362,362,'2014-10-03 13:09:28',0,0,0,NULL,1,'0'),(1,362,NULL,NULL,1,1,362,'2014-10-03 13:09:28',0,'1'),(1,363,363,'2014-10-08 13:55:46',0,0,0,NULL,1,'0'),(1,363,NULL,NULL,1,1,363,'2014-10-08 13:55:46',0,'1'),(1,366,366,'2014-10-09 14:24:20',0,0,0,NULL,1,'0'),(1,366,NULL,NULL,1,1,366,'2014-10-09 14:24:20',0,'1'),(1,369,369,'2014-10-09 14:26:30',0,0,0,NULL,1,'0'),(1,369,NULL,NULL,1,1,369,'2014-10-09 14:26:30',0,'1'),(1,370,370,'2014-10-09 14:26:30',0,0,0,NULL,1,'0'),(1,370,NULL,NULL,1,1,370,'2014-10-09 14:26:30',0,'1'),(1,371,371,'2014-10-29 12:52:29',0,0,0,NULL,1,'0'),(1,371,NULL,NULL,1,1,371,'2014-10-29 12:52:29',0,'1'),(1,372,372,'2014-10-29 12:52:30',0,0,0,NULL,1,'0'),(1,372,NULL,NULL,1,1,372,'2014-10-29 12:52:30',0,'1'),(2,8,8,'2014-07-10 09:59:29',1,1,0,NULL,1,'0'),(2,8,NULL,NULL,1,1,8,'2014-07-10 09:59:29',1,'1'),(2,9,9,'2014-07-10 10:00:22',1,1,0,NULL,1,'0'),(2,9,NULL,NULL,1,1,9,'2014-07-10 10:00:22',1,'1'),(2,21,21,'2014-07-10 15:38:32',1,1,0,NULL,1,'0'),(2,21,NULL,NULL,1,1,21,'2014-07-10 15:38:32',1,'1'),(2,22,22,'2014-07-10 16:04:16',1,1,0,NULL,1,'0'),(2,22,NULL,NULL,1,1,22,'2014-07-10 16:04:16',1,'1'),(2,27,27,'2014-07-10 16:13:48',1,1,0,NULL,1,'0'),(2,27,NULL,NULL,1,1,27,'2014-07-10 16:13:48',1,'1'),(2,33,33,'2014-07-10 16:26:01',0,1,0,NULL,1,'0'),(2,33,NULL,NULL,1,1,33,'2014-07-10 16:26:01',1,'1'),(2,35,35,'2014-07-10 16:56:26',0,1,0,NULL,1,'0'),(2,35,NULL,NULL,1,1,35,'2014-07-10 16:56:26',1,'1'),(2,40,40,'2014-07-11 08:36:02',0,1,0,NULL,1,'0'),(2,40,NULL,NULL,1,1,40,'2014-07-11 08:36:02',1,'1'),(2,41,41,'2014-07-11 08:36:09',1,1,0,NULL,1,'0'),(2,41,NULL,NULL,1,1,41,'2014-07-11 08:36:09',1,'1'),(2,43,43,'2014-07-11 08:42:00',1,1,0,NULL,1,'0'),(2,43,NULL,NULL,1,1,43,'2014-07-11 08:42:00',1,'1'),(2,49,49,'2014-07-12 06:10:27',0,1,0,NULL,1,'0'),(2,49,NULL,NULL,1,1,49,'2014-07-12 06:10:27',1,'1'),(2,75,75,'2014-07-13 20:56:52',0,1,0,NULL,1,'0'),(2,75,NULL,NULL,1,1,75,'2014-07-13 20:56:52',1,'1'),(2,77,77,'2014-07-14 12:53:02',1,1,0,NULL,1,'0'),(2,77,NULL,NULL,1,1,77,'2014-07-14 12:53:02',1,'1'),(2,78,78,'2014-07-14 12:54:56',0,1,0,NULL,1,'0'),(2,78,NULL,NULL,1,1,78,'2014-07-14 12:54:56',1,'1'),(2,82,82,'2014-07-14 13:13:54',1,1,0,NULL,1,'0'),(2,82,NULL,NULL,1,1,82,'2014-07-14 13:13:54',1,'1'),(2,83,83,'2014-07-14 13:14:27',1,1,0,NULL,1,'0'),(2,83,NULL,NULL,1,1,83,'2014-07-14 13:14:27',1,'1'),(2,90,90,'2014-07-14 13:59:39',0,0,0,NULL,1,'0'),(2,90,NULL,NULL,1,1,90,'2014-07-14 13:59:39',0,'1'),(2,91,91,'2014-07-14 14:01:02',0,0,0,NULL,1,'0'),(2,91,NULL,NULL,1,1,91,'2014-07-14 14:01:02',0,'1'),(2,95,95,'2014-07-14 14:07:16',0,0,0,NULL,1,'0'),(2,95,NULL,NULL,1,1,95,'2014-07-14 14:07:16',0,'1'),(2,109,109,'2014-07-16 16:42:45',0,0,0,NULL,1,'0'),(2,109,NULL,NULL,1,1,109,'2014-07-16 16:42:45',0,'1'),(2,110,110,'2014-07-16 16:48:20',0,0,0,NULL,1,'0'),(2,110,NULL,NULL,1,1,110,'2014-07-16 16:48:20',0,'1'),(2,114,114,'2014-08-01 10:08:01',0,0,0,NULL,1,'0'),(2,114,NULL,NULL,1,1,114,'2014-08-01 10:08:01',0,'1'),(2,115,115,'2014-08-01 10:11:58',0,0,0,NULL,1,'0'),(2,115,NULL,NULL,1,1,115,'2014-08-01 10:11:58',0,'1'),(2,126,126,'2014-08-01 10:36:45',0,0,0,NULL,1,'0'),(2,126,NULL,NULL,1,1,126,'2014-08-01 10:36:45',0,'1'),(2,145,145,'2014-08-01 12:43:07',0,0,0,NULL,1,'0'),(2,145,NULL,NULL,1,1,145,'2014-08-01 12:43:07',0,'1'),(2,147,147,'2014-08-01 12:44:48',0,0,0,NULL,1,'0'),(2,147,NULL,NULL,1,1,147,'2014-08-01 12:44:48',0,'1'),(2,148,148,'2014-08-01 12:46:32',0,0,0,NULL,1,'0'),(2,148,NULL,NULL,1,1,148,'2014-08-01 12:46:32',0,'1'),(2,150,150,'2014-08-01 12:47:31',0,0,0,NULL,1,'0'),(2,150,NULL,NULL,1,1,150,'2014-08-01 12:47:31',0,'1'),(2,151,151,'2014-08-01 12:53:55',0,0,0,NULL,1,'0'),(2,151,NULL,NULL,1,1,151,'2014-08-01 12:53:55',0,'1'),(2,275,275,'2014-09-03 12:10:47',0,0,0,NULL,1,'0'),(2,275,NULL,NULL,1,1,275,'2014-09-03 12:10:47',0,'1'),(2,283,283,'2014-09-13 22:10:40',0,0,0,NULL,1,'0'),(2,283,NULL,NULL,1,1,283,'2014-09-13 22:10:40',0,'1'),(2,341,341,'2014-10-02 12:44:17',0,0,0,NULL,1,'0'),(2,341,NULL,NULL,1,1,341,'2014-10-02 12:44:17',0,'1'),(2,355,355,'2014-10-03 11:48:02',1,0,0,NULL,1,'0'),(2,355,NULL,NULL,1,1,355,'2014-10-03 11:48:02',0,'1'),(2,364,364,'2014-10-08 13:56:01',0,0,0,NULL,1,'0'),(2,364,NULL,NULL,1,1,364,'2014-10-08 13:56:01',0,'1'),(2,365,365,'2014-10-08 13:56:38',0,0,0,NULL,1,'0'),(2,365,NULL,NULL,1,1,365,'2014-10-08 13:56:38',0,'1'),(2,367,367,'2014-10-09 14:24:53',0,0,0,NULL,1,'0'),(2,367,NULL,NULL,1,1,367,'2014-10-09 14:24:53',0,'1'),(2,368,368,'2014-10-09 14:25:44',0,0,0,NULL,1,'0'),(2,368,NULL,NULL,1,1,368,'2014-10-09 14:25:44',0,'1'),(3,5,5,'2014-07-10 09:09:48',1,1,0,NULL,1,'0'),(3,5,NULL,NULL,1,1,5,'2014-07-10 09:09:48',1,'1'),(3,6,6,'2014-07-10 09:14:13',0,1,0,NULL,1,'0'),(3,6,NULL,NULL,1,1,6,'2014-07-10 09:14:13',1,'1'),(3,7,7,'2014-07-10 09:40:45',1,1,0,NULL,1,'0'),(3,7,NULL,NULL,1,1,7,'2014-07-10 09:40:44',1,'1'),(3,10,10,'2014-07-10 10:03:41',1,1,0,NULL,1,'0'),(3,10,NULL,NULL,1,1,10,'2014-07-10 10:03:41',1,'1'),(3,11,11,'2014-07-10 12:10:13',0,1,0,NULL,1,'0'),(3,11,NULL,NULL,1,1,11,'2014-07-10 12:10:13',1,'1'),(3,13,13,'2014-07-10 12:13:24',1,1,0,NULL,1,'0'),(3,13,NULL,NULL,1,1,13,'2014-07-10 12:13:24',1,'1'),(3,15,15,'2014-07-10 12:30:56',1,1,0,NULL,1,'0'),(3,15,NULL,NULL,1,1,15,'2014-07-10 12:30:56',1,'1'),(3,17,17,'2014-07-10 12:58:40',1,1,0,NULL,1,'0'),(3,17,NULL,NULL,1,1,17,'2014-07-10 12:58:40',1,'1'),(3,39,39,'2014-07-11 08:26:22',1,1,0,NULL,1,'0'),(3,39,NULL,NULL,1,1,39,'2014-07-11 08:26:22',1,'1'),(3,42,42,'2014-07-11 08:36:09',1,1,0,NULL,1,'0'),(3,42,NULL,NULL,1,1,42,'2014-07-11 08:36:09',1,'1'),(3,44,44,'2014-07-11 08:42:00',1,1,0,NULL,1,'0'),(3,44,NULL,NULL,1,1,44,'2014-07-11 08:42:00',1,'1'),(3,45,45,'2014-07-11 08:55:17',1,1,0,NULL,1,'0'),(3,45,NULL,NULL,1,1,45,'2014-07-11 08:55:17',1,'1'),(3,47,47,'2014-07-11 13:12:07',1,1,0,NULL,1,'0'),(3,47,NULL,NULL,1,1,47,'2014-07-11 13:12:07',1,'1'),(3,50,50,'2014-07-13 09:01:18',1,1,0,NULL,1,'0'),(3,50,NULL,NULL,1,1,50,'2014-07-13 09:01:18',1,'1'),(3,52,52,'2014-07-13 09:03:53',1,1,0,NULL,1,'0'),(3,52,NULL,NULL,1,1,52,'2014-07-13 09:03:53',1,'1'),(3,53,53,'2014-07-13 12:01:09',0,1,0,NULL,1,'0'),(3,53,NULL,NULL,1,1,53,'2014-07-13 12:01:09',1,'1'),(3,57,57,'2014-07-13 12:05:28',1,1,0,NULL,1,'0'),(3,57,NULL,NULL,1,1,57,'2014-07-13 12:05:28',1,'1'),(3,58,58,'2014-07-13 12:10:14',0,1,0,NULL,1,'0'),(3,58,NULL,NULL,1,1,58,'2014-07-13 12:10:14',1,'1'),(3,70,70,'2014-07-13 18:04:20',0,1,0,NULL,1,'0'),(3,70,NULL,NULL,1,1,70,'2014-07-13 18:04:20',1,'1'),(3,93,93,'2014-07-14 14:02:14',0,0,0,NULL,1,'0'),(3,93,NULL,NULL,1,1,93,'2014-07-14 14:02:14',0,'1'),(3,94,94,'2014-07-14 14:03:08',0,0,0,NULL,1,'0'),(3,94,NULL,NULL,1,1,94,'2014-07-14 14:03:08',0,'1'),(3,96,96,'2014-07-14 14:07:28',0,0,0,NULL,1,'0'),(3,96,NULL,NULL,1,1,96,'2014-07-14 14:07:28',0,'1'),(3,97,97,'2014-07-14 14:07:58',0,0,0,NULL,1,'0'),(3,97,NULL,NULL,1,1,97,'2014-07-14 14:07:58',0,'1'),(3,112,112,'2014-07-23 15:42:45',0,0,0,NULL,1,'0'),(3,112,NULL,NULL,1,1,112,'2014-07-23 15:42:45',0,'1'),(3,117,117,'2014-08-01 10:15:57',0,0,0,NULL,1,'0'),(3,117,NULL,NULL,1,1,117,'2014-08-01 10:15:57',0,'1'),(3,118,118,'2014-08-01 10:16:22',0,0,0,NULL,1,'0'),(3,118,NULL,NULL,1,1,118,'2014-08-01 10:16:22',0,'1'),(3,137,137,'2014-08-01 10:36:48',0,0,0,NULL,1,'0'),(3,137,NULL,NULL,1,1,137,'2014-08-01 10:36:48',0,'1'),(3,140,140,'2014-08-01 10:36:49',0,0,0,NULL,1,'0'),(3,140,NULL,NULL,1,1,140,'2014-08-01 10:36:49',0,'1'),(3,146,146,'2014-08-01 12:43:24',0,0,0,NULL,1,'0'),(3,146,NULL,NULL,1,1,146,'2014-08-01 12:43:24',0,'1'),(3,152,152,'2014-08-01 12:56:53',0,0,0,NULL,1,'0'),(3,152,NULL,NULL,1,1,152,'2014-08-01 12:56:53',0,'1'),(3,226,226,'2014-08-26 14:16:57',0,0,0,NULL,1,'0'),(3,226,NULL,NULL,1,1,226,'2014-08-26 14:16:57',0,'1'),(3,227,227,'2014-08-26 14:17:46',1,0,0,NULL,1,'0'),(3,227,NULL,NULL,1,1,227,'2014-08-26 14:17:46',0,'1'),(3,252,252,'2014-09-03 08:19:15',0,0,0,NULL,1,'0'),(3,252,NULL,NULL,1,1,252,'2014-09-03 08:19:15',0,'1'),(3,261,261,'2014-09-03 10:20:31',0,0,0,NULL,1,'0'),(3,261,NULL,NULL,1,1,261,'2014-09-03 10:20:31',0,'1'),(3,269,269,'2014-09-03 12:08:54',0,0,0,NULL,1,'0'),(3,269,NULL,NULL,1,1,269,'2014-09-03 12:08:54',0,'1'),(3,342,342,'2014-10-02 12:44:24',0,0,0,NULL,1,'0'),(3,342,NULL,NULL,1,1,342,'2014-10-02 12:44:24',0,'1'),(3,345,345,'2014-10-02 12:47:29',0,0,0,NULL,1,'0'),(3,345,NULL,NULL,1,1,345,'2014-10-02 12:47:29',0,'1'),(3,346,346,'2014-10-02 12:47:59',0,0,0,NULL,1,'0'),(3,346,NULL,NULL,1,1,346,'2014-10-02 12:47:59',0,'1'),(4,101,101,'2014-07-15 12:05:44',0,0,0,NULL,1,'0'),(4,101,NULL,NULL,1,1,101,'2014-07-15 12:05:44',0,'1'),(4,102,102,'2014-07-15 12:09:07',0,0,0,NULL,1,'0'),(4,102,NULL,NULL,1,1,102,'2014-07-15 12:09:07',0,'1'),(4,120,120,'2014-08-01 10:16:54',0,0,0,NULL,1,'0'),(4,120,NULL,NULL,1,1,120,'2014-08-01 10:16:54',0,'1'),(4,162,162,'2014-08-04 20:21:36',0,0,0,NULL,1,'0'),(4,162,NULL,NULL,1,1,162,'2014-08-04 20:21:36',0,'1'),(4,163,163,'2014-08-05 10:44:38',1,0,0,NULL,1,'0'),(4,163,NULL,NULL,1,1,163,'2014-08-05 10:44:38',0,'1'),(4,253,253,'2014-09-03 08:19:25',1,0,0,NULL,1,'0'),(4,253,NULL,NULL,1,1,253,'2014-09-03 08:19:25',0,'1'),(4,351,351,'2014-10-03 11:19:14',0,0,0,NULL,1,'0'),(4,351,NULL,NULL,1,1,351,'2014-10-03 11:19:14',0,'1'),(4,352,352,'2014-10-03 11:20:00',0,0,0,NULL,1,'0'),(4,352,NULL,NULL,1,1,352,'2014-10-03 11:20:00',0,'1'),(4,356,356,'2014-10-03 11:48:02',1,0,0,NULL,1,'0'),(4,356,NULL,NULL,1,1,356,'2014-10-03 11:48:02',0,'1'),(4,359,359,'2014-10-03 12:51:05',0,0,0,NULL,1,'0'),(4,359,NULL,NULL,1,1,359,'2014-10-03 12:51:05',0,'1'),(4,360,360,'2014-10-03 12:51:53',0,0,0,NULL,1,'0'),(4,360,NULL,NULL,1,1,360,'2014-10-03 12:51:53',0,'1'),(5,104,104,'2014-07-15 12:11:01',0,0,0,NULL,1,'0'),(5,104,NULL,NULL,1,1,104,'2014-07-15 12:11:01',0,'1'),(5,124,124,'2014-08-01 10:19:07',0,0,0,NULL,1,'0'),(5,124,NULL,NULL,1,1,124,'2014-08-01 10:19:07',0,'1'),(5,136,136,'2014-08-01 10:36:48',0,0,0,NULL,1,'0'),(5,136,NULL,NULL,1,1,136,'2014-08-01 10:36:48',0,'1'),(5,138,138,'2014-08-01 10:36:49',0,0,0,NULL,1,'0'),(5,138,NULL,NULL,1,1,138,'2014-08-01 10:36:49',0,'1'),(5,158,158,'2014-08-01 13:39:48',1,0,0,NULL,1,'0'),(5,158,NULL,NULL,1,1,158,'2014-08-01 13:39:48',0,'1'),(5,159,159,'2014-08-01 13:40:16',1,0,0,NULL,1,'0'),(5,159,NULL,NULL,1,1,159,'2014-08-01 13:40:16',0,'1'),(5,250,250,'2014-09-03 08:16:27',0,0,0,NULL,1,'0'),(5,250,NULL,NULL,1,1,250,'2014-09-03 08:16:27',0,'1'),(5,260,260,'2014-09-03 10:19:48',0,0,0,NULL,1,'0'),(5,260,NULL,NULL,1,1,260,'2014-09-03 10:19:48',0,'1'),(5,264,264,'2014-09-03 10:23:49',0,0,0,NULL,1,'0'),(5,264,NULL,NULL,1,1,264,'2014-09-03 10:23:49',0,'1'),(5,270,270,'2014-09-03 12:09:02',0,0,0,NULL,1,'0'),(5,270,NULL,NULL,1,1,270,'2014-09-03 12:09:02',0,'1'),(6,228,228,'2014-08-27 08:52:46',1,0,0,NULL,1,'0'),(6,228,NULL,NULL,1,1,228,'2014-08-27 08:52:46',0,'1'),(6,232,232,'2014-08-27 08:59:43',1,0,0,NULL,1,'0'),(6,232,NULL,NULL,1,1,232,'2014-08-27 08:59:43',0,'1'),(6,239,239,'2014-09-02 22:22:33',1,0,0,NULL,1,'0'),(6,239,NULL,NULL,1,1,239,'2014-09-02 22:22:33',0,'1'),(6,243,243,'2014-09-03 07:45:33',1,0,0,NULL,1,'0'),(6,243,NULL,NULL,1,1,243,'2014-09-03 07:45:33',0,'1'),(6,244,244,'2014-09-03 07:46:49',1,0,0,NULL,1,'0'),(6,244,NULL,NULL,1,1,244,'2014-09-03 07:46:49',0,'1'),(7,165,165,'2014-08-17 11:29:49',1,0,0,NULL,1,'0'),(7,165,NULL,NULL,1,1,165,'2014-08-17 11:29:49',0,'1'),(7,166,166,'2014-08-17 11:30:31',1,0,0,NULL,1,'0'),(7,166,NULL,NULL,1,1,166,'2014-08-17 11:30:31',0,'1'),(7,167,167,'2014-08-17 11:30:38',1,0,0,NULL,1,'0'),(7,167,NULL,NULL,1,1,167,'2014-08-17 11:30:38',0,'1'),(7,169,169,'2014-08-20 08:42:08',1,0,0,NULL,1,'0'),(7,169,NULL,NULL,1,1,169,'2014-08-20 08:42:08',0,'1'),(7,170,170,'2014-08-20 08:42:43',1,0,0,NULL,1,'0'),(7,170,NULL,NULL,1,1,170,'2014-08-20 08:42:43',0,'1'),(7,171,171,'2014-08-20 08:42:57',1,0,0,NULL,1,'0'),(7,171,NULL,NULL,1,1,171,'2014-08-20 08:42:57',0,'1'),(7,172,172,'2014-08-20 08:46:37',1,0,0,NULL,1,'0'),(7,172,NULL,NULL,1,1,172,'2014-08-20 08:46:37',0,'1'),(7,179,179,'2014-08-20 09:10:42',1,0,0,NULL,1,'0'),(7,179,NULL,NULL,1,1,179,'2014-08-20 09:10:42',0,'1'),(7,183,183,'2014-08-20 09:30:18',1,0,0,NULL,1,'0'),(7,183,NULL,NULL,1,1,183,'2014-08-20 09:30:18',0,'1'),(7,187,187,'2014-08-20 12:48:03',1,0,0,NULL,1,'0'),(7,187,NULL,NULL,1,1,187,'2014-08-20 12:48:03',0,'1'),(7,194,194,'2014-08-20 20:18:06',1,0,0,NULL,1,'0'),(7,194,NULL,NULL,1,1,194,'2014-08-20 20:18:06',0,'1'),(7,197,197,'2014-08-20 20:20:01',1,0,0,NULL,1,'0'),(7,197,NULL,NULL,1,1,197,'2014-08-20 20:20:01',0,'1'),(7,199,199,'2014-08-20 20:20:48',1,0,0,NULL,1,'0'),(7,199,NULL,NULL,1,1,199,'2014-08-20 20:20:48',0,'1'),(7,204,204,'2014-08-20 21:35:22',1,0,0,NULL,1,'0'),(7,204,NULL,NULL,1,1,204,'2014-08-20 21:35:22',0,'1'),(7,205,205,'2014-08-20 21:35:22',1,0,0,NULL,1,'0'),(7,205,NULL,NULL,1,1,205,'2014-08-20 21:35:22',0,'1'),(7,220,220,'2014-08-24 12:57:37',1,0,0,NULL,1,'0'),(7,220,NULL,NULL,1,1,220,'2014-08-24 12:57:37',0,'1'),(7,222,222,'2014-08-24 12:57:38',1,0,0,NULL,1,'0'),(7,222,NULL,NULL,1,1,222,'2014-08-24 12:57:38',0,'1'),(7,235,235,'2014-09-02 09:41:22',1,0,0,NULL,1,'0'),(7,235,NULL,NULL,1,1,235,'2014-09-02 09:41:22',0,'1'),(7,325,325,'2014-09-17 21:42:31',1,0,0,NULL,1,'0'),(7,325,NULL,NULL,1,1,325,'2014-09-17 21:42:31',0,'1'),(7,328,328,'2014-09-17 22:03:55',1,0,0,NULL,1,'0'),(7,328,NULL,NULL,1,1,328,'2014-09-17 22:03:55',0,'1'),(7,329,329,'2014-09-17 22:29:35',1,0,0,NULL,1,'0'),(7,329,NULL,NULL,1,1,329,'2014-09-17 22:29:35',0,'1'),(7,334,334,'2014-09-18 22:35:40',1,0,0,NULL,1,'0'),(7,334,NULL,NULL,1,1,334,'2014-09-18 22:35:40',0,'1'),(8,168,168,'2014-08-18 13:20:18',1,0,0,NULL,1,'0'),(8,168,NULL,NULL,1,1,168,'2014-08-18 13:20:18',0,'1'),(8,175,175,'2014-08-20 09:01:37',1,0,0,NULL,1,'0'),(8,175,NULL,NULL,1,1,175,'2014-08-20 09:01:37',0,'1'),(8,180,180,'2014-08-20 09:10:57',1,0,0,NULL,1,'0'),(8,180,NULL,NULL,1,1,180,'2014-08-20 09:10:57',0,'1'),(8,181,181,'2014-08-20 09:23:58',1,0,0,NULL,1,'0'),(8,181,NULL,NULL,1,1,181,'2014-08-20 09:23:58',0,'1'),(8,182,182,'2014-08-20 09:27:03',1,0,0,NULL,1,'0'),(8,182,NULL,NULL,1,1,182,'2014-08-20 09:27:03',0,'1'),(8,184,184,'2014-08-20 09:32:30',1,0,0,NULL,1,'0'),(8,184,NULL,NULL,1,1,184,'2014-08-20 09:32:30',0,'1'),(8,185,185,'2014-08-20 12:46:38',1,0,0,NULL,1,'0'),(8,185,NULL,NULL,1,1,185,'2014-08-20 12:46:38',0,'1'),(8,188,NULL,NULL,1,1,188,'2014-08-20 13:15:24',0,'0'),(8,190,190,'2014-08-20 13:40:01',0,0,0,NULL,1,'0'),(8,190,NULL,NULL,1,1,190,'2014-08-20 13:40:01',0,'1'),(8,192,192,'2014-08-20 13:47:58',0,0,0,NULL,1,'0'),(8,192,NULL,NULL,1,1,192,'2014-08-20 13:47:58',0,'1'),(8,206,206,'2014-08-20 21:35:23',0,0,0,NULL,1,'0'),(8,206,NULL,NULL,1,1,206,'2014-08-20 21:35:23',0,'1'),(8,207,207,'2014-08-20 21:35:23',0,0,0,NULL,1,'0'),(8,207,NULL,NULL,1,1,207,'2014-08-20 21:35:23',0,'1'),(8,211,211,'2014-08-20 21:38:12',0,0,0,NULL,1,'0'),(8,211,NULL,NULL,1,1,211,'2014-08-20 21:38:12',0,'1'),(8,212,212,'2014-08-20 21:39:06',0,0,0,NULL,1,'0'),(8,212,NULL,NULL,1,1,212,'2014-08-20 21:39:06',0,'1'),(8,213,213,'2014-08-20 21:39:08',0,0,0,NULL,1,'0'),(8,213,NULL,NULL,1,1,213,'2014-08-20 21:39:08',0,'1'),(8,217,217,'2014-08-24 12:57:36',0,0,0,NULL,1,'0'),(8,217,NULL,NULL,1,1,217,'2014-08-24 12:57:36',0,'1'),(8,219,219,'2014-08-24 12:57:37',0,0,0,NULL,1,'0'),(8,219,NULL,NULL,1,1,219,'2014-08-24 12:57:37',0,'1'),(8,236,236,'2014-09-02 21:55:37',1,0,0,NULL,1,'0'),(8,236,NULL,NULL,1,1,236,'2014-09-02 21:55:37',0,'1'),(8,237,237,'2014-09-02 22:01:53',0,0,0,NULL,1,'0'),(8,237,NULL,NULL,1,1,237,'2014-09-02 22:01:53',0,'1'),(8,281,281,'2014-09-03 13:41:28',0,0,0,NULL,1,'0'),(8,281,NULL,NULL,1,1,281,'2014-09-03 13:41:28',0,'1'),(8,286,286,'2014-09-13 22:10:41',1,0,0,NULL,1,'0'),(8,286,NULL,NULL,1,1,286,'2014-09-13 22:10:41',0,'1'),(8,322,322,'2014-09-16 20:00:44',1,0,0,NULL,1,'0'),(8,322,NULL,NULL,1,1,322,'2014-09-16 20:00:44',0,'1'),(8,323,323,'2014-09-16 20:23:43',0,0,0,NULL,1,'0'),(8,323,NULL,NULL,1,1,323,'2014-09-16 20:23:43',0,'1'),(8,327,327,'2014-09-17 22:02:29',1,0,0,NULL,1,'0'),(8,327,NULL,NULL,1,1,327,'2014-09-17 22:02:29',0,'1'),(8,330,330,'2014-09-17 22:43:13',0,0,0,NULL,1,'0'),(8,330,NULL,NULL,1,1,330,'2014-09-17 22:43:13',0,'1'),(8,336,336,'2014-10-01 13:27:32',0,0,0,NULL,1,'0'),(8,336,NULL,NULL,1,1,336,'2014-10-01 13:27:32',0,'1'),(9,290,290,'2014-09-13 23:15:55',1,0,0,NULL,1,'0'),(9,290,NULL,NULL,1,1,290,'2014-09-13 23:15:55',0,'1'),(9,291,291,'2014-09-13 23:20:53',1,0,0,NULL,1,'0'),(9,291,NULL,NULL,1,1,291,'2014-09-13 23:20:53',0,'1'),(9,296,296,'2014-09-14 00:09:02',1,0,0,NULL,1,'0'),(9,296,NULL,NULL,1,1,296,'2014-09-14 00:09:02',0,'1'),(9,299,299,'2014-09-14 00:14:22',1,0,0,NULL,1,'0'),(9,299,NULL,NULL,1,1,299,'2014-09-14 00:14:22',0,'1'),(9,300,300,'2014-09-14 00:17:47',1,0,0,NULL,1,'0'),(9,300,NULL,NULL,1,1,300,'2014-09-14 00:17:47',0,'1'),(9,301,301,'2014-09-14 00:23:11',1,0,0,NULL,1,'0'),(9,301,NULL,NULL,1,1,301,'2014-09-14 00:23:11',0,'1'),(9,303,303,'2014-09-14 00:30:03',1,0,0,NULL,1,'0'),(9,303,NULL,NULL,1,1,303,'2014-09-14 00:30:03',0,'1'),(9,307,307,'2014-09-14 00:35:45',1,0,0,NULL,1,'0'),(9,307,NULL,NULL,1,1,307,'2014-09-14 00:35:45',0,'1'),(9,308,308,'2014-09-14 00:36:22',1,0,0,NULL,1,'0'),(9,308,NULL,NULL,1,1,308,'2014-09-14 00:36:22',0,'1'),(9,313,313,'2014-09-14 23:14:20',1,0,0,NULL,1,'0'),(9,313,NULL,NULL,1,1,313,'2014-09-14 23:14:20',0,'1'),(9,316,316,'2014-09-14 23:41:13',0,0,0,NULL,1,'0'),(9,316,NULL,NULL,1,1,316,'2014-09-14 23:41:13',0,'1'),(9,317,317,'2014-09-14 23:42:10',0,0,0,NULL,1,'0'),(9,317,NULL,NULL,1,1,317,'2014-09-14 23:42:10',0,'1'),(9,318,318,'2014-09-14 23:43:54',0,0,0,NULL,1,'0'),(9,318,NULL,NULL,1,1,318,'2014-09-14 23:43:54',0,'1'),(10,173,173,'2014-08-20 08:59:25',1,0,0,NULL,1,'0'),(10,173,NULL,NULL,1,1,173,'2014-08-20 08:59:25',0,'1'),(10,174,174,'2014-08-20 09:01:05',1,0,0,NULL,1,'0'),(10,174,NULL,NULL,1,1,174,'2014-08-20 09:01:05',0,'1'),(10,176,176,'2014-08-20 09:03:17',1,0,0,NULL,1,'0'),(10,176,NULL,NULL,1,1,176,'2014-08-20 09:03:17',0,'1'),(10,177,177,'2014-08-20 09:03:26',1,0,0,NULL,1,'0'),(10,177,NULL,NULL,1,1,177,'2014-08-20 09:03:26',0,'1'),(10,178,178,'2014-08-20 09:10:04',1,0,0,NULL,1,'0'),(10,178,NULL,NULL,1,1,178,'2014-08-20 09:10:04',0,'1'),(10,186,186,'2014-08-20 12:47:54',1,0,0,NULL,1,'0'),(10,186,NULL,NULL,1,1,186,'2014-08-20 12:47:54',0,'1'),(10,188,188,'2014-08-20 13:15:24',1,0,0,NULL,1,'0'),(10,189,189,'2014-08-20 13:30:09',1,0,0,NULL,1,'0'),(10,189,NULL,NULL,1,1,189,'2014-08-20 13:30:09',0,'1'),(10,193,193,'2014-08-20 20:09:52',1,0,0,NULL,1,'0'),(10,193,NULL,NULL,1,1,193,'2014-08-20 20:09:52',0,'1'),(10,195,195,'2014-08-20 20:18:31',1,0,0,NULL,1,'0'),(10,195,NULL,NULL,1,1,195,'2014-08-20 20:18:31',0,'1'),(10,196,196,'2014-08-20 20:19:16',0,0,0,NULL,1,'0'),(10,196,NULL,NULL,1,1,196,'2014-08-20 20:19:16',0,'1'),(10,198,198,'2014-08-20 20:20:01',0,0,0,NULL,1,'0'),(10,198,NULL,NULL,1,1,198,'2014-08-20 20:20:01',0,'1'),(10,200,200,'2014-08-20 20:21:04',0,0,0,NULL,1,'0'),(10,200,NULL,NULL,1,1,200,'2014-08-20 20:21:04',0,'1'),(10,201,201,'2014-08-20 20:21:36',0,0,0,NULL,1,'0'),(10,201,NULL,NULL,1,1,201,'2014-08-20 20:21:36',0,'1'),(10,202,202,'2014-08-20 20:22:02',1,0,0,NULL,1,'0'),(10,202,NULL,NULL,1,1,202,'2014-08-20 20:22:02',0,'1'),(10,208,208,'2014-08-20 21:36:05',0,0,0,NULL,1,'0'),(10,208,NULL,NULL,1,1,208,'2014-08-20 21:36:05',0,'1'),(10,210,210,'2014-08-20 21:37:37',1,0,0,NULL,1,'0'),(10,210,NULL,NULL,1,1,210,'2014-08-20 21:37:37',0,'1'),(10,215,215,'2014-08-20 21:51:44',1,0,0,NULL,1,'0'),(10,215,NULL,NULL,1,1,215,'2014-08-20 21:51:44',0,'1'),(10,218,218,'2014-08-24 12:57:37',0,0,0,NULL,1,'0'),(10,218,NULL,NULL,1,1,218,'2014-08-24 12:57:37',0,'1'),(10,221,221,'2014-08-24 12:57:38',0,0,0,NULL,1,'0'),(10,221,NULL,NULL,1,1,221,'2014-08-24 12:57:38',0,'1'),(11,287,287,'2014-09-13 22:52:20',1,0,0,NULL,1,'0'),(11,287,NULL,NULL,1,1,287,'2014-09-13 22:52:20',0,'1'),(11,288,288,'2014-09-13 23:02:58',1,0,0,NULL,1,'0'),(11,288,NULL,NULL,1,1,288,'2014-09-13 23:02:58',0,'1'),(11,289,289,'2014-09-13 23:14:07',1,0,0,NULL,1,'0'),(11,289,NULL,NULL,1,1,289,'2014-09-13 23:14:07',0,'1'),(11,292,292,'2014-09-13 23:39:24',1,0,0,NULL,1,'0'),(11,292,NULL,NULL,1,1,292,'2014-09-13 23:39:24',0,'1'),(11,294,294,'2014-09-14 00:02:41',1,0,0,NULL,1,'0'),(11,294,NULL,NULL,1,1,294,'2014-09-14 00:02:41',0,'1'),(11,295,295,'2014-09-14 00:08:21',1,0,0,NULL,1,'0'),(11,295,NULL,NULL,1,1,295,'2014-09-14 00:08:21',0,'1'),(11,297,297,'2014-09-14 00:11:38',1,0,0,NULL,1,'0'),(11,297,NULL,NULL,1,1,297,'2014-09-14 00:11:38',0,'1'),(11,298,298,'2014-09-14 00:14:00',1,0,0,NULL,1,'0'),(11,298,NULL,NULL,1,1,298,'2014-09-14 00:14:00',0,'1'),(11,302,302,'2014-09-14 00:24:42',1,0,0,NULL,1,'0'),(11,302,NULL,NULL,1,1,302,'2014-09-14 00:24:42',0,'1'),(11,304,304,'2014-09-14 00:33:45',1,0,0,NULL,1,'0'),(11,304,NULL,NULL,1,1,304,'2014-09-14 00:33:45',0,'1'),(11,305,305,'2014-09-14 00:34:09',1,0,0,NULL,1,'0'),(11,305,NULL,NULL,1,1,305,'2014-09-14 00:34:09',0,'1'),(11,306,306,'2014-09-14 00:35:24',1,0,0,NULL,1,'0'),(11,306,NULL,NULL,1,1,306,'2014-09-14 00:35:24',0,'1'),(11,309,309,'2014-09-14 00:39:44',1,0,0,NULL,1,'0'),(11,309,NULL,NULL,1,1,309,'2014-09-14 00:39:44',0,'1'),(11,311,311,'2014-09-14 00:53:33',1,0,0,NULL,1,'0'),(11,311,NULL,NULL,1,1,311,'2014-09-14 00:53:33',0,'1'),(11,312,312,'2014-09-14 23:13:16',1,0,0,NULL,1,'0'),(11,312,NULL,NULL,1,1,312,'2014-09-14 23:13:16',0,'1'),(11,314,314,'2014-09-14 23:31:48',1,0,0,NULL,1,'0'),(11,314,NULL,NULL,1,1,314,'2014-09-14 23:31:48',0,'1'),(11,315,315,'2014-09-14 23:40:26',0,0,0,NULL,1,'0'),(11,315,NULL,NULL,1,1,315,'2014-09-14 23:40:26',0,'1'),(11,320,320,'2014-09-14 23:57:33',0,0,0,NULL,1,'0'),(11,320,NULL,NULL,1,1,320,'2014-09-14 23:57:33',0,'1'),(11,326,326,'2014-09-17 22:02:04',0,0,0,NULL,1,'0'),(11,326,NULL,NULL,1,1,326,'2014-09-17 22:02:04',0,'1'),(11,332,332,'2014-09-18 20:54:20',0,0,0,NULL,1,'0'),(11,332,NULL,NULL,1,1,332,'2014-09-18 20:54:20',0,'1'),(11,338,338,'2014-10-01 13:27:33',0,0,0,NULL,1,'0'),(11,338,NULL,NULL,1,1,338,'2014-10-01 13:27:33',0,'1'),(13,331,331,'2014-09-17 22:44:11',0,0,0,NULL,1,'0'),(13,331,NULL,NULL,1,1,331,'2014-09-17 22:44:11',0,'1'),(13,333,333,'2014-09-18 20:57:05',0,0,0,NULL,1,'0'),(13,333,NULL,NULL,1,1,333,'2014-09-18 20:57:05',0,'1'),(13,335,335,'2014-09-21 23:38:35',0,0,0,NULL,1,'0'),(13,335,NULL,NULL,1,1,335,'2014-09-21 23:38:35',0,'1');
/*!40000 ALTER TABLE `engine4_messages_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_network_membership`
--

DROP TABLE IF EXISTS `engine4_network_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_network_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_network_membership`
--

LOCK TABLES `engine4_network_membership` WRITE;
/*!40000 ALTER TABLE `engine4_network_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_network_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_network_networks`
--

DROP TABLE IF EXISTS `engine4_network_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_network_networks` (
  `network_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pattern` text COLLATE utf8_unicode_ci,
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `assignment` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`network_id`),
  KEY `assignment` (`assignment`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_network_networks`
--

LOCK TABLES `engine4_network_networks` WRITE;
/*!40000 ALTER TABLE `engine4_network_networks` DISABLE KEYS */;
INSERT INTO `engine4_network_networks` VALUES (1,'North America','',0,NULL,0,0,0),(2,'South America','',0,NULL,0,0,0),(3,'Europe','',0,NULL,0,0,0),(4,'Asia','',0,NULL,0,0,0),(5,'Africa','',0,NULL,0,0,0),(6,'Australia','',0,NULL,0,0,0),(7,'Antarctica','',0,NULL,0,0,0);
/*!40000 ALTER TABLE `engine4_network_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_gateways`
--

DROP TABLE IF EXISTS `engine4_payment_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_gateways` (
  `gateway_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` mediumblob,
  `test_mode` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`gateway_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_gateways`
--

LOCK TABLES `engine4_payment_gateways` WRITE;
/*!40000 ALTER TABLE `engine4_payment_gateways` DISABLE KEYS */;
INSERT INTO `engine4_payment_gateways` VALUES (1,'2Checkout',NULL,0,'Payment_Plugin_Gateway_2Checkout',NULL,0),(2,'PayPal',NULL,0,'Payment_Plugin_Gateway_PayPal',NULL,0),(3,'Testing',NULL,0,'Payment_Plugin_Gateway_Testing',NULL,1);
/*!40000 ALTER TABLE `engine4_payment_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_orders`
--

DROP TABLE IF EXISTS `engine4_payment_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_orders` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `gateway_id` int(10) unsigned NOT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` enum('pending','cancelled','failed','incomplete','complete') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'pending',
  `creation_date` datetime NOT NULL,
  `source_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`,`gateway_order_id`),
  KEY `state` (`state`),
  KEY `source_type` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_orders`
--

LOCK TABLES `engine4_payment_orders` WRITE;
/*!40000 ALTER TABLE `engine4_payment_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_packages`
--

DROP TABLE IF EXISTS `engine4_payment_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_packages` (
  `package_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level_id` int(10) unsigned NOT NULL,
  `downgrade_level_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` decimal(16,2) unsigned NOT NULL,
  `recurrence` int(11) unsigned NOT NULL,
  `recurrence_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) unsigned NOT NULL,
  `duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `trial_duration` int(11) unsigned NOT NULL DEFAULT '0',
  `trial_duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `after_signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`package_id`),
  KEY `level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_packages`
--

LOCK TABLES `engine4_payment_packages` WRITE;
/*!40000 ALTER TABLE `engine4_payment_packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_products`
--

DROP TABLE IF EXISTS `engine4_payment_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_products` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `extension_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `extension_id` int(10) unsigned DEFAULT NULL,
  `sku` bigint(20) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(16,2) unsigned NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `extension_type` (`extension_type`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_products`
--

LOCK TABLES `engine4_payment_products` WRITE;
/*!40000 ALTER TABLE `engine4_payment_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_subscriptions`
--

DROP TABLE IF EXISTS `engine4_payment_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_subscriptions` (
  `subscription_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `package_id` int(11) unsigned NOT NULL,
  `status` enum('initial','trial','pending','active','cancelled','expired','overdue','refunded') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'initial',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `gateway_id` int(10) unsigned DEFAULT NULL,
  `gateway_profile_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE KEY `gateway_id` (`gateway_id`,`gateway_profile_id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  KEY `status` (`status`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_subscriptions`
--

LOCK TABLES `engine4_payment_subscriptions` WRITE;
/*!40000 ALTER TABLE `engine4_payment_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_payment_transactions`
--

DROP TABLE IF EXISTS `engine4_payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_payment_transactions` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `gateway_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `gateway_parent_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `currency` char(3) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`transaction_id`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`),
  KEY `type` (`type`),
  KEY `state` (`state`),
  KEY `gateway_transaction_id` (`gateway_transaction_id`),
  KEY `gateway_parent_transaction_id` (`gateway_parent_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_payment_transactions`
--

LOCK TABLES `engine4_payment_transactions` WRITE;
/*!40000 ALTER TABLE `engine4_payment_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_chunks`
--

DROP TABLE IF EXISTS `engine4_storage_chunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_chunks` (
  `chunk_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(11) unsigned NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`chunk_id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_chunks`
--

LOCK TABLES `engine4_storage_chunks` WRITE;
/*!40000 ALTER TABLE `engine4_storage_chunks` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_storage_chunks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_files`
--

DROP TABLE IF EXISTS `engine4_storage_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_files` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_file_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `service_id` int(10) unsigned NOT NULL DEFAULT '1',
  `storage_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_major` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `mime_minor` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `parent_file_id` (`parent_file_id`,`type`),
  KEY `PARENT` (`parent_type`,`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_files`
--

LOCK TABLES `engine4_storage_files` WRITE;
/*!40000 ALTER TABLE `engine4_storage_files` DISABLE KEYS */;
INSERT INTO `engine4_storage_files` VALUES (29,NULL,NULL,'user',7,NULL,'2014-08-17 09:41:16','2014-08-17 09:41:16',1,'public/user/1d/001d_64cb.jpg','jpg','m_che.jpg','image','jpeg',10313,'72ed64cb04c3b5bb14bb10e30e01e9af'),(30,29,'thumb.profile','user',7,NULL,'2014-08-17 09:41:16','2014-08-17 09:41:16',1,'public/user/1e/001e_1a4e.jpg','jpg','p_che.jpg','image','jpeg',6491,'02f11a4eac290737a6e483687d7b266f'),(31,29,'thumb.normal','user',7,NULL,'2014-08-17 09:41:16','2014-08-17 09:41:16',1,'public/user/1f/001f_d1d4.jpg','jpg','n_che.jpg','image','jpeg',1586,'3698d1d489b9f45334e3b8acb0242134'),(32,29,'thumb.icon','user',7,NULL,'2014-08-17 09:41:17','2014-08-17 09:41:17',1,'public/user/20/0020_d1d4.jpg','jpg','s_che.jpg','image','jpeg',1586,'3698d1d489b9f45334e3b8acb0242134'),(33,NULL,NULL,'event',18,7,'2014-08-17 11:26:26','2014-08-17 11:26:26',1,'public/event/21/0021_1349.png','png','m_Made20bacon.png','image','png',192413,'69251349ec307b614aab4292600fc88d'),(34,33,'thumb.profile','event',18,7,'2014-08-17 11:26:26','2014-08-17 11:26:26',1,'public/event/22/0022_6bf8.png','png','p_Made20bacon.png','image','png',30055,'af466bf8ae4a57fbc3cc938d11e88152'),(35,33,'thumb.normal','event',18,7,'2014-08-17 11:26:26','2014-08-17 11:26:26',1,'public/event/23/0023_3009.png','png','in_Made20bacon.png','image','png',15290,'7e90300948a6bc808cfa4ab4586f53f3'),(36,33,'thumb.icon','event',18,7,'2014-08-17 11:26:26','2014-08-17 11:26:26',1,'public/event/24/0024_b674.png','png','is_Made20bacon.png','image','png',3640,'ca9ab674bf2d5afdee5035856badeb51'),(37,NULL,NULL,'user',8,NULL,'2014-08-17 11:28:43','2014-08-17 11:28:43',1,'public/user/25/0025_844f.jpg','jpg','m_hulkster.jpg','image','jpeg',8580,'5930844faa914f3f30a4f95fb207e877'),(38,37,'thumb.profile','user',8,NULL,'2014-08-17 11:28:43','2014-08-17 11:28:43',1,'public/user/26/0026_844f.jpg','jpg','p_hulkster.jpg','image','jpeg',8580,'5930844faa914f3f30a4f95fb207e877'),(39,37,'thumb.normal','user',8,NULL,'2014-08-17 11:28:43','2014-08-17 11:28:43',1,'public/user/27/0027_f713.jpg','jpg','n_hulkster.jpg','image','jpeg',1497,'e9e1f713285825698373bb293257e809'),(40,37,'thumb.icon','user',8,NULL,'2014-08-17 11:28:43','2014-08-17 11:28:43',1,'public/user/28/0028_f713.jpg','jpg','s_hulkster.jpg','image','jpeg',1497,'e9e1f713285825698373bb293257e809'),(41,NULL,NULL,'user',9,9,'2014-08-19 23:09:42','2014-08-19 23:09:42',1,'public/user/29/0029_248c.jpg','jpg','70124160_Spescha_Reto_1000x750_m.jpg','image','jpeg',37070,'8411248ca7a7f55087b39a85075d279b'),(42,41,'thumb.profile','user',9,9,'2014-08-19 23:09:42','2014-08-19 23:09:42',1,'public/user/2a/002a_257b.jpg','jpg','70124160_Spescha_Reto_1000x750_p.jpg','image','jpeg',3872,'fb74257b5c4a96ff66a9a3556cac3c44'),(43,41,'thumb.normal','user',9,9,'2014-08-19 23:09:42','2014-08-19 23:09:42',1,'public/user/2b/002b_2edc.jpg','jpg','70124160_Spescha_Reto_1000x750_in.jpg','image','jpeg',2514,'0e942edc9dbe16cce1be5fb3b5cf0470'),(44,41,'thumb.icon','user',9,9,'2014-08-19 23:09:42','2014-08-19 23:09:42',1,'public/user/2c/002c_0b06.jpg','jpg','70124160_Spescha_Reto_1000x750_is.jpg','image','jpeg',1191,'f8ca0b0605f38d0befef9dc0e3a564c4'),(53,NULL,NULL,'event',20,8,'2014-08-20 09:14:47','2014-08-20 09:14:47',1,'public/event/35/0035_44fd.jpg','jpg','m_images.jpg','image','jpeg',5504,'95ad44fd34af8ba561f6f3fcb985854b'),(54,53,'thumb.profile','event',20,8,'2014-08-20 09:14:47','2014-08-20 09:14:47',1,'public/event/36/0036_9c27.jpg','jpg','p_images.jpg','image','jpeg',3639,'018f9c273b0fd9fe0737c42da31dcee7'),(55,53,'thumb.normal','event',20,8,'2014-08-20 09:14:47','2014-08-20 09:14:47',1,'public/event/37/0037_2837.jpg','jpg','in_images.jpg','image','jpeg',2547,'22592837ad650dabfdc5e1c0d5f86872'),(56,53,'thumb.icon','event',20,8,'2014-08-20 09:14:47','2014-08-20 09:14:47',1,'public/event/38/0038_dff1.jpg','jpg','is_images.jpg','image','jpeg',1239,'275adff1167bbe131041d6272e88c6bc'),(65,NULL,NULL,'event',25,1,'2014-09-03 07:28:13','2014-09-03 07:28:13',1,'public/event/41/0041_c01f.jpeg','jpeg','m_images.jpeg','image','jpeg',14669,'b369c01f18fb2d2a2752f4116f25a11a'),(66,65,'thumb.profile','event',25,1,'2014-09-03 07:28:13','2014-09-03 07:28:13',1,'public/event/42/0042_97fd.jpeg','jpeg','p_images.jpeg','image','jpeg',7780,'1ab197fd217cb58cc6177a36852c962a'),(67,65,'thumb.normal','event',25,1,'2014-09-03 07:28:13','2014-09-03 07:28:13',1,'public/event/43/0043_2f3e.jpeg','jpeg','in_images.jpeg','image','jpeg',4764,'e9d12f3e611ea6e1f70c0e5d0818365d'),(68,65,'thumb.icon','event',25,1,'2014-09-03 07:28:13','2014-09-03 07:28:13',1,'public/event/44/0044_6d43.jpeg','jpeg','is_images.jpeg','image','jpeg',1564,'7b696d43f3e6c01f8a3d7759d4c955db'),(69,NULL,NULL,'event',26,1,'2014-09-03 12:05:04','2014-09-03 12:05:04',1,'public/event/45/0045_0a65.jpeg','jpeg','m_index.jpeg','image','jpeg',14799,'2a2d0a650dbaf424b5576e1ef6e73bc5'),(70,69,'thumb.profile','event',26,1,'2014-09-03 12:05:04','2014-09-03 12:05:04',1,'public/event/46/0046_a583.jpeg','jpeg','p_index.jpeg','image','jpeg',10972,'48a7a5833dede5876a7b6c19b491d6c2'),(71,69,'thumb.normal','event',26,1,'2014-09-03 12:05:04','2014-09-03 12:05:04',1,'public/event/47/0047_b2bd.jpeg','jpeg','in_index.jpeg','image','jpeg',6617,'6f2cb2bd48a717beca4d0a8f4ffb5824'),(72,69,'thumb.icon','event',26,1,'2014-09-03 12:05:04','2014-09-03 12:05:04',1,'public/event/48/0048_3683.jpeg','jpeg','is_index.jpeg','image','jpeg',1543,'eb923683e3bee8471bfb70b7004cbebf'),(73,NULL,NULL,'user',11,NULL,'2014-09-13 22:11:19','2014-09-13 22:11:19',1,'public/user/49/0049_7e4a.jpg','jpg','m_vlcsnap-2010-11-22-18h15m40s151.jpg','image','jpeg',10869,'742f7e4add1808e1f29ba41d3348d042'),(74,73,'thumb.profile','user',11,NULL,'2014-09-13 22:11:19','2014-09-13 22:11:19',1,'public/user/4a/004a_2327.jpg','jpg','p_vlcsnap-2010-11-22-18h15m40s151.jpg','image','jpeg',4918,'85262327052f8291982445e1b69fa4a4'),(75,73,'thumb.normal','user',11,NULL,'2014-09-13 22:11:19','2014-09-13 22:11:19',1,'public/user/4b/004b_ca3b.jpg','jpg','n_vlcsnap-2010-11-22-18h15m40s151.jpg','image','jpeg',1157,'249fca3bc75da70f00af7a6405ad33d0'),(76,73,'thumb.icon','user',11,NULL,'2014-09-13 22:11:19','2014-09-13 22:11:19',1,'public/user/4c/004c_25bc.jpg','jpg','s_vlcsnap-2010-11-22-18h15m40s151.jpg','image','jpeg',1240,'f20725bc66ea8aba7dc7af8a725533f1'),(77,NULL,NULL,'event',28,11,'2014-09-13 22:47:47','2014-09-13 22:47:47',1,'public/event/4d/004d_c96a.jpg','jpg','m_images.jpg','image','jpeg',5830,'487bc96aaa1474696a5ae3d609301501'),(78,77,'thumb.profile','event',28,11,'2014-09-13 22:47:47','2014-09-13 22:47:47',1,'public/event/4e/004e_46ba.jpg','jpg','p_images.jpg','image','jpeg',4287,'482646ba67c95684edf240b0a7922fa9'),(79,77,'thumb.normal','event',28,11,'2014-09-13 22:47:47','2014-09-13 22:47:47',1,'public/event/4f/004f_fb80.jpg','jpg','in_images.jpg','image','jpeg',2703,'7042fb80df930ceb52781d623805b287'),(80,77,'thumb.icon','event',28,11,'2014-09-13 22:47:47','2014-09-13 22:47:47',1,'public/event/50/0050_5ad6.jpg','jpg','is_images.jpg','image','jpeg',1182,'c97f5ad6aa1f7b74350b411d3fe46c9d'),(81,NULL,NULL,'event',29,11,'2014-09-14 23:12:27','2014-09-14 23:12:27',1,'public/event/51/0051_01ec.jpg','jpg','m_pepperoni-2-300x282.jpg','image','jpeg',22043,'7e8101ec801ba056b09fbca55cf4cc64'),(82,81,'thumb.profile','event',29,11,'2014-09-14 23:12:27','2014-09-14 23:12:27',1,'public/event/52/0052_dbc4.jpg','jpg','p_pepperoni-2-300x282.jpg','image','jpeg',11613,'7cd2dbc4ff9319a9766198ac0a6d2818'),(83,81,'thumb.normal','event',29,11,'2014-09-14 23:12:27','2014-09-14 23:12:27',1,'public/event/53/0053_c11a.jpg','jpg','in_pepperoni-2-300x282.jpg','image','jpeg',6915,'7a65c11a58b94c9a1af6dadfc6c91596'),(84,81,'thumb.icon','event',29,11,'2014-09-14 23:12:27','2014-09-14 23:12:27',1,'public/event/54/0054_73af.jpg','jpg','is_pepperoni-2-300x282.jpg','image','jpeg',1668,'685673afb068aae500e5248d5e8069a7'),(85,NULL,NULL,'user',12,NULL,'2014-09-14 23:24:15','2014-09-14 23:24:15',1,'public/user/55/0055_021c.jpg','jpg','m_H6221543-4.jpg','image','jpeg',11002,'efaf021c97ae2917ef90fe17e164068a'),(86,85,'thumb.profile','user',12,NULL,'2014-09-14 23:24:15','2014-09-14 23:24:15',1,'public/user/56/0056_02c8.jpg','jpg','p_H6221543-4.jpg','image','jpeg',6646,'b2dd02c8762cd0a21a40a31cf08eeaf5'),(87,85,'thumb.normal','user',12,NULL,'2014-09-14 23:24:15','2014-09-14 23:24:15',1,'public/user/57/0057_1312.jpg','jpg','n_H6221543-4.jpg','image','jpeg',1402,'0e7f131234112e65800d7fd0b713a186'),(88,85,'thumb.icon','user',12,NULL,'2014-09-14 23:24:15','2014-09-14 23:24:15',1,'public/user/58/0058_14a1.jpg','jpg','s_H6221543-4.jpg','image','jpeg',1507,'fa4114a15561d875d0042230d00c1be4'),(89,NULL,NULL,'event',30,11,'2014-09-14 23:57:31','2014-09-14 23:57:31',1,'public/event/59/0059_f4c6.jpg','jpg','m_broccoli-alone.jpg','image','jpeg',70138,'b4faf4c6e962495961471fe29d83d5ba'),(90,89,'thumb.profile','event',30,11,'2014-09-14 23:57:31','2014-09-14 23:57:31',1,'public/event/5a/005a_c550.jpg','jpg','p_broccoli-alone.jpg','image','jpeg',9103,'6440c55068feb1917123befa00305c0a'),(91,89,'thumb.normal','event',30,11,'2014-09-14 23:57:31','2014-09-14 23:57:31',1,'public/event/5b/005b_c142.jpg','jpg','in_broccoli-alone.jpg','image','jpeg',5176,'35acc1422abfaf01918920b9e255436d'),(92,89,'thumb.icon','event',30,11,'2014-09-14 23:57:31','2014-09-14 23:57:31',1,'public/event/5c/005c_3dc9.jpg','jpg','is_broccoli-alone.jpg','image','jpeg',1508,'8f4c3dc9a77f7db5c9a1613ca60b9129'),(93,NULL,NULL,'user',13,NULL,'2014-09-17 22:33:34','2014-09-17 22:33:34',1,'public/user/5d/005d_3b9e.jpg','jpg','m_Mother-of-hipster.jpg','image','jpeg',38466,'250b3b9ef721d2064ad4cef5befcd4c5'),(94,93,'thumb.profile','user',13,NULL,'2014-09-17 22:33:34','2014-09-17 22:33:34',1,'public/user/5e/005e_8003.jpg','jpg','p_Mother-of-hipster.jpg','image','jpeg',5842,'76a0800360252a0491a01e75edcff320'),(95,93,'thumb.normal','user',13,NULL,'2014-09-17 22:33:34','2014-09-17 22:33:34',1,'public/user/5f/005f_b1e2.jpg','jpg','n_Mother-of-hipster.jpg','image','jpeg',1220,'46d7b1e202cd1e6dee9bdf92e33e00db'),(96,93,'thumb.icon','user',13,NULL,'2014-09-17 22:33:34','2014-09-17 22:33:34',1,'public/user/60/0060_49d3.jpg','jpg','s_Mother-of-hipster.jpg','image','jpeg',1220,'110c49d3988e0d04b5e66ad1432ef8b0'),(109,NULL,NULL,'event',34,1,'2014-10-09 14:20:05','2014-10-09 14:20:05',1,'public/event/6d/006d_7eef.jpg','jpg','m_bannerImage4.jpg','image','jpeg',50185,'9eca7eef13307cf55b06330ad66ad229'),(110,109,'thumb.profile','event',34,1,'2014-10-09 14:20:05','2014-10-09 14:20:05',1,'public/event/6e/006e_5f47.jpg','jpg','p_bannerImage4.jpg','image','jpeg',7315,'5c6b5f475552630dea869d4cf8c35600'),(111,109,'thumb.normal','event',34,1,'2014-10-09 14:20:05','2014-10-09 14:20:05',1,'public/event/6f/006f_f582.jpg','jpg','in_bannerImage4.jpg','image','jpeg',4359,'f05bf5823dcbce6d5652fb504abec96c'),(112,109,'thumb.icon','event',34,1,'2014-10-09 14:20:05','2014-10-09 14:20:05',1,'public/event/70/0070_d92b.jpg','jpg','is_bannerImage4.jpg','image','jpeg',1682,'4168d92b470ca9fe1b7008c21ca94242');
/*!40000 ALTER TABLE `engine4_storage_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_mirrors`
--

DROP TABLE IF EXISTS `engine4_storage_mirrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_mirrors` (
  `file_id` bigint(20) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`file_id`,`service_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_mirrors`
--

LOCK TABLES `engine4_storage_mirrors` WRITE;
/*!40000 ALTER TABLE `engine4_storage_mirrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_storage_mirrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_services`
--

DROP TABLE IF EXISTS `engine4_storage_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_services` (
  `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `servicetype_id` int(10) unsigned NOT NULL,
  `config` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_services`
--

LOCK TABLES `engine4_storage_services` WRITE;
/*!40000 ALTER TABLE `engine4_storage_services` DISABLE KEYS */;
INSERT INTO `engine4_storage_services` VALUES (1,1,NULL,1,1);
/*!40000 ALTER TABLE `engine4_storage_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_storage_servicetypes`
--

DROP TABLE IF EXISTS `engine4_storage_servicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_storage_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`servicetype_id`),
  UNIQUE KEY `plugin` (`plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_storage_servicetypes`
--

LOCK TABLES `engine4_storage_servicetypes` WRITE;
/*!40000 ALTER TABLE `engine4_storage_servicetypes` DISABLE KEYS */;
INSERT INTO `engine4_storage_servicetypes` VALUES (1,'Local Storage','Storage_Service_Local','Storage_Form_Admin_Service_Local',1),(2,'Database Storage','Storage_Service_Db','Storage_Form_Admin_Service_Db',0),(3,'Amazon S3','Storage_Service_S3','Storage_Form_Admin_Service_S3',1),(4,'Virtual File System','Storage_Service_Vfs','Storage_Form_Admin_Service_Vfs',1),(5,'Round-Robin','Storage_Service_RoundRobin','Storage_Form_Admin_Service_RoundRobin',0),(6,'Mirrored','Storage_Service_Mirrored','Storage_Form_Admin_Service_Mirrored',0);
/*!40000 ALTER TABLE `engine4_storage_servicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_block`
--

DROP TABLE IF EXISTS `engine4_user_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_block` (
  `user_id` int(11) unsigned NOT NULL,
  `blocked_user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`blocked_user_id`),
  KEY `REVERSE` (`blocked_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_block`
--

LOCK TABLES `engine4_user_block` WRITE;
/*!40000 ALTER TABLE `engine4_user_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_facebook`
--

DROP TABLE IF EXISTS `engine4_user_facebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_facebook` (
  `user_id` int(11) unsigned NOT NULL,
  `facebook_uid` bigint(20) unsigned NOT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `facebook_uid` (`facebook_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_facebook`
--

LOCK TABLES `engine4_user_facebook` WRITE;
/*!40000 ALTER TABLE `engine4_user_facebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_facebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_maps`
--

DROP TABLE IF EXISTS `engine4_user_fields_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_maps`
--

LOCK TABLES `engine4_user_fields_maps` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_maps` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_maps` VALUES (0,0,1,1),(1,1,2,2),(1,1,3,3),(1,1,4,4),(1,1,5,5),(1,1,6,6),(1,1,7,7),(1,1,8,8),(1,1,9,9),(1,1,10,10),(1,1,11,11),(1,1,12,12),(1,1,13,13);
/*!40000 ALTER TABLE `engine4_user_fields_maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_meta`
--

DROP TABLE IF EXISTS `engine4_user_fields_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_meta` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_meta`
--

LOCK TABLES `engine4_user_fields_meta` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_meta` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_meta` VALUES (1,'profile_type','Profile Type','','profile_type',1,0,0,2,1,999,'',NULL,NULL,NULL,NULL),(2,'heading','Personal Information','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(3,'first_name','First Name','','first_name',1,1,0,2,1,999,'','[[\"StringLength\",false,[1,32]]]',NULL,NULL,NULL),(4,'last_name','Last Name','','last_name',1,1,0,2,1,999,'','[[\"StringLength\",false,[1,32]]]',NULL,NULL,NULL),(5,'gender','Gender','','gender',0,1,0,1,1,999,'',NULL,NULL,NULL,NULL),(6,'birthdate','Birthday','','birthdate',0,1,0,1,1,999,'',NULL,NULL,NULL,NULL),(7,'heading','Contact Information','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(8,'website','Website','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(9,'twitter','Twitter','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(10,'facebook','Facebook','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(11,'aim','AIM','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(12,'heading','Personal Details','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL),(13,'about_me','About Me','','',0,1,0,0,1,999,'',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `engine4_user_fields_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_options`
--

DROP TABLE IF EXISTS `engine4_user_fields_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_options` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_options`
--

LOCK TABLES `engine4_user_fields_options` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_options` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_options` VALUES (1,1,'Regular Member',1),(2,5,'Male',1),(3,5,'Female',2);
/*!40000 ALTER TABLE `engine4_user_fields_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_search`
--

DROP TABLE IF EXISTS `engine4_user_fields_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  `profile_type` smallint(11) unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` smallint(6) unsigned DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `profile_type` (`profile_type`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `gender` (`gender`),
  KEY `birthdate` (`birthdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_search`
--

LOCK TABLES `engine4_user_fields_search` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_search` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_search` VALUES (1,1,'First','Last',2,'0000-00-00'),(2,1,'user','1',2,'0000-00-00'),(3,1,'user','2',2,'0000-00-00'),(4,1,'user','3',2,'0000-00-00'),(7,1,'Markus','Liechti',2,'0000-00-00'),(8,1,'Hulk','Hogan',2,'0000-00-00'),(9,1,'Reto','Spescha',2,'1981-04-18'),(11,1,'Peter','North',2,'2000-10-10'),(12,1,'reto','happetite',2,'1996-05-08'),(13,1,'Markus','Local',0,'0000-00-00');
/*!40000 ALTER TABLE `engine4_user_fields_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_fields_values`
--

DROP TABLE IF EXISTS `engine4_user_fields_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `privacy` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_fields_values`
--

LOCK TABLES `engine4_user_fields_values` WRITE;
/*!40000 ALTER TABLE `engine4_user_fields_values` DISABLE KEYS */;
INSERT INTO `engine4_user_fields_values` VALUES (1,1,0,'1',NULL),(1,3,0,'First','everyone'),(1,4,0,'Last','everyone'),(1,5,0,'2','everyone'),(1,6,0,'','everyone'),(1,8,0,'','everyone'),(1,9,0,'','everyone'),(1,10,0,'','everyone'),(1,11,0,'','everyone'),(1,13,0,'','everyone'),(2,1,0,'1',NULL),(2,3,0,'user',NULL),(2,4,0,'1',NULL),(2,5,0,'2',NULL),(2,6,0,'',NULL),(2,8,0,'',NULL),(2,9,0,'',NULL),(2,10,0,'',NULL),(2,11,0,'',NULL),(2,13,0,'',NULL),(3,1,0,'1',NULL),(3,3,0,'user',NULL),(3,4,0,'2',NULL),(3,5,0,'2',NULL),(3,6,0,'',NULL),(3,8,0,'',NULL),(3,9,0,'',NULL),(3,10,0,'',NULL),(3,11,0,'',NULL),(3,13,0,'',NULL),(4,1,0,'1',NULL),(4,3,0,'user',NULL),(4,4,0,'3',NULL),(4,5,0,'2',NULL),(4,6,0,'',NULL),(4,8,0,'',NULL),(4,9,0,'',NULL),(4,10,0,'',NULL),(4,11,0,'',NULL),(4,13,0,'',NULL),(7,1,0,'1',NULL),(7,3,0,'Markus',NULL),(7,4,0,'Liechti',NULL),(7,5,0,'2',NULL),(7,6,0,'',NULL),(7,8,0,'',NULL),(7,9,0,'',NULL),(7,10,0,'',NULL),(7,11,0,'',NULL),(7,13,0,'',NULL),(8,1,0,'1',NULL),(8,3,0,'Hulk',NULL),(8,4,0,'Hogan',NULL),(8,5,0,'2',NULL),(8,6,0,'',NULL),(8,8,0,'',NULL),(8,9,0,'',NULL),(8,10,0,'',NULL),(8,11,0,'',NULL),(8,13,0,'I\'m the Hulkster ',NULL),(9,1,0,'1',NULL),(9,3,0,'Reto',NULL),(9,4,0,'Spescha',NULL),(9,5,0,'2',NULL),(9,6,0,'1981-4-18',NULL),(9,8,0,'',NULL),(9,9,0,'',NULL),(9,10,0,'',NULL),(9,11,0,'',NULL),(9,13,0,'hello',NULL),(11,1,0,'1',NULL),(11,3,0,'Peter',NULL),(11,4,0,'North',NULL),(11,5,0,'2',NULL),(11,6,0,'2000-10-10',NULL),(11,8,0,'',NULL),(11,9,0,'',NULL),(11,10,0,'',NULL),(11,11,0,'',NULL),(11,13,0,'Hello, I am Peter',NULL),(12,1,0,'1',NULL),(12,3,0,'reto',NULL),(12,4,0,'happetite',NULL),(12,5,0,'2',NULL),(12,6,0,'1996-5-8',NULL),(12,8,0,'',NULL),(12,9,0,'',NULL),(12,10,0,'',NULL),(12,11,0,'',NULL),(12,13,0,'sdf',NULL),(13,1,0,'1',NULL),(13,3,0,'Markus',NULL),(13,4,0,'Local',NULL),(13,5,0,'',NULL),(13,6,0,'',NULL),(13,8,0,'',NULL),(13,9,0,'',NULL),(13,10,0,'',NULL),(13,11,0,'',NULL),(13,13,0,'',NULL);
/*!40000 ALTER TABLE `engine4_user_fields_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_forgot`
--

DROP TABLE IF EXISTS `engine4_user_forgot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_forgot` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_forgot`
--

LOCK TABLES `engine4_user_forgot` WRITE;
/*!40000 ALTER TABLE `engine4_user_forgot` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_forgot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_janrain`
--

DROP TABLE IF EXISTS `engine4_user_janrain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_janrain` (
  `user_id` int(11) unsigned NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_janrain`
--

LOCK TABLES `engine4_user_janrain` WRITE;
/*!40000 ALTER TABLE `engine4_user_janrain` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_janrain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_listitems`
--

DROP TABLE IF EXISTS `engine4_user_listitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_listitems` (
  `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`listitem_id`),
  KEY `list_id` (`list_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_listitems`
--

LOCK TABLES `engine4_user_listitems` WRITE;
/*!40000 ALTER TABLE `engine4_user_listitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_listitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_lists`
--

DROP TABLE IF EXISTS `engine4_user_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_lists` (
  `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_lists`
--

LOCK TABLES `engine4_user_lists` WRITE;
/*!40000 ALTER TABLE `engine4_user_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_logins`
--

DROP TABLE IF EXISTS `engine4_user_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_logins` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varbinary(16) NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` enum('success','no-member','bad-password','disabled','unpaid','third-party','v3-migration','unknown') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'unknown',
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`login_id`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_logins`
--

LOCK TABLES `engine4_user_logins` WRITE;
/*!40000 ALTER TABLE `engine4_user_logins` DISABLE KEYS */;
INSERT INTO `engine4_user_logins` VALUES (1,1,'admin@email.com','\0\0','2014-06-19 15:20:07','success',NULL,1),(2,1,'admin@email.com','\0\0','2014-06-22 15:42:35','success',NULL,0),(3,1,'admin@email.com','\0\0','2014-06-23 08:49:21','success',NULL,1),(4,2,'user1@email.com','\0\0','2014-06-23 08:49:33','success',NULL,1),(5,2,'user1@email.com','\0\0','2014-06-24 07:32:09','success',NULL,0),(6,2,'user1@email.com','\0\0','2014-06-24 07:32:20','success',NULL,0),(7,4,'user3@email.com','\0\0','2014-06-24 07:32:38','success',NULL,1),(8,1,'admin@email.com','\0\0','2014-06-28 14:02:10','success',NULL,1),(9,1,'admin@email.com','\0\0','2014-06-28 15:08:52','success',NULL,1),(10,1,'admin@email.com','\0\0','2014-06-28 15:08:56','success',NULL,1),(11,2,'user1@email.com','\0\0','2014-06-30 10:31:37','success',NULL,1),(12,3,'user2@email.com','\0\0','2014-06-30 10:31:51','success',NULL,1),(13,4,'user3@email.com','\0\0','2014-06-30 10:33:14','success',NULL,1),(14,1,'admin@email.com','\0\0','2014-07-01 20:28:15','success',NULL,1),(15,6,'user5@email.com','\0\0','2014-07-01 20:57:19','success',NULL,1),(16,1,'admin@email.com','\0\0','2014-07-05 06:01:53','success',NULL,1),(17,1,'admin@email.com','\0\0','2014-07-07 08:08:33','success',NULL,1),(18,1,'admin@email.com','\0\0','2014-07-08 13:29:44','success',NULL,1),(19,2,'user1@email.com','\0\0','2014-07-09 15:35:58','success',NULL,1),(20,3,'user2@email.com','\0\0','2014-07-09 15:39:27','success',NULL,1),(21,2,'user1@email.com','\0\0','2014-07-11 07:50:48','success',NULL,1),(22,3,'user2@email.com','\0\0','2014-07-11 08:03:53','success',NULL,1),(23,1,'admin@email.com','\0\0','2014-07-13 08:10:23','success',NULL,1),(24,2,'user1@email.com','\0\0','2014-07-13 09:00:52','success',NULL,1),(25,3,'user2@email.com','\0\0','2014-07-13 09:01:10','success',NULL,1),(26,4,'user3@email.com','\0\0','2014-07-15 12:05:16','success',NULL,0),(27,5,'user4@email.com','\0\0','2014-07-15 12:10:40','success',NULL,0),(28,4,'user3@email.com','\0\0','2014-07-15 12:18:03','success',NULL,1),(29,2,'user1@email.com','\0\0','2014-07-16 16:42:14','success',NULL,1),(30,1,'admin@email.com','\0\0','2014-07-23 13:50:56','success',NULL,1),(31,3,'user2@email.com','\0\0','2014-07-23 15:41:05','success',NULL,1),(32,3,'user2@email.com','\0\0','2014-07-23 15:44:01','success',NULL,1),(33,3,'user2@email.com','\0\0','2014-07-23 15:44:51','success',NULL,1),(34,1,'admin@email.com','\0\0','2014-07-30 13:24:29','success',NULL,1),(35,1,'admin@email.com','\0\0','2014-07-31 10:43:18','success',NULL,1),(36,2,'user1@email.com','\0\0','2014-08-01 10:07:29','success',NULL,1),(37,3,'user2@email.com','\0\0','2014-08-01 10:15:33','success',NULL,1),(38,4,'user3@email.com','\0\0','2014-08-01 10:16:36','success',NULL,1),(39,5,'user4@email.com','\0\0','2014-08-01 10:17:04','success',NULL,1),(40,1,'admin@email.com','��/B','2014-08-01 12:14:01','success',NULL,1),(41,1,'admin@email.com','��/B','2014-08-01 12:16:24','success',NULL,1),(42,1,'admin@email.com','��/B','2014-08-01 12:32:32','success',NULL,1),(43,1,'admin@email.com','��/B','2014-08-01 12:34:15','success',NULL,1),(44,1,'admin@email.com','��/B','2014-08-01 12:52:42','success',NULL,1),(45,1,'admin@email.com','Xe�','2014-08-04 20:14:49','success',NULL,0),(46,1,'admin@email.com','Xe�','2014-08-05 10:32:19','success',NULL,1),(47,1,'admin@email.com','Xe�','2014-08-05 12:23:03','success',NULL,0),(48,1,'admin@email.com','Xe�','2014-08-06 14:30:48','success',NULL,1),(49,7,'markus@happetite.com','.~�','2014-08-17 09:53:38','success',NULL,0),(50,7,'markus@happetite.com','.~�','2014-08-17 11:31:47','success',NULL,1),(51,7,'markus@happetite.com','Mm�r','2014-08-19 07:55:08','success',NULL,1),(52,8,'markus.liechti@gmail.com','Mm�r','2014-08-20 08:32:54','success',NULL,0),(53,7,'markus@happetite.com','Mm�r','2014-08-20 08:55:49','success',NULL,0),(54,8,'markus.liechti@gmail.com','Mm�r','2014-08-20 09:04:36','success',NULL,0),(55,10,'markus.liechti@local.ch','Mm�r','2014-08-20 09:07:24','success',NULL,1),(56,1,'admin@email.com','Mm�r','2014-08-20 13:26:16','success',NULL,0),(57,8,'markus.liechti@gmail.com','Mm�r','2014-08-20 13:28:52','success',NULL,1),(58,7,'markus@happetite.com','Mm�r','2014-08-20 13:47:07','success',NULL,1),(59,10,'markus.liechti@local.ch','.~�','2014-08-20 20:02:24','success',NULL,1),(60,7,'markus@happetite.com','.~�','2014-08-20 20:03:32','success',NULL,1),(61,8,'markus.liechti@gmail.com','.~�','2014-08-20 20:04:13','success',NULL,1),(62,1,'admin@email.com','.~�','2014-08-20 20:32:10','success',NULL,1),(63,1,'admin@email.com','��/B','2014-08-26 13:19:26','success',NULL,1),(64,1,'admin@email.com','��/B','2014-08-26 13:45:44','success',NULL,1),(65,1,'admin@email.com','��/B','2014-08-27 08:43:39','success',NULL,1),(66,1,'admin@email.com','��/B','2014-08-28 09:08:09','success',NULL,1),(67,1,'admin@email.com','��/B','2014-09-02 08:51:54','success',NULL,0),(68,1,'admin@email.com','��/B','2014-09-02 17:40:51','success',NULL,1),(69,1,'admin@email.com','Xe�','2014-09-02 21:46:32','success',NULL,0),(70,1,'admin@email.com','Xe�','2014-09-02 21:56:15','success',NULL,0),(71,1,'admin@email.com','Xe�','2014-09-02 21:59:15','success',NULL,0),(72,1,'admin@email.com','Xe�','2014-09-02 22:02:36','success',NULL,0),(73,1,'admin@email.com','Xe�','2014-09-02 22:22:17','success',NULL,0),(74,1,'admin@email.com','Xe�','2014-09-02 22:24:39','success',NULL,0),(75,1,'admin@email.com','��/B','2014-09-03 07:18:15','success',NULL,1),(76,1,'admin@email.com','��/B','2014-09-03 07:35:47','success',NULL,1),(77,1,'admin@email.com','��/B','2014-09-03 07:50:15','success',NULL,1),(78,1,'admin@email.com','��/B','2014-09-03 08:04:49','success',NULL,1),(79,1,'admin@email.com','��/B','2014-09-03 08:14:28','success',NULL,0),(80,1,'admin@email.com','��/B','2014-09-03 08:17:26','success',NULL,0),(81,1,'admin@email.com','��/B','2014-09-03 08:19:47','success',NULL,0),(82,1,'admin@email.com','��/B','2014-09-03 08:25:44','success',NULL,1),(83,1,'admin@email.com','Xe�','2014-09-03 09:42:50','success',NULL,1),(84,1,'admin@email.com','��/B','2014-09-03 10:22:18','success',NULL,1),(85,1,'admin@email.com','��/B','2014-09-03 12:06:10','success',NULL,1),(86,1,'admin@email.com','��/B','2014-09-03 13:42:26','success',NULL,1),(87,9,'reto.spescha@gmail.com','��$','2014-09-13 22:07:12','success',NULL,0),(88,11,'reto.spescha@zurichna.com','��$','2014-09-13 22:50:46','success',NULL,0),(89,9,'reto.spescha@gmail.com','��$','2014-09-13 22:51:24','success',NULL,1),(90,9,'reto.spescha@gmail.com','l��','2014-09-14 22:58:25','success',NULL,1),(91,11,'reto.spescha@zurichna.com','l��','2014-09-14 23:02:58','success',NULL,0),(92,11,'reto.spescha@zurichna.com','l��','2014-09-14 23:06:19','success',NULL,0),(93,9,'reto.spescha@gmail.com','l��','2014-09-14 23:07:12','success',NULL,0),(94,11,'reto.spescha@zurichna.com','l��','2014-09-14 23:07:39','success',NULL,1),(95,NULL,'reto@happetite.com','l��','2014-09-14 23:22:14','no-member',NULL,0),(96,1,'admin@email.com','l��','2014-09-15 00:07:14','success',NULL,1),(97,7,'markus@happetite.com','.~�','2014-09-16 19:35:49','success',NULL,0),(98,7,'markus@happetite.com','.~�','2014-09-16 19:38:05','success',NULL,1),(99,NULL,'markus.liechti@local.ch','.~�','2014-09-16 20:10:36','no-member',NULL,0),(100,NULL,'markus.liechti@local.ch','.~�','2014-09-16 20:10:43','no-member',NULL,0),(101,8,'markus.liechti@gmail.com','.~�','2014-09-16 20:11:06','success',NULL,1),(102,1,'admin@email.com','.~�','2014-09-16 20:20:52','success',NULL,1),(103,8,'markus.liechti@gmail.com','.~�','2014-09-17 21:40:13','success',NULL,1),(104,8,'markus.liechti@gmail.com','.~�','2014-09-17 22:03:15','success',NULL,1),(105,NULL,'markus.liechti@local.ch','.~�','2014-09-17 22:32:56','no-member',NULL,0),(106,1,'admin@email.com','.~�','2014-09-18 20:41:22','success',NULL,0),(107,13,'markus.liechti@local.ch','.~�','2014-09-18 20:47:51','success',NULL,1),(108,NULL,'admin@newrosoftdev.com','��/B','2014-10-01 13:19:20','no-member',NULL,0),(109,1,'admin@email.com','��/B','2014-10-02 11:56:59','success',NULL,1),(110,1,'admin@email.com','��/B','2014-10-02 12:42:38','success',NULL,1),(111,1,'admin@email.com','��/B','2014-10-02 12:42:46','success',NULL,1),(112,1,'admin@email.com','��/B','2014-10-02 12:49:34','success',NULL,1),(113,1,'admin@email.com','��/B','2014-10-03 11:18:16','success',NULL,1),(114,1,'admin@email.com','��/B','2014-10-03 11:47:09','success',NULL,1),(115,1,'admin@email.com','��/B','2014-10-06 09:58:34','success',NULL,1),(116,1,'admin@email.com','��/B','2014-10-08 13:39:39','success',NULL,1),(117,1,'admin@email.com','��/B','2014-10-08 13:55:21','success',NULL,1),(118,1,'admin@email.com','��/B','2014-10-09 08:18:07','success',NULL,1),(119,1,'admin@email.com','��/B','2014-10-09 14:22:23','success',NULL,1),(120,7,'markus@happetite.com','.~�','2014-10-09 19:44:36','success',NULL,1),(121,8,'markus.liechti@gmail.com','Mm�r','2014-10-10 15:15:51','success',NULL,1),(122,NULL,'admin@newrosoftdev.com','��/B','2014-10-29 12:53:06','no-member',NULL,0),(123,1,'admin@email.com','��/B','2014-10-29 12:53:20','success',NULL,1),(124,7,'markus@happetite.com','.~�','2014-11-04 22:35:43','success',NULL,1),(125,1,'admin@email.com','��/B','2014-11-05 13:25:55','success',NULL,0),(126,1,'admin@email.com','��/B','2014-11-05 13:28:50','success',NULL,1);
/*!40000 ALTER TABLE `engine4_user_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_membership`
--

DROP TABLE IF EXISTS `engine4_user_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_membership`
--

LOCK TABLES `engine4_user_membership` WRITE;
/*!40000 ALTER TABLE `engine4_user_membership` DISABLE KEYS */;
INSERT INTO `engine4_user_membership` VALUES (7,13,0,1,0,NULL,NULL),(13,7,0,0,1,NULL,NULL);
/*!40000 ALTER TABLE `engine4_user_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_online`
--

DROP TABLE IF EXISTS `engine4_user_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_online` (
  `ip` varbinary(16) NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `active` datetime NOT NULL,
  PRIMARY KEY (`ip`,`user_id`),
  KEY `LOOKUP` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_online`
--

LOCK TABLES `engine4_user_online` WRITE;
/*!40000 ALTER TABLE `engine4_user_online` DISABLE KEYS */;
INSERT INTO `engine4_user_online` VALUES ('%9�',0,'2014-10-10 15:50:07'),('Mm�r',8,'2014-10-10 15:50:07'),('��/B',0,'2014-10-29 12:53:20'),('��/B',1,'2014-10-29 13:20:31'),('.~�',0,'2014-11-04 22:35:42'),('.~�',7,'2014-11-04 22:52:32');
/*!40000 ALTER TABLE `engine4_user_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_settings`
--

DROP TABLE IF EXISTS `engine4_user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_settings` (
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_settings`
--

LOCK TABLES `engine4_user_settings` WRITE;
/*!40000 ALTER TABLE `engine4_user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_signup`
--

DROP TABLE IF EXISTS `engine4_user_signup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_signup` (
  `signup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`signup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_signup`
--

LOCK TABLES `engine4_user_signup` WRITE;
/*!40000 ALTER TABLE `engine4_user_signup` DISABLE KEYS */;
INSERT INTO `engine4_user_signup` VALUES (1,'User_Plugin_Signup_Account',1,1),(2,'User_Plugin_Signup_Fields',2,1),(3,'User_Plugin_Signup_Photo',3,1),(4,'User_Plugin_Signup_Invite',4,0),(5,'Payment_Plugin_Signup_Subscription',0,0);
/*!40000 ALTER TABLE `engine4_user_signup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_twitter`
--

DROP TABLE IF EXISTS `engine4_user_twitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_twitter` (
  `user_id` int(10) unsigned NOT NULL,
  `twitter_uid` bigint(20) unsigned NOT NULL,
  `twitter_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twitter_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `twitter_uid` (`twitter_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_twitter`
--

LOCK TABLES `engine4_user_twitter` WRITE;
/*!40000 ALTER TABLE `engine4_user_twitter` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_twitter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_user_verify`
--

DROP TABLE IF EXISTS `engine4_user_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_user_verify` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_user_verify`
--

LOCK TABLES `engine4_user_verify` WRITE;
/*!40000 ALTER TABLE `engine4_user_verify` DISABLE KEYS */;
/*!40000 ALTER TABLE `engine4_user_verify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine4_users`
--

DROP TABLE IF EXISTS `engine4_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engine4_users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_unicode_ci,
  `status_date` datetime DEFAULT NULL,
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `salt` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'auto',
  `language` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'en_US',
  `timezone` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `show_profileviewers` tinyint(1) NOT NULL DEFAULT '1',
  `level_id` int(11) unsigned NOT NULL,
  `invites_used` int(11) unsigned NOT NULL DEFAULT '0',
  `extra_invites` int(11) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `creation_ip` varbinary(16) NOT NULL,
  `modified_date` datetime NOT NULL,
  `lastlogin_date` datetime DEFAULT NULL,
  `lastlogin_ip` varbinary(16) DEFAULT NULL,
  `update_date` int(11) DEFAULT NULL,
  `member_count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `EMAIL` (`email`),
  UNIQUE KEY `USERNAME` (`username`),
  KEY `MEMBER_COUNT` (`member_count`),
  KEY `CREATION_DATE` (`creation_date`),
  KEY `search` (`search`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine4_users`
--

LOCK TABLES `engine4_users` WRITE;
/*!40000 ALTER TABLE `engine4_users` DISABLE KEYS */;
INSERT INTO `engine4_users` VALUES (1,'admin@email.com','admin','First Last',0,NULL,NULL,'b488a31f3c0857edf4679d84d7756d71','6649683','auto','en_US','Europe/London',1,1,1,0,0,1,1,1,'2014-06-17 07:43:34','2130706433','2014-11-05 13:27:30','2014-11-05 13:28:50','��/B',NULL,0,3),(2,'user1@email.com','user1','user 1',0,NULL,NULL,'04f9da4d5876944f389979abb09e8f64','4829887','English','English','US/Pacific',1,1,4,0,0,1,1,1,'2014-06-23 08:48:37','\0\0','2014-07-14 14:05:06','2014-08-01 10:07:29','\0\0',NULL,0,2),(3,'user2@email.com','user2','user 2',0,NULL,NULL,'01ce893cfaf1b08f7aec02a1425a32a2','2281376','English','English','US/Pacific',1,1,4,0,0,1,1,1,'2014-06-23 08:48:43','\0\0','2014-06-23 08:48:43','2014-08-01 10:15:33','\0\0',NULL,0,1),(4,'user3@email.com','user3','user 3',0,NULL,NULL,'e6634fa039e365330e66e74035bc401a','4835821','English','English','US/Pacific',1,1,4,0,0,1,1,1,'2014-06-23 08:48:49','\0\0','2014-06-23 08:48:49','2014-08-01 10:16:36','\0\0',NULL,0,0),(7,'markus@happetite.com','Jokaero','Markus Liechti',29,NULL,NULL,'ddb8f9ce78625d03714e546ffe57ab91','4377920','de_CH','English','Europe/Berlin',1,1,4,0,0,1,1,1,'2014-08-17 09:41:19','.~�','2014-08-20 20:07:40','2014-11-04 22:35:43','.~�',NULL,0,3),(8,'markus.liechti@gmail.com','Hulk','Hulk Hogan',37,NULL,NULL,'0870ebbdd13c3021f589870c2d666aa1','2646287','English','English','Europe/Berlin',1,1,4,0,0,1,1,1,'2014-08-17 11:28:45','.~�','2014-08-20 09:14:47','2014-10-10 15:15:51','Mm�r',NULL,0,5),(9,'reto.spescha@gmail.com','reto','Reto Spescha',41,NULL,NULL,'46e76757c6d357875924c369a6340fc9','5063979','English','English','Europe/Athens',1,1,4,0,0,1,1,1,'2014-08-19 23:09:11','��$','2014-08-19 23:09:42','2014-09-14 23:07:12','l��',NULL,0,5),(11,'reto.spescha@zurichna.com','PeterNorth','Peter North',73,NULL,NULL,'76fe5e067ca487c625c61deed19c0757','4787335','English','English','Europe/Athens',1,1,4,0,0,1,1,1,'2014-09-13 22:11:23','��$','2014-09-14 23:57:31','2014-09-14 23:07:39','l��',NULL,0,4),(12,'reto@happetite.com','retohappy','reto happetite',85,NULL,NULL,'763b2445ee117a12a87c571c2c4e4d70','4624861','English','English','Europe/Athens',1,1,4,0,0,1,1,1,'2014-09-14 23:24:19','l��','2014-09-14 23:24:19','2014-09-14 23:24:19','l��',NULL,0,0),(13,'markus.liechti@local.ch','local','Markus Local',93,NULL,NULL,'08e8945f83bfd2ea0986d59ceabfb4b1','4136038','en','en','Europe/Athens',1,1,4,0,0,1,1,1,'2014-09-17 22:33:36','.~�','2014-09-17 22:33:37','2014-09-18 20:47:51','.~�',NULL,0,6);
/*!40000 ALTER TABLE `engine4_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-01 16:23:23
