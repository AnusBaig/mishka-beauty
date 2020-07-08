DELIMITER $$

-- GetAllCustomers
DROP PROCEDURE IF EXISTS GetAllCustomers $$

CREATE PROCEDURE GetAllCustomers()
BEGIN
	SELECT * FROM customer_table;
END $$

-- GetCustomerOrders
DROP PROCEDURE If EXISTS GetCustomerOrders $$

CREATE PROCEDURE GetCustomerOrders(IN customer_id VARCHAR(50))
BEGIN
	SELECT c.customer_id,invoice,product_id,date,amount,quantity,status 
	FROM customer_table c
	JOIN customer_order_table co USING(customer_id) 
	WHERE c.customer_id = customer_id;
END $$

DELIMITER ;