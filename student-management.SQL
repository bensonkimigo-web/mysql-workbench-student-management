CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender ENUM('Male', 'Female')
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50)
);

CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    score DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (name, age, gender) VALUES
('Alice', 20, 'Female'),
('Bob', 22, 'Male'),
('Charlie', 21, 'Male'),
('Diana', 23, 'Female');

INSERT INTO courses (course_name, instructor) VALUES
('Math', 'Mr. Smith'),
('English', 'Ms. Brown'),
('Science', 'Dr. Green');

INSERT INTO grades (student_id, course_id, score) VALUES
(1, 1, 85.5),
(1, 2, 78.0),
(1, 3, 92.0),
(2, 1, 90.0),
(2, 2, 82.5),
(3, 1, 76.0),
(3, 3, 88.5),
(4, 2, 91.0),
(4, 3, 87.0);

SELECT s.name AS Student, c.course_name AS Course, g.score AS Score
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN courses c ON g.course_id = c.course_id;

SELECT s.name AS Student, AVG(g.score) AS Average_Score
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.name
ORDER BY Average_Score DESC;

SELECT s.name AS Student, c.course_name AS Course, g.score AS Score
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN courses c ON g.course_id = c.course_id
WHERE g.score > 85
ORDER BY g.score DESC;

SELECT c.course_name AS Course, COUNT(g.student_id) AS Student_Count
FROM courses c
JOIN grades g ON c.course_id = g.course_id
GROUP BY c.course_name;

SELECT c.course_name AS Course, MAX(g.score) AS Highest_Score
FROM courses c
JOIN grades g ON c.course_id = g.course_id
GROUP BY c.course_name;