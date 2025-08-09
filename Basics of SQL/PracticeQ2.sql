/* 
Practice Q2:  
For the given 'payment' table, find the total number of payments made using each payment method. 
We will use the GROUP BY clause to group records by the 'mode' column and COUNT() to count payments for each mode.
*/

-- Create a new databaseCREATE DATABASE Bank;
USE Bank;
CREATE TABLE payment(
customer_id INT PRIMARY KEY,
customer VARCHAR(10),
mode VARCHAR(10),
city VARCHAR(10)
);

-- Insert sample payment records
INSERT INTO payment
(customer_id, customer, mode, city)
VALUES
(101, "Olivia", "Netbanking", "Portland"),
(102, "Ethan", "CreditCard", "Miami"),
(103, "Maya", "CreditCard", "Seattle"),
(104, "Liam", "Netbanking", "Danver"),
(105, "Sophia", "CreditCard", "NewOrleans"),
(106, "Caleb", "DebitCard", "Boston"),
(107, "Ava", "DebitCard", "Phoenix"),
(108, "Lucas", "Netbanking", "Boston"),
(109, "Isabell", "Netbanking", "Nashville"),
(110, "Jackson", "CreditCard", "Boston");

-- Query: Count how many payments were made with each payment mode
SELECT mode, COUNT(customer_id) FROM payment Group by mode; 
