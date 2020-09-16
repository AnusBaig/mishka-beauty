DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`cpses_nh9l7fej79`@`localhost` FUNCTION `decryptPassword`(password BLOB) RETURNS varchar(50) CHARSET utf8
    DETERMINISTIC
BEGIN
	SET @ky = "F3229A0B371ED2D9441B830D21A390C3";
    RETURN AES_DECRYPT(password, @ky);
END$$

DELIMITER ;