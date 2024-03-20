-- Create the database
CREATE DATABASE IF NOT EXISTS dbt24_a1_pes1ug22cs850_vishnu_v;

-- Use the created database
USE dbt24_a1_pes1ug22cs850_vishnu_v;

-- Create table for Department with primary key constraint
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(100)
);

-- Create table for Professor with primary key constraint
CREATE TABLE Professor (
    professor_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create table for Student with primary key constraint
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create table for Course with primary key constraint
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    name VARCHAR(50),
    credits INT,
    professor_id INT,
    department_id INT,
    FOREIGN KEY (professor_id) REFERENCES Professor(professor_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create table for Enrolled with primary key constraint
CREATE TABLE Enrolled (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create table for StudentCourse (linking table) with composite primary key constraint
CREATE TABLE StudentCourse (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Show indexes for each table
SHOW INDEX FROM Department;
SHOW INDEX FROM Professor;
SHOW INDEX FROM Student;
SHOW INDEX FROM Course;
SHOW INDEX FROM Enrolled;
SHOW INDEX FROM StudentCourse;

-- Insert data into the Student table
INSERT INTO Student (student_id, name, age, department_id) VALUES 
(1, 'Student_1', 20, 1),
(2, 'Student_2', 22, 2),
(3, 'Student_3', 21, 1),
(4, 'Student_4', 23, 3),
(5, 'Student_5', 20, 2),
(6, 'Student_6', 22, 1);

-- Index Scan
SELECT * FROM Student WHERE student_id = 10001;

-- Table Scan
SELECT * FROM Student WHERE department_id = 1 AND student_id = 1001;

-- Join Query
SELECT *
FROM Student
JOIN Enrolled ON Student.student_id = Enrolled.student_id
JOIN Course ON Enrolled.course_id = Course.course_id;

-- Join Query with WHERE Clause
SELECT Student.student_id, Student.name AS student_name, Course.name AS course_name
FROM Student
JOIN Enrolled ON Student.student_id = Enrolled.student_id
JOIN Course ON Enrolled.course_id = Course.course_id
WHERE Student.department_id = 1;

-- Explain Query Plan
EXPLAIN SELECT *
FROM Student
JOIN Enrolled ON Student.student_id = Enrolled.student_id
JOIN Course ON Enrolled.course_id = Course.course_id;

-- Select Query with WHERE Clause
SELECT * FROM Student WHERE department_id = 1;

-- Analyze Table
ANALYZE TABLE Student;

-- Create Index
CREATE INDEX idx_student_id ON Student (student_id);

-- Search Using Index
SELECT * FROM Student USE INDEX (idx_student_id) WHERE student_id = 1002;

-- Another Join Query
SELECT *
FROM Student
JOIN Enrolled ON Student.student_id = Enrolled.student_id
JOIN Course ON Enrolled.course_id = Course.course_id;

-- Another Join Query with WHERE Clause
SELECT s.*
FROM Student s
INNER JOIN Course c ON s.course_id = c.course_id
WHERE c.name = 'Course_1';

-- Subquery with IN Clause
SELECT name
FROM Student
WHERE student_id IN (SELECT student_id FROM Course WHERE name = 'Course_4');

-- Explain Query Plan for SELECT *
EXPLAIN SELECT * FROM Student;

-- Show Indexes for Student Table
SHOW INDEX FROM Student;

-- Select All Records from Student Table
SELECT * FROM Student;

-- Query Execution Time Measurement
EXPLAIN SELECT * FROM Student WHERE department_id = 1;

SET @start_time = NOW();
SELECT * FROM Student WHERE department_id = 4;
SET @end_time = NOW();
SELECT TIMEDIFF(@end_time, @start_time) AS execution_time;

-- Another Join Query
SELECT s.*
FROM student s
INNER JOIN course c ON s.course_id = c.course_id
WHERE c.name = 'Course_1';

-- Another Join Query
SELECT *
FROM Student
JOIN Enrolled ON Student.student_id = Enrolled.student_id
JOIN Course ON Enrolled.course_id = Course.course_id;

-- After Index Creation
CREATE INDEX idx_student_id ON student (student_id);

-- Explain Query Plan for JOIN
EXPLAIN SELECT *
FROM Student
JOIN Enrolled ON Student.student_id = Enrolled.student_id
JOIN Course ON Enrolled.course_id = Course.course_id;

-- Another Join Query
SELECT s.*
FROM student s
INNER JOIN course c ON s.course_id = c.course_id
WHERE c.name = 'Course_1';
