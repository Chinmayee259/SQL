-- Create a new database
CREATE DATABASE FC;
USE FC;

-- Create 'fcstudents' table
CREATE TABLE fcstudents (
	roll_No INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);

-- Insert sample data
INSERT INTO fcstudents 
(roll_No, name, marks, grade, city)
VALUES
("101", "Anil", 78, "C", "Pune"),
("102", "Bhumika", 93, "A", "Mumbai"),
("103", "Chetan", 85, "B", "Mumbai"),
("104", "Dhruv", 96, "A", "Dehli"), 
("105", "Emy", 12, "F", "Dehli"),
("106", "Farah", 82, "A", "Dehli");

-- View table data
SELECT * FROM fcstudents;

------------------------------------------------------
-- Disable MySQL safe update mode (0 = OFF, 1 = ON)
SET SQL_SAFE_UPDATES = 0; -- 0 to off and 1 to on the safe mode

------------------------------------------------------
/* UPDATE Command:
   Used to modify existing records in a table.

   Syntax:
   UPDATE table_name
   SET column1 = value1, column2 = value2, ...
   WHERE condition;
*/
-- Change grade from 'A' to 'O'
UPDATE fcstudents 
SET grade = "O"
WHERE grade = "A";

-- Change marks of student with roll_No = 105 to 82
UPDATE fcstudents
SET marks = 82
WHERE roll_No = 105;

-- Change grade to 'B' for students with marks between 80 and 90
UPDATE fcstudents
SET grade = "B"
WHERE marks BETWEEN 80 AND 90;

-- Increment marks of all students by 1
UPDATE fcstudents
SET marks = marks + 1;

------------------------------------------------------
/* DELETE Command:
   Removes one or more rows from a table.

   Syntax:
   DELETE FROM table_name
   WHERE condition;
*/

-- Delete students with marks less than 85
DELETE FROM fcstudents
WHERE marks < 85;

-- View remaining data
SELECT * FROM fcstudents;

-- DELETE FROM fcstudents;  -- Deletes all rows from the table (use with caution)

------------------------------------------------------
/* ALTER Command:
   Used to change the schema (structure) of a table.
   You can add, delete, rename, or modify columns.

   1) Add a column:
      ALTER TABLE table_name
      ADD COLUMN column_name datatype constraint;

   2) Drop a column:
      ALTER TABLE table_name
      DROP COLUMN column_name;

   3) Rename a table:
      ALTER TABLE table_name
      RENAME TO new_table_name;

   4) Rename a column:
      ALTER TABLE table_name
      CHANGE COLUMN old_name new_name new_datatype constraint;

   5) Modify a column's datatype/constraint:
      ALTER TABLE table_name
      MODIFY column_name new_datatype constraint;
*/

SELECT * FROM fcstudents;

-- Add a new column 'age' with default value 19
ALTER TABLE fcstudents
ADD COLUMN age INT NOT NULL DEFAULT 19;

-- Change 'age' column datatype from INT to VARCHAR(2)
ALTER TABLE fcstudents
MODIFY COLUMN age VARCHAR(2);

-- Try inserting with 'age' = 100 (will fail because VARCHAR(2) can only hold 2 characters)
INSERT INTO fcstudents
(roll_No, name, marks, grade, city, age)
VALUES
("106", "Garagi", 68, "B", "Pune", 100);

-- This gives an error - data too long for column 'age' at row 1, because we modified the datatype to varchar with length 2
DELETE FROM fcstudents
WHERE roll_No = 106;

ALTER TABLE fcstudents 
CHANGE COLUMN age stu_age INT;
-- changed the name and datat type of age column now we can insert the age as 100
INSERT INTO fcstudents
(roll_No, name, marks, grade, city, stu_age)
VALUES
("107", "Garagi", 68, "B", "Pune", 100);

------------------------------------------------------
/* TRUNCATE Command:
   Deletes all rows from a table.
   - Faster than DELETE (no WHERE clause needed).
   - Resets auto-increment counters (if any).
   
   Syntax:
   TRUNCATE TABLE table_name;
*/