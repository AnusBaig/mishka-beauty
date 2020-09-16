DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`cpses_nh9l7fej79`@`localhost` PROCEDURE `authenticateCustomer`(IN email VARCHAR(50), IN password VARCHAR(50), IN uname VARCHAR(50))
BEGIN
    IF uname IS NULL THEN
         SET @user = (SELECT `customer_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_table` WHERE decryptEmail(`customer_table`.`email`) = email AND decryptPassword(`customer_table`.`password`) = SUBSTRING(SHA2(password, 256),1,50));
    ELSEIF email IS NULL THEN
         SET @user = (SELECT decryptEmail(`customer_table`.`email`) FROM `nhnxayvj_mishka-beauty`.`customer_table` WHERE `customer_table`.`username` = uname AND decryptPassword(`customer_table`.`password`) = SUBSTRING(SHA2(password, 256),1,50));
    END IF; 
    
    IF @user IS NULL THEN
    	SELECT "Incorrect username/email or password" AS "Message",FALSE AS "Success";
    ELSE
    	SELECT @user AS "user",TRUE AS "Success";
    END IF; 

END$$

DELIMITER ;
