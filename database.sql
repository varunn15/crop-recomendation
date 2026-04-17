-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: crop_recommendation
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user` (
  `user_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user`
--

LOCK TABLES `app_user` WRITE;
/*!40000 ALTER TABLE `app_user` DISABLE KEYS */;
INSERT INTO `app_user` VALUES (1,'Aarav','aarav@gmail.com','pass123'),(2,'Riya','riya@gmail.com','riya123'),(3,'Karan','karan@gmail.com','karan123'),(4,'Neha','neha@gmail.com','neha123'),(5,'Rahul','rahul@gmail.com','rahul123'),(6,'Priya','priya@gmail.com','priya123'),(7,'Aman','aman@gmail.com','aman123'),(8,'Sneha','sneha@gmail.com','sneha123'),(9,'Vikram','vikram@gmail.com','vikram123'),(10,'Anjali','anjali@gmail.com','anjali123');
/*!40000 ALTER TABLE `app_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crop`
--

DROP TABLE IF EXISTS `crop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop` (
  `crop_id` int NOT NULL,
  `crop_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`crop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop`
--

LOCK TABLES `crop` WRITE;
/*!40000 ALTER TABLE `crop` DISABLE KEYS */;
INSERT INTO `crop` VALUES (401,'Rice'),(402,'Wheat'),(403,'Maize'),(404,'Cotton'),(405,'Sugarcane'),(406,'Barley'),(407,'Soybean'),(408,'Millet'),(409,'Groundnut'),(410,'Pulses');
/*!40000 ALTER TABLE `crop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation` (
  `rec_id` int NOT NULL,
  `soil_id` int DEFAULT NULL,
  `weather_id` int DEFAULT NULL,
  `temperature` int DEFAULT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `soil_id` (`soil_id`),
  KEY `weather_id` (`weather_id`),
  CONSTRAINT `recommendation_ibfk_1` FOREIGN KEY (`soil_id`) REFERENCES `soil_data` (`soil_id`),
  CONSTRAINT `recommendation_ibfk_2` FOREIGN KEY (`weather_id`) REFERENCES `weather_data` (`weather_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation`
--

LOCK TABLES `recommendation` WRITE;
/*!40000 ALTER TABLE `recommendation` DISABLE KEYS */;
INSERT INTO `recommendation` VALUES (301,101,201,30),(302,102,202,28),(303,103,203,32),(304,104,204,29),(305,105,205,31),(306,106,206,27),(307,107,207,33),(308,108,208,30),(309,109,209,28),(310,110,210,31),(311,111,211,29),(312,112,212,32),(313,113,213,27),(314,114,214,33),(315,115,215,30),(316,116,216,28),(317,117,217,31),(318,118,218,29),(319,119,219,32),(320,120,220,27),(321,121,221,33),(322,122,222,30),(323,123,223,28),(324,124,224,31),(325,125,225,29),(326,126,226,32),(327,127,227,27),(328,128,228,33),(329,129,229,30),(330,130,230,28);
/*!40000 ALTER TABLE `recommendation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation_crop`
--

DROP TABLE IF EXISTS `recommendation_crop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation_crop` (
  `rec_id` int NOT NULL,
  `crop_id` int NOT NULL,
  PRIMARY KEY (`rec_id`,`crop_id`),
  KEY `crop_id` (`crop_id`),
  CONSTRAINT `recommendation_crop_ibfk_1` FOREIGN KEY (`rec_id`) REFERENCES `recommendation` (`rec_id`),
  CONSTRAINT `recommendation_crop_ibfk_2` FOREIGN KEY (`crop_id`) REFERENCES `crop` (`crop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation_crop`
--

LOCK TABLES `recommendation_crop` WRITE;
/*!40000 ALTER TABLE `recommendation_crop` DISABLE KEYS */;
INSERT INTO `recommendation_crop` VALUES (301,401),(310,401),(320,401),(330,401),(302,402),(311,402),(321,402),(301,403),(312,403),(322,403),(303,404),(313,404),(323,404),(304,405),(314,405),(324,405),(305,406),(315,406),(325,406),(306,407),(316,407),(326,407),(307,408),(317,408),(327,408),(308,409),(318,409),(328,409),(309,410),(319,410),(329,410);
/*!40000 ALTER TABLE `recommendation_crop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soil_data`
--

DROP TABLE IF EXISTS `soil_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `soil_data` (
  `soil_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `nitrogen` int DEFAULT NULL,
  `phosphorus` int DEFAULT NULL,
  `potassium` int DEFAULT NULL,
  `moisture` int DEFAULT NULL,
  PRIMARY KEY (`soil_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `soil_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soil_data`
--

LOCK TABLES `soil_data` WRITE;
/*!40000 ALTER TABLE `soil_data` DISABLE KEYS */;
INSERT INTO `soil_data` VALUES (101,1,45,30,45,60),(102,2,50,35,50,65),(103,3,60,40,60,70),(104,4,35,25,35,55),(105,5,55,45,55,68),(106,6,48,32,42,62),(107,7,52,36,44,66),(108,8,38,28,35,58),(109,9,62,48,55,72),(110,10,40,30,38,60),(111,1,46,31,41,61),(112,2,51,36,46,67),(113,3,61,41,51,71),(114,4,36,26,31,56),(115,5,56,46,51,69),(116,6,49,33,43,63),(117,7,53,37,45,67),(118,8,39,29,36,59),(119,9,63,49,56,73),(120,10,41,31,39,61),(121,1,47,32,42,62),(122,2,52,37,47,68),(123,3,62,42,52,72),(124,4,37,27,32,57),(125,5,57,47,52,70),(126,6,50,34,44,64),(127,7,54,38,46,68),(128,8,40,30,37,60),(129,9,64,50,57,74),(130,10,42,32,40,62);
/*!40000 ALTER TABLE `soil_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather_data`
--

DROP TABLE IF EXISTS `weather_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_data` (
  `weather_id` int NOT NULL,
  `temperature` int DEFAULT NULL,
  `humidity` int DEFAULT NULL,
  `rainfall` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`weather_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_data`
--

LOCK TABLES `weather_data` WRITE;
/*!40000 ALTER TABLE `weather_data` DISABLE KEYS */;
INSERT INTO `weather_data` VALUES (201,30,65,120,'2026-04-01'),(202,28,70,150,'2026-04-02'),(203,32,60,100,'2026-04-03'),(204,29,68,130,'2026-04-04'),(205,31,62,110,'2026-04-05'),(206,27,75,160,'2026-04-06'),(207,33,58,90,'2026-04-07'),(208,30,66,125,'2026-04-08'),(209,28,72,140,'2026-04-09'),(210,31,64,115,'2026-04-10'),(211,29,67,135,'2026-04-11'),(212,32,61,105,'2026-04-12'),(213,27,74,155,'2026-04-13'),(214,33,59,95,'2026-04-14'),(215,30,65,120,'2026-04-15'),(216,28,71,145,'2026-04-16'),(217,31,63,110,'2026-04-17'),(218,29,69,132,'2026-04-18'),(219,32,60,100,'2026-04-19'),(220,27,76,165,'2026-04-20'),(221,33,57,85,'2026-04-21'),(222,30,66,125,'2026-04-22'),(223,28,73,148,'2026-04-23'),(224,31,64,115,'2026-04-24'),(225,29,68,130,'2026-04-25'),(226,32,62,108,'2026-04-26'),(227,27,75,158,'2026-04-27'),(228,33,59,92,'2026-04-28'),(229,30,65,122,'2026-04-29'),(230,28,70,140,'2026-04-30');
/*!40000 ALTER TABLE `weather_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-17 18:01:29
