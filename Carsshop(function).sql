USE carsshop;

DELIMITER |
CREATE FUNCTION MinimalAge() 
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT MIN(cl.age) FROM clients cl 
		INNER JOIN orders o ON cl.id = o.client_id
		INNER JOIN cars c ON c.id = o.car_id
		INNER JOIN marks m ON c.mark_id = m.id);
END
|

SELECT MinimalAge(), cl.name, m.mark
FROM clients cl 
INNER JOIN orders o ON cl.id = o.client_id
INNER JOIN cars c ON c.id = o.car_id
INNER JOIN marks m ON c.mark_id = m.id
WHERE cl.age = MinimalAge();