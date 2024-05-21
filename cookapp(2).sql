-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-05-2024 a las 00:22:46
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
-- Estructura de tabla para la tabla `comm`
--

CREATE TABLE `comm` (
  `id` int(11) NOT NULL,
  `idUserComm` int(11) NOT NULL,
  `idPostComm` int(11) NOT NULL,
  `comm` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comm`
--

INSERT INTO `comm` (`id`, `idUserComm`, `idPostComm`, `comm`) VALUES
(1, 12, 51, 'prueba'),
(2, 12, 44, 'Muy rica tu receta, yo le agregue salchichas y tocino'),
(3, 14, 44, 'Buena receta, perfecta para dias con frio, 100% recomendada');

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
-- Estructura de tabla para la tabla `like`
--

CREATE TABLE `like` (
  `idLike` int(11) NOT NULL,
  `idUserLike` int(11) NOT NULL,
  `idRecipeLike` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `like`
--

INSERT INTO `like` (`idLike`, `idUserLike`, `idRecipeLike`) VALUES
(6, 12, 48),
(11, 12, 51),
(12, 12, 50),
(14, 14, 47);

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
(9, 12, '$2a$08$SCEe254ro7ffd12fwqiBRuZsf3PGeXuWo3QlMIpXyIqC0QhAqAYYC', 'siu', 'siu'),
(10, 13, '$2a$08$TrM/9IvEwTaitfaaTZ4hlurVypc8qbpvYschCL8dHrxCHsfw8N71.', '', 'secu 1'),
(11, 14, '$2a$08$GvNrK34sB0Z92lLfce2uSOAiYWdhzDGT15tdenQosklBr5BjAhIke', 'Como se llamaba tu escuela de secundaria?', 'la cq'),
(12, 15, '$2a$08$NLts9m9H4ODCJq0P/ykf6er8GHc1vfgRTYTXlLjWCZ5TwFv96Dfi6', 'Que nombre tenia tu primera mascota?', 'gary'),
(13, 20, '$2a$08$SKKm3eHciLvSdtB2bZv1B..rXfhsKWjEI/bNi1l9eDwjpAOdLoFAC', 'Que nombre tenia tu primera mascota?', 'Gary'),
(14, 22, '$2a$08$MhRW5Dhaa/6I.cabnzzSB.CYo6436EWpVA/6gezdks6Ic/oK8a66y', 'Como se llamaba tu escuela de secundaria?', 'ahora si prueba'),
(15, 23, '$2a$08$NPNWLOlKXOGOdXyks/z59ODuYa3UlUsE0SjPWStfY8nTHn2OyjE36', 'Cual es el segundo apellido de tu madre?', 'moreno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recipe`
--

CREATE TABLE `recipe` (
  `idRecipe` int(11) NOT NULL,
  `titleRecipe` varchar(120) NOT NULL,
  `categoryRecipe` varchar(120) NOT NULL,
  `stepsRecipe` varchar(1000) NOT NULL,
  `ingredientsRecipe` varchar(1000) NOT NULL,
  `imgTitleRecipe` varchar(120) DEFAULT NULL,
  `imgStepsRecipe` varchar(1000) DEFAULT NULL,
  `idUserSenderRecipe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recipe`
--

INSERT INTO `recipe` (`idRecipe`, `titleRecipe`, `categoryRecipe`, `stepsRecipe`, `ingredientsRecipe`, `imgTitleRecipe`, `imgStepsRecipe`, `idUserSenderRecipe`) VALUES
(40, 'Espinazo de cerdo en salsa roja', 'Carnes', '1.  Licúa los jitomates, el ajo, la cebolla, los chiles, el agua y el Concentrado de Tomate con Pollo CONSOMATE®.\r,2.  Calienta el aceite, vierte lo que licuaste y cocina hasta que espese ligeramente moviendo ocasionalmente.\r,3.  Añade el espinazo, las verdolagas, cocina por 3 minutos más y ofrece.', '4 Jitomates cocidos\r,1 Diente de ajo cocido\r,1/4 De cebolla cocida\r,2 Chiles serranos cocidos\r,2 Tazas de agua\r,2 Cubos de Concentrado de Tomate con Pollo CONSOMATE®\r,1 Cucharada de aceite vegetal\r,400 g De espinazo de cerdo cocido y frito\r,2 Tazas de verdolagas cocidas y escurridas', 'uploads\\title_pics_recipe\\image_title_recipe_8_219503092.jpg', '', 8),
(41, 'Gelatina de chocomango', 'Postres', '1.  Para la gelatina de chocolate, licúa el Chocolate ABUELITA® con la Leche Evaporada CARNATION® CLAVEL® y el agua, con la licuadora encendida agrega la grenetina. Vierte la preparación en un molde para gelatina ligeramente engrasado y refrigera hasta que cuaje ligeramente.\r,2.  Para la gelatina de mango, mezcla el agua caliente con la gelatina sabor mango, deja enfriar sin que cuaje y vierte sobre la gelatina de chocolate. Refrigera hasta que cuaje completamente.\r,3.  Desmolda la gelatina y disfruta.', '2 Tabletas de Chocolate para mesa ABUELITA® ralladas (90 g c/u)\r,1 Lata de Leche Evaporada CARNATION® CLAVEL®\r,2 Tazas de agua\r,3 Sobres de grenetina 7g c/u hidratados en 1 taza de agua disueltos a baño maría\r,3 Tazas de agua caliente\r,1 Sobre de grenetina sabor mango (120 g)', 'uploads\\title_pics_recipe\\image_title_recipe_8_829997564.jpg', '', 8),
(42, 'Bistec ranchero', 'Carnes', '1.  Licúa los jitomates con el Concentrado de Tomate con Pollo CONSOMATE®, el agua y reserva.\r,2.  En una olla caliente, asa el tocino con el bistec, la cebolla, los pimientos y las papas hasta que doren ligeramente. Vierte la salsa y cocina por 10 minutos a fuego medio.\r,3.  Sirve caliente y ofrece.', '4 Jitomates\r,2 Cubos de Concentrado de Tomate con Pollo CONSOMATE®\r,2 Tazas de agua\r,200 Gramos de tocino picado finamente\r,500 Gramos de bistec cortado en cubps pequeños\r,1 Cebolla fileteada\r,1 Pimiento verde sin semillas y cortado en bastones\r,1 Pimiento amarillo sin semillas y cortados en bastones\r,2 Papas cortadas en cubos', 'uploads\\title_pics_recipe\\image_title_recipe_8_57314025.jpg', '', 8),
(43, 'Ensalada de coditos', 'Ensaladas', '1.  En un tazón mezcla los coditos con los granos de elote, el apio, las espinacas, el pimiento y la pechuga de pavo.\r,2.  Bate la Media Crema NESTLÉ® y la mayonesa; agrega al tazón y mezcla para integrar todos los ingredientes.\r,3.  Refrigera por unos minutos antes de servir y ofrece. ', '1 Paquete de pasta tipo codito , cocida (250 g)\r,1 Taza de granos de elote amarillo, cocido\r,1 Taza de apio, cortados en medias lunas\r,3 Tazas de espinaca, fileteada\r,1 Pimiento rojo, sin semilla y cortados en bastones delgados\r,200 Gramos de pechuga de pavo, cortada en cubos\r,1 Lata de Media Crema NESTLÉ®, refrigerada\r,1/4 De taza de mayonesa', 'uploads\\title_pics_recipe\\image_title_recipe_8_796192773.jpg', '', 8),
(44, 'Sopa de lentejas con chorizo', 'Sopas y cremas', 'Cocina las lentejas en una olla con el agua, ¼ pieza de cebolla, el ajo, tapa y cocina a fuego medio por 40 minutos o hasta que estén suaves. \r,Calienta el aceite, fríe la cebolla picada hasta que esté transparente, añade el chorizo y cocina hasta que dore ligeramente, vierte el jitomate y cocina por 5 minutos más.\r,Agrega a las lentejas, la preparación anterior, el Concentrado de Tomate con Pollo CONSOMATE® y cocina hasta que hierva. Sirve, decora con el cilantro y ofrece. ', '1 Taza de lentejas remojadas 20 minutos y escurridas\r,1 1/2 Litros de agua\r,1/4 De pieza de cebolla\r,2 Dientes de ajo\r,1 Cucharada de aceite vegetal\r,3 Cucharadas de cebolla picada\r,2 Piezas de chorizo picado finamente\r,5 Jitomates sin semillas y cortados en cubos\r,2 Cubos de Concentrado de Tomate con Pollo CONSOMATE®\r,Cilantro desinfectado y picado finamente', 'uploads\\title_pics_recipe\\image_title_recipe_12_303347651.jpg', '', 12),
(45, 'Crema de mascarpone', 'Ensaladas', 'Pon las dos yemas de huevo en un bol y prepara las varillas.\r,Por otro lado, calienta a fuego medio el agua y el azúcar en un cazo hasta que salgan las primeras burbujas, sin parar de remover.\r,Cuando salgan las primeras burbujas, apaga el fuego y echa el sirope (agua con azúcar) muy poco a poco sobre las yemas, mientras bates la mezcla. Se irá formando una mezcla uniforme y espesa. Ten paciencia, se tardan unos 10-15 minutos en enfriar suficientemente la mezcla antes de añadir el mascarpone.\r,Es importante que el sirope esté hirviendo antes de mezclarlo con las yemas porque así se cocinan y el resultado no sabe a huevo crudo. \r,Con un tenedor, dale vueltas al mascarpone para que no sea un ‘bloque de queso’. Añade cucharadas de mascarpone al bol con yemas y sirope. Sigue batiendo la mezcla hasta que no haya grumos.\r,Enfría un par de horas en la nevera, o media hora en el congelador, y está lista para comer.\r,Puedes tomarlo con frutas, o espolvorear cacao sobre la crema. Sabe parecido a', '250g de queso mascarpone\r,2 yemas de huevo\r,75g de azúcar\r,25g de agua\r,batidora de varillas', 'uploads\\title_pics_recipe\\image_title_recipe_12_487792966.jpg', 'uploads\\steps_pics_recipe\\image_step_recipe_12_128334411.jpg,uploads\\steps_pics_recipe\\image_step_recipe_12_515722733.jpg,uploads\\steps_pics_recipe\\image_step_recipe_12_713816174.jpg', 12),
(46, 'Chop Suey de Pollo', 'Cocina casera', 'Calienta el aceite y fríe la cebolla con el ajo hasta que cambien de color, añade la pechuga de pollo y cocina por 5 minutos o hasta que dore ligeramente. \r,Agrega el pimiento, el brócoli, el apio, las zanahorias, el germen de soya, la calabaza y cocina por 3 minutos. \r,Añade la sal con ajo y la Salsa de Soya MAGGI®; mezcla y cocina por 5 minutos más, sirve y ofrece. ', '2 Cucharadas de aceite de ajonjolí\r,1/2 Cebolla fileteada\r,1 Diente de ajo picado finamente\r,400 Gramos de pechuga de pollo cortada en cubos\r,1 Pimiento morrón rojo cortado en bastones\r,1 Taza de brócoli cocido y cortado en ramilletes pequeños\r,1/2 Taza de apio cortado en medias lunas\r,2 Zanahorias cortadas en tiras\r,1 Calabaza cortada en tiras\r,1 Cucharada de sal con ajo en polvo\r,5 Cucharadas de Salsa de Soya MAGGI®\r,2 Tazas de germen de soya', 'uploads\\title_pics_recipe\\image_title_recipe_20_533452121.jpg', '', 20),
(47, 'Sándwich de Pollo y Aderezo de Cebolla Dulce ', 'Recetas para niños', '1.  Calienta el Kirkland Signature Aceite de Canola, agrega el pollo y sazona con un poco de Jugo MAGGI® y Salsa Inglesa CROSSE & BLACKWELL®. Fríe la pechuga hasta que esté cocida.\r,2.  Calienta el Kirkland Signature Aceite de Canola y fríe la cebolla hasta que dore ligeramente. Licúa con la Media Crema NESTLÉ®, el queso crema y Kirkland Signature Miel de Abeja.\r,3.  Mezcla la arúgula con el germinado de alfalfa y el Kirkland Signature Aceite de Oliva Extra Virgen; sazona con un poco de Kirkland Signature Pimienta Negra y sal. Forma cada sándwich con el pan de caja multigrano, un poco de aderezo, el pollo, la ensalada de arúgula y el jitomate. Disfruta.', '1 Cucharada de Jugo MAGGI®\r,1 Pechuga de pollo, cortada fajitas (500 g)\r,1 Cucharada de Salsa Inglesa CROSSE & BLACKWELL®\r,1 Cucharadita de Kirkland Signature Aceite de Canola\r,1/2 Cebolla, fileteada\r,1 Cucharada de Kirkland Signature Aceite de Canola\r,1 Lata de Media Crema NESTLÉ®\r,1/2 Barra de queso crema, a temperatura ambiente (95 g)\r,1 Cucharadita de Kirkland Signature Miel de Abeja\r,1 1/2 Taza de arúgula, desinfectada\r,1 Taza de germinado de alfalfa\r,1 Cucharadita de Kirkland Signature Aceite de Oliva Extra Virgen\r,1/2 Cucharadita de Kirkland Signature Pimienta Negra\r,1/4 Cucharadita de sal\r,8 Rebanadas de pan de caja multigrano, tostado\r,1 Jitomate bola, cortado en rebanadas', 'uploads\\title_pics_recipe\\image_title_recipe_20_714884345.jpg', '', 20),
(48, 'Flan napolitano', 'Postres', '1.  Horno precalentado a 180 °C.\r,2.  Vierte el azúcar en una flanera y calienta a fuego medio para que se forme el caramelo; ladea con cuidado el molde para cubrir la superficie y las paredes.\r,3.  Licúa la Leche Condensada LA LECHERA® con la Leche Evaporada CARNATION® CLAVEL®, el queso crema, los huevos y la esencia de vainilla. Vierte la preparación en la flanera y tapa con papel aluminio sellando las orillas. Coloca en un recipiente y cocina a baño María en el horno a 180 °C durante 1 1/2 horas. \r,4.  Retira del fuego y deja enfriar por completo; desmolda y sirve.', '3/4 De taza de azúcar refinada\r,1 Lata de Leche Condensada LA LECHERA®\r,1 Lata de Leche Evaporada CARNATION® CLAVEL®\r,1 Paquete de queso crema a temperatura ambiente (190 g)\r,5 Huevos\r,1 Cucharada de esencia de vainilla', 'uploads\\title_pics_recipe\\image_title_recipe_15_296170885.jpg', '', 15),
(49, 'Carlota de limon', 'Postres', '1.  Licúa la Leche Condensada LA LECHERA® con la Leche Evaporada CARNATION® CLAVEL® y sin dejar de licuar, agrega poco a poco el jugo de limón. \r,2.  En un refractario cuadrado, coloca una capa de galletas, un poco de la mezcla de limón y repite hasta terminar con el resto de los ingredientes. Cubre con plástico adherente y refrigera por 1 hora o hasta que esté firme. \r,3.  Decora con las rodajas de limón, las galletas troceadas, las hojas de menta y la ralladura de limón. Ofrece. ', '1 Lata de Leche Condensada LA LECHERA\r,1 Lata de Leche Evaporada CARNATION CLAVEL\r,1/4 Taza de Jugo de limón colado\r,30 Galletas Marías\r,1 Limón cortado en rodajas\r,5 Galletas Marías troceadas\r,1 Rama de Menta desinfectada\r,1 Limón (su ralladura)', 'uploads\\title_pics_recipe\\image_title_recipe_12_663393299.jpg', '', 12),
(50, 'Tinga de pollo', 'Cocina casera', 'Licúa el Concentrado de Tomate con Pollo CONSOMATE®, el chile chipotle, el puré de tomate, el agua y los jitomates. \r,Calienta el aceite y cocina la cebolla hasta que cambie de color, vierte lo que licuaste, añade la pechuga de pollo y cocina hasta que espese moviendo ocasionalmente; deja enfriar ligeramente. \r,Sirve la tinga sobre las tostadas MISSION®, decora con la lechuga, la Media Crema NESTLÉ® y el queso. Ofrece. ', '2 Cubos de Concentrado de Tomate con Pollo CONSOMATE®\r,1 Chile chipotle adobado\r,1 Taza de puré de tomate natural\r,1/4 De taza de agua\r,3 Jitomates cortados en cuartos\r,2 Cucharadas de aceite de vegetal\r,1/4 De pieza de cebolla fileteada\r,1 Pechuga de pollo cocida y deshebrada (600 g)\r,Tostadas de maíz MISSION®\r,2 Tazas de lechuga desinfectada y fileteada\r,1 Envase de Media Crema NESTLÉ® refrigerada (190 g)\r,100 Gramos de queso panela rallado', 'uploads\\title_pics_recipe\\image_title_recipe_12_477169346.jpg', '', 12),
(51, 'Crema de calabaza', 'Sopas y cremas', 'En una olla calienta el aceite, agrega la cebolla, el ajo y las calabazas, cocina por 5 minutos. \r,Licúa la preparación anterior con el caldo de pollo, la Leche Evaporada CARNATION® CLAVEL®, la Media Crema NESTLÉ®, la sal y la pimienta.\r,Calienta la crema y cocina hasta que espese ligeramente moviendo para evitar que se pegue. Sirve al momento disfruta. ', '1 Cucharada de aceite vegetal\r,1/4 De pieza de cebolla picada finamente\r,1 Diente de ajo picado finamente\r,4 Calabazas cortadas en cubos\r,1 1/2 Tazas de caldo de pollo\r,1 Lata de Leche Evaporada CARNATION® CLAVEL®\r,1 Lata de Media Crema NESTLÉ®\r,Sal\r,Pimienta negra molida', 'uploads\\title_pics_recipe\\image_title_recipe_12_650288398.jpg', '', 12),
(52, 'Sopa de fideo con brocoli', 'Sopas y cremas', '1.  Licúa la mitad del caldo con los jitomates, el ajo y la cebolla; cuela.\r,2.  Calienta el aceite, fríe el fideo hasta que cambie de color, añade el resto del caldo con lo que licuaste y el brócoli; tapa y cocina a fuego medio de 8 a 10 minutos o hasta que el fideo y el brócoli estén suaves.\r,3.  Agrega el Concentrado de Tomate con Pollo CONSOMATE®, mezcla y cocina 2 minutos más. Ofrece.', '1 1/2 Litros de caldo de pollo\r,3 Jitomates, cortados en cuartos\r,1 Diente de ajo\r,1/4 Pieza de cebolla, mediana\r,2 Cucharadas de aceite vegetal\r,1 Paquete de pasta de fideo #2 (220 g)\r,1 Taza de brócoli, cortado en ramilletes pequeños\r,2 Cubos de Concentrado de Tomate con Pollo CONSOMATE®', 'uploads\\title_pics_recipe\\image_title_recipe_12_178035253.jpg', '', 12),
(53, 'Prueba de receta ', 'Postres', 'Mezcla el Alimento a Base de Almendra CARNATION® CLAVEL® con el puré de plátano, la esencia de vainilla, la avena, la harina de trigo, el polvo para hornear, la nuez y la quínoa hasta integrar. \r,Calienta una sartén, añade algunos disparos de aceite y con ayuda de un cucharón vierte un poco de la mezcla para formar los hot cakes; cocina por ambos lados y repite el procedimiento con el resto de la preparación. \r,Sirve los hot cakes en una lonchera acompañando con la miel de maple, el durazno y el huevo duro.', '1/4 Taza de Alimento a Base de Almendra CARNATION® CLAVEL®\r,1/4 Pieza de Plátano hecho puré\r,1 Cucharadita de Esencia de vainilla\r,3 Cucharadas de Avena molida\r,3 Cucharadas de Harina de trigo integral\r,1 Cucharadita de Polvo para hornear\r,2 Cucharadas de Nuez picada\r,4 Cucharadas de Quinoa cocida\r,Aceite en aerosol\r,1 Cucharada de Miel de maple\r,1 Durazno sin hueso y cortado a la mitad\r,1 Huevo duro', 'uploads\\title_pics_recipe\\image_title_recipe_12_177504783.jpg', '', 12);

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
(8, 'ahorasi@gmail.com', 'ahorasi', 'prueba de cambio de descripcion 5.3', NULL, NULL, 'uploads\\profile_pics\\profile_pic_8.png', 0, 21),
(9, '', '', '', NULL, NULL, NULL, 0, 0),
(12, 'cr7@gmail.com', 'cristiano', 'soy el mejor pero no mejor que el mejor de los mejores que es rafa marquez el mejor', NULL, NULL, 'uploads\\profile_pics\\profile_pic_12.jpg', 0, 35),
(13, 'emi@email.com', 'prueba de emi', 'desc de prueba', NULL, NULL, NULL, 0, 20),
(14, 'efectivo@gmail.com', 'don cangrejo', 'dinero', NULL, NULL, NULL, 0, 50),
(15, 'feo@gmail.com', 'calamardo tentaculos', 'amargado', NULL, NULL, NULL, 0, 30),
(20, 'patricio@gmail.com', 'Patricio Estrella', 'Soy el mejor amigo de Bob Esponja y vivo debajo de una roca', NULL, NULL, NULL, 0, 25),
(22, 'ahorasiiiiii@gmail.com', 'Ahora si', 'Ahora si prueba', NULL, NULL, NULL, 0, 23),
(23, 'sebas@gmail.com', 'Noel', 'cocina con nosotros', NULL, NULL, NULL, 0, 20);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comm`
--
ALTER TABLE `comm`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `like`
--
ALTER TABLE `like`
  ADD PRIMARY KEY (`idLike`);

--
-- Indices de la tabla `passwordc`
--
ALTER TABLE `passwordc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`idUserC`);

--
-- Indices de la tabla `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`idRecipe`),
  ADD KEY `idUserSenderRecipe` (`idUserSenderRecipe`);

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
-- AUTO_INCREMENT de la tabla `comm`
--
ALTER TABLE `comm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `like`
--
ALTER TABLE `like`
  MODIFY `idLike` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `passwordc`
--
ALTER TABLE `passwordc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `recipe`
--
ALTER TABLE `recipe`
  MODIFY `idRecipe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `userc`
--
ALTER TABLE `userc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_idPostLike` FOREIGN KEY (`idPostLike`) REFERENCES `postc` (`idP`),
  ADD CONSTRAINT `fk_idUserlike` FOREIGN KEY (`idUserLike`) REFERENCES `userc` (`id`);

--
-- Filtros para la tabla `passwordc`
--
ALTER TABLE `passwordc`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`idUserC`) REFERENCES `userc` (`id`);

--
-- Filtros para la tabla `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`idUserSenderRecipe`) REFERENCES `userc` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
