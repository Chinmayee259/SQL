/*PRACTICE Q 3
  In the studnet table:
  a. Change the name of column "name" to "full_name".
  b. Delete all the students who scored marks less than 80.
  c. Delete the column for grades.
*/

-- Create a new database for this practice question
CREATE DATABASE PracticeQ3;
USE PracticeQ3;

-- Create the 'Student' table
CREATE TABLE Student(
roll_no INT PRIMARY KEY,
name VARCHAR(50),
grade VARCHAR(1),
score INT
);

-- Insert sample student records
INSERT INTO Student
(roll_no, name, grade, score)
VALUES
(1, "Abhay", "A", 98),
(2, "Shanti", "C", 50),
(3, "Rana", "B", 79),
(4, "Jaya", "B", 87),
(5, "Jethalal", "A", 90);

-- View the table data
SELECT * FROM Student;

-------------------------------------------------------
-- a) Rename column "name" to "full_name"
ALTER TABLE Student
CHANGE COLUMN name full_name VARCHAR(20);

------------------------------------------------------
-- b) Delete all students with a score less than 80
-- Turn off MySQL safe update mode to allow deletion without primary key in WHERE
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Student
WHERE score < 80;

------------------------------------------------------
-- c) Remove the "grade" column from the table
ALTER TABLE Student
DROP COLUMN grade;