-- create database named School Management System,
-- it has been abbreviated as SMS. 

CREATE DATABASE SMS;

-- CREATE table named Student's table
CREATE TABLE IF NOT EXISTS Student
(
    Student_ID INT SERIAL DEFAULT VALUE,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name  VARCHAR(50) NOT NULL,
    Gender ENUM ('M', 'F') NOT NULL,
    Date_of_birth DATE NOT NULL,
    Date_of_entry DATE NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Phone_Number VARCHAR(50),
    PRIMARY KEY (Student_ID)
); 

-- Noticed SERIAL DEFAULT VALUE does not work in MYSQL 
-- I had to drop and modify.
ALTER TABLE student Alter Student_ID drop default;
ALTER TABLE student 
MODIFY Student_ID INT AUTO_INCREMENT;


-- create Teacher's Table
CREATE TABLE Teachers
(
Teacher_ID INT SERIAL DEFAULT VALUE,
First_Name VARCHAR(50) NOT NULL,
Last_Name VARCHAR(50) NOT NULL,
Email VARCHAR(50) UNIQUE NOT NULL,
Phone_Number VARCHAR(50),
PRIMARY KEY ( Teacher_ID)
);


-- Noticed SERIAL DEFAULT VALUE does not work in MYSQL 
-- I had to drop and modify.
ALTER TABLE Teachers Alter Teacher_ID drop default;
ALTER TABLE Teachers
MODIFY Teacher_ID INT AUTO_INCREMENT;


-- Create Courses table
CREATE TABLE Courses
(
Course_ID INT SERIAL DEFAULT VALUE,
Course_Name VARCHAR(20) NOT NULL,
Units INT  NOT NULL,
PRIMARY KEY (Course_ID)
);
-- add additional column Course_Description
ALTER table Courses
ADD COLUMN Course_Description VARCHAR(50) NOT NULL;

-- Noticed SERIAL DEFAULT VALUE does not work in MYSQL 
-- I had to drop and modify.
ALTER TABLE Courses Alter Course_ID drop default;
ALTER TABLE Courses
MODIFY Course_ID INT AUTO_INCREMENT;


-- Create the Teachers_Courses table (Junction Table)
CREATE TABLE TEACHERS_COURSES (
	TeacherID INT,
    CourseID INT,
    PRIMARY KEY (TeacherID, CourseID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(Teacher_ID),
    FOREIGN KEY (CourseID) REFERENCES Courses(Course_ID)
    
);

-- Altering the TEACHERS_COURSES table to modify the primary key 
-- Determinig the name of the PK constraint: 
SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'TEACHERS_COURSES'
  AND TABLE_SCHEMA = 'SMS'
  AND CONSTRAINT_TYPE = 'PRIMARY KEY';


-- Create Attendance Table
CREATE TABLE ATTENDANCE
( 
 ID INT PRIMARY KEY  SERIAL DEFAULT VALUE, 
 StudentID INT NOT NULL, 
 CourseID INT NOT NULL, 
 date DATE NOT NULL, 
 status VARCHAR(7) NOT NULL, 
 FOREIGN KEY (studentID) REFERENCES Student(Student_ID), 
 FOREIGN KEY (courseID) REFERENCES Courses(Course_ID) 
) ;

-- Noticed SERIAL DEFAULT VALUE does not work in MYSQL 
-- I had to drop and modify.
ALTER TABLE attendance Alter ID drop default;
ALTER TABLE attendance
MODIFY ID INT AUTO_INCREMENT;


-- Creating Gradebook table 
CREATE TABLE GRADEBOOK( 
 ID INT PRIMARY KEY SERIAL DEFAULT VALUE, 
 StudentID INT NOT NULL, 
 CourseID INT NOT NULL, 
 MarksObtained INT, 
 TotalMarks INT DEFAULT 100, 
 date Date, 
 FOREIGN KEY (StudentID) REFERENCES Student(Student_ID), 
 FOREIGN KEY (CourseID) REFERENCES Courses(Course_ID) 
) ;


/* Observation: A GRADEBOOK should have a unique entry where 
there should be no duplicate value for studentID & courseID. 
Hence they should be the primary key because a student shouldn’t 
take the same course multiple times. 
*/ 
-- Dropping the primary key (ID) 
ALTER TABLE GRADEBOOK 
DROP PRIMARY KEY;

-- Adding a new primary key 
Alter table GRADEBOOK 
ADD PRIMARY KEY (studentID, CourseID);



-- POPULATING THE TABLES
-- Inserting data into STUDENTS table 
INSERT INTO Student ( First_Name, Last_Name, Gender, Date_Of_Birth,
Date_Of_Entry, Email, Phone_Number) 
VALUES 
('John', 'Doe', 'M', '2002-03-15', '2021-09-01', 
'john.doe1@example.com', '123-456-7890'), 
('Jane', 'Smith', 'F', '2003-07-22', '2022-09-01', 
'jane.smith2@example.com', '987-654-3210'), 
('Alice', 'Johnson', 'F', '2001-11-10', '2020-09-01', 
'alice.johnson3@example.com', '555-123-4567'), 
('Robert', 'Brown', 'M', '2004-02-18', '2022-01-15', 
'robert.brown4@example.com', '444-321-6789'), 
('Emily', 'Davis', 'F', '2002-06-30', '2021-01-15', 
'emily.davis5@example.com', '666-789-1234'), 
('Michael', 'Miller', 'M', '2000-09-25', '2019-09-01', 
'michael.miller6@example.com', '777-456-2345'), 
('Sarah', 'Wilson', 'F', '2003-12-11', '2022-05-01', 
'sarah.wilson7@example.com', '888-123-7894'), 
('David', 'Moore', 'M', '2002-01-19', '2021-09-01', 
'david.moore8@example.com', '333-654-9870'), 
('Sophia', 'Taylor', 'F', '2004-07-01', '2023-01-15', 
'sophia.taylor9@example.com', '222-789-6543'), 
('James', 'Anderson', 'M', '2001-04-22', '2020-09-01', 
'james.anderson10@example.com', '999-234-5678'), 
('Olivia', 'Thomas', 'F', '2002-03-15', '2021-09-01', 
'olivia.thomas11@example.com', '123-111-7890'), 
('Liam', 'Jackson', 'M', '2003-07-22', '2022-09-01', 
'liam.jackson12@example.com', '987-222-3210'), 
('Ava', 'White', 'F', '2001-11-10', '2020-09-01', 
'ava.white13@example.com', '555-333-4567'), 
('Ethan', 'Harris', 'M', '2004-02-18', '2022-01-15', 
'ethan.harris14@example.com', '444-444-6789'), 
('Isabella', 'Martin', 'F', '2002-06-30', '2021-01-15', 
'isabella.martin15@example.com', '666-555-1234'), 
('Noah', 'Garcia', 'M', '2000-09-25', '2019-09-01', 
'noah.garcia16@example.com', '777-666-2345'), 
('Mia', 'Martinez', 'F', '2003-12-11', '2022-05-01', 
'mia.martinez17@example.com', '888-777-7894'), 
('Alexander', 'Robinson', 'M', '2002-01-19', '2021-09-01', 
'alexander.robinson18@example.com', '333-888-9870'), 
('Charlotte', 'Clark', 'F', '2004-07-01', '2023-01-15', 
'charlotte.clark19@example.com', '222-999-6543'), 
('Benjamin', 'Lewis', 'M', '2001-04-22', '2020-09-01', 
'benjamin.lewis20@example.com', '999-000-5678'), 
('Amelia', 'Lee', 'F', '2002-08-10', '2021-09-01', 
'amelia.lee21@example.com', '123-101-7890'), 
('Logan', 'Walker', 'M', '2003-05-25', '2022-09-01', 
'logan.walker22@example.com', '987-202-3210'), 
('Harper', 'Hall', 'F', '2001-09-17', '2020-09-01', 
'harper.hall23@example.com', '555-303-4567'), 
('Elijah', 'Allen', 'M', '2004-10-05', '2022-01-15', 
'elijah.allen24@example.com', '444-404-6789'), 
('Aria', 'Young', 'F', '2002-12-30', '2021-01-15', 
'aria.young25@example.com', '666-505-1234'), 
('Jacob', 'Hernandez', 'M', '2000-03-18', '2019-09-01', 
'jacob.hernandez26@example.com', '777-606-2345'), 
('Ella', 'King', 'F', '2003-01-15', '2022-05-01', 
'ella.king27@example.com', '888-707-7894'), 
('Lucas', 'Wright', 'M', '2002-04-28', '2021-09-01', 
'lucas.wright28@example.com', '333-808-9870'), 
('Abigail', 'Lopez', 'F', '2004-03-14', '2023-01-15', 
'abigail.lopez29@example.com', '222-909-6543'), 
('Daniel', 'Hill', 'M', '2001-02-27', '2020-09-01', 
'daniel.hill30@example.com', '999-101-5678'), 
('Zoe', 'Scott', 'F', '2002-05-13', '2021-09-01', 
'zoe.scott31@example.com', '123-123-4567'), 
('Henry', 'Green', 'M', '2003-06-21', '2022-09-01', 
'henry.green32@example.com', '987-321-6543'), 
('Victoria', 'Adams', 'F', '2001-11-30', '2020-09-01', 
'victoria.adams33@example.com', '555-444-3210'), 
('Jackson', 'Baker', 'M', '2004-09-11', '2022-01-15', 
'jackson.baker34@example.com', '444-555-7894'), 
('Scarlett', 'Perez', 'F', '2002-12-05', '2021-01-15', 
'scarlett.perez35@example.com', '666-666-6789'), 
('Owen', 'Carter', 'M', '2000-10-23', '2019-09-01', 
'owen.carter36@example.com', '777-777-1234'), 
('Grace', 'Mitchell', 'F', '2003-03-20', '2022-05-01', 
'grace.mitchell37@example.com', '888-888-2345'), 
('Sebastian', 'Roberts', 'M', '2002-07-04', '2021-09-01', 
'sebastian.roberts38@example.com', '333-333-7890'), 
('Layla', 'Turner', 'F', '2004-01-18', '2023-01-15', 
'layla.turner39@example.com', '222-222-9876'), 
('Aiden', 'Phillips', 'M', '2001-12-09', '2020-09-01', 
'aiden.phillips40@example.com', '999-999-4567');  
        
        -- Insert into teachers table
INSERT INTO TEACHERS (first_Name, last_Name, email, phone_Number) 
VALUES 
('Emma', 'Williams', 'emma.williams@example.com', '123-456
7890'), 
('Liam', 'Johnson', 'liam.johnson@example.com', '987-654-3210'), 
('Olivia', 'Brown', 'olivia.brown@example.com', '555-123-4567'), 
('Noah', 'Jones', 'noah.jones@example.com', '444-321-6789'), 
('Ava', 'Garcia', 'ava.garcia@example.com', '666-789-1234'), 
('Elijah', 'Martinez', 'elijah.martinez@example.com', '777-456
2345'), 
('Sophia', 'Rodriguez', 'sophia.rodriguez@example.com', '888-123
7894'), 
('James', 'Hernandez', 'james.hernandez@example.com', '333-654
9870'), 
('Isabella', 'Lopez', 'isabella.lopez@example.com', '222-789
6543'), 
('William', 'Clark', 'william.clark@example.com', '999-234
5678');


-- Insert records into the COURSES table from 100L to 700L 
INSERT INTO COURSES (Course_name, units, course_Description) 
VALUES -- Level 100 courses 
('MATH-100', 3, 'Calculus I'), 
('ENG-101', 2, 'English Composition'), 
('CS-100', 4, 'Introduction to Computer Science'), 
('PHY-101', 3, 'Physics I'), 
 -- Level 200 courses 
('MATH-200', 3, 'Calculus II'), 
('ENG-201', 2, 'Technical Writing'), 
('CS-200', 4, 'Data Structures'), 
('PHY-201', 3, 'Physics II'), 
 -- Level 300 courses 
('CS-300', 4, 'Algorithms'), 
('STAT-300', 3, 'Probability and Statistics'), 
('ENG-301', 2, 'Professional Communication'), 
('MATH-300', 3, 'Linear Algebra'), 
 -- Level 400 courses 
('CS-400', 4, 'Operating Systems'), 
('NET-400', 3, 'Computer Networks'), 
('AI-400', 3, 'Introduction to AI'), 
('DB-400', 4, 'Database Systems'), 
 -- Level 500 courses 
('DSA-500', 4, 'Data Structures and Algorithms'), 
('ML-500', 3, 'Machine Learning'), 
('SE-500', 3, 'Software Engineering'), 
('CS-500', 4, 'Advanced Programming'), 
 -- Level 600 courses 
('DL-600', 4, 'Deep Learning'), 
('CN-600', 3, 'Cloud Networking'), 
('BD-600', 3, 'Big Data Analytics'), 
('CS-600', 4, 'Advanced Software Design'), 
 -- Level 700 courses 
('AI-700', 4, 'Advanced AI'), 
('DS-700', 3, 'Data Science'), 
('SEC-700', 3, 'Cybersecurity'), 
('PM-700', 3, 'Project Management');  


-- Inserting records into the TEACHERSCOURSES table 
INSERT INTO TEACHERS_COURSES (teacherID, courseID) 
VALUES -- Teacher 1 Courses 
(1, 1), (1, 2), (1, 3), (1, 4), 
 -- Teacher 2 Courses 
(2, 3), (2, 5), (2, 6), (2, 7), 
 -- Teacher 3 courses 
(3, 8), (3, 9), (3, 10), (3, 11), 
 -- Teacher 4 courses 
(4, 12), (4, 13), (4, 14), (4, 15), 
 -- Teacher 5 courses 
(5, 16), (5, 17), (5, 18), (5, 19), 
 -- Teacher 6 courses 
(6, 20), (6, 21), (6, 22), (6, 23), 
 -- Teacher 7 courses 
(7, 24), (7, 25), (7, 26), (7, 27), 
 -- Teacher 8 courses 
(8, 1), (8, 4), (8, 8), (8, 12), (8, 16), 
 -- Teacher 9 courses 
(9, 3), (9, 7), (9, 11), (9, 15), (9, 19), 
 -- Teacher 10 courses 
(10, 2), (10, 6), (10, 10), (10, 14), (10, 18), (10, 28);   


INSERT INTO ATTENDANCE (studentID, courseID, date, status)  
VALUES 
(1, 1, DATE(DATE_SUB(NOW(), INTERVAL 1 DAY)), 'Present');  select*from attendance;


-- Insert Gradebook Records for Students and Courses 
INSERT INTO GRADEBOOK (studentID, courseID, marksObtained, date) 
VALUES 
(1, 1, 87, DATE(DATE_SUB(NOW(), INTERVAL 1 DAY))); 

INSERT INTO GRADEBOOK (studentID, courseID, marksObtained, date) 
VALUES 
(1, 2, 92, DATE(DATE_SUB(NOW(), INTERVAL 2 DAY))),
(1, 3, 78, DATE(DATE_SUB(NOW(), INTERVAL 3 DAY))),
(2, 1, 85, DATE(DATE_SUB(NOW(), INTERVAL 1 DAY))),
(2, 4, 90, DATE(DATE_SUB(NOW(), INTERVAL 3 DAY))),
(2, 5, 76, DATE(DATE_SUB(NOW(), INTERVAL 4 DAY))),
(3, 2, 81, DATE(DATE_SUB(NOW(), INTERVAL 2 DAY))),
(3, 3, 88, DATE(DATE_SUB(NOW(), INTERVAL 3 DAY))),
(3, 6, 95, DATE(DATE_SUB(NOW(), INTERVAL 5 DAY))),
(4, 1, 73, DATE(DATE_SUB(NOW(), INTERVAL 1 DAY))),
(4, 7, 68, DATE(DATE_SUB(NOW(), INTERVAL 6 DAY))),
(5, 3,  79, DATE(DATE_SUB(NOW(), INTERVAL 2 DAY))),
(5, 9, 94, DATE(DATE_SUB(NOW(), INTERVAL 8 DAY))),
(5, 10, 85, DATE(DATE_SUB(NOW(), INTERVAL 9 DAY))),
(6, 2, 82, DATE(DATE_SUB(NOW(), INTERVAL 2 DAY))),
(6, 11, 88, DATE(DATE_SUB(NOW(), INTERVAL 10 DAY))),
(6, 12, 77, DATE(DATE_SUB(NOW(), INTERVAL 11 DAY))),
(7, 4, 96, DATE(DATE_SUB(NOW(), INTERVAL 4 DAY))),
(7, 13, 85, DATE(DATE_SUB(NOW(), INTERVAL 12 DAY))),
(7, 14, 89, DATE(DATE_SUB(NOW(), INTERVAL 13 DAY))),
(8, 5, 74, DATE(DATE_SUB(NOW(), INTERVAL 3 DAY))),
(8, 15, 92, DATE(DATE_SUB(NOW(), INTERVAL 14 DAY))),
(8, 16, 81, DATE(DATE_SUB(NOW(), INTERVAL 15 DAY))),
(9, 6, 91, DATE(DATE_SUB(NOW(), INTERVAL 5 DAY))),
(9, 17, 78, DATE(DATE_SUB(NOW(), INTERVAL 16 DAY))),
(9, 18, 83, DATE(DATE_SUB(NOW(), INTERVAL 17 DAY))),
(10, 7, 88, DATE(DATE_SUB(NOW(), INTERVAL 6 DAY))),
(10, 19, 95, DATE(DATE_SUB(NOW(), INTERVAL 18 DAY))),
(10, 20, 80, DATE(DATE_SUB(NOW(), INTERVAL 19 DAY))),
(11, 8, 77, DATE(DATE_SUB(NOW(), INTERVAL 7 DAY))),
(11, 21, 88, DATE(DATE_SUB(NOW(), INTERVAL 20 DAY))),
(11, 22, 84, DATE(DATE_SUB(NOW(), INTERVAL 21 DAY))),
(12, 9, 75, DATE(DATE_SUB(NOW(), INTERVAL 8 DAY))),
(12, 23, 86, DATE(DATE_SUB(NOW(), INTERVAL 22 DAY))),
(12, 24, 79, DATE(DATE_SUB(NOW(), INTERVAL 23 DAY))),
(13, 25, 89, DATE(DATE_SUB(NOW(), INTERVAL 24 DAY))),
(13, 26, 90, DATE(DATE_SUB(NOW(), INTERVAL 25 DAY))),
(14, 11, 88, DATE(DATE_SUB(NOW(), INTERVAL 10 DAY))),
(14, 27, 91, DATE(DATE_SUB(NOW(), INTERVAL 26 DAY))),
(14, 28, 76, DATE(DATE_SUB(NOW(), INTERVAL 27 DAY))),
(15, 12, 93, DATE(DATE_SUB(NOW(), INTERVAL 11 DAY))),
(15, 1, 81, DATE(DATE_SUB(NOW(), INTERVAL 1 DAY))),
(15, 2, 88, DATE(DATE_SUB(NOW(), INTERVAL 2 DAY))),
(16, 3, 94, DATE(DATE_SUB(NOW(), INTERVAL 3 DAY))),
(16, 4, 72, DATE(DATE_SUB(NOW(), INTERVAL 4 DAY))),
(16, 5, 85, DATE(DATE_SUB(NOW(), INTERVAL 5 DAY)));









-- Querrying the tables
/*1. Retrieve Student Grades Across All Courses 
• Write a query to retrieve each student's full name, course name, marks obtained, 
and total marks from the GRADEBOOK table. Sort the result by student ID and 
course names. */

SELECT
	s.Student_ID,
	CONCAT (s.First_Name, ' ', s.Last_Name) AS Student_FullName,
    c.course_name,
    g.marksobtained AS Actual_score,
    g.totalmarks AS obtainable_score
FROM
	Student s
 JOIN
	gradebook g
ON
	s.Student_ID = g.StudentID
JOIN 
	courses c
ON
	g.CourseID = c.Course_ID
ORDER BY 
	s.student_id;
    
 
/* Track Student Attendance 
• Write a query to display attendance records for each student. Show student full 
name, course name, date of attendance, and attendance status. */

 SELECT 
	CONCAT(s.first_name, ' ',  s.last_name) AS full_name,
    c.course_name,
    a.date AS attendance_date,
    a.status AS attendance_status
FROM
	student s
INNER JOIN 
	attendance a
ON
	s.Student_ID = a.StudentID
INNER JOIN
	courses c
ON
	a.CourseID = c.Course_ID;
    
/*
Calculate Average Marks for Each Student 
• Write a query to calculate the average marks obtained by each student across all 
courses. Display the student's full name and their average marks.
*/


SELECT
	CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    AVG(g.marksobtained) AS Avg_marksobtained
FROM
	student s
INNER JOIN
	gradebook g
ON
	s.Student_ID = g.StudentID
    
GROUP BY 
	First_Name, Last_Name
ORDER BY Avg_marksobtained DESC;

/*
List Teachers and the Courses They Teach 
• Write a query to display each teacher's full name and the courses they are 
assigned to teach. Display the courses taught by multiple teachers 
*/
select*from courses;
SELECT
	CONCAT(t.first_name, ' ', t.last_name) AS full_name,
    c.Course_Description,
    c.course_name
FROM
	teachers t
INNER JOIN
	teachers_courses tc
ON
	t.Teacher_ID = tc.TeacherID
INNER JOIN
	courses c
ON
	tc.CourseID = c.Course_ID
ORDER BY 
	c.Course_Name;
    

/*
Find Courses with the Highest Enrollment 
• Determine which courses have the highest number of students enrolled. Display 
the course name and the total number of students. 
*/

SELECT 
	c.course_name,
    COUNT(s.student_id) AS Enrolled_students
FROM
	student s
INNER JOIN
	attendance a
ON
	s.Student_ID = a.StudentID
INNER JOIN 
	courses c
ON	
	a.CourseID = c.Course_ID
GROUP BY
	c.Course_Name;
    

/*
Identify Underperforming Students 
• Write a query to identify students who scored below 50% in any course. Display 
the student's full name, course name, marks obtained, and total marks.
*/

SELECT 
	CONCAT(s.first_name, ' ', s.last_name) AS Full_name,
    c.course_name AS course_code,
    g.marksobtained AS actual_mark,
    g.totalmarks AS Total_mark
FROM
	gradebook g
INNER JOIN
	 student s
ON
	g.StudentID = s.Student_ID 
INNER JOIN
	courses c
ON
	g.CourseID = c.Course_ID
WHERE 
	(g.MarksObtained / g.TotalMarks) < 0.5 ; -- an empty table returned because no student scored below 50%

/*
Generate a Report of Teacher Workloads 
• Write a query to calculate the total number of courses each teacher is responsible 
for. Display the teacher's full name and the number of courses.
*/

SELECT 
	CONCAT(t.first_name, ' ', t.last_name) AS full_name,
    COUNT(c.course_id) total_course
FROM 
	teachers t
INNER JOIN 
	teachers_courses tc
ON 
	t.Teacher_ID = tc.TeacherID
INNER JOIN 
	courses c
ON
	tc.CourseID = c.Course_ID
GROUP BY
	full_name
ORDER BY 
	total_course desc;


	

    
    
    


