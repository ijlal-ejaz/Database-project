"""
Milestone 3 - Synthetic Data Generator
Project: Online Exam Management System
Student: Ijlal Ejaz | BS Computer Science (A)

Run: pip install faker
     python generate_data.py
Output: CSV files for each table (50-100 rows each)
"""

import csv
import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()
random.seed(42)

# ─────────────────────────────────────────
# 1. STUDENT TABLE (80 rows)
# ─────────────────────────────────────────
programs = [
    "BS Computer Science", "BS Software Engineering",
    "BS Information Technology", "BS Data Science", "BS Artificial Intelligence"
]

students = []
student_ids = list(range(1, 81))

for sid in student_ids:
    students.append({
        "student_id": sid,
        "name": fake.name(),
        "email": fake.unique.email(),
        "password": fake.sha256()[:20],
        "program": random.choice(programs)
    })

with open("student.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["student_id","name","email","password","program"])
    writer.writeheader()
    writer.writerows(students)
print("student.csv generated — 80 rows")


# ─────────────────────────────────────────
# 2. TEACHER TABLE (10 rows)
# ─────────────────────────────────────────
teachers = []
teacher_ids = list(range(1, 11))

for tid in teacher_ids:
    teachers.append({
        "teacher_id": tid,
        "name": fake.name(),
        "email": fake.unique.email(),
        "password": fake.sha256()[:20]
    })

with open("teacher.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["teacher_id","name","email","password"])
    writer.writeheader()
    writer.writerows(teachers)
print("teacher.csv generated — 10 rows")


# ─────────────────────────────────────────
# 3. EXAM TABLE (50 rows)
# ─────────────────────────────────────────
exam_titles = [
    "Database Systems Midterm", "Database Systems Final",
    "Data Structures Quiz", "OOP Midterm", "OOP Final",
    "Web Technologies Quiz", "Software Engineering Midterm",
    "Computer Networks Final", "Operating Systems Quiz",
    "Artificial Intelligence Midterm", "Machine Learning Final",
    "Algorithms Quiz", "Discrete Math Midterm", "Linear Algebra Final",
    "Digital Logic Quiz", "Computer Architecture Midterm",
    "Compiler Design Final", "Theory of Computation Quiz",
    "Mobile App Development Midterm", "Cloud Computing Final"
]

exams = []
exam_ids = list(range(1, 51))
base_date = datetime(2024, 1, 15)

for eid in exam_ids:
    exam_date = base_date + timedelta(days=random.randint(0, 300))
    exams.append({
        "exam_id": eid,
        "teacher_id": random.choice(teacher_ids),
        "title": random.choice(exam_titles),
        "duration": random.choice([30, 45, 60, 90, 120]),
        "total_marks": random.choice([20, 25, 50, 75, 100]),
        "date": exam_date.strftime("%Y-%m-%d")
    })

with open("exam.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["exam_id","teacher_id","title","duration","total_marks","date"])
    writer.writeheader()
    writer.writerows(exams)
print("exam.csv generated — 50 rows")


# ─────────────────────────────────────────
# 4. QUESTION TABLE (100 rows)
# ─────────────────────────────────────────
question_templates = [
    "What is the primary purpose of {}?",
    "Explain the concept of {} in detail.",
    "Which of the following best describes {}?",
    "How does {} work in a database system?",
    "Define {} and give an example.",
    "What are the advantages of using {}?",
    "Compare {} with its alternative.",
    "When would you use {} in a real-world scenario?",
    "What problem does {} solve?",
    "List two key properties of {}."
]

topics = [
    "normalization", "primary keys", "foreign keys", "SQL joins",
    "indexing", "transactions", "ACID properties", "stored procedures",
    "triggers", "views", "ERD design", "data integrity",
    "query optimization", "relational algebra", "concurrency control",
    "backup strategies", "NoSQL databases", "data warehousing",
    "hashing", "B-trees"
]

question_types = ["MCQ", "Short Answer", "True/False", "Descriptive"]
answers = {
    "MCQ": ["A", "B", "C", "D"],
    "Short Answer": ["See answer key"],
    "True/False": ["True", "False"],
    "Descriptive": ["Refer to rubric"]
}

questions = []
qid = 1
for eid in exam_ids:
    num_questions = random.randint(1, 3)
    for _ in range(num_questions):
        if qid > 100:
            break
        q_type = random.choice(question_types)
        q_text = random.choice(question_templates).format(random.choice(topics))
        questions.append({
            "question_id": qid,
            "exam_id": eid,
            "question_text": q_text,
            "question_type": q_type,
            "marks": random.choice([1, 2, 3, 5, 10]),
            "correct_answer": random.choice(answers[q_type])
        })
        qid += 1

# Fill remaining to reach 100
while len(questions) < 100:
    q_type = random.choice(question_types)
    questions.append({
        "question_id": qid,
        "exam_id": random.choice(exam_ids),
        "question_text": random.choice(question_templates).format(random.choice(topics)),
        "question_type": q_type,
        "marks": random.choice([1, 2, 3, 5, 10]),
        "correct_answer": random.choice(answers[q_type])
    })
    qid += 1

with open("question.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["question_id","exam_id","question_text","question_type","marks","correct_answer"])
    writer.writeheader()
    writer.writerows(questions)
print(f"question.csv generated — {len(questions)} rows")


# ─────────────────────────────────────────
# 5. RESULT TABLE (100 rows)
# ─────────────────────────────────────────
def calculate_grade(score, total):
    pct = (score / total) * 100
    if pct >= 90: return "A+"
    elif pct >= 85: return "A"
    elif pct >= 80: return "A-"
    elif pct >= 75: return "B+"
    elif pct >= 70: return "B"
    elif pct >= 65: return "B-"
    elif pct >= 60: return "C+"
    elif pct >= 55: return "C"
    elif pct >= 50: return "C-"
    else: return "F"

results = []
used_pairs = set()

for rid in range(1, 101):
    while True:
        sid = random.choice(student_ids)
        eid = random.choice(exam_ids)
        if (sid, eid) not in used_pairs:
            used_pairs.add((sid, eid))
            break

    total = next(e["total_marks"] for e in exams if e["exam_id"] == eid)
    score = random.randint(int(total * 0.3), total)
    grade = calculate_grade(score, total)
    exam_date = next(e["date"] for e in exams if e["exam_id"] == eid)
    attempt_date = (datetime.strptime(exam_date, "%Y-%m-%d") + timedelta(days=random.randint(0,2))).strftime("%Y-%m-%d")
    status = "Pass" if score >= total * 0.5 else "Fail"

    results.append({
        "result_id": rid,
        "student_id": sid,
        "exam_id": eid,
        "score": score,
        "grade": grade,
        "attempt_date": attempt_date,
        "status": status
    })

with open("result.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["result_id","student_id","exam_id","score","grade","attempt_date","status"])
    writer.writeheader()
    writer.writerows(results)
print("result.csv generated — 100 rows")

print("\n✅ All CSV files generated successfully!")
print("Files: student.csv, teacher.csv, exam.csv, question.csv, result.csv")
