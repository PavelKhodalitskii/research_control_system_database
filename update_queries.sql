CREATE OR REPLACE FUNCTION update_account(
	p_AccountId INTEGER,
	p_FirstName VARCHAR,
	p_LastName VARCHAR,
	p_Patronymic VARCHAR
) RETURNS TABLE (
	Id INTEGER,
	FirstName VARCHAR,
	LastName VARCHAR,
	Patronymic VARCHAR
) as $$
	UPDATE Account SET 
	FirstName = p_FirstName,
	LastName = p_LastName,
	Patronymic = p_Patronymic
	WHERE Id = p_AccountId
	RETURNING *;
$$ LANGUAGE sql;

-----

CREATE OR REPLACE FUNCTION update_student(
	p_StudentProfileId INTEGER,
	p_Year INTEGER,
	p_Group INTEGER,
	p_Account INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Year INTEGER,
	Studgroup VARCHAR,
	Account INTEGER
) as $$
	UPDATE StudentProfile SET
		Year = p_Year,
		StudGroup = p_Group,
		Account = p_Account
	WHERE StudentProfile.Id = p_StudentProfileId
	RETURNING *;
$$ LANGUAGE sql;

---

CREATE OR REPLACE FUNCTION update_graduate_student(
	p_GraduateStudentProfileId INTEGER,
	p_Year INTEGER,
	p_Group INTEGER,
	p_Account INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Year INTEGER,
	Studgroup VARCHAR,
	Account INTEGER
) as $$
	UPDATE GraduateStudentProfile SET
		Year = p_Year,
		StudGroup = p_Group,
		Account = p_Account
	WHERE GraduateStudentProfile.Id = p_GraduateStudentProfileId
	RETURNING *;
$$ LANGUAGE sql;

----

CREATE OR REPLACE FUNCTION update_teacher(
	p_TeacherProfileId INTEGER,
	p_Post INTEGER,
	p_Status VARCHAR,
	p_Degree INTEGER,
	p_Account INTEGER,
	p_Department INTEGER,
	p_isHead BOOLEAN
) RETURNS TABLE (
	Id INTEGER,
	Post INTEGER,
	Status VARCHAR,
	Degree INTEGER,
	Account INTEGER,
	Department INTEGER,
	IsHead BOOLEAN
) as $$
	UPDATE TeacherProfile SET
	Post = p_Post,
	Status = p_Status,
	Degree = p_Degree,
	Account = p_Account,
	Department = p_Department,
	isHead = p_isHead
	WHERE TeacherProfile.Id = p_TeacherProfileId
	RETURNING *;
$$ LANGUAGE sql;