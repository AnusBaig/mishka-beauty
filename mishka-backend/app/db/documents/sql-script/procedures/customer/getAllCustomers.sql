DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`cpses_nh9l7fej79`@`localhost` PROCEDURE `getAllCustomers`()
BEGIN
    SELECT `customer_table`.`username` AS `username`, decryptEmail(`customer_table`.`email`) AS `email`, 
    decryptName(`customer_table`.`name`) AS `name`, decryptAddress(`customer_table`.`address`) AS `address`, 
    decryptPhone(`customer_table`.`contact`) AS `contact` FROM `nhnxayvj_mishka-beauty`.`customer_table`;
END$$

DELIMITER ;
