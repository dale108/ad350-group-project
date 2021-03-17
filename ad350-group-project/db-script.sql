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
CREATE TABLE IF NOT EXISTS `mydb`.`election_worker_roles` (
  `role_id` INT NOT NULL,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`election_worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`election_worker` (
  `election_worker_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` INT NOT NULL,
  `ssn` VARCHAR(12) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`election_worker_id`, `role_id`),
  INDEX `role_id_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`election_worker_roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT NOT NULL,
  `street_address` VARCHAR(300) NOT NULL,
  `zip_code` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`election_worker_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`election_worker_permissions` (
  `permission_id` INT NOT NULL,
  `permission_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`permission_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`role_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`role_permissions` (
  `role_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  INDEX `fk_role_permissions_election_worker_permissions1_idx` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `fk_role_permissions_election_worker_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`election_worker_roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_permissions_election_worker_permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `mydb`.`election_worker_permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`workers_assigned_to_site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`workers_assigned_to_site` (
  `site_id` INT NOT NULL,
  `date_assigned` DATETIME NOT NULL,
  `election_worker_id` INT NOT NULL,
  PRIMARY KEY (`site_id`, `election_worker_id`),
  INDEX `fk_workers_assigned_to_site_election_worker1_idx` (`election_worker_id` ASC) VISIBLE,
  CONSTRAINT `fk_workers_assigned_to_site_election_worker1`
    FOREIGN KEY (`election_worker_id`)
    REFERENCES `mydb`.`election_worker` (`election_worker_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voting_machines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`voting_machines` (
  `voting_machine_id` INT NOT NULL,
  `last_error` DATETIME NOT NULL,
  `error_message` BLOB NOT NULL,
  PRIMARY KEY (`voting_machine_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`district`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`district` (
  `district_id` INT NOT NULL,
  `district_number` INT NOT NULL,
  `county` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`district_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voting_site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`voting_site` (
  `voting_site_id` INT NOT NULL,
  `street_address` VARCHAR(200) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` INT NOT NULL,
  `district_id` INT NOT NULL,
  PRIMARY KEY (`voting_site_id`, `district_id`),
  INDEX `fk_voting_site_district1_idx` (`district_id` ASC) VISIBLE,
  CONSTRAINT `fk_voting_site_district1`
    FOREIGN KEY (`district_id`)
    REFERENCES `mydb`.`district` (`district_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`worker_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`worker_address` (
  `address_id` INT NOT NULL,
  `election_worker_id` INT NOT NULL,
  PRIMARY KEY (`address_id`, `election_worker_id`),
  INDEX `fk_worker_address_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_worker_address_election_worker1_idx` (`election_worker_id` ASC) VISIBLE,
  CONSTRAINT `fk_worker_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_address_election_worker1`
    FOREIGN KEY (`election_worker_id`)
    REFERENCES `mydb`.`election_worker` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`days_worked_at_assigment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`days_worked_at_assigment` (
  `checked_in` DATETIME NOT NULL,
  `checked_out` DATETIME NOT NULL,
  `site_id` INT NOT NULL,
  `worker_assignment_id` INT NOT NULL,
  INDEX `fk_days_worked_at_assigment_workers_assigned_to_site1_idx` (`site_id` ASC) VISIBLE,
  PRIMARY KEY (`site_id`, `worker_assignment_id`),
  CONSTRAINT `fk_days_worked_at_assigment_workers_assigned_to_site1`
    FOREIGN KEY (`site_id`)
    REFERENCES `mydb`.`workers_assigned_to_site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voting_machines_at_site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`voting_machines_at_site` (
  `voting_site_id` INT NOT NULL,
  `voting_machine_id` INT NOT NULL,
  `voting_machine_at_site_id` INT NOT NULL,
  PRIMARY KEY (`voting_site_id`, `voting_machine_id`, `voting_machine_at_site_id`),
  INDEX `voting_machine_id_idx` (`voting_machine_id` ASC) VISIBLE,
  CONSTRAINT `site_id`
    FOREIGN KEY (`voting_site_id`)
    REFERENCES `mydb`.`voting_site` (`voting_site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `voting_machine_id`
    FOREIGN KEY (`voting_machine_id`)
    REFERENCES `mydb`.`voting_machines` (`voting_machine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`candidate` (
  `candidate_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `party` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`candidate_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ballot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ballot` (
  `ballot_id` INT NOT NULL,
  `candidate_id` INT NOT NULL,
  `voting_machines_at_site_voting_machine_at_site_id` INT NOT NULL,
  PRIMARY KEY (`ballot_id`, `candidate_id`, `voting_machines_at_site_voting_machine_at_site_id`),
  INDEX `fk_ballot_candidate1_idx` (`candidate_id` ASC) VISIBLE,
  INDEX `fk_ballot_voting_machines_at_site1_idx` (`voting_machines_at_site_voting_machine_at_site_id` ASC) VISIBLE,
  CONSTRAINT `fk_ballot_candidate1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `mydb`.`candidate` (`candidate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ballot_voting_machines_at_site1`
    FOREIGN KEY (`voting_machines_at_site_voting_machine_at_site_id`)
    REFERENCES `mydb`.`voting_machines_at_site` (`voting_machine_at_site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`voter` (
  `voter_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `ssn` VARCHAR(12) NOT NULL,
  `address_id` INT NOT NULL,
  `ballot_id` INT NOT NULL,
  PRIMARY KEY (`voter_id`, `address_id`, `ballot_id`),
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  INDEX `fk_voter_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_voter_ballot1_idx` (`ballot_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_ballot1`
    FOREIGN KEY (`ballot_id`)
    REFERENCES `mydb`.`ballot` (`ballot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voter_check_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`voter_check_in` (
  `timstamp` DATETIME NOT NULL,
  `voting_site_id` INT NOT NULL,
  `voter_id` INT NOT NULL,
  `voter_checkin_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`voting_site_id`, `voter_id`, `voter_checkin_id`),
  INDEX `fk_voter_check_in_voting_site1_idx` (`voting_site_id` ASC) VISIBLE,
  INDEX `fk_voter_check_in_voter1_idx` (`voter_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_check_in_voting_site1`
    FOREIGN KEY (`voting_site_id`)
    REFERENCES `mydb`.`voting_site` (`voting_site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_check_in_voter1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `mydb`.`voter` (`voter_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`signature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`signature` (
  `signature_id` INT NOT NULL,
  `path_to_signature_s3` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `path_to_signature_s3_UNIQUE` (`path_to_signature_s3` ASC) VISIBLE,
  PRIMARY KEY (`signature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`voter_signature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`voter_signature` (
  `signature_id` INT NOT NULL,
  `voter_id` INT NOT NULL,
  PRIMARY KEY (`signature_id`, `voter_id`),
  INDEX `fk_voter_signature_signatures1_idx` (`signature_id` ASC) VISIBLE,
  INDEX `fk_voter_signature_voter1_idx` (`voter_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_signature_signatures1`
    FOREIGN KEY (`signature_id`)
    REFERENCES `mydb`.`signature` (`signature_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_signature_voter1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `mydb`.`voter` (`voter_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



  -------------------- Insert -------------------- 

  INSERT INTO candidate(candidate_id, first_name, last_name, party)
VALUES 
    (1, "Jake", "Burt", "Republican"),
	(2, "Silas", "Cox", "Green Party"),
    (3, "William", "Miller", "Democrat")		
;

INSERT INTO ballot(ballot_id, candidate_id, voting_machine_at_site_id)
VALUES 	
	(4, 3, 47), 
	(5, 1, 51), 
	(6, 1, 49), 
	(7, 3, 47), 
	(8, 2, 50)
;

/*need to change address_id*/
INSERT INTO voter(voter_id, first_name, last_name, ssn, ballot_id, address_id)
VALUES 
    (9, "Rick", "Smith", 12345678, 4, 52),
	(10, "Molly", "Miller", 67894044, 5, 53),
    (11, "Bob", "Williams", 9345935, 6, 54),
    (12, "Erik", "Jones", 4575546, 5, 51),
    (13, "Sarah", "Davis", 4444636, 8, 55),
    (14, "David", "Brown", 5454549, 7, 51),
    (15, "Rebecca", "Wilson", 78787940, 6, 52)        
;


INSERT INTO signature(signature_id, path_to_signature_s3)
VALUES 	
    (16, "testing1.url"),
	(17, "testing2.url"),
	(18, "testing3.url"),
    (19, "testing4.url"),
	(20, "testing5.url"),
    (21, "testing6.url"),
	(22, "testing7.url")
;


INSERT INTO voter_signature(signature_id, voter_id)
VALUES 	
    (16, 9),
	(18, 11),
    (20, 13),
    (19, 14),
    (22, 15),
    (17, 10),
    (19, 14)
;


INSERT INTO voter_check_in(timstamp, voting_site_id, voter_id, voter_checkin_id)
    VALUES
        ("2021-03-01 05:05:30", 46, 9, 23),
		("2021-03-01 10:12:15", 45, 12, 24),
        ("2021-03-01 07:45:10", 43, 11, 25),
        ("2021-03-01 05:05:10", 42, 13, 25),
        ("2021-03-01 09:23:00", 44, 10, 26),
        ("2021-03-01 07:45:10", 42, 14, 27),
        ("2021-03-01 12:34:34", 44, 15, 28)
;


/* Needs to change election_worker_id */
INSERT INTO workers_assigned_to_site(site_id, date_assigned, election_worker_id)
    VALUES
        (29, "2021-03-01 07:40:00", 62),
        (30, "2021-03-01 07:55:00", 61),
        (31, "2021-03-01 08:30:00", 63),
        (32, "2021-03-01 08:30:00", 64)
;

INSERT INTO days_worked_at_assigment(checked_in, checked_out, site_id, worker_assignment_id)
    VALUES
        ("2021-03-01 07:35:55", "2021-03-01 04:00:03", 32, 33),
        ("2021-03-01 07:45:20", "2021-03-01 04:10:37", 30, 34),
        ("2021-03-01 08:25:33", "2021-03-01 05:30:26", 29, 35),
        ("2021-03-01 08:25:33", "2021-03-01 05:30:55", 31, 36)
;

INSERT INTO district(district_id, district_number, county)
    VALUES
        (37, 3, "King"),
        (38, 7, "Southwest"),
        (39, 5, "El Paso")
;

INSERT INTO voting_machines(voting_machine_id, last_error, error_message)
    VALUES
       (40, "2021-03-16 01:00:35", "Error with ballot"),
       (41, "2021-05-17 10:22:08", "Error with system")
;

INSERT INTO voting_site(voting_site_id, street_address, city, state, zip_code, district_id)
    VALUES
        (42, "9600 College Way N", "Seattle", "WA", "98103", 37),
        (43, "14 E, W Cache La Poudre St", "Colorado Springs", "CO", "80903", 39),
        (44, "1156 College Dr", "Summit", "MS", "39666", 38),
        (45, "1701 Broadway", "Seattle", "WA", "98122", 37),
        (46, "5675 S Academy Blvd", "Colorado Springs", "CO", "80906", 39)
;


INSERT INTO voting_machines_at_site(voting_site_id, voting_machine_id, voting_machine_at_site_id)
    VALUES
       (45, 40, 47),
       (44, 40, 48),
       (44, 41, 49),
       (46, 40, 50),
       (42, 41, 51)
;




