BEGIN
    DBMS_OUTPUT.enable;
END;
/
SET SERVEROUTPUT ON;


-- умова завдання на процедуру:
-- додає спікера до конференції. exception: конференцію чи спікера не знайдено.

CREATE OR REPLACE PROCEDURE Add_Speaker_To_Event_Proc (
    -- використовуємо id людини замість імені, бо може бути кілька людей з однаковим іменем
    par_speaker_id PERSON.passport_id%TYPE
    , par_speech_name TEDTALK.speech_name%TYPE
    , par_event TEDEVENT.event%TYPE)
    AS
        var_speaker_id PERSON.passport_id%TYPE;
        var_event TEDEVENT.event%TYPE;
    BEGIN
        -- спочатку переконаємось, що спікер та конференція існують
        -- якщо ні, то виникне помилка NO_DATA_FOUND
        SELECT passport_id INTO var_speaker_id   FROM Person     WHERE passport_id = par_speaker_id;
        SELECT event       INTO var_event        FROM TEDEvent   WHERE event = par_event;
    
        -- вставляємо інформацію про виступ та про конференцію
        INSERT INTO TEDTalk (speech_name, event) VALUES (par_speech_name, par_event);
        -- вставляємо інформацію про автора
        INSERT INTO Speech_Author (person_id, speech_name) VALUES (par_speaker_id, par_speech_name);
        DBMS_OUTPUT.put_line('Success');
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('Error');
            DBMS_OUTPUT.put_line('Speaker or event was not found');
        
    END;
    

