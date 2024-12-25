-----------------------------------------------------

-- Trigger funciton
CREATE OR REPLACE FUNCTION return_new_instance()
RETURNS TRIGGER AS $$
BEGIN
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-----

CREATE TRIGGER after_insert_on_event
AFTER INSERT ON Event
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_Research
AFTER INSERT ON Research
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_researchparticipants
AFTER INSERT ON researchparticipants
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_commitette
AFTER INSERT ON commitette
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_relationteacherscommitette
AFTER INSERT ON relationteacherscommitette
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_account
AFTER INSERT ON account
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_studentprofile
AFTER INSERT ON studentprofile
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

------

CREATE TRIGGER after_insert_on_teacherprofile
AFTER INSERT ON teacherprofile
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

-----

CREATE TRIGGER after_insert_on_faculty
AFTER INSERT ON faculty
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

------

CREATE TRIGGER after_insert_on_department
AFTER INSERT ON department
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

------

CREATE TRIGGER after_insert_on_speciality
AFTER INSERT ON speciality
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

------

CREATE TRIGGER after_insert_on_groups
AFTER INSERT ON groups
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();

------

CREATE TRIGGER after_update_on_account
AFTER UPDATE ON account
FOR EACH ROW
EXECUTE FUNCTION return_new_instance();
