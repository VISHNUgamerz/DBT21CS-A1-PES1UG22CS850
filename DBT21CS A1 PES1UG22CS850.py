import mysql.connector
import random

# Database connection configuration
config = {
    'user': 'root',
    'password': '',  # Set to your MySQL password
    'host': 'localhost',
    'database': 'dbt24_a1_pes1ug22cs850_vishnu_v',
    'raise_on_warnings': True
}

# Establishing connection to the database
conn = mysql.connector.connect(**config)
cursor = conn.cursor()


# Generate and insert records into Department table
for i in range(1, 6):
    name = f'Department_{i}'
    cursor.execute("INSERT INTO Department (name) VALUES (%s)", (name,))
conn.commit()

# Generate and insert records into Professor table
for i in range(1, 6):
    professor_name = f'Professor_{i}'
    department_id = random.randint(1, 5)
    cursor.execute("INSERT INTO Professor (name, department_id) VALUES (%s, %s)", (professor_name, department_id))
conn.commit()

# Generate and insert records into Course table
for i in range(1, 11):
    course_name = f'Course_{i}'
    professor_id = random.randint(1, 5)
    department_id = random.randint(1, 5)
    cursor.execute("INSERT INTO Course (name, professor_id, department_id) VALUES (%s, %s, %s)", (course_name, professor_id, department_id))
conn.commit()

# Generate and insert records into Student table
for i in range(1, 10001):
    student_name = f'Student_{i}'
    department_id = random.randint(1, 5)
    cursor.execute("INSERT INTO Student (name, department_id) VALUES (%s, %s)", (student_name, department_id))
conn.commit()

# Generate and insert records into Enrolled table
for i in range(1, 10001):
    student_id = i
    course_id = random.randint(1, 10)
    cursor.execute("INSERT INTO Enrolled (student_id, course_id) VALUES (%s, %s)", (student_id, course_id))
conn.commit()

# Generate and insert records into StudentCourse table
for i in range(1, 10001):
    student_id = i
    course_id = random.randint(1, 10)
    cursor.execute("INSERT INTO StudentCourse (student_id, course_id) VALUES (%s, %s)", (student_id, course_id))
conn.commit()

cursor.close()
conn.close()
