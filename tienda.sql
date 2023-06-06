-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.28-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para tienda
CREATE DATABASE IF NOT EXISTS `tienda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `tienda`;

-- Volcando estructura para tabla tienda.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `idCategoria` int(100) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tienda.categoria: ~7 rows (aproximadamente)
INSERT INTO `categoria` (`idCategoria`, `categoria`) VALUES
	(1, 'Refresco'),
	(2, 'Botana'),
	(3, 'Dulce'),
	(4, 'comida'),
	(5, 'limpieza'),
	(6, 'prueba'),
	(7, 'Hogar');

-- Volcando estructura para tabla tienda.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `idCliente` int(100) NOT NULL AUTO_INCREMENT,
  `nombreCliente` varchar(100) NOT NULL,
  `idPedido` int(100) NOT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `idPedido` (`idPedido`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tienda.clientes: ~2 rows (aproximadamente)
INSERT INTO `clientes` (`idCliente`, `nombreCliente`, `idPedido`) VALUES
	(1, 'Moises', 1),
	(5, 'Alex', 4);

-- Volcando estructura para tabla tienda.detalle_pedido
CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `idDetallePedido` int(100) NOT NULL AUTO_INCREMENT,
  `idPedido` int(100) NOT NULL,
  `detalle` varchar(100) NOT NULL,
  PRIMARY KEY (`idDetallePedido`),
  KEY `idPedido` (`idPedido`),
  CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tienda.detalle_pedido: ~2 rows (aproximadamente)
INSERT INTO `detalle_pedido` (`idDetallePedido`, `idPedido`, `detalle`) VALUES
	(1, 1, 'Doritos y 1 coca cola'),
	(5, 4, '2 Doritos y 2 cocas');

-- Volcando estructura para tabla tienda.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `idPedido` int(100) NOT NULL AUTO_INCREMENT,
  `idDetallePedido` int(100) NOT NULL,
  `idCliente` int(11) NOT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `idDetallePedido` (`idDetallePedido`,`idCliente`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`idDetallePedido`) REFERENCES `detalle_pedido` (`idDetallePedido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tienda.pedido: ~2 rows (aproximadamente)
INSERT INTO `pedido` (`idPedido`, `idDetallePedido`, `idCliente`) VALUES
	(1, 1, 1),
	(4, 1, 5);

-- Volcando estructura para procedimiento tienda.productocategoria
DELIMITER //
CREATE PROCEDURE `productocategoria`(IN `id` INT)
BEGIN
SELECT * FROM productos WHERE idCategoria=id;
END//
DELIMITER ;

-- Volcando estructura para tabla tienda.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `idProducto` int(100) NOT NULL AUTO_INCREMENT,
  `producto` varchar(100) NOT NULL,
  `precio` int(100) NOT NULL,
  `idCategoria` int(100) NOT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tienda.productos: ~3 rows (aproximadamente)
INSERT INTO `productos` (`idProducto`, `producto`, `precio`, `idCategoria`) VALUES
	(4, 'Doritos', 20, 2),
	(5, 'Chetos', 16, 2),
	(6, 'Cocaina', 1000000, 2),
	(7, 'Coca Cola', 20, 1);

-- Volcando estructura para tabla tienda.tempcategoria
CREATE TABLE IF NOT EXISTS `tempcategoria` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla tienda.tempcategoria: ~2 rows (aproximadamente)
INSERT INTO `tempcategoria` (`id`, `categoria`) VALUES
	(1, 'prueba'),
	(2, 'Hogar');

-- Volcando estructura para vista tienda.vista_cliente_detalle
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_cliente_detalle` (
	`nombre_cliente` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`id_cliente` INT(100) NOT NULL,
	`detalle` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista tienda.vista_producto_categoria
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_producto_categoria` (
	`idProducto` INT(100) NOT NULL,
	`producto` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`precio` INT(100) NOT NULL,
	`categoria` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para disparador tienda.tempTrigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tempTrigger` BEFORE INSERT ON `categoria` FOR EACH ROW BEGIN 
INSERT INTO tempcategoria(categoria) VALUE (NEW.categoria);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para vista tienda.vista_cliente_detalle
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_cliente_detalle`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_cliente_detalle` AS select `c`.`nombreCliente` AS `nombre_cliente`,`c`.`idCliente` AS `id_cliente`,`dp`.`detalle` AS `detalle` from ((`clientes` `c` join `pedido` `p` on(`c`.`idCliente` = `p`.`idCliente`)) join `detalle_pedido` `dp` on(`p`.`idPedido` = `dp`.`idPedido`)) ;

-- Volcando estructura para vista tienda.vista_producto_categoria
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_producto_categoria`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_producto_categoria` AS select `productos`.`idProducto` AS `idProducto`,`productos`.`producto` AS `producto`,`productos`.`precio` AS `precio`,`categoria`.`categoria` AS `categoria` from (`productos` join `categoria` on(`productos`.`idCategoria` = `categoria`.`idCategoria`)) ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
