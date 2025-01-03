CREATE OR REPLACE FUNCTION get_commitette_participants(
	p_Commitette INTEGER
) RETURNS TABLE (
	Id INTEGER
) AS $$
	SELECT Account FROM
	(SELECT Account FROM
	RelationTeachersCommitette
	JOIN TeacherProfile 
	ON RelationTeachersCommitette.TeacherProfile = TeacherProfile.Id
	WHERE RelationTeachersCommitette.Commitette = p_Commitette) as TeacherCommitettes
	UNION ALL
	(SELECT Account FROM
	RelationGraduateStudentCommitette
	JOIN GraduateStudentProfile 
	ON RelationGraduateStudentCommitette.GraduateStudentProfile = GraduateStudentProfile.Id
	WHERE RelationGraduateStudentCommitette.Commitette = p_Commitette);
$$ LANGUAGE sql;


$$ LANGUAGE sql;


CREATE OR REPLACE FUNCTION get_committies_by_teacher_id()
RETURNS TABLE (
	Id INTEGER,
	ResearchId INTEGER,
	ResearchName VARCHAR,
	IsHead BOOLEAN
) AS $$

---------------------


CREATE OR REPLACE FUNCTION get_all_graduate_students_info()
RETURNS TABLE (
	Id INTEGER,
	AccountID INTEGER,
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR,
	Year INTEGER,
	StudGroup INTEGER,
	GroupName VARCHAR,
	Speciality VARCHAR,
	Department VARCHAR,
	Faculty VARCHAR
) AS $$
	SELECT 
		GraduateStudentProfile.Id as Id,
		Account.Id as AccountID,
		Account.FirstName as FirstName, 
		Account.LastName as LastName, 
		Account.Patronymic as Patronymic,
		GraduateStudentProfile.Year as Year,
		Groups.Id as StudGroup,
		Groups.Name as GroupName,
		Speciality.Name as Speciality,
		Department.Name as Department,
		Faculty.Name as Faculty
	FROM
	GraduateStudentProfile
	JOIN Account
	ON GraduateStudentProfile.Account = Account.Id
	JOIN Groups
	ON GraduateStudentProfile.StudGroup = Groups.Id
	JOIN Speciality
	ON Groups.Specialty = Speciality.Id
	JOIN Department
	ON Speciality.Department = Department.Id
	JOIN Faculty
	ON Department.Faculty = Faculty.Id
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION get_researches_by_account_id(
	p_AccountId INTEGER
) RETURNS TABLE (
	ID INTEGER,
	Event INTEGER,
	EventName VARCHAR,
	EventType VARCHAR,
	City VARCHAR,
	Street VARCHAR,
	AddressNumber VARCHAR,
	Date DATE,
	Faculty INTEGER,
	FacultyName VARCHAR,
	CommitetteChairManId INTEGER
) AS $$
	SELECT
		Research.Id as Id,
		Event.Id as Event,
		Event.Name as EventName,
		Event.Type as EventType,
		Event.AddressCity as City,
		Event.AddressStreet as Street,
		Event.AddressNumber as AddressNumber,
		Event.Date as Date,
		Faculty INTEGER,
		Faculty.Name as FacultyName,
		Commitette.ChairMan as CommitetteChairManId
	FROM 
	Research
	RIGHT JOIN (SELECT Research FROM ResearchParticipants WHERE Account = p_AccountId) AccountsResearches
	ON Research.Id = AccountsResearches.Research
	JOIN Event
	ON Event.Id = Research.Event
	JOIN Faculty
	ON Faculty.Id = Event.Faculty
	JOIN Commitette 
	ON Commitette.Id = Research.Commitette
	JOIN TeacherProfile
	ON TeacherProfile.Id = Commitette.Chairman
	JOIN Post
	ON Post.Id = TeacherProfile.post;
$$ LANGUAGE sql;


--------------------------------------------------------

CREATE OR REPLACE FUNCTION get_all_teachers_info(
) RETURNS TABLE (
	Id INTEGER,
	AccountId INTEGER, 
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR,
	Post INTEGER,
	PostName VARCHAR,
	Degree INTEGER,
	AcademicDegreeName VARCHAR,
	Department INTEGER,
	DepartmentName VARCHAR,
	IsHead BOOLEAN
) AS $$
	SELECT 
		TeacherProfile.id as Id,
		Account.Id as AccountId, 
		Account.FirstName as FirstName, 
		Account.LastName as LastName, 
		Account.Patronymic as Patronymic,
		Post.Id as Post,
		Post.PostName as PostName,
		AcademicDegree.Id as Degree,
		AcademicDegree.AcademicDegreeName as AcademicDegreeName,
		Department.Id as Department,
		Department.Name as DepartmentName,
		TeacherProfile.IsHead as IsHead
	FROM 
	TeacherProfile
	JOIN Account
	ON TeacherProfile.Account = Account.Id
	JOIN Post
	ON TeacherProfile.Post = Post.Id
	JOIN AcademicDegree
	ON TeacherProfile.Degree = AcademicDegree.Id
	JOIN Department
	ON TeacherProfile.Department = Department.Id
$$ LANGUAGE sql;

--------------------------------------------------------

CREATE OR REPLACE FUNCTION get_all_student_info()
RETURNS TABLE (
	Id INTEGER,
	AccountID INTEGER,
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR,
	Year INTEGER,
	StudGroup INTEGER,
	GroupName VARCHAR,
	Speciality VARCHAR,
	Department VARCHAR,
	Faculty VARCHAR
) AS $$
	SELECT 
		StudentProfile.Id as Id,
		Account.Id as AccountID,
		Account.FirstName as FirstName, 
		Account.LastName as LastName, 
		Account.Patronymic as Patronymic,
		StudentProfile.Year as Year,
		Groups.Id as StudGroup,
		Groups.Name as GroupName,
		Speciality.Name as Speciality,
		Department.Name as Department,
		Faculty.Name as Faculty
	FROM
	StudentProfile
	JOIN Account
	ON StudentProfile.Account = Account.Id
	JOIN Groups
	ON StudentProfile.StudGroup = Groups.Id
	JOIN Speciality
	ON Groups.Specialty = Speciality.Id
	JOIN Department
	ON Speciality.Department = Department.Id
	JOIN Faculty
	ON Department.Faculty = Faculty.Id
$$ LANGUAGE sql;

--------------------------------------------------------

-- Получить аспиранта по его аккаунту

CREATE OR REPLACE FUNCTION get_graduate_student_by_account_id(
	p_AccountId INTEGER
) RETURNS TABLE (
	GraduateStudentID INTEGER,
	AccountID INTEGER,
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR,
	Year INTEGER,
	StudGroup VARCHAR,
	Speciality VARCHAR,
	Department VARCHAR,
	Faculty VARCHAR
) AS $$
	SELECT 
		GraduateStudentProfile.Id as GraduateStudentID,
		AccountData.Id as AccountID,
		AccountData.FirstName as FirstName, 
		AccountData.LastName as LastName, 
		AccountData.Patronymic as Patronymic,
		GraduateStudentProfile.Year as Year,
		Groups.Name as StudGroup,
		Speciality.Name as Speciality,
		Department.Name as Department,
		Faculty.Name as Faculty
	FROM
	GraduateStudentProfile
	JOIN (SELECT Account.Id,
				 Account.FirstName,
				 Account.LastName,
				 Account.Patronymic
		  FROM Account WHERE Account.Id = p_AccountId) AccountData
	ON GraduateStudentProfile.Account = AccountData.Id
	JOIN Groups
	ON GraduateStudentProfile.StudGroup = Groups.Id
	JOIN Speciality
	ON Groups.Specialty = Speciality.Id
	JOIN Department
	ON Speciality.Department = Department.Id
	JOIN Faculty
	ON Department.Faculty = Faculty.Id
$$ LANGUAGE sql;


--------------------------------------------------------

-- Получить студента по его аккаунту


CREATE OR REPLACE FUNCTION get_student_by_account_id(
	p_AccountId INTEGER
) RETURNS TABLE (
	Id INTEGER,
	AccountID INTEGER,
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR,
	Year INTEGER,
	StudGroup VARCHAR,
	Speciality VARCHAR,
	Department VARCHAR,
	Faculty VARCHAR
) AS $$
	SELECT 
		StudentProfile.Id as StudentID,
		AccountData.Id as AccountID,
		AccountData.FirstName as FirstName, 
		AccountData.LastName as LastName, 
		AccountData.Patronymic as Patronymic,
		StudentProfile.Year as Year,
		Groups.Name as StudGroup,
		Speciality.Name as Speciality,
		Department.Name as Department,
		Faculty.Name as Faculty
	FROM
	StudentProfile
	JOIN (SELECT Account.Id,
				 Account.FirstName,
				 Account.LastName,
				 Account.Patronymic
		  FROM Account WHERE Account.Id = p_AccountId) AccountData
	ON StudentProfile.Account = AccountData.Id
	JOIN Groups
	ON StudentProfile.StudGroup = Groups.Id
	JOIN Speciality
	ON Groups.Specialty = Speciality.Id
	JOIN Department
	ON Speciality.Department = Department.Id
	JOIN Faculty
	ON Department.Faculty = Faculty.Id
$$ LANGUAGE sql;


--------------------------------------------------------

-- Получить преподавателя по его аккаунту

CREATE OR REPLACE FUNCTION get_teacher_by_account_id(
	p_AccountId INTEGER
) RETURNS TABLE (
	Id INTEGER,
	AccountID INTEGER, 
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR,
	Post VARCHAR,
	AcademicDegree VARCHAR,
	DepartmentName VARCHAR,
	IsHead BOOLEAN
) AS $$
	SELECT 
		TeacherProfile.id as Id,
		AccountData.id as AccountID, 
		AccountData.FirstName as FirstName, 
		AccountData.LastName as LastName, 
		AccountData.Patronymic as Patronymic,
		Post.PostName as Post,
		AcademicDegree.AcademicDegreeName as AcademicDegree,
		Department.Name as DepartmentName,
		TeacherProfile.IsHead as IsHead
	FROM 
	TeacherProfile
	JOIN (SELECT Account.Id,
				 Account.FirstName,
				 Account.LastName,
				 Account.Patronymic
		  FROM Account WHERE Account.Id = p_AccountId) AccountData
	ON TeacherProfile.Account = AccountData.Id
	JOIN Post
	ON TeacherProfile.Post = Post.Id
	JOIN AcademicDegree
	ON TeacherProfile.Degree = AcademicDegree.Id
	JOIN Department
	ON TeacherProfile.Department = Department.Id
$$ LANGUAGE sql;

--------------------------------------------------------

CREATE OR REPLACE FUNCTION get_researches() 
RETURNS TABLE (
		Id INTEGER,
		Name VARCHAR,
		Type VARCHAR,
		City VARCHAR,
		Street VARCHAR,
		AddressNumber VARCHAR,
		Date DATE,
		Faculty INTEGER,
		CommitetteChairManId INTEGER
) AS $$
	SELECT
		Event.Id as Id,
		Event.Name as Name,
		Event.Type as Type,
		Event.AddressCity as City,
		Event.AddressStreet as Street,
		Event.AddressNumber as AddressNumber,
		Event.Date as Date,
		Faculty.Id as Faculty,
		Commitette.ChairMan as CommitetteChairManId
	FROM Research 
	
	JOIN Event
	ON Event.Id = Research.Event
	
	JOIN Faculty
	ON Faculty.Id = Event.Faculty
	
	JOIN Commitette 
	ON Commitette.Id = Research.Commitette
	
	JOIN TeacherProfile
	ON TeacherProfile.Id = Commitette.Chairman
	
	JOIN Post
	ON Post.Id = TeacherProfile.post;
$$ LANGUAGE sql;

--------------------------------------------------------

-- Получить НИР за определенный год
CREATE OR REPLACE FUNCTION get_researches_by_year(
	p_YEAR VARCHAR
) RETURNS TABLE (
		ResearchID INTEGER,
		EventName VARCHAR,
		EventType VARCHAR,
		City VARCHAR,
		Street VARCHAR,
		AddressNumber VARCHAR,
		Date DATE,
		FacultyName VARCHAR,
		CommitetteChairManId INTEGER
) AS $$
	SELECT
		ResearchID,
		EventName,
		EventType,
		City,
		Street,
		AddressNumber,
		Date,
		FacultyName,
		CommitetteChairManId
	FROM get_researches() 
	WHERE DATE_PART('Year', Date) = p_YEAR;
$$ LANGUAGE sql;

-- Получить НИР на определенную дату
CREATE OR REPLACE FUNCTION get_researches_by_date(
	p_Date DATE
) RETURNS TABLE (
		ResearchID INTEGER,
		EventName VARCHAR,
		EventType VARCHAR,
		City VARCHAR,
		Street VARCHAR,
		AddressNumber VARCHAR,
		Date DATE,
		FacultyName VARCHAR,
		CommitetteChairManId INTEGER
) AS $$
	SELECT
		ResearchID,
		EventName,
		EventType,
		City,
		Street,
		AddressNumber,
		Date,
		FacultyName,
		CommitetteChairManId
	FROM get_researches() 
	WHERE Date = p_Date;
$$ LANGUAGE sql;


--------------------------------------------------------

-- Получить участников исследования по его id

CREATE OR REPLACE FUNCTION get_research_participants(
	p_ResearchId INTEGER
) RETURNS TABLE (
	ResearchID INTEGER,
	AccountID INTEGER, 
	FirstName VARCHAR, 
	LastName VARCHAR, 
	Patronymic VARCHAR
) AS $$
	SELECT 
		Research.id as ResearchID,
		Account.id as AccountID,
		Account.FirstName as FirstName, 
		Account.LastName as LastName, 
		Account.Patronymic as Patronymic
	FROM 
	ResearchParticipants
	JOIN Research
	ON Research.Id = ResearchParticipants.Research
	JOIN Account
	ON Account.Id = ResearchParticipants.Account
	WHERE Research.id = p_ResearchId;
$$ LANGUAGE sql;

--------------------------------------------------------

-- Получение списка олимпиад, проводимых определенным факультетом.
CREATE OR REPLACE FUNCTION get_olymps_by_faculty_id(
	p_FacultyID INTEGER
) RETURNS TABLE (
		ResearchID INTEGER,
		EventName VARCHAR,
		EventType VARCHAR,
		City VARCHAR,
		Street VARCHAR,
		AddressNumber VARCHAR,
		Date Date,
		FacultyName VARCHAR,
		CommitetteChairManId INTEGER
) AS $$
	SELECT
		ResearchID,
		EventName,
		EventType,
		City,
		Street,
		AddressNumber,
		Date,
		FacultyName,
		CommitetteChairManId
	FROM
		get_researches()
	WHERE
		EventType = 'Олимпиада' AND FacultyName = (SELECT Faculty.Name FROM Faculty WHERE Faculty.Id = p_FacultyID);
$$ LANGUAGE sql;

--------------------------------------------------------

SELECT
	Research.Id as ResearchID,
	Event.Name as EventName,
	Event.Type as EventType,
	Event.AddressCity as City,
	Event.AddressStreet as Street,
	Event.AddressNumber as Number,
	Event.Date as Date,
	Faculty.Name as FacultyName,
	Commitette.ChairMan as CommitetteChairManId,
	Participants.AccountID as ParticipantId,
	Participants.FirstName as ParticipantsFirstName,
	Participants.LastName as ParticipantsLastName,
	Participants.Patronymic as ParticipantsPatronymic
FROM Research 

JOIN Event
ON Event.Id = Research.Event

JOIN Faculty
ON Faculty.Id = Event.Faculty

JOIN Commitette 
ON Commitette.Id = Research.Commitette

JOIN TeacherProfile
ON TeacherProfile.Id = Commitette.Chairman

JOIN Post
ON Post.Id = TeacherProfile.post

JOIN (
	SELECT 
		Research.id as ResearchID,
		Account.id as AccountID, 
		Account.FirstName as FirstName, 
		Account.LastName as LastName, 
		Account.Patronymic as Patronymic
	FROM 
	ResearchParticipants
	JOIN Research
	ON Research.Id = ResearchParticipants.Research
	JOIN Account
	ON Account.Id = ResearchParticipants.Account
	) Participants
ON Participants.ResearchID = Research.Id

WHERE DATE_PART('Year', Date) = '2024';

-------------

select Research.id as ResearchID, Account.id, Account.FirstName, Account.LastName, Account.Patronymic from 
ResearchParticipants
JOIN Research
ON Research.Id = ResearchParticipants.Research
JOIN Account
On Account.Id = ResearchParticipants.Account