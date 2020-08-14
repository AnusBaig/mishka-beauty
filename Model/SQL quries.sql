-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema nhnxayvj_mishka-beauty
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nhnxayvj_mishka-beauty
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nhnxayvj_mishka-beauty` DEFAULT CHARACTER SET utf8 ;
USE `nhnxayvj_mishka-beauty` ;

-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`admin_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`admin_table` (
  `email` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `username` VARCHAR(16) CHARACTER SET 'utf8' NOT NULL,
  `password` BLOB NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`brand_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`brand_table` (
  `brand_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`brand_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`category_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`category_table` (
  `category_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`customer_activation_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`customer_activation_table` (
  `username` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `name` BLOB NOT NULL,
  `email` BLOB NOT NULL,
  `password` BLOB NOT NULL,
  `address` BLOB NULL DEFAULT NULL,
  `contact` BLOB NULL DEFAULT NULL,
  `activation_key` BLOB NOT NULL,
  `time_available` DATETIME NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`customer_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`customer_table` (
  `username` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `name` BLOB NOT NULL,
  `email` BLOB NOT NULL,
  `password` BLOB NOT NULL,
  `address` BLOB NULL DEFAULT NULL,
  `contact` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`subcategory_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`subcategory_table` (
  `subcategory_id` VARCHAR(50) NOT NULL,
  `category_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`subcategory_id`),
  INDEX `FK_SCT_CT_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_SCT_CT`
    FOREIGN KEY (`category_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`category_table` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- ABOVE COMPLETED Table `nhnxayvj_mishka-beauty`.`groupcategory_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`groupcategory_table` (
  `groupcategory_id` VARCHAR(50) NOT NULL,
  `subcategory_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`groupcategory_id`),
  INDEX `FK_GCT_SCT_idx` (`subcategory_id` ASC) VISIBLE,
  CONSTRAINT `FK_GCT_SCT`
    FOREIGN KEY (`subcategory_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`subcategory_table` (`subcategory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_table` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `brand_id` VARCHAR(50) NOT NULL,
  `groupcategory_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `FK_PT_GCT_idx` (`groupcategory_id` ASC) VISIBLE,
  INDEX `FK_PT_BT_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `FK_PT_BT`
    FOREIGN KEY (`brand_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`brand_table` (`brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PT_GCT`
    FOREIGN KEY (`groupcategory_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`groupcategory_table` (`groupcategory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 33300026
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_discount_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_discount_table` (
  `code` VARCHAR(15) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `percent` FLOAT NOT NULL,
  `effective` DATETIME NOT NULL,
  `ending` DATETIME NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`, `product_id`),
  INDEX `FK_PDT_PT_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `FK_PDiT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`customer_discount_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`customer_discount_table` (
  `code` VARCHAR(15) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `username` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `counts_allot` INT(11) NOT NULL,
  `counts_availed` INT(11) NULL DEFAULT '0',
  PRIMARY KEY (`code`, `product_id`, `username`),
  INDEX `FK_CDT_PT_idx` (`product_id` ASC) VISIBLE,
  INDEX `FK_CDT_CT_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `FK_CDT_CT`
    FOREIGN KEY (`username`)
    REFERENCES `nhnxayvj_mishka-beauty`.`customer_table` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CDT_PDiT`
    FOREIGN KEY (`code`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_discount_table` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CDT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`customer_order_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`customer_order_table` (
  `invoice` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `amount` FLOAT NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(10) NOT NULL DEFAULT 'Placed',
  `phone` VARCHAR(20) NOT NULL,
  `address` VARCHAR(75) NOT NULL,
  `is_cart` BIT(1) NOT NULL DEFAULT b'0',
  `discount` FLOAT NOT NULL DEFAULT '0',
  `discount_quantity` INT(11) NOT NULL DEFAULT '0',
  `net_amount` FLOAT NOT NULL,
  `code` VARCHAR(15) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`invoice`),
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  INDEX `FK_COT_CT` (`username` ASC) VISIBLE,
  CONSTRAINT `FK_COT_CT`
    FOREIGN KEY (`username`)
    REFERENCES `nhnxayvj_mishka-beauty`.`customer_table` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_COT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1000000021
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`otp_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`otp_table` (
  `username` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `otp` BLOB NULL DEFAULT NULL,
  `time_usable` VARCHAR(70) NULL DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `FK_OT_CT`
    FOREIGN KEY (`username`)
    REFERENCES `nhnxayvj_mishka-beauty`.`customer_table` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_attributes_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_attributes_table` (
  `product_id` INT(11) NOT NULL,
  `attribute_key` VARCHAR(45) NOT NULL,
  `attribute_value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_id`, `attribute_key`, `attribute_value`),
  CONSTRAINT `FK_PAT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_comments_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_comments_table` (
  `product_id` INT(11) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `comment` VARCHAR(100) NOT NULL,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`, `username`),
  INDEX `FK_PCT_CT_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `FK_PCT_CT`
    FOREIGN KEY (`username`)
    REFERENCES `nhnxayvj_mishka-beauty`.`customer_table` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PCT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_description_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_description_table` (
  `product_id` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `stock` INT(11) NOT NULL,
  `price` FLOAT NOT NULL,
  `rating` FLOAT NOT NULL DEFAULT '0',
  `total_raters` INT(11) NOT NULL DEFAULT '0',
  `orders` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`),
  CONSTRAINT `FK_PDT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_picture_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_picture_table` (
  `path` VARCHAR(50) NOT NULL,
  `product_id` INT(11) NOT NULL,
  PRIMARY KEY (`path`),
  INDEX `FK_PPT_PT_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `FK_PPT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_rating_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_rating_table` (
  `product_id` INT(11) NOT NULL,
  `username` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `rating` FLOAT NOT NULL,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`, `username`),
  INDEX `FK_PRT_CT_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `FK_PRT_CT`
    FOREIGN KEY (`username`)
    REFERENCES `nhnxayvj_mishka-beauty`.`customer_table` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PRT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nhnxayvj_mishka-beauty`.`product_variation_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nhnxayvj_mishka-beauty`.`product_variation_table` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `product_id` INT(11) NOT NULL,
  `variation_id` INT(11) NOT NULL,
  `attribute_key` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_PVT_PT_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `FK_PVT_PT`
    FOREIGN KEY (`product_id`)
    REFERENCES `nhnxayvj_mishka-beauty`.`product_table` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8;

USE `nhnxayvj_mishka-beauty` ;

-- -----------------------------------------------------
-- procedure activateCustomer
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `activateCustomer`(IN akey BLOB, IN uname VARCHAR(50))
BEGIN
    # akey = activation key 
    # uname = unsername
	SET @otime = NOW();
    IF NOT validateActivationKey(akey, uname) THEN
		SELECT "You have used wrong/old URL. Kindly visit newest URl or request one" AS "Message", FALSE AS "Success";
	ELSEIF NOT validateActivationKeyTime(uname, @otime) THEN 
		SELECT "This URL has expired. Kindly request a new one" AS "Message", FALSE AS "Success";
	ELSE
		INSERT INTO `nhnxayvj_mishka-beauty`.`customer_table`
		(`username`, `name`, `email`, `password`, `address`, `contact`)
        SELECT `customer_activation_table`.`username`,
		`customer_activation_table`.`name`, `customer_activation_table`.`email`,
		`customer_activation_table`.`password`, `customer_activation_table`.`address`,
		`customer_activation_table`.`contact`
		FROM `nhnxayvj_mishka-beauty`.`customer_activation_table`;
		
        DELETE FROM `nhnxayvj_mishka-beauty`.`customer_activation_table` WHERE
        `customer_activation_table`.`username` = uname;
        
        SELECT "You are account has been activated" AS "Message", TRUE AS "Success";
        
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addAdmin
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAdmin`(IN em VARCHAR(45), IN un VARCHAR(16), IN pass VARCHAR(20))
BEGIN
    # em = email address
    # un = username
    # pass = password
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
        SELECT "Error Occured. Recheck your values" AS "Error";
    END;
    INSERT INTO `nhnxayvj_mishka-beauty`.`admin_table`
	(`email`,
	`username`,
	`password`)
	VALUES
	(em,
	un,
	AES_ENCRYPT(SHA2(pass, 256), "F3229A0B371ED2D9441B830D21A390C3")
    );
    SELECT "Admin added" AS "Message";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addBrand
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBrand`(IN bid VARCHAR(50))
BEGIN
    # bid = Brand name
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
        SELECT "Something went wrong" AS "Error";
    END;
    
	IF validateUniqueBrand(bid) THEN
		INSERT INTO `nhnxayvj_mishka-beauty`.`brand_table` (`brand_id`) VALUES (bid);
		SELECT CONCAT(bid, " added as new Brand") AS "Message", TRUE AS "Success";
	ELSE
		SELECT CONCAT(bid, " already exists as Brand") AS "Message", FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCategory`(IN cid VARCHAR(50))
BEGIN
    # cid = category name
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
        SELECT "Something went wrong" AS "Error";
    END;

	IF validateUniqueCategory(cid) THEN
		INSERT INTO `nhnxayvj_mishka-beauty`.`category_table` (`category_id`) VALUES (cid);
		SELECT CONCAT(cid, " added as new Category") AS "Message", TRUE AS "Success";
	ELSE
		SELECT CONCAT(cid, " already exists as Category") AS "Message", FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addCustomer
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addCustomer`(
	IN uname VARCHAR(50), IN nm VARCHAR(50), IN mail VARCHAR(50),
    IN pass VARCHAR(50), IN addr VARCHAR(75), IN ph VARCHAR(20)
)
BEGIN
    # uname = username, nm = original name, mail = email address
    # pass = password, addr = address, ph = phonenumber
	SET @expiray = TIMESTAMPADD(MONTH, 1, NOW());
    SET @ky = SHA2(CONCAT(uname, mail, NOW()), 256);
    
    IF validateUniqueUsername(uname) AND validateUniqueEmail(mail) THEN
		INSERT INTO `nhnxayvj_mishka-beauty`.`customer_activation_table`
		(`username`, `name`, `email`, `password`, `address`, `contact`, `activation_key`, `time_available`)
		VALUES
		(uname, encryptName(nm), encryptEmail(mail), savePassword(pass),
        encryptAddress(addr), encryptPhone(ph), encryptActivationKey(@ky), @expiray
		);

		SELECT 
		CONCAT("Your account has been created. KIndly visit above URL to activate your account before ", @expiray) 
		AS "Message", HEX(@ky) AS "Key", TRUE AS "Success";
        
	ELSE
		SELECT CONCAT("Username: ", uname, " and/or Email: ", mail, " has already been taken") AS "Message",
        FALSE AS "Success";
	
    END If;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addDiscount
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDiscount`(
	IN cd VARCHAR(15), IN pid INT(11), IN per FLOAT, IN eff DATETIME, IN ed DATETIME, IN des VARCHAR(45),
    IN uname VARCHAR(50), IN callot INT
)
BEGIN
	# cd = code, pid = product id, per = percentage, eff = date effective, ed = date ending
    # des = description, # uname = all unsernames valid for discount, callot = number of counts allocated
    DECLARE a VARCHAR(50);
	DECLARE done INT DEFAULT FALSE;
	DECLARE users CURSOR FOR SELECT `customer_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_table`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	IF (uname != "*" AND NOT customerExists(uname)) OR NOT validateUniqueDiscount(cd, pid) THEN
		SELECT CONCAT(uname, " and/or unique ", cd, "/", pid, " pair is not unique") AS "Message", FALSE AS "Success";
	
    ELSE
    
		INSERT INTO `nhnxayvj_mishka-beauty`.`product_discount_table`
        (`code`, `product_id`, `percent`, `effective`, `ending`, `description`) VALUES
        (cd, pid, per, eff, ed, des);
        
		IF uname = "*"  THEN
			OPEN users;
				read_loop: LOOP
				FETCH users INTO a;
				IF done THEN
					LEAVE read_loop;
				END IF;
					INSERT INTO `nhnxayvj_mishka-beauty`.`customer_discount_table`
					(`code`, `product_id`, `username`, `counts_allot`) VALUES
					(cd, pid, a, callot);
				END LOOP;
			CLOSE users;
        
		ELSE
			INSERT INTO `nhnxayvj_mishka-beauty`.`customer_discount_table`
			(`code`, `product_id`, `username`, `counts_allot`) VALUES
			(cd, pid, uname, callot);
		END IF;
	
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addGroupCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addGroupCategory`(IN gcid VARCHAR(50), IN scid VARCHAR(50))
BEGIN
    # gcid = group category id, scid = sub category id
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
        SELECT "Something went wrong" AS "Error";
    END;

	IF validateUniqueGroupCategory(gcid) AND (NOT validateUniqueSubCategory(scid))THEN
		INSERT INTO `nhnxayvj_mishka-beauty`.`groupcategory_table` (`groupcategory_id`, `subcategory_id`) VALUES (gcid, scid);
		SELECT CONCAT(gcid, " added as new Group-Category against Sub-Category ", scid) AS "Message", TRUE AS "Success";
	ELSE
		SELECT CONCAT(gcid, " already exists as Group-Category and\\or SUb-Category, ", scid, " does not exists") AS "Message", FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addProduct
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addProduct`(
	IN bid VARCHAR(50), IN gcid VARCHAR(50),
    IN pname VARCHAR(45), IN pstock INT, IN pprice FLOAT,
    IN attributes VARCHAR(1500)
    )
BEGIN    
# attributes= " ( 'size', 'small' ), ( 'colour', 'blue') "
# bid = brand name, gcid = group category id, pname = product name
# pstock = product stock, pprice = product price
IF NOT validateUniqueGroupCategory(gcid) AND NOT validateUniqueBrand(bid) THEN
	
SET @temp_attr_query = CONCAT("INSERT INTO temp_attr(attribute_key, attribute_value) 
VALUES ", attributes);

CREATE TEMPORARY TABLE temp_attr (
	attribute_key VARCHAR(50), 
	attribute_value VARCHAR(50),
    varient_id VARCHAR(50)
);

PREPARE insert_attr_sql FROM @temp_attr_query;
EXECUTE insert_attr_sql;

CREATE TEMPORARY TABLE temp_varients AS
SELECT 	ta.attribute_key, IFNULL(pat.product_id, 'NA')"varient_id"
FROM
		temp_attr ta LEFT JOIN
        (product_attributes_table pat JOIN product_description_table pdt ON 
        pat.product_id = pdt.product_id AND pdt.name = pname)
        ON ta.attribute_key = pat.attribute_key
WHERE
		ta.attribute_value != IFNULL(pat.attribute_value, 'NA');

TRUNCATE temp_attr;

INSERT INTO temp_attr (varient_id, attribute_key)
SELECT DISTINCT(pat.product_id), tv.attribute_key FROM temp_varients tv JOIN 
(	product_attributes_table pat JOIN product_description_table pdt 
    ON pat.product_id = pdt.product_id	AND pdt.name = pname ) 
ON tv.attribute_key != pat.attribute_key AND tv.varient_id = 'NA';

INSERT INTO temp_varients(attribute_key, varient_id) 
SELECT attribute_key, varient_id FROM temp_attr;

SET sql_safe_updates = 0;
DELETE FROM temp_varients WHERE varient_id = 'NA';
SET sql_safe_updates = 1;

SET @result = (SELECT
(SELECT COUNT(DISTINCT(varient_id)) FROM temp_varients) = 
(SELECT COUNT(product_id) FROM product_description_table WHERE name = pname));

IF @result THEN
	INSERT INTO `nhnxayvj_mishka-beauty`.`product_table` (`brand_id`, `groupcategory_id`)
	VALUES (bid, gcid);
    SET @id = LAST_INSERT_ID();
    
    TRUNCATE temp_attr;
    EXECUTE insert_attr_sql;
    
    INSERT INTO `nhnxayvj_mishka-beauty`.`product_attributes_table`
    (`product_id`, `attribute_key`, `attribute_value`)
	SELECT @id, attribute_key, attribute_value FROM temp_attr;
    
    INSERT INTO `nhnxayvj_mishka-beauty`.`product_description_table` 
	(`product_id`, `name`, `stock`, `price`) VALUES (@id, pname, pstock, pprice);

	INSERT INTO `nhnxayvj_mishka-beauty`.`product_variation_table`
	(`product_id`, `variation_id`, `attribute_key`)
    SELECT @id, varient_id, attribute_key FROM temp_varients ORDER BY varient_id;
    
    INSERT INTO `nhnxayvj_mishka-beauty`.`product_variation_table`
	(`product_id`, `variation_id`, `attribute_key`)
    SELECT varient_id, @id, attribute_key FROM temp_varients ORDER BY varient_id;
    
    SELECT CONCAT("Successfully added product: ", pname) AS "Message", TRUE AS "Success";
ELSE
	SELECT CONCAT("A product with same attributes and name: ", pname, " already exists. Change attributes and/or create new product") AS "Message", FALSE AS "Success";
END IF;

DEALLOCATE PREPARE insert_attr_sql;
DROP TEMPORARY TABLE temp_attr;
DROP TEMPORARY TABLE temp_varients;

ELSE
SELECT CONCAT("Groupcategory: ", gcid, " and/or Brand: ", bid, " does not exists") AS "Message", FALSE AS "Success";

END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addSubCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addSubCategory`(IN scid VARCHAR(50), IN cid VARCHAR(50))
BEGIN
    # scid = sub category id, cid = category id
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
        SELECT "Something went wrong" AS "Error";
    END;
    
	IF validateUniqueSubCategory(scid) AND (NOT validateUniqueCategory(cid)) THEN
		INSERT INTO `nhnxayvj_mishka-beauty`.`subcategory_table` (`subcategory_id`, `category_id`) VALUES (scid, cid);
		SELECT CONCAT(scid, " added as new Sub-Category against Category ", cid) AS "Message", TRUE AS "Success";
	ELSE
		SELECT 
        CONCAT(scid, " already exists as Sub-Category and\\or ", cid, " does not exist") AS "Message", FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function availableDiscountCounts
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `availableDiscountCounts`(uname VARCHAR(50), cd VARCHAR(15), pid INT(11)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	SET @availed = (SELECT `customer_discount_table`.`counts_availed`
		FROM `nhnxayvj_mishka-beauty`.`customer_discount_table` WHERE
		`customer_discount_table`.`username` = uname 
		AND `customer_discount_table`.`code` = cd
		AND `customer_discount_table`.`product_id` = pid);

	SET @alloted = (SELECT `customer_discount_table`.`counts_allot`
		FROM `nhnxayvj_mishka-beauty`.`customer_discount_table` WHERE
		`customer_discount_table`.`username` = uname 
		AND `customer_discount_table`.`code` = cd
		AND `customer_discount_table`.`product_id` = pid);

RETURN (@alloted-@availed);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function customerExists
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `customerExists`(uname VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (SELECT `customer_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_table` WHERE `customer_table`.`username` = uname);

    IF @result IS NULL THEN RETURN FALSE;
    ELSE RETURN TRUE;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function decryptActivationKey
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `decryptActivationKey`(akey BLOB) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
    RETURN AES_DECRYPT(akey, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function decryptAddress
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `decryptAddress`(addr BLOB) RETURNS varchar(75) CHARSET utf8
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
    RETURN AES_DECRYPT(addr, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function decryptEmail
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `decryptEmail`(mail BLOB) RETURNS varchar(50) CHARSET utf8
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
    RETURN AES_DECRYPT(mail, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function decryptName
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `decryptName`(nm BLOB) RETURNS varchar(50) CHARSET utf8
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
    RETURN AES_DECRYPT(nm, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function decryptPhone
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `decryptPhone`(phone BLOB) RETURNS varchar(20) CHARSET utf8
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
    RETURN AES_DECRYPT(phone, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function encryptActivationKey
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `encryptActivationKey`(akey BLOB) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
	RETURN AES_ENCRYPT(akey, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function encryptAddress
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `encryptAddress`(addr VARCHAR(75)) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
	RETURN AES_ENCRYPT(addr, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function encryptEmail
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `encryptEmail`(mail VARCHAR(45)) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
	RETURN AES_ENCRYPT(mail, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function encryptName
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `encryptName`(nm VARCHAR(50)) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
	RETURN AES_ENCRYPT(nm, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function encryptPhone
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `encryptPhone`(ph VARCHAR(20)) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
	RETURN AES_ENCRYPT(ph, @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function hasReviewRight
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `hasReviewRight`(uname VARCHAR(50), pid INT(11)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (SELECT (COUNT(`customer_order_table`.`invoice`) > 0)
		FROM `nhnxayvj_mishka-beauty`.`customer_order_table` WHERE
        `customer_order_table`.`username` = uname AND 
		`customer_order_table`.`product_id` = pid);
	
    IF @result THEN RETURN TRUE;
    ELSE RETURN FALSE;
	END IF;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function isDiscountAvailable
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `isDiscountAvailable`(uname VARCHAR(50), cd VARCHAR(15), pid INT(11)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (SELECT `customer_discount_table`.`username` FROM 
		`nhnxayvj_mishka-beauty`.`customer_discount_table` WHERE
		`customer_discount_table`.`username` = uname 
		AND `customer_discount_table`.`code` = cd
		AND `customer_discount_table`.`product_id` = pid);
	
    IF @result IS NULL THEN RETURN FALSE;
    ELSE RETURN TRUE;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure placeOrder
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `placeOrder`(
	IN qty INT, IN addr VARCHAR(75), IN ph VARCHAR(20),IN uname VARCHAR(50), IN pid INT(11), IN cart BOOLEAN,
	IN apply_discount BOOLEAN, IN discount_qty INT, IN cd VARCHAR(15)
)
customer_label: BEGIN
# qty = quantity, addr = droping address, ph = phone number, uname = username, pid = product id
# cart = is cart checkout?, apply_discount = is discount applied
# discount_qty = how many types discount has been applied on this product, cd = discount code
IF NOT customerExists(uname) THEN
	SELECT CONCAT("Customer: ", uname, " does not exists") AS "Message", FALSE AS "Success";
    LEAVE customer_label;
END IF;

IF NOT productExists(pid) THEN
	SELECT CONCAT("Product: ", pid, " does not exists") AS "Message", FALSE AS "Success";
    LEAVE customer_label;
END IF;

IF apply_discount = TRUE THEN
	IF isDiscountAvailable(uname, cd, pid) = TRUE THEN
		SET @available_qty = availableDiscountCounts(uname, cd, pid);
		IF discount_qty <= @available_qty THEN
			IF qty = discount_qty THEN
            
					SET @rate = (SELECT price FROM product_description_table WHERE product_id = pid);
					SET @dis = (SELECT `product_discount_table`.`percent` FROM `nhnxayvj_mishka-beauty`.`product_discount_table` WHERE `product_discount_table`.`code` = cd AND `product_discount_table`.`product_id` = pid);
					SET @old_availed = (SELECT  `customer_discount_table`.`counts_availed` FROM `nhnxayvj_mishka-beauty`.`customer_discount_table` WHERE `customer_discount_table`.`code` = cd AND `customer_discount_table`.`product_id` = pid AND`customer_discount_table`.`username` = uname); 
                    SET @amount = qty * @rate;
					SET @net_amount = @amount - ((@dis/100)*@amount);
					
                    INSERT INTO `nhnxayvj_mishka-beauty`.`customer_order_table` 
					(`username`, `product_id`, `quantity`, `amount`,`discount`, `discount_quantity`, `net_amount`,`code`, `phone`, `address`, `is_cart`)
					VALUES (uname, pid, qty, @amount, @dis, discount_qty, @net_amount, cd,  ph, addr, cart);
                    
                    UPDATE `nhnxayvj_mishka-beauty`.`customer_discount_table`
					SET `counts_availed` = (@old_availed + discount_qty) WHERE 
					`code` = cd AND `product_id` = pid AND `username` = uname;
					
                    SELECT *, (SELECT TRUE) AS "Success" FROM customer_order_table WHERE invoice = LAST_INSERT_ID();
                    
			ELSEIF qty > discount_qty THEN
            
					SET @rate = (SELECT price FROM product_description_table WHERE product_id = pid);
					SET @dis = (SELECT `product_discount_table`.`percent` FROM `nhnxayvj_mishka-beauty`.`product_discount_table` WHERE `product_discount_table`.`code` = cd AND `product_discount_table`.`product_id` = pid);
					SET @amount = qty * @rate;
					SET @net_amount = (@rate * (qty-discount_qty)) + ((discount_qty*@rate)-((@dis/100)*@rate*discount_qty));
					
                    INSERT INTO `nhnxayvj_mishka-beauty`.`customer_order_table` 
					(`username`, `product_id`, `quantity`, `amount`,`discount`, `discount_quantity`, `net_amount`,`code`, `phone`, `address`, `is_cart`)
					VALUES (uname, pid, qty, @amount, @dis, discount_qty, @net_amount, cd,  ph, addr, cart);
					
                    UPDATE `nhnxayvj_mishka-beauty`.`customer_discount_table`
					SET `counts_availed` = (@old_availed + discount_qty) WHERE 
					`code` = cd AND `product_id` = pid AND `username` = uname;
                    
                    SELECT *, (SELECT TRUE) AS "Success" FROM customer_order_table WHERE invoice = LAST_INSERT_ID();
			ELSE
				SELECT "Selected product quantity is less than discounts applied" AS "Message", FALSE AS "Success";
			END IF;
		ELSE
			SELECT CONCAT("You have ", @available_qty, ", discounts is/are available" )AS "Message", FALSE AS "Success";
		END IF;
	ELSE
		SELECT "Discount not available" AS "Message", FALSE AS "Success";
	END IF;
ELSE
	SET @rate = (SELECT price FROM product_description_table WHERE product_id = pid);
    
    INSERT INTO `nhnxayvj_mishka-beauty`.`customer_order_table` 
    (`username`, `product_id`, `quantity`, `amount`, `net_amount`, `phone`, `address`, `is_cart`)
    VALUES (uname, pid, qty, @rate*qty, @rate*qty, ph, addr, cart);
    
    SELECT *, (SELECT TRUE) AS "Success" FROM customer_order_table WHERE invoice = LAST_INSERT_ID();
END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function productExists
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `productExists`(pid INT(11)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result=( SELECT COUNT(`product_table`.`product_id`) = 1
		FROM `nhnxayvj_mishka-beauty`.`product_table` WHERE `product_table`.`product_id` = pid);
	IF @result THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function savePassword
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `savePassword`(pass VARCHAR(50)) RETURNS blob
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
	RETURN AES_ENCRYPT(SHA2(pass, 256), @ky);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateComment
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateComment`(IN pid INT(11), IN uname VARCHAR(50), IN cmnt VARCHAR(100))
BEGIN
    # pid = product id, uname = username, cmnt = comment content
	IF hasReviewRight(uname, pid) THEN
		SET @previous = (SELECT COUNT(`product_comments_table`.`product_id`) = 1
        FROM `nhnxayvj_mishka-beauty`.`product_comments_table`
        WHERE `product_comments_table`.`username`= uname AND 
        `product_comments_table`.`product_id` = pid);
        
        IF @previous THEN 
			UPDATE `nhnxayvj_mishka-beauty`.`product_comments_table` SET
			`comment` = cmnt, `time` = NOW() WHERE 
            `product_id` = pid AND `username` = uname;
		ELSE
			INSERT INTO `nhnxayvj_mishka-beauty`.`product_comments_table`
			(`product_id`, `username`, `comment`) VALUES (pid, uname, cmnt);
		END IF;
        
        SELECT CONCAT("Your new comment has been updated for product: ", pid) AS "Message", TRUE AS "Success";
        
    ELSE
		SELECT CONCAT("Customer: ", uname, " has not purchased this Product: ", pid, " yet"), FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateRating
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRating`(IN pid INT(11), IN uname VARCHAR(50), IN rating FLOAT)
BEGIN
    # pid = product id, uname = username, rating = out of five rating
	IF hasReviewRight(uname, pid) THEN
		SET @old_raters = (SELECT `product_description_table`.`total_raters`
		FROM `nhnxayvj_mishka-beauty`.`product_description_table` WHERE
        `product_description_table`.`product_id` = pid);
		
        SET @previous = (SELECT COUNT(`product_rating_table`.`product_id`) = 1
        FROM `nhnxayvj_mishka-beauty`.`product_rating_table`
        WHERE `product_rating_table`.`username`= uname AND 
        `product_rating_table`.`product_id` = pid);
        
        IF @previous = TRUE THEN 
			UPDATE `nhnxayvj_mishka-beauty`.`product_rating_table` SET
			`rating` = rating, `time` = NOW() WHERE 
            `product_id` = pid AND `username` = uname;
            
            UPDATE `nhnxayvj_mishka-beauty`.`product_description_table`
			SET	`rating` = (
				SELECT AVG(`product_rating_table`.`rating`)
				FROM `nhnxayvj_mishka-beauty`.`product_rating_table`
				WHERE `product_rating_table`.`product_id` = pid
			) WHERE `product_id` = pid;
            
            SELECT CONCAT("Your new rating has been updated for product: ", pid) AS "Message", TRUE AS "Success";
        
		ELSE
			SET @avg1 = (SELECT `product_description_table`.`rating`
				FROM `nhnxayvj_mishka-beauty`.`product_description_table`
				WHERE `product_description_table`.`product_id` = pid);
			
            INSERT INTO `nhnxayvj_mishka-beauty`.`product_rating_table`
			(`product_id`, `username`, `rating`) VALUES (pid, uname, rating);
            
            UPDATE `nhnxayvj_mishka-beauty`.`product_description_table`
			SET	`rating` = (
				((@avg1*@old_raters)+rating)/(@old_raters+1)
            ),
			`total_raters` = (@old_raters + 1) WHERE `product_description_table`.`product_id` = pid;
            
            SELECT CONCAT("Your new rating has been added for product: ", pid) AS "Message", TRUE AS "Success";
		END IF;
        
    ELSE
		SELECT CONCAT("Customer: ", uname, " has not purchased this Product: ", pid, " yet"), FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateRatting
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRatting`(IN pid INT(11), IN uname VARCHAR(50), IN rating FLOAT)
BEGIN
	IF hasReviewRight(uname, pid) THEN
		SET @previous = (SELECT COUNT(`product_rating_table`.`product_id`) = 1
        FROM `nhnxayvj_mishka-beauty`.`product_rating_table`
        WHERE `product_rating_table`.`username`= uname AND 
        `product_rating_table`.`product_id` = pid);
        
		SET @old_raters = (SELECT `product_description_table`.`total_raters`
		FROM `nhnxayvj_mishka-beauty`.`product_description_table` WHERE `product_description_table`.`product_id` = pid);
        
        IF (@previous = 1) THEN 
			UPDATE `nhnxayvj_mishka-beauty`.`product_rating_table` SET
			`rating` = rating, `time` = NOW() WHERE 
            `product_id` = pid AND `username` = uname;
            
            SET @new_rating = (SELECT SUM(rating)/(@old_raters+1) FROM product_rating_table WHERE product_id = pid);
            
            UPDATE `nhnxayvj_mishka-beauty`.`product_description_table`
			SET `rating` = @new_rating, `total_raters` = (@old_raters + 1)
			WHERE `product_id` = pid;
            
			SELECT CONCAT("Your new rating has been updated for product: ", pid) AS "Message", TRUE AS "Success";
		ELSE
			SET @new_rating = (
			SELECT ((`product_description_table`.`rating` * @old_raters) + rating)/(@old_raters + 1)
			FROM `nhnxayvj_mishka-beauty`.`product_description_table` WHERE `product_description_table`.`product_id` = pid);
   
			INSERT INTO `nhnxayvj_mishka-beauty`.`product_rating_table`
			(`product_id`, `username`, `rating`) VALUES (pid, uname, rating);
			     
			UPDATE `nhnxayvj_mishka-beauty`.`product_description_table`
			SET `rating` = @new_rating, `total_raters` = (@old_raters + 1)
			WHERE `product_id` = pid;
            
			SELECT CONCAT("Your new rating has been added for product: ", pid) AS "Message", TRUE AS "Success";
		END IF;
        
    ELSE
		SELECT CONCAT("Customer: ", uname, " has not purchased this Product: ", pid, " yet"), FALSE AS "Success";
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateActivationKey
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateActivationKey`(akey VARCHAR(65), uname VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	RETURN (SELECT akey = HEX(decryptActivationKey(
    `customer_activation_table`.`activation_key`)) FROM 
	`nhnxayvj_mishka-beauty`.`customer_activation_table` WHERE username = uname);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateActivationKeyTime
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateActivationKeyTime`(uname VARCHAR(50), otime DATETIME) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	RETURN (SELECT otime <= `customer_activation_table`.`time_available` FROM 
	`nhnxayvj_mishka-beauty`.`customer_activation_table` WHERE username = uname);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateAdmin
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateAdmin`(un VARCHAR(16), pass VARCHAR(20)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @actual = (SELECT password FROM admin_table WHERE username = un);
    if AES_DECRYPT(@actual, "F3229A0B371ED2D9441B830D21A390C3") = SHA2(pass,256) then RETURN TRUE;
    ELSE RETURN FALSE;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateCustomer
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateCustomer`(cid VARCHAR(45), pass VARCHAR(32)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @actual = (SELECT password FROM customer_table WHERE customer_id = cid);
    if AES_DECRYPT(@actual, "F3229A0B371ED2D9441B830D21A390C3") = SHA2(pass,256) then RETURN TRUE;
    ELSE RETURN FALSE;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueBrand
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueBrand`(item VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (item IN 
	(SELECT `brand_table`.`brand_id` FROM `nhnxayvj_mishka-beauty`.`brand_table`));
	
    IF @result THEN
		RETURN FALSE;
    ELSE
		RETURN TRUE;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueCategory`(item VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (item IN 
	(SELECT `category_table`.`category_id` FROM `nhnxayvj_mishka-beauty`.`category_table`));
	
    IF @result THEN
		RETURN FALSE;
    ELSE
		RETURN TRUE;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueDiscount
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueDiscount`(cd VARCHAR(15), pid INT(11)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (SELECT 
		(
			(SELECT cd "code", pid "product_id")
            NOT IN
            (SELECT `product_discount_table`.`code`, `product_discount_table`.`product_id`FROM `nhnxayvj_mishka-beauty`.`product_discount_table`)
		));
	IF @result THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueEmail
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueEmail`(mail VARCHAR(45)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	SET @email = encryptEmail(mail);
	SET @u1 = (SELECT `customer_table`.`email` FROM `nhnxayvj_mishka-beauty`.`customer_table` WHERE `customer_table`.`email` = @email);
    SET @u2 = (SELECT `customer_activation_table`.`email` FROM `nhnxayvj_mishka-beauty`.`customer_activation_table` WHERE `customer_activation_table`.`email` = @email);
    
    IF @u1 IS NULL AND @u2 IS NULL THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueGroupCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueGroupCategory`(item VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (item IN 
	(SELECT `groupcategory_table`.`groupcategory_id` FROM `nhnxayvj_mishka-beauty`.`groupcategory_table`));
	
    IF @result THEN
		RETURN FALSE;
    ELSE
		RETURN TRUE;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueSubCategory
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueSubCategory`(item VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @result = (item IN 
	(SELECT `subcategory_table`.`subcategory_id` FROM `nhnxayvj_mishka-beauty`.`subcategory_table`));
	
    IF @result THEN
		RETURN FALSE;
    ELSE
		RETURN TRUE;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function validateUniqueUsername
-- -----------------------------------------------------

DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `validateUniqueUsername`(uname VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @u1 = (SELECT `customer_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_table` WHERE `customer_table`.`username` = uname);
    SET @u2 = (SELECT `customer_activation_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_activation_table` WHERE `customer_activation_table`.`username` = uname);
    
    IF @u1 IS NULL AND @u2 IS NULL THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
    END IF;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
