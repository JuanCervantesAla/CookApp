-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-05-2024 a las 05:40:02
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cookapp`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `commentary`
--

CREATE TABLE `commentary` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idUserComm` int(11) NOT NULL,
  `idPostComm` int(11) DEFAULT NULL,
  `comm` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favorites`
--

CREATE TABLE `favorites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `idPostLike` int(11) DEFAULT NULL,
  `idUserLike` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingredientc`
--

CREATE TABLE `ingredientc` (
  `id` int(11) UNSIGNED NOT NULL,
  `idPostIngredient` int(11) DEFAULT NULL,
  `ingrediente` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `passwordc`
--

CREATE TABLE `passwordc` (
  `id` int(11) NOT NULL,
  `idUserC` int(11) DEFAULT NULL,
  `pass` varchar(70) NOT NULL,
  `preguntaSecreta` varchar(80) NOT NULL,
  `respuestaSecreta` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `passwordc`
--

INSERT INTO `passwordc` (`id`, `idUserC`, `pass`, `preguntaSecreta`, `respuestaSecreta`) VALUES
(1, NULL, '$2a$08$mFG2M6wp7tngcXj6tN.pierU3zULOcKiL8f3UbbSzMrIfc260nUJC', 'pregunta secreta', 'respuesta secreta'),
(2, NULL, '$2a$08$F3W4E7nqjaszvl3ZHRlS7eO19jghdv4XCinmWhJXIJWgIRoVCkJtK', 'pregunta secreta2', 'respuesta secreta2'),
(3, NULL, '$2a$08$9nuS2knPWZsJKD2X5u.jjephN/.VbHOGDYB7YxS4ybyCx0G9ft6Si', 'pregunta secreta3', 'respuesta secreta3'),
(4, NULL, '$2a$08$5vxNvseNOJaCUiS/C/YlVucEIfLQ3tQ8eQJP3/rPO6.4WUpTUTsl6', 'pregunta secreta4', 'respuesta secreta4'),
(5, 6, '$2a$08$QeHktiX8DAfyEfC7BUKRTefeH.KJqmNO3XACGjxR/QZ98PdH/b2o.', 'dos', 'dos'),
(6, 7, '$2a$08$cCB52/RL58gRVf.5JoX/3e31E74xYT5uhVoknlUwhDZL73KJ4dl7i', '¿Cual es el mejor juego?', 'Minecraft'),
(7, 8, '$2a$08$0wLkvf3No/o/WrhfATD3peIc8jgPumaVlwbK5ZFPsRbMEH8nUH0MW', 'ahorasi', 'ahorasi'),
(8, 9, '$2a$08$Bo/OBDp5BPewEZ8gfJmrU.MiXR0.o4XHJv6Qf142Z9VVfyY/DdTge', '', ''),
(9, 12, '$2a$08$SCEe254ro7ffd12fwqiBRuZsf3PGeXuWo3QlMIpXyIqC0QhAqAYYC', 'siu', 'siu');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `picc`
--

CREATE TABLE `picc` (
  `id` int(11) UNSIGNED NOT NULL,
  `noPic` int(11) NOT NULL,
  `url` varchar(150) NOT NULL,
  `idPostPic` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postc`
--

CREATE TABLE `postc` (
  `idP` int(11) NOT NULL,
  `idUserSender` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `category` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `postc`
--
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
-- Estructura de tabla para la tabla `stepc`
--

CREATE TABLE `stepc` (
  `id` int(11) UNSIGNED NOT NULL,
  `idPost` int(11) DEFAULT NULL,
  `step` varchar(50) DEFAULT NULL,
  `noStep` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `userc`
--

CREATE TABLE `userc` (
  `id` int(11) NOT NULL,
  `email` varchar(60) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(120) NOT NULL,
  `socialNet1` varchar(60) DEFAULT NULL,
  `socialNet2` varchar(60) DEFAULT NULL,
  `profilePicUrl` varchar(150) DEFAULT NULL,
  `noPost` int(11) NOT NULL,
  `age` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `userc`
--

INSERT INTO `userc` (`id`, `email`, `name`, `description`, `socialNet1`, `socialNet2`, `profilePicUrl`, `noPost`, `age`) VALUES
(1, 'prueba@gmail.com', 'prueba', 'descripcion prueba', 'red social uno prueba', 'red social dos prueba', 'url imagen prueba', 1, 1),
(2, 'algo@algo.com', 'Manuel', 'Genio', NULL, NULL, NULL, 0, 20),
(3, 'algo@algo2.com', 'Manuel2', 'Genio2', NULL, NULL, NULL, 0, 202),
(4, 'algo@algo3.com', 'Manuel3', 'Genio3', NULL, NULL, NULL, 0, 203),
(5, 'algo@algo4.com', 'Manuel4', 'Genio4', NULL, NULL, NULL, 0, 204),
(6, 'dos@dos.com', 'dos', 'dos', NULL, NULL, NULL, 0, 2),
(7, 'serio@serio.gmail.com', 'Alejandro', 'El mejor', NULL, NULL, NULL, 0, 20),
(8, 'ahorasi@gmail.com', 'ahorasi', 'ahorasi', NULL, NULL, NULL, 0, 21),
(9, '', '', '', NULL, NULL, NULL, 0, 0),
(12, 'cr7@gmail.com', 'cristiano', 'futbolista', NULL, NULL, 'img/authors/manuel.jpg', 0, 35);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `commentary`
--
ALTER TABLE `commentary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idUserComm` (`idUserComm`),
  ADD KEY `fk_idPostComm` (`idPostComm`);

--
-- Indices de la tabla `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idUserlike` (`idUserLike`),
  ADD KEY `fk_idPostLike` (`idPostLike`);

--
-- Indices de la tabla `ingredientc`
--
ALTER TABLE `ingredientc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_postIngredient` (`idPostIngredient`);

--
-- Indices de la tabla `passwordc`
--
ALTER TABLE `passwordc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`idUserC`);

--
-- Indices de la tabla `picc`
--
ALTER TABLE `picc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_postPicture` (`idPostPic`);

--
-- Indices de la tabla `postc`
--
ALTER TABLE `postc`
  ADD PRIMARY KEY (`idP`),
  ADD KEY `fk_postC` (`idUserSender`);

--
-- Indices de la tabla `stepc`
--
ALTER TABLE `stepc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_postStep` (`idPost`);

--
-- Indices de la tabla `userc`
--
ALTER TABLE `userc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `commentary`
--
ALTER TABLE `commentary`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ingredientc`
--
ALTER TABLE `ingredientc`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `passwordc`
--
ALTER TABLE `passwordc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `picc`
--
ALTER TABLE `picc`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `postc`
--
ALTER TABLE `postc`
  MODIFY `idP` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `stepc`
--
ALTER TABLE `stepc`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `userc`
--
ALTER TABLE `userc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `commentary`
--
ALTER TABLE `commentary`
  ADD CONSTRAINT `fk_idPostComm` FOREIGN KEY (`idPostComm`) REFERENCES `postc` (`idP`),
  ADD CONSTRAINT `fk_idUserComm` FOREIGN KEY (`idUserComm`) REFERENCES `userc` (`id`);

--
-- Filtros para la tabla `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_idPostLike` FOREIGN KEY (`idPostLike`) REFERENCES `postc` (`idP`),
  ADD CONSTRAINT `fk_idUserlike` FOREIGN KEY (`idUserLike`) REFERENCES `userc` (`id`);

--
-- Filtros para la tabla `ingredientc`
--
ALTER TABLE `ingredientc`
  ADD CONSTRAINT `fk_postIngredient` FOREIGN KEY (`idPostIngredient`) REFERENCES `postc` (`idP`);

--
-- Filtros para la tabla `passwordc`
--
ALTER TABLE `passwordc`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`idUserC`) REFERENCES `userc` (`id`);

--
-- Filtros para la tabla `picc`
--
ALTER TABLE `picc`
  ADD CONSTRAINT `fk_postPicture` FOREIGN KEY (`idPostPic`) REFERENCES `postc` (`idP`);

--
-- Filtros para la tabla `postc`
--
ALTER TABLE `postc`
  ADD CONSTRAINT `fk_postC` FOREIGN KEY (`idUserSender`) REFERENCES `userc` (`id`);

--
-- Filtros para la tabla `stepc`
--
ALTER TABLE `stepc`
  ADD CONSTRAINT `fk_postStep` FOREIGN KEY (`idPost`) REFERENCES `postc` (`idP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
