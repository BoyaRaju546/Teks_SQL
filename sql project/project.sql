-- creating and using database
create database project;
use project;

-- creating tables
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    enrollment_date DATE NOT NULL
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    credits INT NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade CHAR(2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id)
);

-- inserting values
INSERT INTO students (first_name, last_name, email, date_of_birth, enrollment_date)
VALUES
('Raju', 'Boya', 'raj@example.com', '2002-05-15', '2025-09-01'),
('sidhu', 'posu', 'sidhu@example.com', '2001-03-22', '2025-08-15'),
('shiva', 'kamampati', 'shiva@example.com', '2003-07-30', '2025-07-25'),
('bharat', 'pagidi', 'bharat@example.com', '2003-08-30', '2025-07-25');

INSERT INTO courses (course_name, course_description, credits)
VALUES
('Data Science', 'Introduction to data science', 3),
('Python Full Stack', 'Learning the basics of Python programming', 4),
('Java Full Stack', 'Study of Java development', 3);

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES
(1, 1, '2025-09-01', 'A'),
(1, 3, '2025-09-01', 'B'),
(2, 2, '2025-08-15', 'A'),
(3, 1, '2025-07-25', 'B');

-- 1
-- joins and like operators
-- select s.first_name as toppers,e.grade from students s,enrollments e where s.student_id=e.student_id and grade like'a';
select s.first_name as toppers,e.grade from enrollments e join students s on e.student_id=s.student_id where grade like'a';

select max(credits) from courses as maximum_credits;

-- 2
-- exists and logical operation and having 
select s.first_name from students s where exists(select * from courses c, enrollments e where c.course_id=e.course_id and e.student_id=s.student_id having course_name='data science');

-- 3
-- order by and comparation operation
-- select course_name,credits from courses c order by credits desc ;
select enrollment_date,grade from enrollments where enrollment_date<'2025-09-01' order by grade asc ;

-- 4
-- DML and TCL -->insert,delete,update and transaction,autocommet,savepoint,rollback
start transaction;
set autocommit=0;
savepoint sp;
delete from students where first_name='bharat';
insert into students values(5,'sai','sriraj','saisriraj@gmail.com','2001-04-03','2024-09-05');
update students set student_id=4 where first_name='sai';  
select * from students;
rollback to savepoint sp;

-- 5
-- joins and group by and aggrigate
-- select course_name,count(course_id) from courses c join enrollments e on c.course_id=e.course_id group by course_name;
select course_name,count(e.course_id) from courses c join enrollments e on c.course_id=e.course_id group by course_name;

-- 6 
-- view and union
create view enrollment as select enrollment_date from students union select enrollment_date from enrollments;
select * from enrollment;

-- 7
-- normalization and joins
select s.first_name,s.email,s.date_of_birth,e.enrollment_date,c.course_name,c.credits,e.grade from enrollments e join students s on e.student_id=s.student_id join courses c on e.course_id=c.course_id;
