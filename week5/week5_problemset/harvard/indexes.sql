CREATE INDEX enrollment_course_index ON enrollments (course_id);

CREATE INDEX enrollment_student_index ON enrollments (student_id);

CREATE INDEX course_index ON courses (department, number, semester, title);

CREATE INDEX student_index ON students (name);

CREATE INDEX requirements_index ON requirements (name);

CREATE INDEX satisfies_index ON satisfies (requirement_id);
