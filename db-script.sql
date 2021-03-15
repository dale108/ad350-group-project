-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`election_worker_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`election_worker_roles` ;

CREATE TABLE IF NOT EXISTS `mydb`.`election_worker_roles` (
  `id` INT NOT NULL,
  `role_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`election_worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`election_worker` ;

CREATE TABLE IF NOT EXISTS `mydb`.`election_worker` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` INT NOT NULL,
  `ssn` VARCHAR(12) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `role_id_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`election_worker_roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `id` INT NOT NULL,
  `street_address` VARCHAR(300) NOT NULL,
  `zip_code` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`election_worker_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`election_worker_permissions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`election_worker_permissions` (
  `id` INT NOT NULL,
  `permission_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`role_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`role_permissions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`role_permissions` (
  `role_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  CONSTRAINT `role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`election_worker_roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `permission_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`election_worker_permissions` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`district`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`district` ;

CREATE TABLE IF NOT EXISTS `mydb`.`district` (
  `id` INT NOT NULL,
  `district_number` INT NULL,
  `county` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voting_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`voting_site` ;

CREATE TABLE IF NOT EXISTS `mydb`.`voting_site` (
  `id` INT NOT NULL,
  `street_address` VARCHAR(200) NOT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip_code` INT NULL,
  `district_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `district_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`district` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`workers_assigned_to_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`workers_assigned_to_site` ;

CREATE TABLE IF NOT EXISTS `mydb`.`workers_assigned_to_site` (
  `id` INT NOT NULL,
  `site_id` INT NOT NULL,
  `worker_id` INT NOT NULL,
  `date_assigned` DATETIME NULL,
  PRIMARY KEY (`site_id`, `worker_id`),
  INDEX `site_id_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `worker_id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`election_worker` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `site_id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`voting_site` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voting_machines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`voting_machines` ;

CREATE TABLE IF NOT EXISTS `mydb`.`voting_machines` (
  `id` INT NOT NULL,
  `last_error` DATETIME NULL,
  `error_message` BLOB NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`worker_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`worker_address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`worker_address` (
  `address_id` INT NOT NULL,
  `worker_id` INT NOT NULL,
  PRIMARY KEY (`address_id`, `worker_id`),
  CONSTRAINT `address_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`address` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `worker_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`election_worker` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`days_worked_at_assigment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`days_worked_at_assigment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`days_worked_at_assigment` (
  `checked_in` DATETIME NOT NULL,
  `checked_out` DATETIME NULL,
  `worker_assignment_id` INT NOT NULL,
  PRIMARY KEY (`checked_in`, `worker_assignment_id`),
  CONSTRAINT `worker_assignment_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`workers_assigned_to_site` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voting_machines_at_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`voting_machines_at_site` ;

CREATE TABLE IF NOT EXISTS `mydb`.`voting_machines_at_site` (
  `site_id` INT NOT NULL,
  `voting_machine_id` INT NOT NULL,
  PRIMARY KEY (`site_id`, `voting_machine_id`),
  INDEX `voting_machine_id_idx` (`voting_machine_id` ASC) VISIBLE,
  CONSTRAINT `site_id`
    FOREIGN KEY (`site_id`)
    REFERENCES `mydb`.`voting_site` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `voting_machine_id`
    FOREIGN KEY (`voting_machine_id`)
    REFERENCES `mydb`.`voting_machines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`candidate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`candidate` ;

CREATE TABLE IF NOT EXISTS `mydb`.`candidate` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `party` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ballot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ballot` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ballot` (
  `id` INT NOT NULL,
  `voting_machine_id` INT NULL,
  `selected_candidate_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `voting_machine_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`voting_machines_at_site` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `candidate_id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`candidate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`voter` ;

CREATE TABLE IF NOT EXISTS `mydb`.`voter` (
  `id` INT NOT NULL,
  `ballot_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `ssn` VARCHAR(12) NOT NULL,
  `address_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ballot_id_UNIQUE` (`ballot_id` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  CONSTRAINT `ballot_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`ballot` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voter_check_in`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`voter_check_in` ;

CREATE TABLE IF NOT EXISTS `mydb`.`voter_check_in` (
  `voter_id` INT NOT NULL,
  `voting_site_id` VARCHAR(45) NOT NULL,
  `timstamp` DATETIME NOT NULL,
  PRIMARY KEY (`voter_id`, `voting_site_id`),
  CONSTRAINT `voter_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`voter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `voting_site`
    FOREIGN KEY ()
    REFERENCES `mydb`.`voting_site` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`signature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`signature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`signature` (
  `id` INT NOT NULL,
  `path_to_signature_s3` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `path_to_signature_s3_UNIQUE` (`path_to_signature_s3` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voter_signature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`voter_signature` ;

CREATE TABLE IF NOT EXISTS `mydb`.`voter_signature` (
  `voter_id` INT NOT NULL,
  `signature_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`voter_id`, `signature_id`),
  CONSTRAINT `voter_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`voter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `signature_id`
    FOREIGN KEY ()
    REFERENCES `mydb`.`signature` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

