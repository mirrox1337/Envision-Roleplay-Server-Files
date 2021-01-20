USE `oldfellas`;

CREATE TABLE `user_billings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `amount` int(8) DEFAULT NULL,
  `sender` varchar(60) DEFAULT NULL,
  `receiverName` varchar(255) NOT NULL,
  `senderName` varchar(255) DEFAULT NULL,
  `jobb` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=LATIN1;
