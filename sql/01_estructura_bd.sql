-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: ciudadainteligente
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `alertaambiental`
--

DROP TABLE IF EXISTS `alertaambiental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alertaambiental` (
  `idAlertaAmbiental` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `nivel` varchar(45) NOT NULL,
  `descripcion` text,
  `fechaHora` datetime NOT NULL,
  `ubicacion_id` int NOT NULL,
  `estado` varchar(45) NOT NULL,
  `cuenta_id` int DEFAULT NULL,
  PRIMARY KEY (`idAlertaAmbiental`),
  KEY `fk_alerta_ubicacion_idx` (`ubicacion_id`),
  KEY `fk_alerta_cuenta_idx` (`cuenta_id`),
  KEY `idx_alerta_ubicacion` (`ubicacion_id`),
  KEY `idx_alerta_fecha` (`fechaHora`),
  CONSTRAINT `fk_alerta_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_alerta_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `atencionreclamo`
--

DROP TABLE IF EXISTS `atencionreclamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atencionreclamo` (
  `idAtencion` int NOT NULL AUTO_INCREMENT,
  `reclamo_id` int NOT NULL,
  `cuentaOperador_id` int NOT NULL,
  `fechaAsignacion` datetime DEFAULT NULL,
  `fechaCierre` datetime DEFAULT NULL,
  `comentarioFinal` text,
  PRIMARY KEY (`idAtencion`),
  KEY `fk_atencion_reclamo_idx` (`reclamo_id`),
  KEY `fk_atencion_cuentaoperador_idx` (`cuentaOperador_id`),
  CONSTRAINT `fk_atencion_cuentaoperador` FOREIGN KEY (`cuentaOperador_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_atencion_reclamo` FOREIGN KEY (`reclamo_id`) REFERENCES `reclamo` (`idReclamo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camara`
--

DROP TABLE IF EXISTS `camara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camara` (
  `idCamara` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` varchar(45) NOT NULL,
  `ubicacion_id` int NOT NULL,
  PRIMARY KEY (`idCamara`),
  KEY `fk_camara_ubicacion_idx` (`ubicacion_id`),
  CONSTRAINT `fk_camara_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ciudadano`
--

DROP TABLE IF EXISTS `ciudadano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudadano` (
  `idCiudadano` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `ci` varchar(20) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `emailPrincipal` varchar(100) DEFAULT NULL,
  `fechaRegistro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCiudadano`),
  UNIQUE KEY `ci_UNIQUE` (`ci`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corteprogramado`
--

DROP TABLE IF EXISTS `corteprogramado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corteprogramado` (
  `idCorte` int NOT NULL AUTO_INCREMENT,
  `servicioPublico_id` int NOT NULL,
  `estadoServicio_id` int NOT NULL,
  `fechaInicio` datetime DEFAULT NULL,
  `fechaFin` datetime DEFAULT NULL,
  `motivo` text,
  PRIMARY KEY (`idCorte`),
  KEY `fk_corte_serviciopublico_idx` (`servicioPublico_id`),
  KEY `fk_corte_estadoservicio_idx` (`estadoServicio_id`),
  CONSTRAINT `fk_corte_estadoCorte` FOREIGN KEY (`estadoServicio_id`) REFERENCES `estadocorte` (`idEstadoCorte`),
  CONSTRAINT `fk_corte_estadoservicio` FOREIGN KEY (`estadoServicio_id`) REFERENCES `estadoservicio` (`idEstadoServicio`),
  CONSTRAINT `fk_corte_serviciopublico` FOREIGN KEY (`servicioPublico_id`) REFERENCES `serviciopublico` (`idServicioPublico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corteubicacion`
--

DROP TABLE IF EXISTS `corteubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corteubicacion` (
  `corte_id` int NOT NULL,
  `observacion` text,
  `zona_id` int NOT NULL,
  PRIMARY KEY (`corte_id`,`zona_id`),
  KEY `fk_cortezona_ubicacion_idx` (`zona_id`),
  CONSTRAINT `fk_cortezona_corte` FOREIGN KEY (`corte_id`) REFERENCES `corteprogramado` (`idCorte`),
  CONSTRAINT `fk_cortezona_ubicacion` FOREIGN KEY (`zona_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuenta`
--

DROP TABLE IF EXISTS `cuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuenta` (
  `idCuenta` int NOT NULL AUTO_INCREMENT,
  `ciudadano_id` int NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `passwordHash` varchar(255) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `fechaCreacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCuenta`),
  UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  KEY `fk_cuenta_ciudadano_idx` (`ciudadano_id`),
  CONSTRAINT `fk_cuenta_ciudadano` FOREIGN KEY (`ciudadano_id`) REFERENCES `ciudadano` (`idCiudadano`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuentarol`
--

DROP TABLE IF EXISTS `cuentarol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentarol` (
  `cuenta_id` int NOT NULL,
  `rol_id` int NOT NULL,
  PRIMARY KEY (`cuenta_id`,`rol_id`),
  KEY `fk_cuentarol_rol_idx` (`rol_id`),
  CONSTRAINT `fk_cuentarol_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_cuentarol_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `denuncia`
--

DROP TABLE IF EXISTS `denuncia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denuncia` (
  `idDenuncia` int NOT NULL AUTO_INCREMENT,
  `incidenteSeg_id` int NOT NULL,
  `ciudadano_id` int NOT NULL,
  `fecha` datetime NOT NULL,
  `canal` varchar(45) NOT NULL,
  ` descripcion` text,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idDenuncia`),
  KEY `fk_denuncia_incidente_idx` (`incidenteSeg_id`),
  KEY `fk_denuncia_ciudadano_idx` (`ciudadano_id`),
  CONSTRAINT `fk_denuncia_ciudadano` FOREIGN KEY (`ciudadano_id`) REFERENCES `ciudadano` (`idCiudadano`),
  CONSTRAINT `fk_denuncia_incidente` FOREIGN KEY (`incidenteSeg_id`) REFERENCES `incidenteseguridad` (`idIncidenteSeg`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadocorte`
--

DROP TABLE IF EXISTS `estadocorte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadocorte` (
  `idEstadoCorte` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`idEstadoCorte`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadoreclamo`
--

DROP TABLE IF EXISTS `estadoreclamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadoreclamo` (
  `idEstadoReclamo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`idEstadoReclamo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadoservicio`
--

DROP TABLE IF EXISTS `estadoservicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadoservicio` (
  `idEstadoServicio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`idEstadoServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gpsposicion`
--

DROP TABLE IF EXISTS `gpsposicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gpsposicion` (
  `idGPS` int NOT NULL,
  `vehiculo_id` int NOT NULL,
  `fechaHora` datetime NOT NULL,
  PRIMARY KEY (`idGPS`),
  KEY `fk_gpsposicion_vehiculo_idx` (`vehiculo_id`),
  CONSTRAINT `fk_gpsposicion_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`idVehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historialestadogenerico`
--

DROP TABLE IF EXISTS `historialestadogenerico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialestadogenerico` (
  `idHistorialEstadoGenerico` int NOT NULL AUTO_INCREMENT,
  `tipoEntidad` varchar(45) NOT NULL,
  `idEntidad` int NOT NULL,
  `estadoAnterior` varchar(45) DEFAULT NULL,
  `estadoNuevo` varchar(45) DEFAULT NULL,
  `fechaHoraCambio` timestamp NULL DEFAULT NULL,
  `cuentaResponsable_id` int NOT NULL,
  PRIMARY KEY (`idHistorialEstadoGenerico`),
  KEY `fk_HistorialEstado_Cuenta_idx` (`cuentaResponsable_id`),
  CONSTRAINT `fk_HistorialEstado_Cuenta` FOREIGN KEY (`cuentaResponsable_id`) REFERENCES `cuenta` (`idCuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidentemovilidad`
--

DROP TABLE IF EXISTS `incidentemovilidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidentemovilidad` (
  `idIncidenteMovilidad` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `descripcion` text,
  `severidad` varchar(45) DEFAULT NULL,
  `ruta_id` int DEFAULT NULL,
  `parada_id` int DEFAULT NULL,
  `cuenta_id` int NOT NULL,
  `ubicacion_id` int NOT NULL,
  `fechaHora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idIncidenteMovilidad`),
  KEY `fk_incidente_ruta_idx` (`ruta_id`),
  KEY `fk_incidente_parada_idx` (`parada_id`),
  KEY `fk_incidente_cuenta_idx` (`cuenta_id`),
  KEY `fk_incidente_ubicacion_idx` (`ubicacion_id`),
  KEY `idx_incMov_ruta` (`ruta_id`),
  KEY `idx_incMov_parada` (`parada_id`),
  CONSTRAINT `fk_im_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_im_parada` FOREIGN KEY (`parada_id`) REFERENCES `parada` (`idParada`),
  CONSTRAINT `fk_im_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`idRuta`),
  CONSTRAINT `fk_im_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`),
  CONSTRAINT `fk_incidente_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_incidente_parada` FOREIGN KEY (`parada_id`) REFERENCES `parada` (`idParada`),
  CONSTRAINT `fk_incidente_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`idRuta`),
  CONSTRAINT `fk_incidente_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incidenteseguridad`
--

DROP TABLE IF EXISTS `incidenteseguridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidenteseguridad` (
  `idIncidenteSeg` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `descripcion` text,
  `nivelRiesgo` varchar(45) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `fechaHora` datetime NOT NULL,
  `camara_id` int DEFAULT NULL,
  `cuenta_id` int DEFAULT NULL,
  `ubicacion_id` int NOT NULL,
  PRIMARY KEY (`idIncidenteSeg`),
  KEY `fk_incSeg_camara_idx` (`camara_id`),
  KEY `fk_incSeg_cuenta_idx` (`cuenta_id`),
  KEY `fk_incSeg_ubicacion_idx` (`ubicacion_id`),
  CONSTRAINT `fk_incSeg_camara` FOREIGN KEY (`camara_id`) REFERENCES `camara` (`idCamara`),
  CONSTRAINT `fk_incSeg_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_incSeg_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lecturaalerta`
--

DROP TABLE IF EXISTS `lecturaalerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturaalerta` (
  `alerta_id` int NOT NULL,
  `lectura_id` int NOT NULL,
  PRIMARY KEY (`alerta_id`,`lectura_id`),
  KEY `fk_lectAlerta_lectura_idx` (`lectura_id`),
  CONSTRAINT `fk_lectAlerta_alerta` FOREIGN KEY (`alerta_id`) REFERENCES `alertaambiental` (`idAlertaAmbiental`),
  CONSTRAINT `fk_lectAlerta_lectura` FOREIGN KEY (`lectura_id`) REFERENCES `lecturasensor` (`idLecturaSensor`),
  CONSTRAINT `fk_lecturaalerta_alerta` FOREIGN KEY (`alerta_id`) REFERENCES `alertaambiental` (`idAlertaAmbiental`),
  CONSTRAINT `fk_lecturaalerta_lectura` FOREIGN KEY (`lectura_id`) REFERENCES `lecturasensor` (`idLecturaSensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lecturasensor`
--

DROP TABLE IF EXISTS `lecturasensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturasensor` (
  `idLecturaSensor` int NOT NULL AUTO_INCREMENT,
  `sensor_id` int NOT NULL,
  `fechaHora` datetime NOT NULL,
  `valor` double NOT NULL,
  `calidadDato` varchar(45) NOT NULL,
  PRIMARY KEY (`idLecturaSensor`),
  KEY `fk_lectura_sensor_idx` (`sensor_id`),
  CONSTRAINT `fk_lectura_sensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensor` (`idSensor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `idNotificacion` int NOT NULL AUTO_INCREMENT,
  `cuenta_id` varchar(45) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `mensaje` text NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `fechaEnvio` timestamp NULL DEFAULT NULL,
  `leida` tinyint NOT NULL,
  PRIMARY KEY (`idNotificacion`),
  KEY `fk_notificacion_cuenta_idx` (`cuenta_id`),
  CONSTRAINT `fk_notificacion_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parada`
--

DROP TABLE IF EXISTS `parada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parada` (
  `idParada` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `ubicacion_id` int NOT NULL,
  PRIMARY KEY (`idParada`),
  KEY `fk_parada_ubicacion_idx` (`ubicacion_id`),
  CONSTRAINT `fk_parada_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patrullaje`
--

DROP TABLE IF EXISTS `patrullaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrullaje` (
  `idPatrullaje` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) DEFAULT NULL,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime DEFAULT NULL,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idPatrullaje`),
  CONSTRAINT `chk_fechas` CHECK (((`fechaFin` is null) or (`fechaFin` > `fechaInicio`)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patrullajeincidente`
--

DROP TABLE IF EXISTS `patrullajeincidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrullajeincidente` (
  `patrullaje_id` int NOT NULL,
  `incidenteSeg_id` int NOT NULL,
  PRIMARY KEY (`patrullaje_id`,`incidenteSeg_id`),
  KEY `fk_patrInc_incidente_idx` (`incidenteSeg_id`),
  CONSTRAINT `fk_patrInc_incidente` FOREIGN KEY (`incidenteSeg_id`) REFERENCES `incidenteseguridad` (`idIncidenteSeg`),
  CONSTRAINT `fk_patrInc_patrullaje` FOREIGN KEY (`patrullaje_id`) REFERENCES `patrullaje` (`idPatrullaje`),
  CONSTRAINT `fk_pi_incidente` FOREIGN KEY (`incidenteSeg_id`) REFERENCES `incidenteseguridad` (`idIncidenteSeg`) ON DELETE CASCADE,
  CONSTRAINT `fk_pi_patrullaje` FOREIGN KEY (`patrullaje_id`) REFERENCES `patrullaje` (`idPatrullaje`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patrullajevehiculo`
--

DROP TABLE IF EXISTS `patrullajevehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patrullajevehiculo` (
  `patrullaje_id` int NOT NULL,
  `vehiculo_id` int NOT NULL,
  PRIMARY KEY (`patrullaje_id`,`vehiculo_id`),
  KEY `fk_patrVeh_vehiculo_idx` (`vehiculo_id`),
  CONSTRAINT `fk_patrVeh_patrullaje` FOREIGN KEY (`patrullaje_id`) REFERENCES `patrullaje` (`idPatrullaje`),
  CONSTRAINT `fk_patrVeh_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`idVehiculo`),
  CONSTRAINT `fk_pv_patrullaje` FOREIGN KEY (`patrullaje_id`) REFERENCES `patrullaje` (`idPatrullaje`) ON DELETE CASCADE,
  CONSTRAINT `fk_pv_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permiso` (
  `idPermiso` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `modulo` varchar(45) NOT NULL,
  PRIMARY KEY (`idPermiso`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preferencianotificacion`
--

DROP TABLE IF EXISTS `preferencianotificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preferencianotificacion` (
  `idPreferenciaNotificacion` int NOT NULL AUTO_INCREMENT,
  `cuenta_id` int NOT NULL,
  `canal` varchar(45) NOT NULL,
  `recibeAlertasAmbientales` tinyint NOT NULL,
  `recibeIncidentesMovilidad` tinyint NOT NULL,
  `recibeInfoCortes` tinyint NOT NULL,
  PRIMARY KEY (`idPreferenciaNotificacion`),
  KEY `fk_preferencianotificacion_cuenta_idx` (`cuenta_id`),
  CONSTRAINT `fk_preferencianotificacion_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `contacto` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reclamo`
--

DROP TABLE IF EXISTS `reclamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reclamo` (
  `idReclamo` int NOT NULL AUTO_INCREMENT,
  `servicioPublico_id` int NOT NULL,
  `cuenta_id` int NOT NULL,
  `estadoReclamo_id` int NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text,
  `fechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `canal` varchar(45) DEFAULT NULL,
  `prioridad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idReclamo`),
  KEY `fk_reclamo_serviciopublico_idx` (`servicioPublico_id`),
  KEY `fk_reclamo_cuenta_idx` (`cuenta_id`),
  KEY `fk_reclamo_estadoReclamo_idx` (`estadoReclamo_id`),
  KEY `idx_reclamo_servicio` (`servicioPublico_id`),
  KEY `idx_reclamo_estado` (`estadoReclamo_id`),
  CONSTRAINT `fk_reclamo_cuenta` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta` (`idCuenta`),
  CONSTRAINT `fk_reclamo_estadoReclamo` FOREIGN KEY (`estadoReclamo_id`) REFERENCES `estadoreclamo` (`idEstadoReclamo`),
  CONSTRAINT `fk_reclamo_estadoservicio` FOREIGN KEY (`servicioPublico_id`) REFERENCES `estadoservicio` (`idEstadoServicio`),
  CONSTRAINT `fk_reclamo_serviciopublico` FOREIGN KEY (`servicioPublico_id`) REFERENCES `serviciopublico` (`idServicioPublico`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idRol`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rolpermiso`
--

DROP TABLE IF EXISTS `rolpermiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolpermiso` (
  `rol_id` int NOT NULL,
  `permiso_id` int NOT NULL,
  PRIMARY KEY (`rol_id`,`permiso_id`),
  KEY `fk_rolpermiso_permiso_idx` (`permiso_id`),
  CONSTRAINT `fk_rolpermiso_permiso` FOREIGN KEY (`permiso_id`) REFERENCES `permiso` (`idPermiso`),
  CONSTRAINT `fk_rolpermiso_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ruta`
--

DROP TABLE IF EXISTS `ruta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ruta` (
  `idRuta` int NOT NULL AUTO_INCREMENT,
  `nombreRuta` varchar(100) NOT NULL,
  `sentido` varchar(45) DEFAULT NULL,
  `transporte_id` int NOT NULL,
  PRIMARY KEY (`idRuta`),
  KEY `fk_ruta_transporte_idx` (`transporte_id`),
  CONSTRAINT `fk_ruta_transporte` FOREIGN KEY (`transporte_id`) REFERENCES `transporte` (`idTransporte`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rutaparada`
--

DROP TABLE IF EXISTS `rutaparada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutaparada` (
  `ruta_id` int NOT NULL,
  `parada_id` int NOT NULL,
  `orden` int DEFAULT NULL,
  PRIMARY KEY (`ruta_id`,`parada_id`),
  KEY `fk_rutaparada_parada_idx` (`parada_id`),
  CONSTRAINT `fk_rp_parada` FOREIGN KEY (`parada_id`) REFERENCES `parada` (`idParada`) ON DELETE CASCADE,
  CONSTRAINT `fk_rp_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`idRuta`) ON DELETE CASCADE,
  CONSTRAINT `fk_rutaparada_parada` FOREIGN KEY (`parada_id`) REFERENCES `parada` (`idParada`),
  CONSTRAINT `fk_rutaparada_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `ruta` (`idRuta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensor` (
  `idSensor` int NOT NULL AUTO_INCREMENT,
  `tipoSensor_id` int NOT NULL,
  `ubicacion_id` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` text,
  `estado` varchar(45) NOT NULL,
  `fechaInstalacion` date NOT NULL,
  `fechaBaja` date DEFAULT NULL,
  PRIMARY KEY (`idSensor`),
  KEY `fk_sensor_tipoSensor_idx` (`tipoSensor_id`),
  KEY `fk_sensor_ubicacion_idx` (`ubicacion_id`),
  CONSTRAINT `fk_sensor_tipoSensor` FOREIGN KEY (`tipoSensor_id`) REFERENCES `tiposensor` (`idTipoSensor`),
  CONSTRAINT `fk_sensor_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serviciopublico`
--

DROP TABLE IF EXISTS `serviciopublico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serviciopublico` (
  `idServicioPublico` int NOT NULL AUTO_INCREMENT,
  `tipoServicio_id` int NOT NULL,
  `estadoServicio_id` int NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `descripcion` text,
  `proveedor_id` int DEFAULT NULL,
  `fechaAlta` date DEFAULT NULL,
  `fechaBaja` date DEFAULT NULL,
  `ubicacion_id` int NOT NULL,
  PRIMARY KEY (`idServicioPublico`),
  KEY `fk_serviciopublico_tiposervicio_idx` (`tipoServicio_id`),
  KEY `fk_serviciopublico_estadoservicio_idx` (`estadoServicio_id`),
  KEY `fk_serviciopublico_ubicacion_idx` (`ubicacion_id`),
  KEY `fk_servicio_proveedor` (`proveedor_id`),
  CONSTRAINT `fk_servicio_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`idProveedor`),
  CONSTRAINT `fk_serviciopublico_estadoservicio` FOREIGN KEY (`estadoServicio_id`) REFERENCES `estadoservicio` (`idEstadoServicio`),
  CONSTRAINT `fk_serviciopublico_tiposervicio` FOREIGN KEY (`tipoServicio_id`) REFERENCES `tiposervicio` (`idTipoServicio`),
  CONSTRAINT `fk_serviciopublico_ubicacion` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicacion` (`idUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tiposensor`
--

DROP TABLE IF EXISTS `tiposensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposensor` (
  `idTipoSensor` int NOT NULL,
  `nombre` varchar(65) NOT NULL,
  `unidad` varchar(45) NOT NULL,
  `descripcion` text,
  `esCritico` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idTipoSensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tiposervicio`
--

DROP TABLE IF EXISTS `tiposervicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposervicio` (
  `idTipoServicio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text,
  `esCritico` tinyint(1) NOT NULL,
  PRIMARY KEY (`idTipoServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoubicacion`
--

DROP TABLE IF EXISTS `tipoubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoubicacion` (
  `idTipoUbicacion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`idTipoUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transporte`
--

DROP TABLE IF EXISTS `transporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transporte` (
  `idTransporte` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `nombreLinea` varchar(45) DEFAULT NULL,
  `empresa` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTransporte`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicacion` (
  `idUbicacion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` text,
  `tipoUbicacion_id` int NOT NULL,
  PRIMARY KEY (`idUbicacion`),
  KEY `fk_ubicacion_tipoubicacion_idx` (`tipoUbicacion_id`),
  CONSTRAINT `fk_ubicacion_tipoubicacion` FOREIGN KEY (`tipoUbicacion_id`) REFERENCES `tipoubicacion` (`idTipoUbicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_ciudadanos`
--

DROP TABLE IF EXISTS `v_ciudadanos`;
/*!50001 DROP VIEW IF EXISTS `v_ciudadanos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_ciudadanos` AS SELECT 
 1 AS `idCiudadano`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `ci`,
 1 AS `telefono`,
 1 AS `emailPrincipal`,
 1 AS `fechaRegistro`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_cuentas_activas`
--

DROP TABLE IF EXISTS `v_cuentas_activas`;
/*!50001 DROP VIEW IF EXISTS `v_cuentas_activas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_cuentas_activas` AS SELECT 
 1 AS `idCuenta`,
 1 AS `usuario`,
 1 AS `estado`,
 1 AS `fechaCreacion`,
 1 AS `idCiudadano`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `ci`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_alto`
--

DROP TABLE IF EXISTS `v_incidentes_alto`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_alto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_alto` AS SELECT 
 1 AS `idIncidenteSeg`,
 1 AS `tipo`,
 1 AS `nivelRiesgo`,
 1 AS `estado`,
 1 AS `fechaHora`,
 1 AS `ubicacion`,
 1 AS `camara`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_bajo`
--

DROP TABLE IF EXISTS `v_incidentes_bajo`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_bajo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_bajo` AS SELECT 
 1 AS `idIncidenteSeg`,
 1 AS `tipo`,
 1 AS `nivelRiesgo`,
 1 AS `estado`,
 1 AS `fechaHora`,
 1 AS `ubicacion`,
 1 AS `camara`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_camaras`
--

DROP TABLE IF EXISTS `v_incidentes_camaras`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_camaras`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_camaras` AS SELECT 
 1 AS `id_incidente`,
 1 AS `tipo`,
 1 AS `nivelRiesgo`,
 1 AS `estado`,
 1 AS `fechaHora`,
 1 AS `idCamara`,
 1 AS `codigo_camara`,
 1 AS `nombre_ubicacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_medio`
--

DROP TABLE IF EXISTS `v_incidentes_medio`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_medio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_medio` AS SELECT 
 1 AS `idIncidenteSeg`,
 1 AS `tipo`,
 1 AS `nivelRiesgo`,
 1 AS `estado`,
 1 AS `fechaHora`,
 1 AS `ubicacion`,
 1 AS `camara`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_movilidad`
--

DROP TABLE IF EXISTS `v_incidentes_movilidad`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_movilidad`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_movilidad` AS SELECT 
 1 AS `idIncidenteMovilidad`,
 1 AS `tipo`,
 1 AS `descripcion`,
 1 AS `severidad`,
 1 AS `fechaHora`,
 1 AS `nombreRuta`,
 1 AS `tipoTransporte`,
 1 AS `nombreLinea`,
 1 AS `ubicacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_por_ubicacion`
--

DROP TABLE IF EXISTS `v_incidentes_por_ubicacion`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_por_ubicacion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_por_ubicacion` AS SELECT 
 1 AS `ubicacion_id`,
 1 AS `nombre_ubicacion`,
 1 AS `total_incidentes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_incidentes_seguridad`
--

DROP TABLE IF EXISTS `v_incidentes_seguridad`;
/*!50001 DROP VIEW IF EXISTS `v_incidentes_seguridad`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_incidentes_seguridad` AS SELECT 
 1 AS `idIncidenteSeg`,
 1 AS `tipo`,
 1 AS `nivelRiesgo`,
 1 AS `estado`,
 1 AS `fechaHora`,
 1 AS `ubicacion`,
 1 AS `camara`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_movilidad_ambiente`
--

DROP TABLE IF EXISTS `v_movilidad_ambiente`;
/*!50001 DROP VIEW IF EXISTS `v_movilidad_ambiente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_movilidad_ambiente` AS SELECT 
 1 AS `idIncidenteMovilidad`,
 1 AS `tipo`,
 1 AS `severidad`,
 1 AS `fechaHora`,
 1 AS `ubicacion`,
 1 AS `calidad_aire`,
 1 AS `calidad_dato`,
 1 AS `horaLectura`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_promedio_lecturas`
--

DROP TABLE IF EXISTS `v_promedio_lecturas`;
/*!50001 DROP VIEW IF EXISTS `v_promedio_lecturas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_promedio_lecturas` AS SELECT 
 1 AS `tipoSensor`,
 1 AS `ubicacion`,
 1 AS `promedio_valor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_reclamos_detalle`
--

DROP TABLE IF EXISTS `v_reclamos_detalle`;
/*!50001 DROP VIEW IF EXISTS `v_reclamos_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_reclamos_detalle` AS SELECT 
 1 AS `idReclamo`,
 1 AS `titulo`,
 1 AS `prioridad`,
 1 AS `canal`,
 1 AS `fechaCreacion`,
 1 AS `ciudadano`,
 1 AS `servicio`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_reclamos_por_servicio`
--

DROP TABLE IF EXISTS `v_reclamos_por_servicio`;
/*!50001 DROP VIEW IF EXISTS `v_reclamos_por_servicio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_reclamos_por_servicio` AS SELECT 
 1 AS `idServicioPublico`,
 1 AS `servicio`,
 1 AS `total_reclamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_servicios_mas_reclamos`
--

DROP TABLE IF EXISTS `v_servicios_mas_reclamos`;
/*!50001 DROP VIEW IF EXISTS `v_servicios_mas_reclamos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_servicios_mas_reclamos` AS SELECT 
 1 AS `idServicioPublico`,
 1 AS `servicio`,
 1 AS `tipoServicio`,
 1 AS `total_reclamos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_servicios_sin_reclamos`
--

DROP TABLE IF EXISTS `v_servicios_sin_reclamos`;
/*!50001 DROP VIEW IF EXISTS `v_servicios_sin_reclamos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_servicios_sin_reclamos` AS SELECT 
 1 AS `idServicioPublico`,
 1 AS `nombre`,
 1 AS `descripcion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_ubicaciones_mas_incidentes`
--

DROP TABLE IF EXISTS `v_ubicaciones_mas_incidentes`;
/*!50001 DROP VIEW IF EXISTS `v_ubicaciones_mas_incidentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_ubicaciones_mas_incidentes` AS SELECT 
 1 AS `idUbicacion`,
 1 AS `nombre`,
 1 AS `total_incidentes`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vehiculo`
--

DROP TABLE IF EXISTS `vehiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiculo` (
  `idVehiculo` int NOT NULL AUTO_INCREMENT,
  `Vehiculo` varchar(45) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `capacidad` int NOT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `transporte_id` int NOT NULL,
  PRIMARY KEY (`idVehiculo`),
  UNIQUE KEY `Vehiculo_UNIQUE` (`Vehiculo`),
  KEY `fk_vehiculo_transporte_idx` (`transporte_id`),
  CONSTRAINT `fk_vehiculo_transporte` FOREIGN KEY (`transporte_id`) REFERENCES `transporte` (`idTransporte`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `v_ciudadanos`
--

/*!50001 DROP VIEW IF EXISTS `v_ciudadanos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_ciudadanos` AS select `c`.`idCiudadano` AS `idCiudadano`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,`c`.`ci` AS `ci`,`c`.`telefono` AS `telefono`,`c`.`emailPrincipal` AS `emailPrincipal`,`c`.`fechaRegistro` AS `fechaRegistro` from `ciudadano` `c` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_cuentas_activas`
--

/*!50001 DROP VIEW IF EXISTS `v_cuentas_activas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_cuentas_activas` AS select `cu`.`idCuenta` AS `idCuenta`,`cu`.`usuario` AS `usuario`,`cu`.`estado` AS `estado`,`cu`.`fechaCreacion` AS `fechaCreacion`,`ci`.`idCiudadano` AS `idCiudadano`,`ci`.`nombre` AS `nombre`,`ci`.`apellido` AS `apellido`,`ci`.`ci` AS `ci` from (`cuenta` `cu` join `ciudadano` `ci` on((`cu`.`ciudadano_id` = `ci`.`idCiudadano`))) where (`cu`.`estado` = 'ACTIVO') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_alto`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_alto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_alto` AS select `v_incidentes_seguridad`.`idIncidenteSeg` AS `idIncidenteSeg`,`v_incidentes_seguridad`.`tipo` AS `tipo`,`v_incidentes_seguridad`.`nivelRiesgo` AS `nivelRiesgo`,`v_incidentes_seguridad`.`estado` AS `estado`,`v_incidentes_seguridad`.`fechaHora` AS `fechaHora`,`v_incidentes_seguridad`.`ubicacion` AS `ubicacion`,`v_incidentes_seguridad`.`camara` AS `camara` from `v_incidentes_seguridad` where (`v_incidentes_seguridad`.`nivelRiesgo` = 'ALTA') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_bajo`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_bajo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_bajo` AS select `v_incidentes_seguridad`.`idIncidenteSeg` AS `idIncidenteSeg`,`v_incidentes_seguridad`.`tipo` AS `tipo`,`v_incidentes_seguridad`.`nivelRiesgo` AS `nivelRiesgo`,`v_incidentes_seguridad`.`estado` AS `estado`,`v_incidentes_seguridad`.`fechaHora` AS `fechaHora`,`v_incidentes_seguridad`.`ubicacion` AS `ubicacion`,`v_incidentes_seguridad`.`camara` AS `camara` from `v_incidentes_seguridad` where (`v_incidentes_seguridad`.`nivelRiesgo` = 'BAJA') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_camaras`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_camaras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_camaras` AS select `iseg`.`idIncidenteSeg` AS `id_incidente`,`iseg`.`tipo` AS `tipo`,`iseg`.`nivelRiesgo` AS `nivelRiesgo`,`iseg`.`estado` AS `estado`,`iseg`.`fechaHora` AS `fechaHora`,`c`.`idCamara` AS `idCamara`,`c`.`codigo` AS `codigo_camara`,`u`.`nombre` AS `nombre_ubicacion` from ((`incidenteseguridad` `iseg` left join `camara` `c` on((`iseg`.`camara_id` = `c`.`idCamara`))) left join `ubicacion` `u` on((`iseg`.`ubicacion_id` = `u`.`idUbicacion`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_medio`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_medio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_medio` AS select `v_incidentes_seguridad`.`idIncidenteSeg` AS `idIncidenteSeg`,`v_incidentes_seguridad`.`tipo` AS `tipo`,`v_incidentes_seguridad`.`nivelRiesgo` AS `nivelRiesgo`,`v_incidentes_seguridad`.`estado` AS `estado`,`v_incidentes_seguridad`.`fechaHora` AS `fechaHora`,`v_incidentes_seguridad`.`ubicacion` AS `ubicacion`,`v_incidentes_seguridad`.`camara` AS `camara` from `v_incidentes_seguridad` where (`v_incidentes_seguridad`.`nivelRiesgo` = 'MEDIA') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_movilidad`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_movilidad`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_movilidad` AS select `im`.`idIncidenteMovilidad` AS `idIncidenteMovilidad`,`im`.`tipo` AS `tipo`,`im`.`descripcion` AS `descripcion`,`im`.`severidad` AS `severidad`,`im`.`fechaHora` AS `fechaHora`,`r`.`nombreRuta` AS `nombreRuta`,`t`.`tipo` AS `tipoTransporte`,`t`.`nombreLinea` AS `nombreLinea`,`u`.`nombre` AS `ubicacion` from (((`incidentemovilidad` `im` left join `ruta` `r` on((`im`.`ruta_id` = `r`.`idRuta`))) left join `transporte` `t` on((`r`.`transporte_id` = `t`.`idTransporte`))) join `ubicacion` `u` on((`im`.`ubicacion_id` = `u`.`idUbicacion`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_por_ubicacion`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_por_ubicacion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_por_ubicacion` AS select `u`.`idUbicacion` AS `ubicacion_id`,`u`.`nombre` AS `nombre_ubicacion`,count(`i`.`idIncidenteSeg`) AS `total_incidentes` from (`ubicacion` `u` left join `incidenteseguridad` `i` on((`i`.`ubicacion_id` = `u`.`idUbicacion`))) group by `u`.`idUbicacion`,`u`.`nombre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_incidentes_seguridad`
--

/*!50001 DROP VIEW IF EXISTS `v_incidentes_seguridad`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_incidentes_seguridad` AS select `i`.`idIncidenteSeg` AS `idIncidenteSeg`,`i`.`tipo` AS `tipo`,`i`.`nivelRiesgo` AS `nivelRiesgo`,`i`.`estado` AS `estado`,`i`.`fechaHora` AS `fechaHora`,`u`.`nombre` AS `ubicacion`,`cam`.`codigo` AS `camara` from ((`incidenteseguridad` `i` left join `camara` `cam` on((`cam`.`idCamara` = `i`.`camara_id`))) join `ubicacion` `u` on((`u`.`idUbicacion` = `i`.`ubicacion_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_movilidad_ambiente`
--

/*!50001 DROP VIEW IF EXISTS `v_movilidad_ambiente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_movilidad_ambiente` AS select `im`.`idIncidenteMovilidad` AS `idIncidenteMovilidad`,`im`.`tipo` AS `tipo`,`im`.`severidad` AS `severidad`,`im`.`fechaHora` AS `fechaHora`,`u`.`nombre` AS `ubicacion`,`ls`.`valor` AS `calidad_aire`,`ls`.`calidadDato` AS `calidad_dato`,`ls`.`fechaHora` AS `horaLectura` from (((`incidentemovilidad` `im` join `ubicacion` `u` on((`im`.`ubicacion_id` = `u`.`idUbicacion`))) join `sensor` `s` on((`s`.`ubicacion_id` = `u`.`idUbicacion`))) join `lecturasensor` `ls` on((`ls`.`sensor_id` = `s`.`idSensor`))) where (`s`.`tipoSensor_id` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_promedio_lecturas`
--

/*!50001 DROP VIEW IF EXISTS `v_promedio_lecturas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_promedio_lecturas` AS select `ts`.`nombre` AS `tipoSensor`,`u`.`nombre` AS `ubicacion`,avg(`ls`.`valor`) AS `promedio_valor` from (((`lecturasensor` `ls` join `sensor` `s` on((`ls`.`sensor_id` = `s`.`idSensor`))) join `tiposensor` `ts` on((`s`.`tipoSensor_id` = `ts`.`idTipoSensor`))) join `ubicacion` `u` on((`s`.`ubicacion_id` = `u`.`idUbicacion`))) group by `ts`.`nombre`,`u`.`nombre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_reclamos_detalle`
--

/*!50001 DROP VIEW IF EXISTS `v_reclamos_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_reclamos_detalle` AS select `r`.`idReclamo` AS `idReclamo`,`r`.`titulo` AS `titulo`,`r`.`prioridad` AS `prioridad`,`r`.`canal` AS `canal`,`r`.`fechaCreacion` AS `fechaCreacion`,`c`.`usuario` AS `ciudadano`,`sp`.`nombre` AS `servicio`,`esr`.`nombre` AS `estado` from (((`reclamo` `r` join `cuenta` `c` on((`r`.`cuenta_id` = `c`.`idCuenta`))) join `serviciopublico` `sp` on((`r`.`servicioPublico_id` = `sp`.`idServicioPublico`))) join `estadoreclamo` `esr` on((`esr`.`idEstadoReclamo` = `r`.`estadoReclamo_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_reclamos_por_servicio`
--

/*!50001 DROP VIEW IF EXISTS `v_reclamos_por_servicio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_reclamos_por_servicio` AS select `sp`.`idServicioPublico` AS `idServicioPublico`,`sp`.`nombre` AS `servicio`,count(`r`.`idReclamo`) AS `total_reclamos` from (`serviciopublico` `sp` left join `reclamo` `r` on((`r`.`servicioPublico_id` = `sp`.`idServicioPublico`))) group by `sp`.`idServicioPublico`,`sp`.`nombre` order by `total_reclamos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_servicios_mas_reclamos`
--

/*!50001 DROP VIEW IF EXISTS `v_servicios_mas_reclamos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_servicios_mas_reclamos` AS select `sp`.`idServicioPublico` AS `idServicioPublico`,`sp`.`nombre` AS `servicio`,`ts`.`nombre` AS `tipoServicio`,count(`r`.`idReclamo`) AS `total_reclamos` from ((`serviciopublico` `sp` join `tiposervicio` `ts` on((`sp`.`tipoServicio_id` = `ts`.`idTipoServicio`))) join `reclamo` `r` on((`r`.`servicioPublico_id` = `sp`.`idServicioPublico`))) group by `sp`.`idServicioPublico`,`sp`.`nombre`,`ts`.`nombre` having (count(`r`.`idReclamo`) > (select avg(`x`.`cnt`) from (select count(0) AS `cnt` from `reclamo` group by `reclamo`.`servicioPublico_id`) `x`)) order by `total_reclamos` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_servicios_sin_reclamos`
--

/*!50001 DROP VIEW IF EXISTS `v_servicios_sin_reclamos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_servicios_sin_reclamos` AS select `sp`.`idServicioPublico` AS `idServicioPublico`,`sp`.`nombre` AS `nombre`,`sp`.`descripcion` AS `descripcion` from `serviciopublico` `sp` where `sp`.`idServicioPublico` in (select `r`.`servicioPublico_id` from `reclamo` `r`) is false */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_ubicaciones_mas_incidentes`
--

/*!50001 DROP VIEW IF EXISTS `v_ubicaciones_mas_incidentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_ubicaciones_mas_incidentes` AS select `u`.`idUbicacion` AS `idUbicacion`,`u`.`nombre` AS `nombre`,`v`.`total_incidentes` AS `total_incidentes` from (`ubicacion` `u` join `v_incidentes_por_ubicacion` `v` on((`u`.`idUbicacion` = `v`.`ubicacion_id`))) where (`v`.`total_incidentes` > (select avg(`v_incidentes_por_ubicacion`.`total_incidentes`) from `v_incidentes_por_ubicacion`)) */;
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

-- Dump completed on 2025-12-12  3:23:58

