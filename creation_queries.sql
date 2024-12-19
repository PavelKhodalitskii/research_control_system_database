CREATE OR REPLACE FUNCTION create_account(
	p_FirstName VARCHAR,
	p_LastName VARCHAR,
	p_Patronymic VARCHAR
) RETURNS void as $$
BEGIN
	INSERT INTO Account (FirstName, LastName, Patronymic)
		VALUES (
    		p_FirstName,
			p_LastName,
			p_Patronymic
		);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION create_student(
	p_AccountId INTEGER,
	p_Group INTEGER,
	p_Year INTEGER
) RETURNS void as $$
BEGIN
	INSERT INTO StudentProfile (Account, StudGroup, Year)
		VALUES (
    		p_AccountId,
			p_Group,
			p_Year
		);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_student()

CREATE OR REPLACE FUNCTION delete_student()