/*	1.1 Create a new database named school_db and a table called students with the following columns:
student_id, student_name, age, class, and address.	*/
CREATE DATABASE school_db;

USE school_db;

CREATE TABLE students
(student_id INT PRIMARY KEY,
student_name VARCHAR(30) NOT NULL,
age INT NOT NULL,
class INT NOT NULL,
address VARCHAR(50)
);



/*	1.2 Insert five records into the students table and retrieve all records using the SELECT statement.	*/
USE school_db;

INSERT INTO students
(student_id,student_name,age,class,address)
VALUES
(1,"Hemal Parmar",17,12,"Ahemdabad"),
(2,"Om Vaghela",17,12,"Surat"),
(3,"Parth Parmar",15,10,"Surat"),
(4,"Aryan Chauhan",16,11,"Ahemdabad"),
(5,"Rohit Chavda",16,11,"Rajkot");

SELECT * FROM students;



/*	2.1 Write SQL queries to retrieve specific columns (student_name and age) from the students table.	*/
USE school_db;
SELECT student_name,age FROM students;



/*	2.2 Write SQL queries to retrieve all students whose age is greater than 10.	*/
SELECT * FROM students
WHERE age > 10;



/*	3.1 Create a table teachers with the following columns: 
teacher_id (Primary Key), teacher_name (NOT NULL), subject (NOT NULL), and email (UNIQUE).	*/
USE school_db;

CREATE TABLE teachers(
teacher_id INT PRIMARY KEY,
teacher_name VARCHAR(30) NOT NULL,
subject VARCHAR(20) NOT NULL,
email VARCHAR(40) UNIQUE KEY
);



/*	3.2 :Implement a FOREIGN KEY constraint to relate the teacher_id from the teachers table with the students table.	*/
CREATE TABLE students(
student_id INT PRIMARY KEY,
student_name VARCHAR(30) NOT NULL,
age INT NOT NULL,
class INT NOT NULL,
address VARCHAR(50),
teacher_id INT,
FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);



/*	4.1 Create a table courses with columns: 
course_id, course_name, and course_credits. Set the course_id as the primary key.	*/
CREATE TABLE courses(
course_id INT PRIMARY KEY,
course_name VARCHAR(50),
course_credits INT
);



/*	4.2 Use the CREATE command to create a database university_db.	*/
CREATE DATABASE university_db;



/*	5.1 Modify the courses table by adding a column course_duration using the ALTER command.	*/
ALTER TABLE courses ADD course_durration VARCHAR(25);



/*	5.2 Drop the course_credits column from the courses table.	*/
ALTER TABLE courses DROP course_credits;



/*	6.1  Drop the teachers table from the school_db database.	*/
ALTER TABLE students
DROP FOREIGN KEY students_ibfk_1;

DROP TABLE IF EXISTS teachers;



/*	6.2  Drop the students table from the school_db database and verify that the table has been removed.	*/
USE school_db;
DROP TABLE IF EXISTS students;
SHOW TABLES;



/*	7.1  Insert three records into the courses table using the INSERT command.	*/
INSERT INTO courses(course_id,course_name,course_durration)
VALUES
(1,"Backend Development","6 Months"),
(2,"Fullstack Development","1 Year"),
(3,"Frontend Development","6 Months");



/*	7.2 Update the course duration of a specific course using the UPDATE command.	*/
UPDATE courses
SET course_durration = "7 Months"
WHERE course_id = 1;



/*	7.3 Delete a course with a specific course_id from the courses table using the DELETE command.	*/
DELETE FROM COURSES WHERE course_id = 3;



/*	8.1 Retrieve all courses from the courses table using the SELECT statement.	*/
SELECT * FROM courses;



/*	8.2 Sort the courses based on course_duration in descending order using ORDER BY.	*/
SELECT * FROM courses ORDER BY course_durration DESC;



/*	8.3 Limit the results of the SELECT query to show only the top two courses using LIMIT.	*/
SELECT * FROM courses 
LIMIT 2;



/*	9.1 Create two new users user1 and user2 and grant user1 permission to SELECT from the courses table.	*/
-- Create user1 and user2 with passwords
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password2';

-- Grant SELECT permission on the courses table to user1
GRANT SELECT ON school_db.courses TO 'user1'@'localhost';



/*	9.2 Revoke the INSERT permission from user1 and give it to user2.	*/
-- Revoke INSERT permission from user1
REVOKE INSERT ON school_db.courses FROM 'user1'@'localhost';

-- Grant INSERT permission to user2
GRANT INSERT ON school_db.courses TO 'user2'@'localhost';



/*	10.1 Insert a few rows into the courses table and use COMMIT to save the changes.	*/
START TRANSACTION;

INSERT INTO courses(course_id, course_name, course_durration)
VALUES
(3, 'Data Science', '8 Months'),
(4, 'Cloud Computing', '6 Months');

COMMIT;



/*	10.2 Insert additional rows, then use ROLLBACK to undo the last insert operation.	*/
START TRANSACTION;

INSERT INTO courses(course_id, course_name, course_durration)
VALUES
(6, 'AI & Machine Learning', '9 Months'),
(7, 'DevOps', '6 Months');

ROLLBACK;



/*	10.3 Create a SAVEPOINT before updating the courses table, and use it to rollback specific changes.	*/
-- Start a transaction
START TRANSACTION;

-- Create a SAVEPOINT before making updates
SAVEPOINT before_update;

-- Update multiple rows in the courses table
UPDATE courses SET course_durration = '10 Months' WHERE course_id = 2;
UPDATE courses SET course_durration = '12 Months' WHERE course_id = 4;

-- Rollback to the SAVEPOINT (undo the updates above)
ROLLBACK TO SAVEPOINT before_update;

-- Commit the transaction (no changes will be saved because we rolled back to before the updates)
COMMIT;



/*	11.1 Create two tables: departments and employees. Perform an INNER JOIN to display 
employees along with their respective departments.	*/
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert into departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering');

-- Insert into employees
INSERT INTO employees (emp_id, emp_name, dept_id) VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Charlie', 3),
(104, 'David', 2);

SELECT employees.emp_id, employees.emp_name, departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id;



/*	11.2 Use a LEFT JOIN to show all departments, even those without employees.	*/
SELECT departments.dept_id, departments.dept_name, employees.emp_id, employees.emp_name
FROM departments
LEFT JOIN employees ON departments.dept_id = employees.dept_id;



/*	12.1 Group employees by department and count the number of employees in each department using GROUP BY.	*/
SELECT departments.dept_name, COUNT(employees.emp_id) AS employee_count
FROM departments
LEFT JOIN employees ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name;



/*	12.2  Use the AVGaggregate function to find the average salary of employees in each department.	*/
ALTER TABLE employees ADD salary DECIMAL(10, 2);

UPDATE employees SET salary = 50000 WHERE emp_id = 101;
UPDATE employees SET salary = 60000 WHERE emp_id = 102;
UPDATE employees SET salary = 55000 WHERE emp_id = 103;
UPDATE employees SET salary = 62000 WHERE emp_id = 104;

SELECT departments.dept_name, AVG(employees.salary) AS average_salary
FROM departments
LEFT JOIN employees ON departments.dept_id = employees.dept_id
GROUP BY departments.dept_name;



/*	13.1  Write a stored procedure to retrieve all employees from the employees table based on department.	*/
DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN deptName VARCHAR(50))
BEGIN
    SELECT employees.emp_id, employees.emp_name, departments.dept_name, employees.salary
    FROM employees
    INNER JOIN departments ON employees.dept_id = departments.dept_id
    WHERE departments.dept_name = deptName;
END $$

DELIMITER ;

CALL GetEmployeesByDepartment('Finance');



/*	13.2 Write a stored procedure that accepts course_id as input and returns the course details.	*/
DELIMITER $$

CREATE PROCEDURE GetCourseDetails(IN input_course_id INT)
BEGIN
    SELECT * 
    FROM courses
    WHERE course_id = input_course_id;
END $$

DELIMITER ;



/*	14.1  Create a view to show all employees along with their department names.	*/
CREATE VIEW employee_department_view AS
SELECT 
    employees.emp_id,
    employees.emp_name,
    employees.salary,
    departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id;

SELECT * FROM employee_department_view;



/*	14.2 Modify the view to exclude employees whose salaries are below $50,000.	*/
DROP VIEW IF EXISTS employee_department_view;

CREATE VIEW employee_department_view AS
SELECT 
    employees.emp_id,
    employees.emp_name,
    employees.salary,
    departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id
WHERE employees.salary >= 50000;

SELECT * FROM employee_department_view;



/*	15.1 Create a trigger to automatically log changes to the employees table when a new employee is added.	*/
CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_type VARCHAR(10)
);

DELIMITER $$
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (emp_id, emp_name, dept_id, action_type)
    VALUES (NEW.emp_id, NEW.emp_name, NEW.dept_id, 'INSERT');
END $$
DELIMITER ;

INSERT INTO employees (emp_id, emp_name, dept_id, salary)
VALUES (106, 'Esha', 1, 58000);

SELECT * FROM employee_log;



/*	15.2  Create a trigger to update the last_modified timestamp whenever an employee record is updated.	*/
ALTER TABLE employees 
ADD last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Only needed if you want to control the timestamp manually
DELIMITER $$

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END $$

DELIMITER ;

-- This update will trigger the timestamp update
UPDATE employees
SET salary = salary + 1000
WHERE emp_id = 101;



/*	16.1  Write a PL/SQL block to print the total number of employees from the employees table.	*/
SET SERVEROUTPUT ON;
DECLARE
    total_employees NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_employees FROM employees;
    DBMS_OUTPUT.PUT_LINE('Total number of employees: ' || total_employees);
END;
/



/* 16.2 Create a PL/SQL block that calculates the total sales from an orders table.	*/
SET SERVEROUTPUT ON;

DECLARE
    total_sales NUMBER;
BEGIN
    SELECT SUM(order_amount) INTO total_sales FROM orders;
    DBMS_OUTPUT.PUT_LINE('Total Sales: ' || total_sales);
END;
/



/*	17.1 Write a PL/SQL block using an IF-THEN condition to check the department of an employee.	*/
SET SERVEROUTPUT ON;

DECLARE
    v_emp_id     employees.emp_id%TYPE := 102;  -- change the emp_id as needed
    v_dept_id    employees.dept_id%TYPE;
BEGIN
    -- Retrieve the department ID of the employee
    SELECT dept_id INTO v_dept_id
    FROM employees
    WHERE emp_id = v_emp_id;

    -- Check the department using IF-THEN
    IF v_dept_id = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' works in Human Resources.');
    ELSIF v_dept_id = 2 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' works in Finance.');
    ELSIF v_dept_id = 3 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' works in Engineering.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' works in another department.');
    END IF;
END;
/



/* 17.2 Use a FOR LOOP to iterate through employee records and display their names.	*/
SET SERVEROUTPUT ON;

DECLARE
    CURSOR emp_cursor IS
        SELECT emp_name FROM employees;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec.emp_name);
    END LOOP;
END;
/



/*	18.1 Write a PL/SQL block using an explicit cursor to retrieve and display employee details.	*/
SET SERVEROUTPUT ON;

DECLARE
    -- Declare cursor to fetch employee details
    CURSOR emp_cursor IS
        SELECT emp_id, emp_name, dept_id, salary
        FROM employees;

    -- Declare a record variable to hold one row from the cursor
    emp_rec emp_cursor%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN emp_cursor;

    -- Loop through each record
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;

        -- Display employee details
        DBMS_OUTPUT.PUT_LINE('ID: ' || emp_rec.emp_id ||
                             ', Name: ' || emp_rec.emp_name ||
                             ', Dept ID: ' || emp_rec.dept_id ||
                             ', Salary: ' || emp_rec.salary);
    END LOOP;

    -- Close the cursor
    CLOSE emp_cursor;
END;
/



/*	18.2 Create a cursor to retrieve all courses and display them one by one.	*/
SET SERVEROUTPUT ON;

DECLARE
    -- Declare cursor to fetch all courses
    CURSOR course_cursor IS
        SELECT course_id, course_name, course_durration
        FROM courses;

    -- Declare a variable to hold each row from the cursor
    course_rec course_cursor%ROWTYPE;
BEGIN
    -- Open the cursor
    OPEN course_cursor;

    -- Loop through each course
    LOOP
        FETCH course_cursor INTO course_rec;
        EXIT WHEN course_cursor%NOTFOUND;

        -- Display course details
        DBMS_OUTPUT.PUT_LINE('Course ID: ' || course_rec.course_id ||
                             ', Name: ' || course_rec.course_name ||
                             ', Duration: ' || course_rec.course_durration);
    END LOOP;

    -- Close the cursor
    CLOSE course_cursor;
END;
/



/*	19.1 Perform a transaction where you create a savepoint, insert records, then rollback to the savepoint.	*/
-- Start the transaction
START TRANSACTION;

-- First insert (before savepoint)
INSERT INTO courses (course_id, course_name, course_durration)
VALUES (8, 'Cybersecurity Fundamentals', '3 Months');

-- Create a savepoint
SAVEPOINT before_extra_insert;

-- Additional inserts (will be rolled back)
INSERT INTO courses (course_id, course_name, course_durration)
VALUES 
(9, 'Blockchain Basics', '4 Months'),
(10, 'Game Development', '5 Months');

-- Rollback to the savepoint (undo course_id 9 and 10 inserts)
ROLLBACK TO SAVEPOINT before_extra_insert;

-- Commit the transaction (only course_id 8 is saved)
COMMIT;



/*	19.2 Commit part of a transaction after using a savepoint and then rollback the remaining changes.	*/
-- Start the transaction
START TRANSACTION;

-- First insert (will be committed)
INSERT INTO courses (course_id, course_name, course_durration)
VALUES (11, 'Data Analytics', '6 Months');

-- Create a savepoint
SAVEPOINT after_first_insert;

-- Second insert (will be rolled back)
INSERT INTO courses (course_id, course_name, course_durration)
VALUES (12, 'AR/VR Development', '7 Months');

-- Commit changes up to the savepoint manually
-- Since partial COMMIT isn't possible, we simulate it by doing nothing here

-- Rollback the remaining changes
ROLLBACK TO after_first_insert;

-- Final commit (saves only what's before the savepoint)
COMMIT;

SELECT * FROM courses WHERE course_id IN (11, 12);
