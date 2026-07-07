--  UNIVERSITY COURSE MANAGEMENT SYSTEM
--  FINAL PROJECT - COMPLETE SQL IMPLEMATATION 

--  STEP  create the database

CREATE DATABASE IF NOT EXISTS UniversityCMS;
USE UniversityCMS;

--  CREATE THE TABLES 
-- table 1 DEPARTMENT
CREATE TABLE Departments (
	DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

-- table 2 students
CREATE TABLE Students (
	StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    BirthDate DATE,
    EnrollmentDate DATE
);

-- TABLE 3 INSTRUCTORS
CREATE TABLE Instructors (
	InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- table 4 courses
CREATE TABLE Courses (
	CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Credits INT,
    InstructorID INT,
    FOREIGN KEY(DepartmentID) REFERENCES Departments(DepartmentID),
	FOREIGN KEY(InstructorID) REFERENCES Instructors(InstructorID)
);

-- Table 5 Enrollments 
CREATE TABLE Enrollments (
	EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate date,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
    
    
-- insert sampal data
-- Departments 
INSERT INTO Departments (DepartmentName) VALUES
("computer science"),
("MatheMatics"),
("Physics"),
("English"),
("business administration");

-- Student
INSERT INTO Students (FirstName, lastName, Email, BirthDate, EnrollmentDate) VALUES
('John',    'Doe',      'john.doe@email.com',      '2000-01-15', '2022-08-01'),
('Jane',    'Smith',    'jane.smith@email.com',    '1999-05-25', '2021-08-01'),
('Alice',   'Brown',    'alice.brown@email.com',   '2001-03-10', '2023-08-01'),
('Bob',     'Wilson',   'bob.wilson@email.com',    '2000-07-22', '2019-08-01'),
('Charlie', 'Davis',    'charlie.davis@email.com', '1998-11-30', '2018-08-01'),
('Emily',   'Johnson',  'emily.j@email.com',       '2002-02-14', '2023-08-01'),
('Michael', 'Taylor',   'michael.t@email.com',     '1999-09-05', '2020-08-01'),
('Sophia',  'Martinez', 'sophia.m@email.com',      '2001-06-18', '2022-08-01');

--  Instructors
INSERT INTO Instructors (FirstName, LastName, Email, salary, DepartmentID) VALUES
('Alice', 'Johnson', 'alice.johnson@univ.com', 75000.00, 1),
('Bob',   'Lee',     'bob.lee@univ.com',       82000.00, 2),
('Carol', 'White',   'carol.white@univ.com',   68000.00, 3),
('David', 'King',    'david.king@univ.com',    90000.00, 1),
('Eva',   'Green',   'eva.green@univ.com',     71000.00, 4);


-- Courses
INSERT INTO Courses (CourseName, DepartmentID, credits, InstructorID) VALUES
('Introduction to SQL',  1, 3, 1),
('Data Structures',      1, 4, 1),
('Database Management',  1, 3, 4),
('Calculus I',           2, 4, 2),
('Physics Fundamentals', 3, 3, 3),
('English Composition',  4, 2, 5),
('Business Ethics',      5, 3, 5),
('Machine Learning',     1, 4, 1),
('Linear Algebra',       2, 3, 2),
('Modern Literature',    4, 2, 5);

-- Enrollment
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2022-08-01'),
(2, 2, '2021-08-01'),
(1, 3, '2022-08-01'),
(3, 1, '2023-08-01'),
(4, 1, '2019-08-01'),
(5, 1, '2018-08-01'),
(6, 1, '2023-08-01'),
(7, 2, '2020-08-01'),
(8, 3, '2022-08-01'),
(1, 2, '2022-08-01'),
(2, 3, '2021-08-01'),
(3, 4, '2023-08-01'),
(4, 5, '2019-08-01'),
(5, 6, '2018-08-01'),
(6, 8, '2023-08-01'),
(7, 9, '2020-08-01');

-- Basic crud operation
INSERT INTO Students (FirstName, LastName, Email, BirthDate, EnrollmentDate) values
('Liam', 'Scott', 'liam.scott@email.com', '2003-04-10', '2024-08-01');

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Departments;    
SELECT * FROM Enrollments;    


-- Update gmail
UPDATE Students
SET Email = "John.updated@gmail.com"
WHERE StudentID = 1;

-- update course credit values
update Courses
set credits = 5
where CourseID = 1;
    
-- update give an instructors
UPDATE Instructors
SET Salary = 95000.00
WHERE InstructorID = 4;

--  delete remove the test student created above
DELETE FROM students
WHERE Email ="liam.scott@email.com";

-- reporting queries
-- student who enrolled after 2022

SELECT StudentID, FirstName, LastName, Email, EnrollmentDate
from Students
where EnrollmentDate > "2022-12-31"
Order by EnrollmentDate ASC;

-- COURSES OF OFFERD BY THE MATHEMETICS DEPARTMENT (TOP 5)
SELECT c.CourseID, c.CourseName, c.credits
FROM Courses c
JOIN Departments d ON c.DepartmentID = d.DepartmentID
WHERE d.departmentName = "MatheMatics"
LIMIT 5;


-- Courses with more than 5 enrollled student
SELECT c.CourseName, COUNT(e.studentID) AS TotalStudents
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName 
HAVING COUNT(e.StudentID) > 5; 

-- data structure
SELECT s.StudentID, s.FirstName, s.LastName
FROM Students s
where s.StudentID in (
	SELECT e.StudentID
    FROM Enrollments e
	JOIN Courses c On e.CourseID = c.CourseID
    WHERE c.CourseName = "Introduction to SQL"
)
AND s.StudentID IN (
	SELECT e.StudentID
    FROM Enrollments e
	JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = "Data Structures"
);


-- students enrolled in EITHER "Introduction to sql" or "data structures"
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c  on e.CourseID = c.CourseID
WHERE c.CourseName in ("Introduction to sql", "data structures")
ORDER BY s.StudentID;

-- average number of redits across all course
SELECT ROUND(AVG(Credits), 2) AS AverageCredits
FROM Courses;

--  highest instructor salary in the computer science department
SELECT MAX(i.Salary) AS MaxSalary
FROM Instructors i  
JOIN Departments d on i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = "computer science";

 --  number of distinct students per department
 SELECT d.DepartmentName, COUNT(DISTINCT e.StudentID) AS TotalStudents
 FROM Enrollments e
 JOIN Courses c on e.CourseID = c.CourseID
 join Departments d ON c.DepartmentID = d.DepartmentID
 GROUP BY d.DepartmentNAme
 ORDER BY TotalStudents DESC;
 
 -- innner join studentns matched with the courses they're taking
 SELECT 
	s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName,
    e.EnrollmentDate 
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentID;
 
 
--  LEFT JOIN all students, including those with no courses
SELECT 
	s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseName,
    e.EnrollmentDate 
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.StudentID;
    

--  Students who are in courses with more than 10 total students
 SELECT s.StudentID, s.FirstName, s.Lastname
 FROM Students s 
 WHERE s.STudentID IN (
	SELECT e.StudentID
    FROM Enrollments e
	WHERE e.CourseID IN (
		SELECT CourseID
        FROM Enrollments
        GROUP by CourseID
        HAVING COUNT(StudentID) > 2
	)
);

-- Extract just the enrollment year for each student
SELECT
	StudentID,
    FirstNAme,
    LastName,
    EnrollmentDate,
    YEAR(EnrollmentDate) AS EnrollmentYear
FROM Students
ORDER BY  EnrollmentYear;


--  Combine instructor first and last name into one column
SELECT 
	InstructorID,
    CONCAT(FirstName, " ", LastName) AS FullName,
    Email,
    Salary
FROM Instructors
ORDER BY InstructorID;

-- Running total of students enrolled, course by course ( Window function)
SELECT 
	c.CourseName,
    COUNT(e.StudentID) AS StudentInCourse,
    SUM(COUNT(e.StudentID)) OVER (ORDER BY c.CourseID) AS RunningTotal
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseID , c.CourseName 
ORDER BY c.CourseID;


--  Label each student as senior or junior based on year enrolled
SELECT
	StudentID,
    FirstName,
    LastName,
    EnrollmentDate,
    CASE 
		WHEN TIMESTAMPDIFF(YEAR, EnrollmentDate, CURDATE()) > 4
			THEN "Senior"
		ELSE "Junior"
	END AS StudentLEvel
FROM Students
ORDER BY EnrollmentDate;




	