CREATE DATABASE StudentEnrollment;

USE StudentEnrollment;

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    HOD VARCHAR(50)
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DOB DATE,
    Phone VARCHAR(15),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50) NOT NULL,
    Credits INT,
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

CREATE TABLE Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    Grade VARCHAR(5),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
    UNIQUE (Student_ID, Course_ID)
);

INSERT INTO Department VALUES
(1, 'Computer Science', 'Dr. Sharma'),
(2, 'Electronics', 'Dr. Verma'),
(3, 'Mechanical', 'Dr. Singh');

INSERT INTO Student VALUES
(101, 'Divyanshu Rai', 'divyanshu@gmail.com', '2005-02-14', '9876543210', 1),
(102, 'Aarav Singh', 'aarav@gmail.com', '2005-06-09', '9876543211', 1),
(103, 'Meera Gupta', 'meera@gmail.com', '2005-08-20', '9876543212', 2),
(104, 'Rahul Verma', 'rahul@gmail.com', '2004-12-11', '9876543213', 3);

INSERT INTO Course VALUES
(201, 'DBMS', 4, 1),
(202, 'Data Structures', 4, 1),
(203, 'Digital Electronics', 3, 2),
(204, 'Thermodynamics', 4, 3);

INSERT INTO Faculty VALUES
(301, 'Prof. Kumar', 'kumar@gmail.com', 1),
(302, 'Prof. Sinha', 'sinha@gmail.com', 2),
(303, 'Prof. Mehta', 'mehta@gmail.com', 3);

INSERT INTO Enrollment VALUES
(1001, 101, 201, '2026-08-01', 'A'),
(1002, 101, 202, '2026-08-02', 'A+'),
(1003, 102, 201, '2026-08-01', 'B+'),
(1004, 103, 203, '2026-08-03', 'A'),
(1005, 104, 204, '2026-08-04', 'B');

SELECT * FROM Department;

SELECT * FROM Student;

SELECT * FROM Course;

SELECT * FROM Faculty;

SELECT * FROM Enrollment;

SELECT
    S.Student_ID,
    S.Name,
    D.Dept_Name
FROM Student S
JOIN Department D
ON S.Dept_ID = D.Dept_ID;

SELECT
    S.Name,
    C.Course_Name,
    E.Grade
FROM Student S
JOIN Enrollment E
ON S.Student_ID = E.Student_ID
JOIN Course C
ON E.Course_ID = C.Course_ID;

SELECT
    C.Course_Name,
    COUNT(E.Student_ID) AS Total_Students
FROM Course C
LEFT JOIN Enrollment E
ON C.Course_ID = E.Course_ID
GROUP BY C.Course_ID, C.Course_Name;

SELECT
    S.Student_ID,
    S.Name,
    D.Dept_Name
FROM Student S
JOIN Department D
ON S.Dept_ID = D.Dept_ID
WHERE D.Dept_Name = 'Computer Science';

SELECT
    C.Course_Name,
    COUNT(E.Student_ID) AS Total_Students
FROM Course C
JOIN Enrollment E
ON C.Course_ID = E.Course_ID
GROUP BY C.Course_ID, C.Course_Name
HAVING COUNT(E.Student_ID) > 1;
