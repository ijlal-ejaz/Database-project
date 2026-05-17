# Normalization Document — Online Exam Management System

**Student Name:** Ijlal Ejaz  
**Program:** BS Computer Science (A)  
**Project Title:** Online Exam Management System  

---

## Overview

This document walks through the normalization of all five tables in the Online Exam Management System database. Each table is analyzed through First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF). For each step, the issue (if any), the change made, and the justification are clearly documented.

---

## Tables Being Normalized

1. Student
2. Teacher
3. Exam
4. Question
5. Result

---

## Table 1: Student

### Original Schema
```
Student(student_id, name, email, password, program)
```

---

### 1NF — First Normal Form

**Rule:** Every column must contain atomic (indivisible) values. No repeating groups or arrays allowed.

**Analysis:**
- `student_id` → single integer value ✅
- `name` → single string value ✅
- `email` → single string value ✅
- `password` → single string value ✅
- `program` → single string value ✅

**Issue Found:** None. All columns already contain atomic, single values. There are no repeating groups or multi-valued attributes.

**Change Made:** No change required.

**Justification:** The Student table already satisfies 1NF because every attribute holds exactly one value per row and there are no sets, arrays, or comma-separated values stored in any column.

---

### 2NF — Second Normal Form

**Rule:** Must be in 1NF and every non-key attribute must be fully functionally dependent on the entire primary key (no partial dependencies). Partial dependency only applies when the primary key is composite.

**Analysis:**
- Primary Key: `student_id` (single column, not composite)
- Since the primary key is a single column, partial dependency cannot exist.
- All attributes (name, email, password, program) depend entirely on `student_id`.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** Because the primary key is a single column (`student_id`), partial dependency is mathematically impossible. All non-key attributes are fully dependent on the whole primary key.

---

### 3NF — Third Normal Form

**Rule:** Must be in 2NF and no non-key attribute should be transitively dependent on the primary key through another non-key attribute.

**Analysis:**
- Does `name` determine `email`? No.
- Does `email` determine `program`? No.
- Does `program` determine `name`? No.
- All attributes depend directly and only on `student_id`.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** There are no transitive dependencies in the Student table. Every non-key attribute (name, email, password, program) is directly and independently determined by `student_id` alone.

**Final Schema (Unchanged):**
```
Student(student_id PK, name, email, password, program)
```

---

## Table 2: Teacher

### Original Schema
```
Teacher(teacher_id, name, email, password)
```

---

### 1NF — First Normal Form

**Analysis:**
- All four columns hold single, atomic values per row.
- No repeating groups or multi-valued attributes exist.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** The Teacher table satisfies 1NF. Each attribute stores one indivisible value and the table has a well-defined primary key (`teacher_id`).

---

### 2NF — Second Normal Form

**Analysis:**
- Primary Key: `teacher_id` (single column)
- Partial dependency is impossible with a single-column primary key.
- All attributes fully depend on `teacher_id`.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** With a non-composite primary key, 2NF is automatically satisfied as long as 1NF holds, which it does.

---

### 3NF — Third Normal Form

**Analysis:**
- `name` does not determine `email` or `password`.
- `email` does not determine `name` or `password`.
- No transitive dependencies exist between non-key attributes.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** All non-key columns depend only and directly on `teacher_id`. There are no transitive functional dependencies.

**Final Schema (Unchanged):**
```
Teacher(teacher_id PK, name, email, password)
```

---

## Table 3: Exam

### Original Schema (Before Normalization)
```
Exam(exam_id, teacher_id, teacher_name, teacher_email, title, duration, total_marks, date)
```

> Note: The original design considered including `teacher_name` and `teacher_email` directly in the Exam table to make queries easier. This is analyzed and corrected below.

---

### 1NF — First Normal Form

**Analysis:**
- All columns hold single atomic values.
- No repeating groups or arrays.

**Issue Found:** None at this stage.

**Change Made:** No change required for 1NF.

**Justification:** Every attribute in the Exam table is atomic. Each exam row holds one value per column.

---

### 2NF — Second Normal Form

**Analysis:**
- Primary Key: `exam_id` (single column)
- All non-key attributes depend on `exam_id`.

**Issue Found:** None (no composite key, so no partial dependency possible).

**Change Made:** No change required for 2NF.

**Justification:** Single-column primary key eliminates any possibility of partial dependency.

---

### 3NF — Third Normal Form

**Analysis:**
- `teacher_id` → `teacher_name` (teacher_name depends on teacher_id, not exam_id)
- `teacher_id` → `teacher_email` (teacher_email depends on teacher_id, not exam_id)
- This is a **transitive dependency**: `exam_id → teacher_id → teacher_name, teacher_email`

**Issue Found:** ⚠️ Transitive dependency detected. `teacher_name` and `teacher_email` depend on `teacher_id`, not directly on `exam_id`. Storing teacher details inside the Exam table causes redundancy — if a teacher's email changes, it must be updated in every exam row.

**Change Made:** Remove `teacher_name` and `teacher_email` from the Exam table. Keep only `teacher_id` as a foreign key reference to the Teacher table.

**Justification:** By keeping only `teacher_id` in the Exam table and storing teacher details in the Teacher table, we eliminate the transitive dependency. Teacher information is now stored in one place, preventing update anomalies and data redundancy.

**Final Schema (After 3NF Fix):**
```
Exam(exam_id PK, teacher_id FK, title, duration, total_marks, date)
```

---

## Table 4: Question

### Original Schema (Before Normalization)
```
Question(question_id, exam_id, exam_title, question_text, question_type, marks, correct_answer)
```

> Note: `exam_title` was initially considered to be stored in Question for display convenience.

---

### 1NF — First Normal Form

**Analysis:**
- All columns hold single atomic values.
- `question_text` holds one complete question per row.
- `correct_answer` holds one answer value per row.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** Every column in the Question table is atomic. No multi-valued attributes or repeating groups exist.

---

### 2NF — Second Normal Form

**Analysis:**
- Primary Key: `question_id` (single column)
- No partial dependency possible.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** Single primary key means 2NF is satisfied automatically alongside 1NF.

---

### 3NF — Third Normal Form

**Analysis:**
- `exam_id` → `exam_title` (exam_title depends on exam_id, not question_id)
- Transitive dependency: `question_id → exam_id → exam_title`

**Issue Found:** ⚠️ Transitive dependency detected. `exam_title` depends on `exam_id`, not on `question_id`. Storing `exam_title` in the Question table means it would be repeated for every question in that exam.

**Change Made:** Remove `exam_title` from the Question table. Keep only `exam_id` as a foreign key.

**Justification:** The exam title belongs in the Exam table. The Question table only needs `exam_id` to establish the relationship. This removes redundancy and ensures that changing an exam title only requires one update in the Exam table.

**Final Schema (After 3NF Fix):**
```
Question(question_id PK, exam_id FK, question_text, question_type, marks, correct_answer)
```

---

## Table 5: Result

### Original Schema
```
Result(result_id, student_id, exam_id, score, grade, attempt_date, status)
```

---

### 1NF — First Normal Form

**Analysis:**
- All columns hold atomic, single values.
- No multi-valued attributes (each result row captures one student's performance in one exam).

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** The Result table satisfies 1NF. Every attribute is indivisible and each row uniquely identifies one exam attempt by one student.

---

### 2NF — Second Normal Form

**Analysis:**
- Primary Key: `result_id` (single column)
- No composite key, so partial dependency cannot exist.
- `student_id` and `exam_id` are non-key foreign key attributes, not part of the primary key.

**Issue Found:** None.

**Change Made:** No change required.

**Justification:** Since the primary key is a single column (`result_id`), all non-key attributes are fully functionally dependent on it. 2NF is satisfied.

---

### 3NF — Third Normal Form

**Analysis:**
- Does `student_id` determine `score`? No — score depends on the specific exam attempt, not just the student.
- Does `exam_id` determine `score`? No — different students get different scores on the same exam.
- Does `score` determine `grade`? **Potentially yes** — if grade is calculated purely from score (e.g., score ≥ 90 → A), then `grade` transitively depends on `result_id` via `score`.

**Issue Found:** ⚠️ Potential transitive dependency: `result_id → score → grade` if grade is derived directly from score.

**Change Made:** Since grade can be computed from score at query time using a CASE statement, we remove `grade` as a stored column to eliminate the transitive dependency. However, if business rules require storing the grade independently (e.g., manual override possible), it can be retained with documentation.

**Decision:** We retain `grade` as a stored column because in an exam system, grades may follow custom grading curves set by each teacher and cannot always be recalculated from score alone. This is explicitly documented as a justified exception.

**Justification for Retaining Grade:** The relationship `score → grade` is not always deterministic in this system. A teacher may apply a curve or use a custom grade boundary per exam. Therefore, `grade` represents independent data, not a derived value, and retaining it does not violate 3NF in this context.

**Final Schema (Unchanged):**
```
Result(result_id PK, student_id FK, exam_id FK, score, grade, attempt_date, status)
```

---

## Summary of Normalization Changes

| Table    | 1NF | 2NF | 3NF | Changes Made |
|----------|-----|-----|-----|--------------|
| Student  | ✅  | ✅  | ✅  | None |
| Teacher  | ✅  | ✅  | ✅  | None |
| Exam     | ✅  | ✅  | ⚠️→✅ | Removed `teacher_name`, `teacher_email` (transitive dependency) |
| Question | ✅  | ✅  | ⚠️→✅ | Removed `exam_title` (transitive dependency) |
| Result   | ✅  | ✅  | ✅  | None (grade retained with justification) |

---

## Final Normalized Schema

```
Student  (student_id PK, name, email, password, program)
Teacher  (teacher_id PK, name, email, password)
Exam     (exam_id PK, teacher_id FK, title, duration, total_marks, date)
Question (question_id PK, exam_id FK, question_text, question_type, marks, correct_answer)
Result   (result_id PK, student_id FK, exam_id FK, score, grade, attempt_date, status)
```
