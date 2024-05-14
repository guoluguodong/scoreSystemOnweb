-- DROP TABLE IF EXISTS grade;
-- DROP TABLE IF EXISTS myclass;
-- DROP TABLE IF EXISTS course;
-- DROP TABLE IF EXISTS student;
-- DROP TABLE IF EXISTS teacher;
-- DROP TABLE IF EXISTS user;

-- CREATE TABLE user (
--     userid VARCHAR(255) PRIMARY KEY,
--     password VARCHAR(255) NOT NULL,
--     accounttype VARCHAR(255) NOT NULL
-- );

-- INSERT INTO user (userid, password, accounttype)
-- VALUES ('student1', 'student_password', 'student');
-- INSERT INTO user (userid, password, accounttype)
-- VALUES ('teacher1', 'teacher_password', 'teacher');

-- CREATE TABLE student (
--     studentid VARCHAR(255) PRIMARY Key,
--     userid VARCHAR(255),
--     name VARCHAR(255),
--     grade INT,
--     averagescore DOUBLE,
--     ranking INT
-- );
-- INSERT INTO student (studentid, userid, name, grade, averagescore, ranking)
-- VALUES ('2', 'student3', 'Tom Doe', 1, 85.5, 2);

-- CREATE TABLE teacher (
--     teacherid VARCHAR(255) PRIMARY Key,
--     userid VARCHAR(255),
--     name VARCHAR(255)
-- );
-- INSERT INTO teacher (teacherid, userid, name)
-- VALUES ('1', 'teacher1', 'Tom Jerry');

-- CREATE TABLE course (
--     courseid VARCHAR(255) PRIMARY KEY,
--     coursename VARCHAR(255)
-- );

-- INSERT INTO course (courseid, coursename)
-- VALUES ('CSCI101', 'Computer Science');
-- INSERT INTO course (courseid, coursename)
-- VALUES ('MATH101', 'MATH');

-- CREATE TABLE myclass (
-- 	classid VARCHAR(255) PRIMARY KEY,
--     teacherid VARCHAR(255),
--     courseid VARCHAR(255),
--     totalstudents INT DEFAULT 0
-- );
-- INSERT INTO myclass (classid, teacherid, courseid, totalstudents) 
-- VALUES ('Class001', '1', 'CSCI101', 0);
-- INSERT INTO myclass (classid, teacherid, courseid, totalstudents) 
-- VALUES ('Class002', '1', 'MATH101', 0);

-- CREATE TABLE grade (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
--     studentid VARCHAR(255),
--     classid VARCHAR(255),
-- 	attendancegrade DOUBLE DEFAULT 0,
--     midtermgrade DOUBLE,
--     labgrade DOUBLE,
--     finalgrade DOUBLE,
--     comprehensivegrade DOUBLE
-- );
-- INSERT INTO grade (id,studentid, classid, attendancegrade, midtermgrade, labgrade, finalgrade, comprehensivegrade) 
-- VALUES (1,'1', 'Class001', 95, 85, 90, 88, 92);
-- INSERT INTO grade (id,studentid, classid, attendancegrade, midtermgrade, labgrade, finalgrade, comprehensivegrade) 
-- VALUES (2,'1', 'Class002', 88, 60, 90, 52, 92);

-- 首先，插入教师信息
-- INSERT INTO teacher (teacherid, userid, name) VALUES
-- ('1', 'user1', 'John Smith'),
-- ('2', 'user2', 'Emily Johnson'),
-- ('3', 'user3', 'Michael Davis'),
-- ('4', 'user4', 'Sarah Brown'),
-- ('5', 'user5', 'David Wilson'),
-- ('6', 'user6', 'Jessica Lee');

-- NSERT INTO course (courseid, coursename) VALUES
-- ('C001', 'Mathematics'),
-- ('C002', 'English'),
-- ('C003', 'Science');

-- -- For Mathematics Course
-- INSERT INTO myclass (classid, teacherid, courseid) VALUES
-- ('M001', '1', 'C001'), -- Assigning teacher with teacherid 1 to this class
-- ('M002', '2', 'C001'); -- Assigning teacher with teacherid 2 to this class

-- -- For English Course
-- INSERT INTO myclass (classid, teacherid, courseid) VALUES
-- ('E001', '3', 'C002'), -- Assigning teacher with teacherid 3 to this class
-- ('E002', '4', 'C002'); -- Assigning teacher with teacherid 4 to this class

-- -- For Science Course
-- INSERT INTO myclass (classid, teacherid, courseid) VALUES
-- ('S001', '5', 'C003'), -- Assigning teacher with teacherid 5 to this class
-- ('S002', '6', 'C003'); -- Assigning teacher with teacherid 6 to this class
-- Assuming you have a function to generate random strings and integers, you can use a loop to insert 100 records
-- Here's a generic example of how you might do it:

-- Assuming you have a function to generate random strings and integers, you can use a loop to insert 100 records
-- Here's a generic example of how you might do it:
-- delimiter $$  
-- create procedure addStudentData()
-- begin
-- 	DECLARE counter INT;
--     set counter = 1;
-- 	WHILE counter <= 100
-- 		do
-- 			INSERT INTO student (studentid, userid, name, grade, averagescore, ranking)
-- 			VALUES (
-- 				CONCAT('S', counter), -- Generating studentid like 'S1', 'S2', ..., 'S100'
-- 				CONCAT('user', counter), -- Generating userid like 'user1', 'user2', ..., 'user100'
-- 				CONCAT('Student', counter), -- Generating student names like 'Student1', 'Student2', ..., 'Student100'
-- 				FLOOR(RAND() * 12) + 1, -- Generating random grade between 1 and 12
-- 				RAND() * 100, -- Generating random average score between 0 and 100
-- 				FLOOR(RAND() * 1000) + 1 -- Generating random ranking between 1 and 1000
-- 			);
-- 			SET counter = counter + 1;
-- 		end
-- 	while;
-- end $$
-- call addStudentData(); 
UPDATE myclass
SET totalstudents = 50
WHERE classid IS NOT NULL; -- 这里可以根据你的实际需求设置条件

