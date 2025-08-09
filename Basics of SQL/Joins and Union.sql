/* 
JOINS in SQL
A JOIN is used to combine rows from two or more tables based on a related column between them.

Types of Joins:
1) INNER JOIN  – Returns rows that have matching values in both tables.
2) LEFT JOIN   – Returns all rows from the left table and matching rows from the right table.
3) RIGHT JOIN  – Returns all rows from the right table and matching rows from the left table.
4) FULL JOIN   – Returns all rows from both tables (not directly supported in MySQL; achieved using UNION of LEFT JOIN and RIGHT JOIN).
*/
 
-- Create a new database for JOIN examples
CREATE DATABASE Joins;
USE Joins;

-- Create 'student' table
CREATE TABLE student(
id INT PRIMARY KEY,
name VARCHAR(50)
);

-- Insert sample data into 'student'
INSERT INTO student
(id, name)
VALUES
(101, "adam"),
(102, "bob"),
(103, "casey");

-- Create 'course' table
CREATE TABLE course(
id INT PRIMARY KEY,
course VARCHAR(50)
);

-- Insert sample data into 'course'
INSERT INTO course
(id, course)
VALUES
(101, "english"),
(102, "math"),
(103, "science"),
(104, "computer");


-- View data
SELECT * FROM student;
SELECT * FROM course;

/*	Inner Join :- Returns records that have matching values in both tables
	SYNTAX :-
    SELECT column(s)
    FROM tableA
    INNER JOIN tableB
    ON tableA.col_name = tableB.col_name;
*/
SELECT * FROM student AS s  -- 'AS' is used to assign a short alias name to a table
INNER JOIN course AS c
ON s.id = c.id;

/* Left Join :- Returns all records from the left table and the matched recorde from the right table
	SYNTAX :-
    SELECT column(s)
    FROM tableA
    LEFT JOIN tableB
    ON tableA.col_name = tableB.col_name;
*/
SELECT * FROM student AS s  
LEFT JOIN course AS c
ON s.id = c.id;

/* Right Join :- Returns all records from the right table and the matched recorde from the left table
	SYNTAX :-
    SELECT column(s)
    FROM tableA
    Right JOIN tableB
    ON tableA.col_name = tableB.col_name;
*/
SELECT * FROM student AS s  
RIGHT JOIN course AS c
ON s.id = c.id;

/* FULL join :- Cant directly do full join in my sql . But can use full join in oracal
In my sql we take union of left join and right join 

SYNTAX
SELECT column(s)
FROM tableA
LEFT JOIN tableB
ON tableA.col_name = tableB.col_name
UNION
SELECT column(s)
FROM tableA
Right JOIN tableB
ON tableA.col_name = tableB.col_name; 
*/
SELECT * FROM student AS s  
LEFT JOIN course AS c
ON s.id = c.id
UNION
SELECT * FROM student AS s  
RIGHT JOIN course AS c
ON s.id = c.id;

-- LEFT EXCLUSIVE JOIN: Rows present in LEFT table but not in RIGHT table
SELECT * FROM student AS s  
LEFT JOIN course AS c
ON s.id = c.id
WHERE c.id IS NULL;

-- RIGHT EXCLUSIVE JOIN: Rows present in RIGHT table but not in LEFT table
SELECT * FROM student AS s  
RIGHT JOIN course AS c
ON s.id = c.id
WHERE s.id IS NULL;

-- FULL EXCLUSIVE JOIN: Rows that exist in one table but not in both
SELECT * FROM student AS s  
LEFT JOIN course AS c
ON s.id = c.id
WHERE c.id IS NULL
UNION
SELECT * FROM student AS s  
RIGHT JOIN course AS c
ON s.id = c.id
WHERE s.id IS NULL;

/* SELF join : It is a regular join but the table is joined with itself.
   SYNTAX 
   SELECT column(s)
   FROM table as a
   JOIN table as b
   ON a.col_name = b.col_name;
*/
CREATE TABLE Employee(
id INT PRIMARY KEY,
name VARCHAR(50),
manager_id INT
); 

-- Insert sample employee data
INSERT INTO Employee
(id, name, manager_id)
VALUES
(101, "adam", 103),
(102, "bob", 104),
(103, "casey", NULL),
(104, "donald", 103);

-- View employees
SELECT * FROM Employee;

-- Find employees and their managers
SELECT a.name, b.name 
FROM Employee as a
JOIN Employee as b
ON a.id = b.manager_id;

/* UNION
	It is used to combine the result-set of 2 or more SELECT statements. Gives UNIQUE records.
    To use it:
     1) Every SELECT should have some no. of columns
     2) Columns must have similar data types
     3) Columns in every SELECT should be in same order.
	Syntax:
    SELECT column(s) FROM tableA
    UNION
    SELECT column(s) FROM tableB
*/
SELECT name FROM Employee
UNION 
SELECT name FROM Employee;

/* UNION ALL
   allows duplicate values */
SELECT name FROM Employee
UNION ALL
SELECT name FROM Employee; 