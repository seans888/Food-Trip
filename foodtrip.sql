SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Foodtrip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Foodtrip` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Foodtrip` ;

-- -----------------------------------------------------
-- Table `Foodtrip`.`Promo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Foodtrip`.`Promo` (
  `promoID` INT NOT NULL,
  `promo_name` VARCHAR(45) NOT NULL,
  `promo_desc` VARCHAR(200) NOT NULL,
  `discount` DECIMAL(5,2) NOT NULL,
  `discounted_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`promoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Foodtrip`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Foodtrip`.`Location` (
  `locationID` INT NOT NULL,
  `street_num` INT NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `latitude` INT NOT NULL,
  `longitude` INT NOT NULL,
  PRIMARY KEY (`locationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Foodtrip`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Foodtrip`.`Restaurant` (
  `restoID` INT NOT NULL,
  `resto_name` VARCHAR(45) NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `resto_desc` VARCHAR(200) NOT NULL,
  `resto_type` VARCHAR(45) NOT NULL,
  `menu_desc` VARCHAR(500) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `op_time` TIME NOT NULL,
  `cl_time` TIME NOT NULL,
  `promoID` INT NOT NULL,
  `locationID` INT NOT NULL,
  PRIMARY KEY (`restoID`, `promoID`),
  INDEX `fk_Restaurant_Promo1_idx` (`promoID` ASC),
  INDEX `fk_Restaurant_Location1_idx` (`locationID` ASC),
  CONSTRAINT `fk_Restaurant_Promo1`
    FOREIGN KEY (`promoID`)
    REFERENCES `Foodtrip`.`Promo` (`promoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_Location1`
    FOREIGN KEY (`locationID`)
    REFERENCES `Foodtrip`.`Location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Foodtrip`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Foodtrip`.`User` (
  `userID` INT NOT NULL,
  `f_name` VARCHAR(45) NOT NULL,
  `m_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `contact_num` INT NOT NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Foodtrip`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Foodtrip`.`Book` (
  `User_userID` INT NOT NULL,
  `Restaurant_restoID` INT NOT NULL,
  `date` DATE NOT NULL,
  `time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`User_userID`, `Restaurant_restoID`),
  INDEX `fk_User_has_Restaurant_Restaurant1_idx` (`Restaurant_restoID` ASC),
  INDEX `fk_User_has_Restaurant_User_idx` (`User_userID` ASC),
  CONSTRAINT `fk_User_has_Restaurant_User`
    FOREIGN KEY (`User_userID`)
    REFERENCES `Foodtrip`.`User` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Restaurant_Restaurant1`
    FOREIGN KEY (`Restaurant_restoID`)
    REFERENCES `Foodtrip`.`Restaurant` (`restoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
