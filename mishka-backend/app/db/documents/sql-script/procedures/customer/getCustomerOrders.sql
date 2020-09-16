DELIMITER $$
USE `nhnxayvj_mishka-beauty`$$
CREATE DEFINER=`cpses_nh9l7fej79`@`localhost` PROCEDURE `getCustomerOrders`(IN uname VARCHAR(50))
BEGIN
    SELECT `c`.`username` AS `username`,`co`.`invoice` AS `order Id`,
	`pd`.`name` AS `product name`, `pp`.`path` AS `product thumnail`, `pd`.`rating` AS `product rating`,
	`pd`.`stock` AS `stock remained`,`co`.`discount` AS `discounted amount`,
	`co`.`net_amount` AS `total amount`,`co`.`quantity` AS `quantity`, `co`.`status` AS `order status`,
	 `co`.`date` AS `date` FROM `nhnxayvj_mishka-beauty`.`customer_table` `c`
	JOIN `nhnxayvj_mishka-beauty`.`customer_order_table` `co` ON `c`.`username`=`co`.`username`
	JOIN `nhnxayvj_mishka-beauty`.`product_description_table` `pd` ON `co`.`product_id`=`pd`.`product_id`
	JOIN `nhnxayvj_mishka-beauty`.`product_picture_table` `pp` ON `co`.`product_id`=`pp`.`product_id`
	where `c`.`username`=uname ORDER BY `co`.`date` DESC;
END$$

DELIMITER ;
