-- MySQL Script generated by MySQL Workbench
-- Σαβ 29 Δεκ 2018 12:38:53 πμ EET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema fuelgr-django
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `fuelgr-django` ;

-- -----------------------------------------------------
-- Schema fuelgr-django
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fuelgr-django` DEFAULT CHARACTER SET utf8 ;
USE `fuelgr-django` ;

-- -----------------------------------------------------
-- Table `fuelgr-django`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fuelgr-django`.`users` ;

CREATE TABLE IF NOT EXISTS `fuelgr-django`.`users` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) BINARY NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fuelgr-django`.`gasstations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fuelgr-django`.`gasstations` ;

CREATE TABLE IF NOT EXISTS `fuelgr-django`.`gasstations` (
  `gasStationID` SMALLINT UNSIGNED NOT NULL,
  `gasStationLat` DECIMAL(10,7) NULL,
  `gasStationLong` DECIMAL(10,7) NULL,
  `fuelCompID` TINYINT NOT NULL,
  `fuelCompNormalName` VARCHAR(45) NOT NULL,
  `gasStationOwner` VARCHAR(128) NOT NULL,
  `ddID` VARCHAR(10) NOT NULL,
  `ddNormalName` VARCHAR(45) NOT NULL,
  `municipalityID` VARCHAR(10) NOT NULL,
  `municipalityNormalName` VARCHAR(45) NOT NULL,
  `countyID` VARCHAR(10) NOT NULL,
  `countyName` VARCHAR(64) NOT NULL,
  `gasStationAddress` VARCHAR(255) NULL,
  `phone1` CHAR(10) NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gasStationID`),
  INDEX `fk_gasstations_users1_idx` (`username` ASC),
  CONSTRAINT `fk_gasstations_users1`
    FOREIGN KEY (`username`)
    REFERENCES `fuelgr-django`.`users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fuelgr-django`.`pricedata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fuelgr-django`.`pricedata` ;

CREATE TABLE IF NOT EXISTS `fuelgr-django`.`pricedata` (
  `productID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gasStationID` SMALLINT UNSIGNED NOT NULL,
  `fuelTypeID` TINYINT UNSIGNED NOT NULL,
  `fuelSubTypeID` TINYINT UNSIGNED NOT NULL,
  `fuelNormalName` VARCHAR(64) NOT NULL,
  `fuelName` VARCHAR(128) NOT NULL,
  `fuelPrice` DECIMAL(4,3) NOT NULL,
  `dateUpdated` TIMESTAMP NULL,
  `isPremium` TINYINT(1) NULL,
  PRIMARY KEY (`productID`),
  UNIQUE INDEX `unique_product` (`gasStationID` ASC, `fuelTypeID` ASC, `fuelSubTypeID` ASC),
  CONSTRAINT `fk_pricedata_gasstations`
    FOREIGN KEY (`gasStationID`)
    REFERENCES `fuelgr-django`.`gasstations` (`gasStationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fuelgr-django`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fuelgr-django`.`orders` ;

CREATE TABLE IF NOT EXISTS `fuelgr-django`.`orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `productID` INT UNSIGNED NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `quantity` SMALLINT UNSIGNED NOT NULL,
  `when` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`orderID`),
  INDEX `fk_orders_users1_idx` (`username` ASC),
  INDEX `fk_orders_pricedata1_idx` (`productID` ASC),
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`username`)
    REFERENCES `fuelgr-django`.`users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_pricedata1`
    FOREIGN KEY (`productID`)
    REFERENCES `fuelgr-django`.`pricedata` (`productID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
