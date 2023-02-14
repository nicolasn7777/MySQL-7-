CREATE DATABASE MyFunkDB;

USE MyFunkDB;

CREATE TABLE employee(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(20) NOT NULL,
phone VARCHAR(15) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE employee_position(
employee_id INT NOT NULL,
employee_post VARCHAR(30) NOT NULL,
salary DOUBLE NOT NULL,
PRIMARY KEY(employee_id),
FOREIGN KEY (employee_id) REFERENCES employee(id) 
);

CREATE TABLE personal_data(
employee_id INT NOT NULL,
marital_status VARCHAR(20) NOT NULL,
birthday DATE NOT NULL,
adress VARCHAR(30) NOT NULL,
PRIMARY KEY(employee_id),
FOREIGN KEY (employee_id) REFERENCES employee(id) 
);

INSERT INTO employee
(name, phone)
VALUES
('Bob','+380985456325'),
('Alan','+380965789652'),
('Mary','+380991111111');

INSERT INTO employee_position
(employee_id, employee_post, salary)
VALUES
(1, 'Director', 100000),
(2, 'Manager', 50000),
(3, 'Worker', 25000);

INSERT INTO personal_data
(employee_id, marital_status, birthday, adress)
VALUES
(1, 'married', '1993-10-08','Kyiv, Sacsaganskogo 9'),
(2, 'not married', '1992-09-09','Kyiv, Korolova 20'),
(3, 'married', '1991-12-10','Kyiv, Korolova 25');


DELIMITER |
CREATE PROCEDURE getPhoneAndAddress()
BEGIN
SELECT employee.name, employee.phone, personal_data.adress
FROM employee
JOIN personal_data
ON employee.id = personal_data.employee_id;
END;
|

|
CREATE PROCEDURE getMaritalNotMarried()
BEGIN
SELECT employee.name, personal_data.birthday, employee.phone
FROM employee
JOIN personal_data
ON employee.id = personal_data.employee_id
WHERE personal_data.marital_status = 'not married';
END;
|

|
CREATE PROCEDURE getManagers()
BEGIN
SELECT employee.name, personal_data.birthday, employee.phone
FROM employee
JOIN personal_data
ON employee.id = personal_data.employee_id
JOIN employee_position
ON employee.id = employee_position.employee_id
WHERE employee_position.employee_post = 'Manager';
END;
|

|
CALL getPhoneAndAddress();
|

|
CALL getMaritalNotMarried();
|

|
CALL getManagers();
|