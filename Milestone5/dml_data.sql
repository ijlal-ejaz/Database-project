-- ============================================================
-- Milestone 5 — DML Scripts (Data Population + Validation)
-- Project: Online Exam Management System
-- Student: Ijlal Ejaz | BS Computer Science (A)
-- Database: MySQL
-- ============================================================

USE online_exam_db;

-- ============================================================
-- STEP 1: LOAD DATA FROM CSV FILES (LOAD DATA INFILE)
-- Place CSV files in MySQL's secure_file_priv directory
-- OR use the INSERT approach below as an alternative
-- ============================================================

-- Option A: LOAD DATA INFILE (fastest, requires file path access)
-- Uncomment and update path if using this approach:

/*
LOAD DATA INFILE '/var/lib/mysql-files/teacher.csv'
INTO TABLE Teacher
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(teacher_id, name, email, password);

LOAD DATA INFILE '/var/lib/mysql-files/student.csv'
INTO TABLE Student
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(student_id, name, email, password, program);

LOAD DATA INFILE '/var/lib/mysql-files/exam.csv'
INTO TABLE Exam
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(exam_id, teacher_id, title, duration, total_marks, date);

LOAD DATA INFILE '/var/lib/mysql-files/question.csv'
INTO TABLE Question
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(question_id, exam_id, question_text, question_type, marks, correct_answer);

LOAD DATA INFILE '/var/lib/mysql-files/result.csv'
INTO TABLE Result
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(result_id, student_id, exam_id, score, grade, attempt_date, status);
*/


-- ============================================================
-- Option B: Sample INSERT statements (10 rows per table shown)
-- Full data comes from CSV files generated in Milestone 3
-- ============================================================

-- Insert Teachers
INSERT INTO Teacher (teacher_id, name, email, password) VALUES
(1,  'Dr. Ahmed Khan',      'ahmed.khan@university.edu',    'a3f8b2c1d4e5f6a7'),
(2,  'Prof. Sara Malik',    'sara.malik@university.edu',    'b4c9d3e2f1a6b7c8'),
(3,  'Dr. Usman Ali',       'usman.ali@university.edu',     'c5d0e4f3a2b8c9d0'),
(4,  'Prof. Nadia Hassan',  'nadia.hassan@university.edu',  'd6e1f5a4b3c9d0e1'),
(5,  'Dr. Bilal Akhtar',    'bilal.akhtar@university.edu',  'e7f2a6b5c4d0e1f2'),
(6,  'Prof. Ayesha Raza',   'ayesha.raza@university.edu',   'f8a3b7c6d5e1f2a3'),
(7,  'Dr. Tariq Mehmood',   'tariq.mehmood@university.edu', 'a9b4c8d7e6f2a3b4'),
(8,  'Prof. Hina Baig',     'hina.baig@university.edu',     'b0c5d9e8f7a3b4c5'),
(9,  'Dr. Kamran Siddiqui', 'kamran.sid@university.edu',    'c1d6e0f9a8b4c5d6'),
(10, 'Prof. Zara Qureshi',  'zara.qureshi@university.edu',  'd2e7f1a0b9c5d6e7');

-- Insert Students (10 sample rows shown)
INSERT INTO Student (student_id, name, email, password, program) VALUES
(1,  'Ali Raza',         'ali.raza@student.edu',       'pass1a2b3c', 'BS Computer Science'),
(2,  'Fatima Noor',      'fatima.noor@student.edu',    'pass2b3c4d', 'BS Software Engineering'),
(3,  'Hassan Butt',      'hassan.butt@student.edu',    'pass3c4d5e', 'BS Information Technology'),
(4,  'Zainab Cheema',    'zainab.ch@student.edu',      'pass4d5e6f', 'BS Data Science'),
(5,  'Omar Sheikh',      'omar.sheikh@student.edu',    'pass5e6f7a', 'BS Computer Science'),
(6,  'Mariam Tariq',     'mariam.tariq@student.edu',   'pass6f7a8b', 'BS Artificial Intelligence'),
(7,  'Bilal Hussain',    'bilal.hussain@student.edu',  'pass7a8b9c', 'BS Software Engineering'),
(8,  'Sana Iftikhar',    'sana.ifti@student.edu',      'pass8b9c0d', 'BS Computer Science'),
(9,  'Imran Waheed',     'imran.waheed@student.edu',   'pass9c0d1e', 'BS Data Science'),
(10, 'Nadia Karim',      'nadia.karim@student.edu',    'pass0d1e2f', 'BS Information Technology');

-- Insert Exams (10 sample rows)
INSERT INTO Exam (exam_id, teacher_id, title, duration, total_marks, date) VALUES
(1,  1, 'Database Systems Midterm',         60,  50,  '2024-03-10'),
(2,  1, 'Database Systems Final',           90,  100, '2024-06-15'),
(3,  2, 'Data Structures Quiz',             30,  20,  '2024-02-20'),
(4,  2, 'OOP Midterm',                      60,  50,  '2024-03-12'),
(5,  3, 'Web Technologies Quiz',            30,  25,  '2024-04-05'),
(6,  4, 'Software Engineering Midterm',     90,  75,  '2024-03-18'),
(7,  5, 'Computer Networks Final',          120, 100, '2024-06-20'),
(8,  6, 'Operating Systems Quiz',           45,  25,  '2024-04-22'),
(9,  7, 'Artificial Intelligence Midterm',  60,  50,  '2024-03-25'),
(10, 8, 'Machine Learning Final',           120, 100, '2024-06-28');

-- Insert Questions (10 sample rows)
INSERT INTO Question (question_id, exam_id, question_text, question_type, marks, correct_answer) VALUES
(1,  1, 'What does SQL stand for?',                               'MCQ',          5, 'B'),
(2,  1, 'Define normalization in databases.',                     'Short Answer', 10, 'See answer key'),
(3,  1, 'A primary key can contain NULL values. True or False?',  'True/False',   5, 'False'),
(4,  2, 'Explain ACID properties in detail.',                     'Descriptive',  20, 'Refer to rubric'),
(5,  2, 'Which join returns all rows from both tables?',          'MCQ',          5, 'C'),
(6,  3, 'What is the time complexity of binary search?',         'MCQ',          5, 'A'),
(7,  4, 'Explain polymorphism with an example.',                  'Short Answer', 10, 'See answer key'),
(8,  5, 'What is the purpose of the DOCTYPE declaration?',        'MCQ',          5, 'D'),
(9,  6, 'Define software development lifecycle (SDLC).',          'Short Answer', 15, 'See answer key'),
(10, 7, 'What is the difference between TCP and UDP?',            'Short Answer', 10, 'See answer key');

-- Insert Results (10 sample rows)
INSERT INTO Result (result_id, student_id, exam_id, score, grade, attempt_date, status) VALUES
(1,  1,  1,  42, 'A',  '2024-03-10', 'Pass'),
(2,  2,  1,  35, 'B+', '2024-03-10', 'Pass'),
(3,  3,  2,  78, 'A-', '2024-06-15', 'Pass'),
(4,  4,  3,  15, 'A',  '2024-02-20', 'Pass'),
(5,  5,  4,  38, 'B',  '2024-03-12', 'Pass'),
(6,  6,  5,  20, 'A+', '2024-04-05', 'Pass'),
(7,  7,  6,  45, 'C+', '2024-03-18', 'Pass'),
(8,  8,  7,  55, 'F',  '2024-06-20', 'Fail'),
(9,  9,  8,  18, 'B+', '2024-04-22', 'Pass'),
(10, 10, 9,  30, 'C',  '2024-03-25', 'Pass');


-- ============================================================
-- STEP 2: UPDATE OPERATION (with WHERE condition)
-- ============================================================

-- UPDATE 1: Correct a student's grade after manual review
UPDATE Result
SET grade = 'A+', score = 48
WHERE student_id = 1 AND exam_id = 1;

-- UPDATE 2: Extend the duration of an exam by 30 minutes
UPDATE Exam
SET duration = duration + 30
WHERE exam_id = 7;

-- UPDATE 3: Update a teacher's email address
UPDATE Teacher
SET email = 'ahmed.khan.updated@university.edu'
WHERE teacher_id = 1;


-- ============================================================
-- STEP 3: DELETE OPERATION (with WHERE condition)
-- ============================================================

-- DELETE 1: Remove a failed result record for a student who re-appeared
DELETE FROM Result
WHERE student_id = 8 AND exam_id = 7 AND status = 'Fail';

-- DELETE 2: Remove an exam that was cancelled
-- (Questions will auto-delete due to ON DELETE CASCADE)
-- DELETE FROM Exam WHERE exam_id = 10 AND date > CURDATE();


-- ============================================================
-- STEP 4: VALIDATION QUERIES
-- ============================================================

-- ── 4A: COUNT(*) for each table ──────────────────────────────
SELECT 'Teacher'  AS table_name, COUNT(*) AS row_count FROM Teacher
UNION ALL
SELECT 'Student',                COUNT(*)               FROM Student
UNION ALL
SELECT 'Exam',                   COUNT(*)               FROM Exam
UNION ALL
SELECT 'Question',               COUNT(*)               FROM Question
UNION ALL
SELECT 'Result',                 COUNT(*)               FROM Result;


-- ── 4B: NULL Check on key columns ────────────────────────────
SELECT 'NULL Check: Teacher - name/email'     AS check_name,
       COUNT(*) AS null_count
FROM Teacher
WHERE name IS NULL OR email IS NULL

UNION ALL

SELECT 'NULL Check: Student - name/email/program',
       COUNT(*)
FROM Student
WHERE name IS NULL OR email IS NULL OR program IS NULL

UNION ALL

SELECT 'NULL Check: Exam - title/date/total_marks',
       COUNT(*)
FROM Exam
WHERE title IS NULL OR date IS NULL OR total_marks IS NULL

UNION ALL

SELECT 'NULL Check: Question - question_text/correct_answer',
       COUNT(*)
FROM Question
WHERE question_text IS NULL OR correct_answer IS NULL

UNION ALL

SELECT 'NULL Check: Result - score/grade/status',
       COUNT(*)
FROM Result
WHERE score IS NULL OR grade IS NULL OR status IS NULL;

-- All counts above should return 0 if data is clean.


-- ── 4C: FK Integrity Check via JOINs ─────────────────────────

-- Check 1: Every Exam must have a valid Teacher
SELECT 'FK Check: Exam -> Teacher' AS check_name,
       COUNT(*) AS orphan_count
FROM Exam e
LEFT JOIN Teacher t ON e.teacher_id = t.teacher_id
WHERE t.teacher_id IS NULL;

-- Check 2: Every Question must have a valid Exam
SELECT 'FK Check: Question -> Exam' AS check_name,
       COUNT(*) AS orphan_count
FROM Question q
LEFT JOIN Exam e ON q.exam_id = e.exam_id
WHERE e.exam_id IS NULL;

-- Check 3: Every Result must have a valid Student
SELECT 'FK Check: Result -> Student' AS check_name,
       COUNT(*) AS orphan_count
FROM Result r
LEFT JOIN Student s ON r.student_id = s.student_id
WHERE s.student_id IS NULL;

-- Check 4: Every Result must have a valid Exam
SELECT 'FK Check: Result -> Exam' AS check_name,
       COUNT(*) AS orphan_count
FROM Result r
LEFT JOIN Exam e ON r.exam_id = e.exam_id
WHERE e.exam_id IS NULL;

-- All orphan_count values above should be 0.


-- ── 4D: Bonus Query — Full result report with names ──────────
SELECT
    s.name          AS student_name,
    e.title         AS exam_title,
    t.name          AS teacher_name,
    r.score,
    e.total_marks,
    r.grade,
    r.status,
    r.attempt_date
FROM Result r
JOIN Student s ON r.student_id = s.student_id
JOIN Exam    e ON r.exam_id    = e.exam_id
JOIN Teacher t ON e.teacher_id = t.teacher_id
ORDER BY r.attempt_date DESC
LIMIT 20;


-- ── 4E: Average score per exam ───────────────────────────────
SELECT
    e.title          AS exam_title,
    COUNT(r.result_id) AS attempts,
    AVG(r.score)       AS average_score,
    MAX(r.score)       AS highest_score,
    MIN(r.score)       AS lowest_score
FROM Exam e
JOIN Result r ON e.exam_id = r.exam_id
GROUP BY e.exam_id, e.title
ORDER BY average_score DESC;


-- ============================================================
-- END OF DML SCRIPT
-- ============================================================
