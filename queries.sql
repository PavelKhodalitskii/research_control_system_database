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
