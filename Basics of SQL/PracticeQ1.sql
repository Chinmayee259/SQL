-- Create a new database named 'my_Company'
CREATE DATABASE my_Company;
USE my_Company;

-- Create a table to store employee details
CREATE TABLE employee_Info (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    salary FLOAT
);

-- Insert sample employee records
INSERT INTO employee_Info 
(id, name, salary)
VALUES
(1, "Adam", 25000),
(2, "Bob", 30000),
(3, "Casey", 40000);

-- View all employee records
SELECT * FROM employee_Info;

