DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`cpses_nhpe2ynhrt`@`localhost` FUNCTION `isCustomerSignedUp`(uname VARCHAR(50),email VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	SET @userExist = (SELECT `customer_activation_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_activation_table` WHERE `customer_activation_table`.`username` = uname OR decryptEmail(`customer_activation_table`.`email`) = email);

    IF @userExist IS NULL THEN
        SET @userExist = (SELECT `customer_table`.`username` FROM `nhnxayvj_mishka-beauty`.`customer_table` WHERE `customer_table`.`username` = uname OR decryptEmail(`customer_table`.`email`) = email);
    END IF; 

    IF @userExist IS NULL THEN RETURN FALSE;
    ELSE RETURN TRUE;
    END IF;
END$$

DELIMITER ;
