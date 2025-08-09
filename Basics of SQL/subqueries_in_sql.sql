/* 
SQL SUBQUERIES
A subquery (also called an inner query or nested query) is a query inside another SQL query.
It is often used when the result of one query is needed for another.

Key points:
- The inner query is executed first.
- The result of the inner query is used by the outer query.
- Subqueries can be used in SELECT, FROM, and WHERE clauses.

General Syntax:
SELECT column(s)
FROM table_name
WHERE col_name operator
    (subquery);
*/

-- Create a database for subquery examples
CREATE DATABASE Subqueries;
USE Subqueries;

-- Create 'students' table
CREATE TABLE students (
	roll_No INT PRIMARY KEY,	-- Unique ID for each student
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);

-- Insert sample student data
INSERT INTO students 
(roll_No, name, marks, grade, city)
VALUES
("101", "Anil", 78, "C", "Pune"),
("102", "Bhumika", 93, "A", "Mumbai"),
("103", "Chetan", 85, "B", "Mumbai"),
("104", "Dhruv", 96, "A", "Dehli"), 
("105", "Emy", 12, "F", "Dehli"),
("106", "Farah", 82, "A", "Dehli");

-- View all student records
SELECT * FROM students;

-- Find the average marks of all students
SELECT AVG(marks) 
FROM students;

-- Example without subquery (static value; not recommended as it's not dynamic)
SELECT name, marks FROM students
WHERE marks > 74.3333;

-- Example with subquery (dynamic; always calculates the latest average)
SELECT name, marks 
FROM students
WHERE marks > 
(SELECT AVG(marks) 
FROM students);

------------------------------------------------------
-- 2) Subquery with IN
-- Goal: Find the names of students who have even roll numbers.

-- Step 1: Find the even roll numbers
SELECT roll_No
FROM students
WHERE roll_NO % 2 = 0;

-- Step 2: Use those roll numbers to get names (static approach)
SELECT name
FROM students
WHERE roll_NO IN(102, 104, 106);

-- Step 3: Dynamic approach using subquery
SELECT name
FROM students
WHERE roll_No IN 
(SELECT roll_No
FROM students
WHERE roll_NO % 2 = 0);

------------------------------------------------------
-- 3) Subquery in FROM
-- Goal: Find the highest marks among students from a specific city.

-- Step 1: Get all students from Dehli
SELECT *
FROM students
WHERE city = "Dehli";

-- Step 2: Find the maximum marks among those students using a subquery in FROM
SELECT MAX(marks)
FROM(SELECT *
FROM students
WHERE city = "Dehli") AS temp;

-- Example with Mumbai
SELECT MAX(marks)
FROM(SELECT *
FROM students
WHERE city = "Mumbai") AS temp;

-- Same result can be achieved without subquery:
SELECT MAX(marks)
FROM students 
WHERE city = "Dehli";

------------------------------------------------------
-- 4) Subquery in SELECT
-- Attempt: Selecting a scalar value (max marks) alongside names.
-- This query will cause an error because the subquery returns only one value, 
-- but the outer query produces multiple rows.

SELECT(SELECT MAX(marks) FROM student), name
FROM students; 
-- Error as multiple lines are not allowed
