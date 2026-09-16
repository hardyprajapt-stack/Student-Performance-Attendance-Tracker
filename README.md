# studentTracker.sql
Student Performance &amp; Attendance Tracker is a MySQL database project used to manage student records, attendance, course enrollments, faculty details, and grades. It helps track student performance, calculate attendance, and generate academic reports using various SQL concepts such as CRUD operations, Joins, Aggregate Function


# 🎓 Student Performance & Attendance Tracker

A comprehensive **SQL Database Management and Data Analysis project** designed to manage and analyze student academic performance, attendance, departments, faculty, courses, enrollments, and grades.

This project demonstrates practical SQL skills ranging from **database creation and CRUD operations to joins, subqueries, aggregate functions, date/time functions, string manipulation, window functions, CASE expressions, primary keys, foreign keys, and data validation**.

The project uses a relational database named:

```text
student_tracker
```

---

# 📌 Project Overview

The **Student Performance & Attendance Tracker** is a relational database system designed to store and analyze academic information.

The database manages:

* 🎓 Students
* 🏢 Departments
* 👨‍🏫 Faculty
* 📚 Courses
* 📝 Enrollments
* 📅 Attendance
* 📊 Grades

The project also contains analytical SQL queries to answer practical academic questions such as:

* Which students belong to each department?
* Which students have attendance below 75%?
* Which students have high marks?
* Which faculty members are not assigned to courses?
* What is the average attendance?
* What are the highest and lowest marks in each course?
* Which students scored above the overall average?
* Which students missed more than 10 classes?
* How many students are enrolled in each department?
* How can students be ranked based on average marks?

---

# 🎯 Project Objectives

The main objectives of this project are:

1. Create a structured relational database.
2. Store student academic information.
3. Manage departments and faculty.
4. Manage courses and student enrollments.
5. Track student attendance.
6. Store student grades and marks.
7. Perform CRUD operations.
8. Practice SQL filtering and sorting.
9. Use aggregate functions for analysis.
10. Understand primary and foreign key relationships.
11. Practice different types of SQL JOINs.
12. Use subqueries for advanced analysis.
13. Perform date and time analysis.
14. Perform string manipulation.
15. Use window functions.
16. Use CASE expressions for categorization.
17. Perform real-world academic data analysis.

---

# 🛠️ Technologies Used

| Technology          | Purpose                              |
| ------------------- | ------------------------------------ |
| 🗄️ MySQL           | Database Management System           |
| SQL                 | Data querying and analysis           |
| DDL                 | Database and table creation          |
| DML                 | Insert, Update and Delete operations |
| JOINs               | Combining related tables             |
| Subqueries          | Advanced filtering                   |
| Aggregate Functions | Statistical analysis                 |
| Window Functions    | Ranking and cumulative analysis      |
| CASE                | Data categorization                  |
| Date Functions      | Time-based analysis                  |
| String Functions    | Text cleaning and formatting         |

---

# 🗂️ Database Name

```sql
student_tracker
```

Database creation:

```sql
DROP DATABASE IF EXISTS student_tracker;

CREATE DATABASE student_tracker;

USE student_tracker;
```

---

# 🏗️ Database Architecture

The database contains **7 main tables**:

```text
Departments
     │
     ├────────── Students
     │              │
     │              ├──────── Enrollments ─────── Courses
     │              │
     │              ├──────── Attendance ──────── Courses
     │              │
     │              └──────── Grades ──────────── Courses
     │
     └────────── Faculty ───────── Courses
```

---

# 📊 Database Tables

## 1️⃣ Departments

Stores information about academic departments.

```text
Departments
├── department_id
└── department_name
```

Example departments:

* Computer Science
* Mathematics
* Physics
* Commerce
* English

---

## 2️⃣ Students

Stores student personal and academic information.

```text
Students
├── student_id
├── name
├── dob
├── gender
├── email
├── phone_number
├── address
├── admission_date
└── department_id
```

The `department_id` connects each student with a department.

---

## 3️⃣ Faculty

Stores faculty information.

```text
Faculty
├── faculty_id
├── name
├── email
├── phone_number
├── experience_years
└── department_id
```

Faculty members are linked to departments.

---

# 4️⃣ Courses

Stores courses offered by the institution.

```text
Courses
├── course_id
├── course_name
└── faculty_id
```

The `faculty_id` connects a course with its assigned faculty member.

One course can also have no assigned faculty, which is intentionally demonstrated in the sample data.

---

# 5️⃣ Enrollments

Stores which students are enrolled in which courses.

```text
Enrollments
├── enrollment_id
├── student_id
├── course_id
└── enrollment_date
```

A unique constraint is used:

```sql
UNIQUE KEY uq_student_course (student_id, course_id)
```

This prevents the same student from enrolling in the same course twice.

---

# 6️⃣ Attendance

Stores student attendance records.

```text
Attendance
├── attendance_id
├── student_id
├── course_id
├── attendance_date
└── status
```

Possible attendance statuses:

```text
Present
Absent
Late
```

For analysis, both `Present` and `Late` are considered attended.

---

# 7️⃣ Grades

Stores marks and grades obtained by students.

```text
Grades
├── grade_id
├── student_id
├── course_id
├── marks_obtained
└── grade
```

Example:

```text
92.50 → A+
85.00 → A
73.00 → B
40.00 → F
```

---

# 🔗 Primary & Foreign Keys

The project demonstrates relational database relationships using:

### Primary Keys

Each table has its own unique identifier:

```text
Departments → department_id
Students → student_id
Faculty → faculty_id
Courses → course_id
Enrollments → enrollment_id
Attendance → attendance_id
Grades → grade_id
```

### Foreign Keys

Important relationships include:

```text
Students.department_id
        ↓
Departments.department_id
```

```text
Faculty.department_id
        ↓
Departments.department_id
```

```text
Courses.faculty_id
        ↓
Faculty.faculty_id
```

```text
Enrollments.student_id
        ↓
Students.student_id
```

```text
Enrollments.course_id
        ↓
Courses.course_id
```

```text
Attendance.student_id
        ↓
Students.student_id
```

```text
Attendance.course_id
        ↓
Courses.course_id
```

```text
Grades.student_id
        ↓
Students.student_id
```

```text
Grades.course_id
        ↓
Courses.course_id
```

---

# 📥 Sample Data

The project includes sample data for:

* 5 departments
* 6 faculty members
* 10 students
* 6 courses
* Multiple enrollments
* Multiple attendance records
* Multiple grade records

The sample data intentionally includes cases useful for SQL demonstrations, such as:

* Missing student emails
* Student names with extra spaces
* A course without assigned faculty
* Different attendance statuses
* Students with different performance levels
* Students with high absence counts

---

# 🧹 Data Cleaning Examples

The project demonstrates basic data cleaning using SQL.

For example, some student names contain unnecessary spaces:

```sql
TRIM(name)
```

Example:

```text
"  Aarav Shah  "
```

becomes:

```text
"Aarav Shah"
```

Missing emails are handled using:

```sql
COALESCE(email, 'Email Not Provided')
```

---

# 📝 TASK 1 — CRUD Operations

CRUD stands for:

```text
C → Create
R → Read
U → Update
D → Delete
```

The project demonstrates CRUD operations on students, faculty, courses and enrollments.

---

## INSERT

Add a new student:

```sql
INSERT INTO Students
(name, dob, gender, email, phone_number, address, admission_date, department_id)
VALUES
('Raj Malhotra', '2004-02-14', 'Male',
 'raj@mail.com', '9911223344',
 'Surat', '2024-06-01', 1);
```

---

## UPDATE

Update student contact information:

```sql
UPDATE Students
SET phone_number = '9900099001',
    address = 'Ahmedabad'
WHERE student_id = 1;
```

---

## DELETE

Before deleting a student who has related records, dependent records are removed first because of foreign-key constraints.

```sql
DELETE FROM Enrollments
WHERE student_id = 11;

DELETE FROM Students
WHERE student_id = 11;
```

---

# 🔎 TASK 2 — SQL Clauses

The project uses important SQL clauses:

```text
WHERE
HAVING
LIMIT
ORDER BY
GROUP BY
```

---

## WHERE

Example:

Find Computer Science students:

```sql
SELECT s.student_id,
       TRIM(s.name) AS name,
       s.email,
       d.department_name
FROM Students s
JOIN Departments d
ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';
```

---

## LIMIT

The project retrieves the top 10 highest-scoring records:

```sql
ORDER BY g.marks_obtained DESC
LIMIT 10;
```

---

## HAVING

Attendance below 75% is filtered using:

```sql
HAVING attendance_pct < 75;
```

This demonstrates the difference between:

```text
WHERE → filters rows before grouping
HAVING → filters grouped results
```

---

# 🔀 TASK 3 — SQL Operators

The project demonstrates:

```text
AND
OR
NOT
```

---

## AND

Students can be filtered using multiple conditions.

Example:

```text
Attendance < 50%
AND
Marks < 40
```

---

## OR

Students are identified if:

```text
Marks > 90
OR
Attendance = 100%
```

---

## NOT

The project also identifies faculty members who are **not assigned to any course**.

---

# 📊 TASK 4 — Sorting & Grouping

The project uses:

```text
ORDER BY
GROUP BY
```

---

## ORDER BY

Students are sorted alphabetically:

```sql
ORDER BY TRIM(name) ASC;
```

---

## GROUP BY

Students are counted department-wise:

```sql
SELECT d.department_name,
       COUNT(s.student_id) AS total_students
FROM Departments d
LEFT JOIN Students s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_students DESC;
```

This produces a department-level student summary.

---

# 📈 TASK 5 — Aggregate Functions

The project uses important SQL aggregate functions:

```text
SUM()
AVG()
MAX()
MIN()
COUNT()
```

---

## AVG()

Calculate average attendance:

```sql
AVG(att_pct)
```

---

## MAX()

Find the highest marks:

```sql
MAX(g.marks_obtained)
```

---

## MIN()

Find the lowest marks:

```sql
MIN(g.marks_obtained)
```

---

## COUNT()

Count students per department:

```sql
COUNT(s.student_id)
```

---

# 🔗 TASK 6 — Primary & Foreign Key Relationships

The project demonstrates referential integrity.

The enrollment table contains:

```sql
UNIQUE(student_id, course_id)
```

This prevents duplicate course enrollment.

Example test:

```sql
INSERT INTO Enrollments
(student_id, course_id, enrollment_date)
VALUES
(1, 1, '2024-01-01');
```

Because the student-course combination already exists, the database should reject the duplicate record.

---

# 🔄 TASK 7 — SQL JOINs

The project demonstrates multiple JOIN concepts.

---

## INNER JOIN

Returns matching records from both tables.

Example:

```sql
SELECT s.student_id,
       TRIM(s.name) AS student_name,
       s.email,
       d.department_name
FROM Students s
INNER JOIN Departments d
ON s.department_id = d.department_id;
```

---

## LEFT JOIN

Used to find students who are not enrolled in any course.

```sql
SELECT s.student_id,
       TRIM(s.name) AS student_name,
       s.email
FROM Students s
LEFT JOIN Enrollments e
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;
```

---

## RIGHT JOIN

Used to identify courses without assigned faculty.

```sql
SELECT c.course_id,
       c.course_name,
       f.name AS faculty_name
FROM Faculty f
RIGHT JOIN Courses c
ON f.faculty_id = c.faculty_id
WHERE c.faculty_id IS NULL;
```

---

## FULL OUTER JOIN

MySQL does not provide a native `FULL OUTER JOIN`, so the project demonstrates the concept using:

```text
LEFT JOIN
+
UNION
+
RIGHT JOIN
```

This is used to identify students without grades and unmatched records.

---

# 🧠 TASK 8 — Subqueries

Subqueries are used for more advanced analysis.

---

## Students Above Average Marks

The project calculates the overall average marks and finds students above that value.

```sql
WHERE g.marks_obtained >
(
    SELECT AVG(marks_obtained)
    FROM Grades
)
```

This demonstrates a **subquery inside a WHERE condition**.

---

## Experienced Faculty

Courses taught by faculty with at least 5 years of experience are identified using a subquery.

```sql
WHERE c.faculty_id IN
(
    SELECT faculty_id
    FROM Faculty
    WHERE experience_years >= 5
);
```

---

## Students With More Than 10 Absences

The project also uses a grouped subquery to identify students with more than 10 absent records.

```sql
HAVING absent_count > 10
```

This is useful for identifying students who may require attendance monitoring.

---

# 📅 TASK 9 — Date & Time Functions

The project uses several date functions.

---

## MONTH()

Extract month number:

```sql
MONTH(attendance_date)
```

---

## MONTHNAME()

Extract month name:

```sql
MONTHNAME(attendance_date)
```

This can be used to analyze attendance trends by month.

---

## TIMESTAMPDIFF()

Calculate years since admission:

```sql
TIMESTAMPDIFF(
    YEAR,
    admission_date,
    CURDATE()
)
```

---

## DATE_FORMAT()

Format dates into:

```text
DD-MM-YYYY
```

using:

```sql
DATE_FORMAT(attendance_date, '%d-%m-%Y')
```

---

# 🔤 TASK 10 — String Manipulation

The project demonstrates several SQL string functions.

---

## UPPER()

Convert faculty names to uppercase:

```sql
UPPER(name)
```

---

## TRIM()

Remove unnecessary spaces:

```sql
TRIM(name)
```

---

## COALESCE()

Replace missing email values:

```sql
COALESCE(
    email,
    'Email Not Provided'
)
```

Example:

```text
NULL
↓
Email Not Provided
```

---

# 🪟 TASK 11 — Window Functions

Window functions are one of the more advanced SQL concepts demonstrated in this project.

The project uses:

```text
RANK()
SUM() OVER()
```

---

# 🏆 Student Ranking

Students are ranked according to their average marks.

```sql
RANK() OVER (
    ORDER BY AVG(g.marks_obtained) DESC
)
```

This produces:

```text
Student
Average Marks
Rank
```

---

# 📈 Cumulative Attendance

The project calculates cumulative attendance percentage by course using a window function.

Conceptually:

```text
Student Attendance
        ↓
Course Grouping
        ↓
Attendance %
        ↓
Window Function
        ↓
Cumulative Attendance
```

---

# 📊 Running Enrollment Total

The project calculates monthly enrollments and a running total.

```sql
SUM(COUNT(*))
OVER (
    ORDER BY DATE_FORMAT(enrollment_date, '%Y-%m')
)
```

This helps analyze how enrollment grows over time.

---

# 🏷️ TASK 12 — CASE Expressions

CASE expressions are used to convert numerical values into meaningful categories.

---

# 🎯 Student Performance Categories

The project classifies marks as:

```text
Marks > 90
→ Excellent

75–90
→ Good

Below 75
→ Needs Improvement
```

SQL:

```sql
CASE
    WHEN g.marks_obtained > 90
        THEN 'Excellent'

    WHEN g.marks_obtained BETWEEN 75 AND 90
        THEN 'Good'

    ELSE
        'Needs Improvement'
END
```

---

# 📅 Attendance Categories

Attendance is categorized into:

```text
Above 80%
→ Regular

50%–80%
→ Irregular

Below 50%
→ Defaulter
```

This converts raw attendance percentages into useful business-style categories.

---

# 📊 Attendance Calculation

The project defines attendance percentage as:

```text
(Present + Late)
---------------- × 100
Total Classes
```

SQL logic:

```sql
SUM(
    CASE
        WHEN status IN ('Present','Late')
        THEN 1
        ELSE 0
    END
)
```

Then:

```sql
attended classes / total classes × 100
```

This means `Late` records are counted as attended.

---

# 📈 Academic Analytics

The database can be used to analyze:

### Student Performance

```text
Student
   ↓
Courses
   ↓
Marks
   ↓
Average Marks
   ↓
Performance Category
```

### Attendance

```text
Student
   ↓
Attendance Records
   ↓
Present / Late / Absent
   ↓
Attendance %
   ↓
Regular / Irregular / Defaulter
```

### Enrollment

```text
Student
   ↓
Course
   ↓
Enrollment Date
   ↓
Monthly Enrollment
   ↓
Running Total
```

---

# 💼 Real-World Business / Institutional Use Cases

This type of SQL database can support:

### 🎓 Student Management

Track:

* Student details
* Department
* Admission date
* Contact information

### 📚 Course Management

Track:

* Courses
* Assigned faculty
* Student enrollments

### 📅 Attendance Monitoring

Identify:

* Low-attendance students
* High absence counts
* Monthly attendance trends

### 📊 Academic Performance

Analyze:

* Highest marks
* Lowest marks
* Average marks
* Student rankings
* Performance categories

### 👨‍🏫 Faculty Management

Analyze:

* Faculty experience
* Department
* Course assignments
* Faculty without courses

---

# 🔍 Key SQL Concepts Covered

```text
SQL Fundamentals
│
├── CREATE DATABASE
├── CREATE TABLE
├── INSERT
├── UPDATE
├── DELETE
├── SELECT
│
├── WHERE
├── HAVING
├── LIMIT
├── ORDER BY
├── GROUP BY
│
├── AND
├── OR
├── NOT
│
├── SUM()
├── AVG()
├── MAX()
├── MIN()
├── COUNT()
│
├── INNER JOIN
├── LEFT JOIN
├── RIGHT JOIN
├── FULL OUTER JOIN concept
│
├── Subqueries
│
├── MONTH()
├── MONTHNAME()
├── TIMESTAMPDIFF()
├── DATE_FORMAT()
│
├── UPPER()
├── TRIM()
├── COALESCE()
│
├── RANK()
├── SUM() OVER()
│
└── CASE
```

---

# 🧪 Data Validation Examples

The project contains multiple validation mechanisms.

### Unique Enrollment

```sql
UNIQUE(student_id, course_id)
```

Prevents duplicate student-course enrollment.

### Foreign Keys

Ensure related records reference valid parent records.

### NOT NULL

Used for important fields such as:

```text
Student name
Attendance student_id
Attendance course_id
Attendance date
Attendance status
```

### ENUM

Used for controlled values such as:

```text
Gender:
Male
Female
Other
```

and:

```text
Attendance:
Present
Absent
Late
```

---

# 🧩 Complete Project Workflow

```text
Create Database
      ↓
Create Tables
      ↓
Define Primary Keys
      ↓
Define Foreign Keys
      ↓
Insert Sample Data
      ↓
Perform CRUD Operations
      ↓
Filter Data
      ↓
Sort & Group Data
      ↓
Aggregate Analysis
      ↓
JOIN Tables
      ↓
Use Subqueries
      ↓
Date Analysis
      ↓
String Cleaning
      ↓
Window Functions
      ↓
CASE Categorization
      ↓
Academic Insights
```

---

# ▶️ How to Run the Project

## Step 1 — Open MySQL

Open your MySQL environment such as:

```text
MySQL Workbench
```

or another MySQL-compatible SQL editor.

---

## Step 2 — Open SQL File

Open:

```text
student_tracker.sql
```

---

## Step 3 — Execute Database Setup

Run:

```sql
DROP DATABASE IF EXISTS student_tracker;

CREATE DATABASE student_tracker;

USE student_tracker;
```

---

## Step 4 — Create Tables

Execute the table creation section.

The following tables will be created:

```text
Departments
Students
Faculty
Courses
Enrollments
Attendance
Grades
```

---

## Step 5 — Insert Sample Data

Run the sample data section.

---

## Step 6 — Run Analysis Queries

Execute the tasks one by one:

```text
TASK 1 → CRUD
TASK 2 → WHERE / HAVING / LIMIT
TASK 3 → AND / OR / NOT
TASK 4 → ORDER BY / GROUP BY
TASK 5 → Aggregate Functions
TASK 6 → Keys & Relationships
TASK 7 → JOINs
TASK 8 → Subqueries
TASK 9 → Date & Time
TASK 10 → String Functions
TASK 11 → Window Functions
TASK 12 → CASE Expressions
```

---

# 📁 Recommended GitHub Structure

```text
Student-Performance-Attendance-Tracker/
│
├── student_tracker.sql
│
├── README.md
│
└── Screenshots/
    ├── database.png
    ├── tables.png
    ├── queries.png
    └── results.png
```

---

# 📸 Suggested Screenshots for GitHub

For a professional project repository, screenshots can include:

### Screenshot 1

Database and tables:

```text
student_tracker
├── Departments
├── Students
├── Faculty
├── Courses
├── Enrollments
├── Attendance
└── Grades
```

### Screenshot 2

Student performance query result.

### Screenshot 3

Attendance analysis.

### Screenshot 4

JOIN query output.

### Screenshot 5

Student ranking using `RANK()`.

### Screenshot 6

CASE-based performance and attendance categories.

---

# 🎓 Learning Outcomes

After completing this project, the following SQL skills are practiced:

* ✅ Database creation
* ✅ Table design
* ✅ Primary keys
* ✅ Foreign keys
* ✅ Unique constraints
* ✅ CRUD operations
* ✅ Filtering
* ✅ Sorting
* ✅ Grouping
* ✅ Aggregate functions
* ✅ JOINs
* ✅ Subqueries
* ✅ Date/time functions
* ✅ String functions
* ✅ Window functions
* ✅ CASE expressions
* ✅ Data validation
* ✅ Relational database concepts
* ✅ Academic data analysis

---

# 💼 Data Analyst Skills Demonstrated

This project is especially useful for demonstrating SQL skills relevant to Data Analytics.

```text
Raw Academic Data
        ↓
Database Structure
        ↓
Data Cleaning
        ↓
SQL Queries
        ↓
Data Transformation
        ↓
Aggregation
        ↓
Advanced SQL
        ↓
Performance Analysis
        ↓
Business / Institutional Insights
```

---

# 🚀 Future Improvements

The project can be extended with:

* 📊 Student performance dashboard
* 📈 Attendance trend dashboard
* 📚 Course popularity analysis
* 👨‍🏫 Faculty workload analysis
* 🏆 Top-performing student dashboard
* ⚠️ Low-attendance alerts
* 📅 Monthly attendance reports
* 📊 Department comparison
* 🐍 Python integration
* 🐼 Pandas-based analysis
* 📊 Power BI dashboard
* 🔄 Automated reporting
* 📋 Student performance reports

---

# 🔗 Possible Power BI Integration

The SQL database can later be connected to Power BI.

Possible dashboard KPIs:

```text
Total Students
Total Courses
Total Faculty
Average Marks
Average Attendance %
Total Enrollments
```

Possible visuals:

```text
Department-wise Students
Course-wise Average Marks
Attendance by Month
Student Performance
Grade Distribution
Faculty Experience
Enrollment Trends
```

---

# 🐍 Possible Python Integration

The database can also be connected to Python for advanced analytics.

Possible workflow:

```text
MySQL
  ↓
Python
  ↓
Pandas
  ↓
Data Cleaning
  ↓
Statistical Analysis
  ↓
Matplotlib / Seaborn
  ↓
Visualization
```

This can turn the SQL project into a complete **SQL + Python + Data Analytics portfolio project**.

---

# 🌟 Project Highlights

* 🎓 Complete Student Management Database
* 🏢 Department Management
* 👨‍🏫 Faculty Management
* 📚 Course Management
* 📝 Enrollment Tracking
* 📅 Attendance Tracking
* 📊 Grade Management
* 🔐 Primary & Foreign Key Relationships
* 🔄 CRUD Operations
* 🔗 Multiple SQL JOINs
* 🧠 Subqueries
* 📈 Aggregate Functions
* 🪟 Window Functions
* 📅 Date & Time Analysis
* 🔤 String Manipulation
* 🏷️ CASE-based Categorization
* 🧹 Basic Data Cleaning
* 📊 Real-world Academic Analytics

---

# 🧠 Project Complexity

```text
SQL Basics
     ↓
Database Design
     ↓
CRUD
     ↓
Filtering & Sorting
     ↓
Aggregation
     ↓
JOINs
     ↓
Subqueries
     ↓
Date & String Functions
     ↓
Window Functions
     ↓
CASE Expressions
     ↓
Advanced SQL Analysis
```

---

# 🏁 Conclusion

The **Student Performance & Attendance Tracker** demonstrates how SQL can be used to build a structured relational database and perform meaningful academic data analysis.

The project covers the complete process from:

```text
Database Creation
        ↓
Schema Design
        ↓
Sample Data
        ↓
Data Manipulation
        ↓
Data Cleaning
        ↓
SQL Analysis
        ↓
Advanced SQL
        ↓
Academic Insights
```

It provides practical experience with both **database management and analytical SQL**, making it a strong foundation for progressing toward larger **Data Analyst projects involving SQL, Python and Power BI**.

---

# 👨‍💻 Author

**Hardik Kumawat**

### Project

`Student Performance & Attendance Tracker`

### Database

`student_tracker`

### Project Type

`SQL Database & Data Analysis Project`

### Status

`Completed ✅`

### Focus

`SQL • Database Management • Data Analysis • Advanced SQL • Problem Solving`

---

⭐ If you found this project useful, consider giving the repository a **Star ⭐**.
