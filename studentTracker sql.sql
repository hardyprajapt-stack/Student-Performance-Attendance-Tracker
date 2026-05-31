
-- PROJECT: Student Performance & Attendance Tracker


-- STEP 1: CREATE & USE DATABASE


DROP DATABASE IF EXISTS student_tracker;
CREATE DATABASE student_tracker;
USE student_tracker;


-- STEP 2: CREATE TABLES (Schema Setup)


-- Table 1: Departments
CREATE TABLE Departments (
    department_id   INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Table 2: Students
CREATE TABLE Students (
    student_id    INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    dob           DATE,
    gender        ENUM('Male', 'Female', 'Other'),
    email         VARCHAR(150),
    phone_number  VARCHAR(20),
    address       TEXT,
    admission_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Table 3: Faculty
CREATE TABLE Faculty (
    faculty_id    INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150),
    phone_number  VARCHAR(20),
    experience_years INT DEFAULT 0,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Table 4: Courses
-- faculty_id references Faculty.faculty_id (links faculty to course)
-- UNIQUE constraint on (student_id, course_id) in Enrollments prevents duplicate enrollment
CREATE TABLE Courses (
    course_id   INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    faculty_id  INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

-- Table 5: Enrollments
-- UNIQUE(student_id, course_id) ensures a student cannot enroll in same course twice
CREATE TABLE Enrollments (
    enrollment_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT NOT NULL,
    course_id       INT NOT NULL,
    enrollment_date DATE,
    UNIQUE KEY uq_student_course (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);

-- Table 6: Attendance
CREATE TABLE Attendance (
    attendance_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT NOT NULL,
    course_id       INT NOT NULL,
    attendance_date DATE NOT NULL,
    status          ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);

-- Table 7: Grades
CREATE TABLE Grades (
    grade_id       INT AUTO_INCREMENT PRIMARY KEY,
    student_id     INT NOT NULL,
    course_id      INT NOT NULL,
    marks_obtained DECIMAL(5,2),
    grade          VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);


-- STEP 3: INSERT SAMPLE DATA


-- Departments
INSERT INTO Departments (department_name) VALUES
('Computer Science'),
('Mathematics'),
('Physics'),
('Commerce'),
('English');

-- Faculty
INSERT INTO Faculty (name, email, phone_number, experience_years, department_id) VALUES
('Dr. Ramesh Kumar',   'ramesh@college.edu',  '9876543210', 10, 1),
('Prof. Sunita Rao',   'sunita@college.edu',  '9876543211',  3, 2),
('Dr. Anil Mehta',     'anil@college.edu',    '9876543212',  7, 3),
('Prof. Kavita Sharma',NULL,                  '9876543213',  2, 4),
('Dr. Priya Nair',     'priya@college.edu',   '9876543214',  6, 1),
('Prof. Deepak Joshi', 'deepak@college.edu',  '9876543215',  8, 2);

-- Students
INSERT INTO Students (name, dob, gender, email, phone_number, address, admission_date, department_id) VALUES
('  Aarav Shah  ',     '2003-05-12', 'Male',   'aarav@mail.com',   '9900001111', 'Mumbai',   '2022-06-01', 1),
('Priya Verma',        '2002-08-22', 'Female', 'priya@mail.com',   '9900002222', 'Delhi',    '2022-06-01', 1),
('Rohit Gupta',        '2003-01-15', 'Male',   NULL,               '9900003333', 'Pune',     '2022-06-01', 2),
('Sneha Patil',        '2002-11-30', 'Female', 'sneha@mail.com',   '9900004444', 'Nagpur',   '2022-06-01', 3),
('Karan Mehta',        '2003-03-20', 'Male',   'karan@mail.com',   '9900005555', 'Jaipur',   '2023-06-01', 1),
('Divya Singh',        '2002-07-08', 'Female', 'divya@mail.com',   '9900006666', 'Lucknow',  '2023-06-01', 4),
('Amit Joshi',         '2003-09-14', 'Male',   NULL,               '9900007777', 'Bhopal',   '2022-06-01', 2),
('Neha Kapoor',        '2002-04-25', 'Female', 'neha@mail.com',    '9900008888', 'Chennai',  '2023-06-01', 1),
('Vikram Reddy',       '2003-12-01', 'Male',   'vikram@mail.com',  '9900009999', 'Hyderabad','2022-06-01', 3),
('Anjali Tiwari',      '2002-06-18', 'Female', 'anjali@mail.com',  '9900001010', 'Kolkata',  '2022-06-01', 1);

-- Courses
INSERT INTO Courses (course_name, faculty_id) VALUES
('Database Management Systems', 1),
('Data Structures',             5),
('Calculus',                    2),
('Quantum Physics',             3),
('Business Studies',            4),
('Algorithms',                  NULL); -- No faculty assigned (for RIGHT JOIN demo)

-- Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1,  1, '2022-07-01'), (1,  2, '2022-07-01'),
(2,  1, '2022-07-01'), (2,  3, '2022-07-02'),
(3,  3, '2022-07-01'), (3,  4, '2022-07-01'),
(4,  4, '2022-07-01'), (4,  5, '2022-07-02'),
(5,  1, '2023-07-01'), (5,  2, '2023-07-01'),
(6,  5, '2023-07-01'),
(7,  3, '2022-07-01'),
(8,  1, '2023-07-01'), (8,  2, '2023-07-01'),
(9,  4, '2022-07-01'),
(10, 1, '2022-07-01'), (10, 2, '2022-07-01');

-- Attendance (sample records)
INSERT INTO Attendance (student_id, course_id, attendance_date, status) VALUES
(1,1,'2024-01-10','Present'),(1,1,'2024-01-11','Present'),(1,1,'2024-01-12','Absent'),
(1,1,'2024-02-10','Present'),(1,1,'2024-02-11','Present'),
(2,1,'2024-01-10','Present'),(2,1,'2024-01-11','Absent'), (2,1,'2024-01-12','Absent'),
(2,1,'2024-02-10','Absent'), (2,1,'2024-02-11','Absent'),
(3,3,'2024-01-10','Present'),(3,3,'2024-01-11','Present'),(3,3,'2024-01-12','Present'),
(4,4,'2024-01-10','Absent'), (4,4,'2024-01-11','Absent'), (4,4,'2024-01-12','Absent'),
(5,1,'2024-01-10','Present'),(5,1,'2024-01-11','Present'),(5,1,'2024-01-12','Present'),
(5,1,'2024-02-10','Present'),(5,1,'2024-02-11','Present'),
(6,5,'2024-01-10','Late'),   (6,5,'2024-01-11','Present'),
(7,3,'2024-01-10','Absent'), (7,3,'2024-01-11','Absent'), (7,3,'2024-01-12','Absent'),
(7,3,'2024-02-10','Absent'), (7,3,'2024-02-11','Absent'),
(8,1,'2024-01-10','Present'),(8,1,'2024-01-11','Present'),
(9,4,'2024-01-10','Present'),(9,4,'2024-01-11','Absent'),
(10,1,'2024-01-10','Present'),(10,1,'2024-01-11','Present'),(10,1,'2024-01-12','Present'),
(10,1,'2024-02-10','Present'),(10,1,'2024-02-11','Present'),
-- Extra absences for student 4 to exceed 10 missed classes
(4,4,'2024-02-10','Absent'),(4,4,'2024-02-11','Absent'),(4,4,'2024-02-12','Absent'),
(4,4,'2024-03-10','Absent'),(4,4,'2024-03-11','Absent'),(4,4,'2024-03-12','Absent'),
(4,4,'2024-03-13','Absent'),(4,4,'2024-03-14','Absent');

-- Grades
INSERT INTO Grades (student_id, course_id, marks_obtained, grade) VALUES
(1,  1, 92.5, 'A+'),
(1,  2, 85.0, 'A'),
(2,  1, 73.0, 'B'),
(2,  3, 88.5, 'A'),
(3,  3, 55.0, 'C'),
(3,  4, 91.0, 'A+'),
(4,  4, 40.0, 'F'),
(4,  5, 62.0, 'B'),
(5,  1, 78.0, 'B+'),
(5,  2, 95.0, 'A+'),
(6,  5, 83.0, 'A'),
(7,  3, 49.0, 'F'),
(8,  1, 88.0, 'A'),
(8,  2, 76.5, 'B+'),
(9,  4, 97.0, 'A+'),
(10, 1, 91.5, 'A+'),
(10, 2, 89.0, 'A');
-- Student 3 (Rohit) has no grade for course 4 intentionally (for FULL OUTER JOIN demo)

-- TASK 1: CRUD OPERATIONS (Low Weightage)

-- INSERT: Add a new student
INSERT INTO Students (name, dob, gender, email, phone_number, address, admission_date, department_id)
VALUES ('Raj Malhotra', '2004-02-14', 'Male', 'raj@mail.com', '9911223344', 'Surat', '2024-06-01', 1);

-- INSERT: Add a new faculty member
INSERT INTO Faculty (name, email, phone_number, experience_years, department_id)
VALUES ('Prof. Meera Desai', 'meera@college.edu', '9888776655', 4, 3);

-- INSERT: Add a new course
INSERT INTO Courses (course_name, faculty_id)
VALUES ('Artificial Intelligence', 5);

-- INSERT: Add a new enrollment
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (11, 1, '2024-07-01');

-- UPDATE: Update a student's contact details
UPDATE Students
SET phone_number = '9900099001', address = 'Ahmedabad'
WHERE student_id = 1;

-- UPDATE: Update email of a faculty member
UPDATE Faculty
SET email = 'kavita.updated@college.edu'
WHERE faculty_id = 4;

-- DELETE: Delete a student who has dropped out
-- (Remove enrollments and grades first due to FK constraints)
DELETE FROM Enrollments WHERE student_id = 11;
DELETE FROM Students    WHERE student_id = 11;


-- TASK 2: SQL CLAUSES — WHERE, HAVING, LIMIT (Low Weightage)


-- Get students enrolled in Computer Science Department
SELECT s.student_id, TRIM(s.name) AS name, s.email, d.department_name
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

-- Retrieve top 10 highest-scoring students
SELECT s.student_id, TRIM(s.name) AS name, g.marks_obtained, g.grade
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
ORDER BY g.marks_obtained DESC
LIMIT 10;

-- Find students with attendance below 75%
-- Attendance % = (Present+Late) / Total * 100
SELECT
    s.student_id,
    TRIM(s.name) AS name,
    COUNT(a.attendance_id) AS total_classes,
    SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) AS attended,
    ROUND(SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
          / COUNT(a.attendance_id), 2) AS attendance_pct
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name
HAVING attendance_pct < 75;


-- TASK 3: SQL OPERATORS — AND, OR, NOT (Medium Weightage)


-- Retrieve students with attendance below 50% AND failing (marks < 40)
SELECT DISTINCT TRIM(s.name) AS name, g.marks_obtained
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
JOIN (
    SELECT student_id,
           ROUND(SUM(CASE WHEN status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
                 / COUNT(*), 2) AS att_pct
    FROM Attendance
    GROUP BY student_id
) att ON s.student_id = att.student_id
WHERE att.att_pct < 50 AND g.marks_obtained < 40;

-- Find students who scored above 90 OR have perfect attendance (100%)
SELECT DISTINCT TRIM(s.name) AS name
FROM Students s
LEFT JOIN Grades g ON s.student_id = g.student_id
LEFT JOIN (
    SELECT student_id,
           ROUND(SUM(CASE WHEN status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
                 / COUNT(*), 2) AS att_pct
    FROM Attendance
    GROUP BY student_id
) att ON s.student_id = att.student_id
WHERE g.marks_obtained > 90 OR att.att_pct = 100;

-- List faculty members NOT assigned to any course
SELECT TRIM(f.name) AS faculty_name, f.email
FROM Faculty f
WHERE f.faculty_id NOT IN (
    SELECT DISTINCT faculty_id FROM Courses WHERE faculty_id IS NOT NULL
);

-- TASK 4: SORTING & GROUPING — ORDER BY, GROUP BY (Medium Weightage)


-- List students alphabetically by name
SELECT student_id, TRIM(name) AS name, email
FROM Students
ORDER BY TRIM(name) ASC;

-- Count number of students enrolled in each department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Departments d
LEFT JOIN Students s ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_students DESC;

-- Show average marks per course
SELECT c.course_name, ROUND(AVG(g.marks_obtained), 2) AS avg_marks
FROM Courses c
JOIN Grades g ON c.course_id = g.course_id
GROUP BY c.course_id, c.course_name
ORDER BY avg_marks DESC;


-- TASK 5: AGGREGATE FUNCTIONS — SUM, AVG, MAX, MIN, COUNT (High Weightage)


-- Find average attendance percentage of all students
SELECT ROUND(AVG(att_pct), 2) AS avg_attendance_pct
FROM (
    SELECT student_id,
           SUM(CASE WHEN status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
           / COUNT(*) AS att_pct
    FROM Attendance
    GROUP BY student_id
) sub;

-- Identify highest and lowest marks obtained in each course
SELECT c.course_name,
       MAX(g.marks_obtained) AS highest_marks,
       MIN(g.marks_obtained) AS lowest_marks
FROM Courses c
JOIN Grades g ON c.course_id = g.course_id
GROUP BY c.course_id, c.course_name;

-- Calculate total number of students per department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Departments d
LEFT JOIN Students s ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;


-- TASK 6: PRIMARY & FOREIGN KEY RELATIONSHIPS (High Weightage)

-- Already established during table creation:
-- • UNIQUE(student_id, course_id) in Enrollments prevents duplicate enrollment
-- • Faculty.faculty_id is referenced by Courses.faculty_id
-- • All FK constraints are defined with FOREIGN KEY ... REFERENCES

-- Verify unique enrollment constraint (this INSERT should FAIL with duplicate key error):
-- INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES (1, 1, '2024-01-01');

-- Show all courses with their linked faculty (demonstrates FK relationship)
SELECT c.course_id, c.course_name, f.name AS faculty_name, f.email
FROM Courses c
LEFT JOIN Faculty f ON c.faculty_id = f.faculty_id;


-- TASK 7: JOINS (High Weightage)


-- INNER JOIN: Retrieve student details along with their department
SELECT s.student_id, TRIM(s.name) AS student_name,
       s.email, d.department_name
FROM Students s
INNER JOIN Departments d ON s.department_id = d.department_id;

-- LEFT JOIN: Students who have NOT enrolled in any course
SELECT s.student_id, TRIM(s.name) AS student_name, s.email
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- RIGHT JOIN: Courses that have NO faculty assigned
SELECT c.course_id, c.course_name, f.name AS faculty_name
FROM Faculty f
RIGHT JOIN Courses c ON f.faculty_id = c.faculty_id
WHERE c.faculty_id IS NULL;

-- FULL OUTER JOIN (simulated with UNION): Students without grades
SELECT s.student_id, TRIM(s.name) AS student_name, g.marks_obtained, g.grade
FROM Students s
LEFT JOIN Grades g ON s.student_id = g.student_id
WHERE g.grade_id IS NULL
UNION
SELECT s.student_id, TRIM(s.name) AS student_name, g.marks_obtained, g.grade
FROM Students s
RIGHT JOIN Grades g ON s.student_id = g.student_id
WHERE s.student_id IS NULL;


-- TASK 8: SUBQUERIES (High Weightage)


-- Find students with marks above the average score
SELECT TRIM(s.name) AS student_name, g.marks_obtained
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
WHERE g.marks_obtained > (
    SELECT AVG(marks_obtained) FROM Grades
)
ORDER BY g.marks_obtained DESC;

-- Retrieve courses taught by faculty with at least 5 years of experience
SELECT c.course_name, f.name AS faculty_name, f.experience_years
FROM Courses c
JOIN Faculty f ON c.faculty_id = f.faculty_id
WHERE c.faculty_id IN (
    SELECT faculty_id FROM Faculty WHERE experience_years >= 5
);

-- Identify students who have missed more than 10 classes (status = 'Absent')
SELECT TRIM(s.name) AS student_name, absent_count
FROM Students s
JOIN (
    SELECT student_id, COUNT(*) AS absent_count
    FROM Attendance
    WHERE status = 'Absent'
    GROUP BY student_id
    HAVING absent_count > 10
) sub ON s.student_id = sub.student_id;

-- ============================================================
-- TASK 9: DATE & TIME FUNCTIONS (High Weightage)
-- ============================================================

-- Extract month from attendance_date to analyze attendance trends
SELECT MONTH(attendance_date)     AS month_number,
       MONTHNAME(attendance_date) AS month_name,
       COUNT(*)                   AS total_records
FROM Attendance
GROUP BY MONTH(attendance_date), MONTHNAME(attendance_date)
ORDER BY month_number;

-- Calculate number of years since a student's admission
SELECT student_id,
       TRIM(name) AS student_name,
       admission_date,
       TIMESTAMPDIFF(YEAR, admission_date, CURDATE()) AS years_since_admission
FROM Students;

-- Format attendance_date as DD-MM-YYYY
SELECT attendance_id,
       student_id,
       DATE_FORMAT(attendance_date, '%d-%m-%Y') AS formatted_date,
       status
FROM Attendance
ORDER BY attendance_date;

-- ============================================================
-- TASK 10: STRING MANIPULATION FUNCTIONS (High Weightage)
-- ============================================================

-- Convert all faculty names to UPPERCASE
SELECT faculty_id, UPPER(name) AS faculty_name_upper, email
FROM Faculty;

-- Trim unnecessary spaces from student names
SELECT student_id, name AS original_name, TRIM(name) AS trimmed_name
FROM Students;

-- Replace NULL email fields with "Email Not Provided"
SELECT student_id,
       TRIM(name) AS student_name,
       COALESCE(email, 'Email Not Provided') AS email_display
FROM Students;

-- TASK 11: WINDOW FUNCTIONS (Very High Weightage)


-- Rank students based on their overall marks (average across courses)
SELECT
    TRIM(s.name) AS student_name,
    ROUND(AVG(g.marks_obtained), 2) AS avg_marks,
    RANK() OVER (ORDER BY AVG(g.marks_obtained) DESC) AS student_rank
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.name;

-- Show cumulative attendance percentage per course
SELECT
    c.course_name,
    TRIM(s.name) AS student_name,
    ROUND(
        SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.attendance_id), 2
    ) AS attendance_pct,
    ROUND(
        SUM(SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
            / COUNT(a.attendance_id))
        OVER (PARTITION BY c.course_id ORDER BY s.student_id), 2
    ) AS cumulative_att_pct
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN Courses  c ON a.course_id  = c.course_id
GROUP BY c.course_id, c.course_name, s.student_id, s.name;

-- Display running total of students enrolled per month
SELECT
    DATE_FORMAT(enrollment_date, '%Y-%m')  AS enroll_month,
    COUNT(*)                               AS new_enrollments,
    SUM(COUNT(*)) OVER (ORDER BY DATE_FORMAT(enrollment_date, '%Y-%m')) AS running_total
FROM Enrollments
GROUP BY DATE_FORMAT(enrollment_date, '%Y-%m')
ORDER BY enroll_month;


-- TASK 12: SQL CASE EXPRESSIONS (Very High Weightage)

-- Assign student performance levels based on marks
SELECT
    TRIM(s.name) AS student_name,
    c.course_name,
    g.marks_obtained,
    CASE
        WHEN g.marks_obtained > 90              THEN 'Excellent'
        WHEN g.marks_obtained BETWEEN 75 AND 90 THEN 'Good'
        ELSE                                         'Needs Improvement'
    END AS performance_level
FROM Grades g
JOIN Students s ON g.student_id = s.student_id
JOIN Courses  c ON g.course_id  = c.course_id
ORDER BY g.marks_obtained DESC;

-- Categorize attendance records
SELECT
    TRIM(s.name) AS student_name,
    ROUND(
        SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.attendance_id), 2
    ) AS attendance_pct,
    CASE
        WHEN SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
             / COUNT(a.attendance_id)  > 80              THEN 'Regular'
        WHEN SUM(CASE WHEN a.status IN ('Present','Late') THEN 1 ELSE 0 END) * 100.0
             / COUNT(a.attendance_id) BETWEEN 50 AND 80  THEN 'Irregular'
        ELSE                                                  'Defaulter'
    END AS attendance_category
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
GROUP BY s.student_id, s.name
ORDER BY attendance_pct DESC;


-- END OF student_tracker.sql