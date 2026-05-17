-- ============================================================
-- Milestone 4 — DDL Scripts (CREATE TABLE Statements)
-- Project: Online Exam Management System
-- Student: Ijlal Ejaz | BS Computer Science (A)
-- Database: MySQL
-- ============================================================

-- Drop database if exists and recreate for clean setup
DROP DATABASE IF EXISTS online_exam_db;
CREATE DATABASE online_exam_db;
USE online_exam_db;

-- ============================================================
-- TABLE 1: Teacher
-- Must be created before Exam (Exam references teacher_id)
-- ============================================================
CREATE TABLE Teacher (
    teacher_id    INT            NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255)   NOT NULL,
    email         VARCHAR(255)   NOT NULL,
    password      VARCHAR(255)   NOT NULL,

    -- Constraints
    CONSTRAINT pk_teacher PRIMARY KEY (teacher_id),
    CONSTRAINT uq_teacher_email UNIQUE (email),
    CONSTRAINT chk_teacher_email CHECK (email LIKE '%@%.%')
);

-- Index on email for fast login lookups
CREATE INDEX idx_teacher_email ON Teacher(email);


-- ============================================================
-- TABLE 2: Student
-- Must be created before Result (Result references student_id)
-- ============================================================
CREATE TABLE Student (
    student_id    INT            NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255)   NOT NULL,
    email         VARCHAR(255)   NOT NULL,
    password      VARCHAR(255)   NOT NULL,
    program       VARCHAR(255)   NOT NULL,

    -- Constraints
    CONSTRAINT pk_student PRIMARY KEY (student_id),
    CONSTRAINT uq_student_email UNIQUE (email),
    CONSTRAINT chk_student_email CHECK (email LIKE '%@%.%')
);

-- Index on email for fast login lookups
CREATE INDEX idx_student_email ON Student(email);


-- ============================================================
-- TABLE 3: Exam
-- Depends on: Teacher (teacher_id FK)
-- ============================================================
CREATE TABLE Exam (
    exam_id       INT            NOT NULL AUTO_INCREMENT,
    teacher_id    INT            NOT NULL,
    title         VARCHAR(255)   NOT NULL,
    duration      INT            NOT NULL,
    total_marks   NUMERIC(10,0)  NOT NULL,
    date          DATE           NOT NULL,

    -- Constraints
    CONSTRAINT pk_exam PRIMARY KEY (exam_id),
    CONSTRAINT fk_exam_teacher FOREIGN KEY (teacher_id)
        REFERENCES Teacher(teacher_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_exam_duration CHECK (duration > 0),
    CONSTRAINT chk_exam_marks CHECK (total_marks > 0)
);

-- Index on teacher_id for fast lookups of exams by teacher
CREATE INDEX idx_exam_teacher ON Exam(teacher_id);
-- Index on date for filtering exams by date
CREATE INDEX idx_exam_date ON Exam(date);


-- ============================================================
-- TABLE 4: Question
-- Depends on: Exam (exam_id FK)
-- ============================================================
CREATE TABLE Question (
    question_id     INT            NOT NULL AUTO_INCREMENT,
    exam_id         INT            NOT NULL,
    question_text   TEXT           NOT NULL,
    question_type   VARCHAR(50)    NOT NULL,
    marks           INT            NOT NULL,
    correct_answer  VARCHAR(255)   NOT NULL,

    -- Constraints
    CONSTRAINT pk_question PRIMARY KEY (question_id),
    CONSTRAINT fk_question_exam FOREIGN KEY (exam_id)
        REFERENCES Exam(exam_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_question_type CHECK (
        question_type IN ('MCQ', 'Short Answer', 'True/False', 'Descriptive')
    ),
    CONSTRAINT chk_question_marks CHECK (marks > 0)
);

-- Index on exam_id for fast retrieval of questions per exam
CREATE INDEX idx_question_exam ON Question(exam_id);


-- ============================================================
-- TABLE 5: Result
-- Depends on: Student (student_id FK), Exam (exam_id FK)
-- ============================================================
CREATE TABLE Result (
    result_id     INT            NOT NULL AUTO_INCREMENT,
    student_id    INT            NOT NULL,
    exam_id       INT            NOT NULL,
    score         NUMERIC(10,0)  NOT NULL,
    grade         VARCHAR(10)    NOT NULL,
    attempt_date  DATE           NOT NULL,
    status        VARCHAR(20)    NOT NULL,

    -- Constraints
    CONSTRAINT pk_result PRIMARY KEY (result_id),
    CONSTRAINT fk_result_student FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_result_exam FOREIGN KEY (exam_id)
        REFERENCES Exam(exam_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uq_result_student_exam UNIQUE (student_id, exam_id),
    CONSTRAINT chk_result_status CHECK (status IN ('Pass', 'Fail')),
    CONSTRAINT chk_result_score CHECK (score >= 0),
    CONSTRAINT chk_result_grade CHECK (
        grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'F')
    )
);

-- Indexes on FK columns for fast joins
CREATE INDEX idx_result_student ON Result(student_id);
CREATE INDEX idx_result_exam    ON Result(exam_id);
-- Index on status for filtering Pass/Fail
CREATE INDEX idx_result_status  ON Result(status);


-- ============================================================
-- Verify all tables were created successfully
-- ============================================================
SHOW TABLES;

-- ============================================================
-- END OF DDL SCRIPT
-- ============================================================
