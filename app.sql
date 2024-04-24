-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: Apr 24, 2024 at 11:42 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `app`
--

-- --------------------------------------------------------

--
-- Table structure for table `commentary`
--

DROP TABLE IF EXISTS `commentary`;
CREATE TABLE IF NOT EXISTS `commentary` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUserComm` int(11) NOT NULL,
  `idPostComm` int(11) DEFAULT NULL,
  `comm` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_idUserComm` (`idUserComm`),
  KEY `fk_idPostComm` (`idPostComm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
CREATE TABLE IF NOT EXISTS `favorites` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idPostLike` int(11) DEFAULT NULL,
  `idUserLike` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_idUserlike` (`idUserLike`),
  KEY `fk_idPostLike` (`idPostLike`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ingredientc`
--

DROP TABLE IF EXISTS `ingredientc`;
CREATE TABLE IF NOT EXISTS `ingredientc` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idPostIngredient` int(11) DEFAULT NULL,
  `ingrediente` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_postIngredient` (`idPostIngredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `passwordc`
--

DROP TABLE IF EXISTS `passwordc`;
CREATE TABLE IF NOT EXISTS `passwordc` (
  `id` int(11) NOT NULL,
  `idUserC` int(11) DEFAULT NULL,
  `pass` varchar(70) NOT NULL,
  `preguntaSecreta` varchar(80) NOT NULL,
  `respuestaSecreta` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user` (`idUserC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `picc`
--

DROP TABLE IF EXISTS `picc`;
CREATE TABLE IF NOT EXISTS `picc` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `noPic` int(11) NOT NULL,
  `url` varchar(150) NOT NULL,
  `idPostPic` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_postPicture` (`idPostPic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `postc`
--

DROP TABLE IF EXISTS `postc`;
CREATE TABLE IF NOT EXISTS `postc` (
  `idP` int(11) NOT NULL,
  `idUserSender` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `category` varchar(30) NOT NULL,
  PRIMARY KEY (`idP`),
  KEY `fk_postC` (`idUserSender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `postc`
--
DROP TRIGGER IF EXISTS `addPlusOneNoPost`;
DELIMITER $$
CREATE TRIGGER `addPlusOneNoPost` AFTER INSERT ON `postc` FOR EACH ROW BEGIN
	UPDATE userC
    SET noPost = noPost + 1
    WHERE id = NEW.idUserSender;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `stepc`
--

DROP TABLE IF EXISTS `stepc`;
CREATE TABLE IF NOT EXISTS `stepc` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idPost` int(11) DEFAULT NULL,
  `step` varchar(50) DEFAULT NULL,
  `noStep` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_postStep` (`idPost`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userc`
--

DROP TABLE IF EXISTS `userc`;
CREATE TABLE IF NOT EXISTS `userc` (
  `id` int(11) NOT NULL,
  `email` varchar(60) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(120) NOT NULL,
  `socialNet1` varchar(60) DEFAULT NULL,
  `socialNet2` varchar(60) DEFAULT NULL,
  `profilePicUrl` varchar(150) DEFAULT NULL,
  `noPost` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commentary`
--
ALTER TABLE `commentary`
  ADD CONSTRAINT `fk_idPostComm` FOREIGN KEY (`idPostComm`) REFERENCES `postc` (`idP`),
  ADD CONSTRAINT `fk_idUserComm` FOREIGN KEY (`idUserComm`) REFERENCES `userc` (`id`);

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_idPostLike` FOREIGN KEY (`idPostLike`) REFERENCES `postc` (`idP`),
  ADD CONSTRAINT `fk_idUserlike` FOREIGN KEY (`idUserLike`) REFERENCES `userc` (`id`);

--
-- Constraints for table `ingredientc`
--
ALTER TABLE `ingredientc`
  ADD CONSTRAINT `fk_postIngredient` FOREIGN KEY (`idPostIngredient`) REFERENCES `postc` (`idP`);

--
-- Constraints for table `passwordc`
--
ALTER TABLE `passwordc`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`idUserC`) REFERENCES `userc` (`id`);

--
-- Constraints for table `picc`
--
ALTER TABLE `picc`
  ADD CONSTRAINT `fk_postPicture` FOREIGN KEY (`idPostPic`) REFERENCES `postc` (`idP`);

--
-- Constraints for table `postc`
--
ALTER TABLE `postc`
  ADD CONSTRAINT `fk_postC` FOREIGN KEY (`idUserSender`) REFERENCES `userc` (`id`);

--
-- Constraints for table `stepc`
--
ALTER TABLE `stepc`
  ADD CONSTRAINT `fk_postStep` FOREIGN KEY (`idPost`) REFERENCES `postc` (`idP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
