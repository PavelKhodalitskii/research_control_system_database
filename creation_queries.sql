CREATE OR REPLACE FUNCTION add_student_to_commitette(
	p_commitette INTEGER,
	p_graduatestudent INTEGER
) RETURNS TABLE (
	Id INTEGER,
	GraduateStudentProfile INTEGER,
	Commitette INTEGER
) AS $$
	INSERT INTO relationgraduatestudentcommitette(GraduateStudentProfile, Commitette)
	VALUES (p_graduatestudent, p_commitette) 
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION add_teacher_to_commitette(
	p_commitette INTEGER,
	p_teacher INTEGER
) RETURNS TABLE (
	Id INTEGER,
	TeacherProfile INTEGER,
	Commitette INTEGER
) AS $$
	INSERT INTO relationteacherscommitette(TeacherProfile, Commitette)
	VALUES (p_teacher, p_commitette) 
	RETURNING *;
$$ LANGUAGE sql;


--------------------------------------

CREATE OR REPLACE FUNCTION add_participant(
	p_research INTEGER,
	p_acoount INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Research INTEGER,
	Account INTEGER
) AS $$
	INSERT INTO researchparticipants(Research, Account)
	VALUES (p_research, p_acoount) 
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_research(
	p_commitette INTEGER,
	p_event INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Commitette INTEGER,
	Event INTEGER
) AS $$
	INSERT INTO Research(Commitette, Event)
	VALUES (p_commitette, p_event) 
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_commitette(
	p_chairman INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Chairman INTEGER
) AS $$
	INSERT INTO Commitette(Chairman)
	VALUES (p_chairman) 
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_event(
	p_EventName VARCHAR,
	p_EventType VARCHAR,
	p_City VARCHAR,
	p_Street VARCHAR,
	p_AddressNumber VARCHAR,
	p_Date DATE,
	p_FacultyId INTEGER 
) RETURNS TABLE (
	Id INTEGER,
	Name VARCHAR,
	Type VARCHAR,
	AddressCity VARCHAR,
	AddressStreet VARCHAR,
	AddressNumber VARCHAR,
	Date Date,
	Faculty INTEGER
) AS $$
	INSERT INTO Event(Name, Type, AddressCity, AddressStreet, AddressNumber, Date, Faculty)
	VALUES (p_EventName, p_EventType, p_City, p_Street, p_AddressNumber, p_Date, p_FacultyId) 
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_account(
	p_FirstName VARCHAR,
	p_LastName VARCHAR,
	p_Patronymic VARCHAR
) RETURNS TABLE (
	Id INTEGER,
	FirstName VARCHAR,
	LastName VARCHAR,
	Patronymic VARCHAR
) as $$
	INSERT INTO Account (FirstName, LastName, Patronymic)
	VALUES (p_FirstName, p_LastName, p_Patronymic)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_student(
	p_Year INTEGER,
	p_Group INTEGER,
	p_Account INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Year INTEGER,
	Studgroup VARCHAR,
	Account INTEGER
) as $$
	INSERT INTO StudentProfile (Year, StudGroup, Account)
	VALUES (p_Year, p_Group, p_Account)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_graduate_student(
	p_Year INTEGER,
	p_Group INTEGER,
	p_Account INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Year INTEGER,
	Studgroup VARCHAR,
	Account INTEGER
) as $$
	INSERT INTO GraduateStudentProfile (Year, StudGroup, Account)
	VALUES (p_Year, p_Group, p_Account)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_teacher(
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
	INSERT INTO TeacherProfile (Post, Status, Degree, Account, Department, isHead)
	VALUES (p_Post, p_Status, p_Degree, p_Account, p_Department, p_isHead)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_faculty (
	p_name VARCHAR
) RETURNS TABLE (
	Id INTEGER,
	Name VARCHAR
) as $$
	INSERT INTO Faculty(Name) 
	VALUES (p_name)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_department (
	p_name VARCHAR,
	p_faculty INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Name VARCHAR,
	Faculty INTEGER
) as $$
	INSERT INTO Department(Name, Faculty) 
	VALUES (p_name, p_faculty)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_speciality (
	p_name VARCHAR,
	p_department INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Name VARCHAR,
	Department INTEGER
) as $$
	INSERT INTO Speciality(Name, Department) 
	VALUES (p_name, p_department)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------

CREATE OR REPLACE FUNCTION create_group (
	p_name VARCHAR,
	p_speciality INTEGER
) RETURNS TABLE (
	Id INTEGER,
	Name VARCHAR,
	Speciality INTEGER
) as $$
	INSERT INTO Groups (Name, specialty) 
	VALUES (p_name, p_speciality)
	RETURNING *;
$$ LANGUAGE sql;

--------------------------------------