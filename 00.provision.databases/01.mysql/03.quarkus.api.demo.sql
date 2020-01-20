#DROP THE DATABASE
DROP DATABASE IF EXISTS `db_quarkus_jvm`;
DROP DATABASE IF EXISTS `db_quarkus_native`;
DROP DATABASE IF EXISTS `db_springboot`;

#CREATE THE DATABASE & TABLES
CREATE DATABASE `db_quarkus_jvm`;
USE `db_quarkus_jvm`;
CREATE TABLE `ToDo` (
  `ID` int(11) NOT NULL,
  `IS_COMPLETE` varchar(255) DEFAULT NULL,
  `TASK_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB;
INSERT INTO db_quarkus_jvm.ToDo values ("1","Yes","Task in Quarkus JVM DB");

#CREATE THE DATABASE & TABLES
CREATE DATABASE `db_quarkus_native`;
USE `db_quarkus_native`;
CREATE TABLE `ToDo` (
  `ID` int(11) NOT NULL,
  `IS_COMPLETE` varchar(255) DEFAULT NULL,
  `TASK_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB;
INSERT INTO db_quarkus_native.ToDo values ("1","Yes","Task in Quarkus Native DB");

#CREATE THE DATABASE & TABLES
CREATE DATABASE `db_springboot`;
USE `db_springboot`;
CREATE TABLE `ToDo` (
  `ID` int(11) NOT NULL,
  `IS_COMPLETE` varchar(255) DEFAULT NULL,
  `TASK_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB;
INSERT INTO db_springboot.ToDo values ("1","Yes","Task in Spring DB");