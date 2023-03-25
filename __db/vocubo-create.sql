-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: vocubo
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `vocubo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `vocubo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `vocubo`;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `characters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `iso639_1` char(2) NOT NULL,
  `charx` char(1) NOT NULL,
  `idx` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iso639_1` (`iso639_1`),
  CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`iso639_1`) REFERENCES `languages` (`iso639_1`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dictionaries`
--

DROP TABLE IF EXISTS `dictionaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictionaries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `dictname` varchar(200) NOT NULL,
  `baselang` char(2) NOT NULL,
  `lang` char(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dictname` (`dictname`),
  KEY `baselang` (`baselang`),
  KEY `lang` (`lang`),
  CONSTRAINT `dictionaries_ibfk_1` FOREIGN KEY (`baselang`) REFERENCES `languages` (`iso639_1`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dictionaries_ibfk_2` FOREIGN KEY (`lang`) REFERENCES `languages` (`iso639_1`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dictionaries_tags`
--

DROP TABLE IF EXISTS `dictionaries_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictionaries_tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dictionaries_tags_xref`
--

DROP TABLE IF EXISTS `dictionaries_tags_xref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictionaries_tags_xref` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_dictionary` int unsigned NOT NULL,
  `id_tag` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_dictionary` (`id_dictionary`),
  KEY `id_tag` (`id_tag`),
  CONSTRAINT `dictionaries_tags_xref_ibfk_1` FOREIGN KEY (`id_dictionary`) REFERENCES `dictionaries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dictionaries_tags_xref_ibfk_2` FOREIGN KEY (`id_tag`) REFERENCES `dictionaries_tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `iso639_1` char(2) NOT NULL,
  `language_name` varchar(100) NOT NULL,
  `native_name` varchar(200) NOT NULL,
  PRIMARY KEY (`iso639_1`),
  KEY `language_name` (`language_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int unsigned NOT NULL,
  `session_id` text NOT NULL,
  `ts` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`(40)),
  KEY `id_user` (`id_user`),
  CONSTRAINT `logins_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `practice_log`
--

DROP TABLE IF EXISTS `practice_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int unsigned NOT NULL,
  `id_vocabulary` int unsigned NOT NULL,
  `result` tinyint unsigned NOT NULL,
  `wrong_answer` text,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `id_vocabulary` (`id_vocabulary`),
  CONSTRAINT `practice_log_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `practice_log_ibfk_2` FOREIGN KEY (`id_vocabulary`) REFERENCES `vocabulary` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `pw` char(40) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_dictionary`
--

DROP TABLE IF EXISTS `user_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_dictionary` (
  `id_user` int unsigned NOT NULL,
  `id_dictionary` int unsigned NOT NULL,
  `enabled` set('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id_user`,`id_dictionary`),
  KEY `id_dictionary` (`id_dictionary`),
  CONSTRAINT `user_dictionary_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  CONSTRAINT `user_dictionary_ibfk_2` FOREIGN KEY (`id_dictionary`) REFERENCES `dictionaries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_dictionaries`
--

DROP TABLE IF EXISTS `v_dictionaries`;
/*!50001 DROP VIEW IF EXISTS `v_dictionaries`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_dictionaries` AS SELECT 
 1 AS `id`,
 1 AS `id_user`,
 1 AS `dictname`,
 1 AS `baselang`,
 1 AS `baselang_long`,
 1 AS `lang`,
 1 AS `lang_long`,
 1 AS `enabled`,
 1 AS `tags`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_vocabulary_duplicates`
--

DROP TABLE IF EXISTS `v_vocabulary_duplicates`;
/*!50001 DROP VIEW IF EXISTS `v_vocabulary_duplicates`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_vocabulary_duplicates` AS SELECT 
 1 AS `id`,
 1 AS `id_dict`,
 1 AS `word_base`,
 1 AS `word_target`,
 1 AS `hints`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_vocabulary_enabled`
--

DROP TABLE IF EXISTS `v_vocabulary_enabled`;
/*!50001 DROP VIEW IF EXISTS `v_vocabulary_enabled`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_vocabulary_enabled` AS SELECT 
 1 AS `id`,
 1 AS `id_user`,
 1 AS `baselang`,
 1 AS `baselang_long`,
 1 AS `word_base`,
 1 AS `lang`,
 1 AS `lang_long`,
 1 AS `word_target`,
 1 AS `hints`,
 1 AS `count_log`,
 1 AS `correct_answers`,
 1 AS `percent_correct`,
 1 AS `enabled`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vocabulary`
--

DROP TABLE IF EXISTS `vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vocabulary` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_dict` int unsigned NOT NULL,
  `word_base` text NOT NULL,
  `word_target` text NOT NULL,
  `hints` text,
  `enabled` set('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`),
  KEY `word_base` (`word_base`(20)),
  KEY `word_target` (`word_target`(20)),
  KEY `id_dict` (`id_dict`),
  CONSTRAINT `vocabulary_ibfk_1` FOREIGN KEY (`id_dict`) REFERENCES `dictionaries` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=851 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `vocubo`
--

USE `vocubo`;

--
-- Final view structure for view `v_dictionaries`
--

/*!50001 DROP VIEW IF EXISTS `v_dictionaries`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_dictionaries` AS select `d`.`id` AS `id`,`du`.`id_user` AS `id_user`,`d`.`dictname` AS `dictname`,`d`.`baselang` AS `baselang`,`l1`.`language_name` AS `baselang_long`,`d`.`lang` AS `lang`,`l2`.`language_name` AS `lang_long`,`du`.`enabled` AS `enabled`,group_concat(`t`.`tag` separator ',') AS `tags` from (((((`dictionaries` `d` join `dictionaries_tags_xref` `x` on((`d`.`id` = `x`.`id_dictionary`))) join `dictionaries_tags` `t` on((`t`.`id` = `x`.`id_tag`))) join `languages` `l1` on((`d`.`baselang` = `l1`.`iso639_1`))) join `languages` `l2` on((`d`.`lang` = `l2`.`iso639_1`))) join `user_dictionary` `du` on((`du`.`id_dictionary` = `d`.`id`))) group by `du`.`id_user`,`d`.`dictname`,`d`.`baselang`,`d`.`lang` order by `du`.`id_user`,`d`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_vocabulary_duplicates`
--

/*!50001 DROP VIEW IF EXISTS `v_vocabulary_duplicates`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vocabulary_duplicates` AS select `a`.`id` AS `id`,`a`.`id_dict` AS `id_dict`,`a`.`word_base` AS `word_base`,`a`.`word_target` AS `word_target`,`a`.`hints` AS `hints` from (`vocabulary` `a` join (select `vocabulary`.`word_base` AS `word_base`,count(0) AS `cnt` from `vocabulary` group by `vocabulary`.`word_base` having (`cnt` > 1) order by `cnt` desc,`vocabulary`.`word_base`) `b` on((`a`.`word_base` = `b`.`word_base`))) order by `a`.`word_base`,`a`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_vocabulary_enabled`
--

/*!50001 DROP VIEW IF EXISTS `v_vocabulary_enabled`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mpopp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vocabulary_enabled` AS select `v`.`id` AS `id`,`du`.`id_user` AS `id_user`,`d`.`baselang` AS `baselang`,`l1`.`language_name` AS `baselang_long`,`v`.`word_base` AS `word_base`,`d`.`lang` AS `lang`,`l2`.`language_name` AS `lang_long`,`v`.`word_target` AS `word_target`,`v`.`hints` AS `hints`,count(`pl`.`result`) AS `count_log`,sum(`pl`.`result`) AS `correct_answers`,(floor((((sum(`pl`.`result`) / count(`pl`.`result`)) * 10000) + 0.5)) / 100) AS `percent_correct`,`v`.`enabled` AS `enabled` from (((((`vocabulary` `v` join `dictionaries` `d` on((`v`.`id_dict` = `d`.`id`))) join `languages` `l1` on((`d`.`baselang` = `l1`.`iso639_1`))) join `languages` `l2` on((`d`.`lang` = `l2`.`iso639_1`))) join `user_dictionary` `du` on((`du`.`id_dictionary` = `d`.`id`))) left join `practice_log` `pl` on(((`v`.`id` = `pl`.`id_vocabulary`) and (`du`.`id_user` = `pl`.`id_user`)))) where ((`du`.`enabled` = 'y') and (`v`.`enabled` = 'y')) group by `v`.`id`,`du`.`id_user`,`d`.`baselang`,`baselang_long`,`v`.`word_base`,`d`.`lang`,`lang_long`,`v`.`word_target`,`v`.`hints` order by `du`.`id_user`,`v`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-25 23:40:50
