-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.38-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table es_extended.user_calls
DROP TABLE IF EXISTS `user_calls`;
CREATE TABLE IF NOT EXISTS `user_calls` (
  `identifier` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL,
  `date` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL,
  `caller` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL,
  `number` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL,
  `prefix` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL,
  `answered` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*!40000 ALTER TABLE `user_calls` ENABLE KEYS */;

-- Dumping structure for table es_extended.user_messages
DROP TABLE IF EXISTS `user_messages`;
CREATE TABLE IF NOT EXISTS `user_messages` (
  `identifier` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `reciever` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `date` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `sender` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `message` varchar(360) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
