-- Create a new database named 'DYP'
CREATE DATABASE DYP;

-- Switch to the 'DYP' database
USE DYP;

-- Create a 'students' table
CREATE TABLE students (
	roll_No INT PRIMARY KEY,	-- Unique roll number for each student
    name VARCHAR(50),
    marks INT NOT NULL,			-- Marks obtained (cannot be NULL)
    grade VARCHAR(1),			-- Grade (single character: A, B, C, etc.)
    city VARCHAR(20)
);

-- Insert sample student records into 'students' table
INSERT INTO students 
(roll_No, name, marks, grade, city)
VALUES
("101", "Anil", 78, "C", "Pune"),
("102", "Bhumika", 93, "A", "Mumbai"),
("103", "Chetan", 85, "B", "Mumbai"),
("104", "Dhruv", 96, "A", "Dehli"), 
("105", "Emy", 12, "F", "Dehli"),
("106", "Farah", 82, "A", "Dehli");

-- Retrieve all records from the 'students' table
SELECT * FROM students;   

-- Retrieve only 'name' and 'marks' columns from 'students'
SELECT name, marks From students;

-- DISTINCT: Retrieve unique cities (no duplicates) from 'students'
SELECT DISTINCT city FROM students;  

-- WHERE Clause: Filter rows based on a condition
SELECT * FROM students WHERE marks >= 80;
SELECT * FROM students WHERE city = "Mumbai";

-- AND operator: Returns rows where BOTH conditions are true
SELECT * FROM students WHERE city = "Mumbai" AND marks >= 80;

-- OR operator: Returns rows where at least ONE condition is true
SELECT * FROM students WHERE city = "Mumbai" OR marks >= 80;

-- BETWEEN operator: Selects values within a given range (inclusive)
SELECT * FROM students WHERE marks BETWEEN 80 AND 90;

-- IN operator: Matches values in a given list
SELECT * FROM students WHERE city IN ("DehLi" , "Mumbai");  -- This will return the info of students from these cities
SELECT * FROM students WHERE city IN ("Pune" , "Mumbai", "Gujrat"); -- This will return the info of students from these cities execpt Gujrat

-- NOT operator: Excludes rows matching the condition
SELECT * FROM students WHERE city NOT IN ("Dehli" , "Mumbai"); -- This return info of students from cities except Dehli and Mumbai --

/* -- LIMIT Clause: Restricts the number of rows returned
SYNTAX: SELECT col1, col2 FROM table_name LIMIT number;					 */
SELECT * FROM students LIMIT 3; -- This query retrieves the first 3 records from the 'students' table.
SELECT * FROM students WHERE marks > 75 LIMIT 3; -- This query retrieves the first 3 records from the 'students' table where the marks are greater than 75.

/* ORDER BY Clause: Sorts results (ASC = ascending, DESC = descending)
   SYNTAX: SELECT col1, col2 FROM table_name
		   ORDER BY col_name(s) ASC                                               */
SELECT * FROM students ORDER BY city ASC; -- This query retrieves all records from the 'students' table and sorts them in ascending order by the 'city' column.
SELECT * FROM students ORDER BY marks DESC LIMIT 3; -- This query retrieves the top 3 students with the highest marks by sorting in descending order.

/* Aggregate Functions: Perform calculations on a column
   Popularly used functions are COUNT(), MAX(), MIN(), SUM(), AVG()		
*/
-- 1) COUNT() : used to count the number of rows that match a specified condition.
SELECT COUNT(*) FROM students; 					-- Counts all rows, including rows with NULL values. (6)
SELECT COUNT(marks) FROM students; 				-- Counts only rows where the marks column is not NULL.
SELECT COUNT(*) FROM students WHERE marks > 75; -- Counts the number of students who scored more than 75.

-- 2) MAX() and MIN() : used to find the highest and lowest values in a column, respectively.
SELECT MAX(marks) FROM students; 						-- Returns the maximum (highest) value in the marks column. (96)
SELECT MIN(marks) FROM students; 						-- Returns the minimum (lowest) value in the marks column. (12)
SELECT MAX(marks) FROM students WHERE city = 'Mumbai';  -- Finds the highest marks among students from Mumbai. (93)

-- SUM(): Adds up values
SELECT SUM(marks) FROM students; 	-- Calculates the total marks of all students (446)

-- AVG(): Finds the average value
SELECT AVG(marks) FROM students; 	-- Calculates the average marks of all students (74.3333)

/* GROUP BY Clause : Groups rows that have the same values into summary rows. It collects data from multiple records and groups the 
 result bu one or more columns. Generally we use group by with some aggregate functions */
 
SELECT city FROM students GROUP BY city; 		-- This query retrieves the list of unique cities from the 'students' table by grouping the records based on the 'city' column.
SELECT city, count(roll_No) FROM students GROUP BY city; 	-- This query retrieves each unique city from the 'students' table along with the number of students (based on roll_No) in each city.
SELECT city,name, count(roll_No) FROM students GROUP BY city,name;

-- Group with aggregate functions
SELECT city, SUM(marks) FROM students GROUP BY city;
SELECT city, MAX(marks) FROM students GROUP BY city;
SELECT city, MIN(marks) FROM students GROUP BY city;
SELECT city, AVG(marks) FROM students GROUP BY city;

-- Practice: Find average marks in each city, sorted by city
SELECT city, avg(marks) From students GROUP BY city ORDER BY city;

/* HAVING Clause : The HAVING clause is used to filter the results of groups created by the GROUP BY clause — similar to 
   how WHERE filters individual rows.
   Why Use HAVING Instead of WHERE? 
      1)WHERE filters before grouping
      2)HAVING filters after grouping
      
   SYNTAX: SELECT column, AGGREGATE_FUNCTION(column)
		   FROM table
		   GROUP BY column
           HAVING condition;
*/
SELECT city, COUNT(roll_No) FROM students GROUP BY city HAVING max(marks) > 90;
/* GROUP BY city: groups the data by city.
   COUNT(roll_No): counts the number of students per city.
   HAVING MAX(marks) > 90: filters only those groups (cities) where the maximum marks is greater than 90. */
  
-- Cities where average marks > 80
SELECT city, AVG(marks)
FROM students
GROUP BY city
HAVING AVG(marks) > 80;

-- Cities where students with grade 'A' have max marks > 90
SELECT city 
FROM students
WHERE grade = "A"
GROUP BY city
HAVING MAX(marks) > 90
ORDER BY city DESC;

/* General Order
SELECT column(s)
FROM table_name
WHERE condition
GROUP BY column(s)
HAVING condition
ORDER BY column(s) ASC/DSEC
*/

/* Foreign key :- Establishes a relationship between two tables
   SYNTAX :- FOREIGN KEY (col_name) REFERENCES table_name(Primary_key)
   
   Parent table = primary key , child table = foreign key
*/

CREATE TABLE dept(
id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(50),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id)
);

-- Cascading Foreign Key:
-- ON DELETE CASCADE → Deletes child rows if parent row is deleted
-- ON UPDATE CASCADE → Updates child rows if parent row is updated
/* EXAMPLE */
CREATE TABLE Depart(
id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE Emp(
id INT PRIMARY KEY,
name VARCHAR(50),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES Depart(id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

-- Insert sample data
INSERT INTO Depart
VALUES 
(101, "Comp"),
(102, "Civil");

-- Check data
INSERT INTO Emp
VALUES 
(1, "Rakesh", 102),
(2, "Siya", 101);

-- Update parent table (reflected in child table because of CASCADE)
SELECT * FROM Depart;
SELECT * FROM Emp;

-- MySQL Views: Virtual tables based on queries
UPDATE Depart
SET id = 103
WHERE id = 101;
-- This change is reflected in Emp table also because of cascading foreign key


/* MYSQL Views
	A view is a virtual table based on the result-set of an SQL statement
    
    SYNTAX
    CREATE VIEW view1 AS
    SELECT rollno, name FROM student;
    
    SELECT * FROM view1; 
    
    A view always shows up-to-date data. The database engine recreates the view, every time a user requires it.
*/

CREATE VIEW view1 AS
SELECT roll_No, name, marks FROM students;

-- Check data in tables and view
SELECT * FROM students;
SELECT * FROM view1; -- For Teachers only limited data

-- Remove the view
DROP VIEW view1;
SELECT * FROM view1; 





