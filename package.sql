CREATE OR REPLACE PACKAGE TEDTalks_pkg IS

    TYPE speech_row IS RECORD (
        speaker_id PERSON.passport_id%TYPE
        , speaker_name PERSON.person_name%TYPE
        , speech_name TEDTalk.speech_name%TYPE
    );
    
    TYPE speech_table IS TABLE OF speech_row;
    
    PROCEDURE Add_Speaker_To_Event_Proc (
        -- використовуємо id людини замість імені, бо може бути кілька людей з однаковим іменем
        par_speaker_id PERSON.passport_id%TYPE
        , par_speech_name TEDTALK.speech_name%TYPE
        , par_event TEDEVENT.event%TYPE);
        
    FUNCTION Find_Speech_By_Rating_Event (
        par_event TEDEVENT.event%TYPE
        , par_rating_name RATING.rating_name%TYPE
        )
        RETURN speech_table
        PIPELINED;
        
END TEDTalks_pkg;
    
    
/    


CREATE OR REPLACE PACKAGE BODY TEDTalks_pkg IS

    PROCEDURE Add_Speaker_To_Event_Proc (
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
    
    
    FUNCTION Find_Speech_By_Rating_Event (
        par_event TEDEVENT.event%TYPE
        , par_rating_name RATING.rating_name%TYPE
        )
        RETURN speech_table
        PIPELINED
        IS        
            CURSOR speech_cursor IS 
                                        --крок 2: person_id -- person_name -- speech_name
                                        SELECT 
                                            Person.passport_id as speaker_id
                                            , Person.person_name as speaker_name
                                            , temp1.speech_name as speech_name
                                            
                                        FROM (   
                                                    --крок 1: виступ -- максимальне rating_value серед усіх rating_name
                                                    SELECT 
                                                        Speech_Rating.speech_name as speech_name
                                                        , MAX(Speech_Rating.rating_value) AS max_rating_value
                                                    FROM 
                                                        Speech_Rating 
                                                    GROUP BY 
                                                        Speech_Rating.speech_name
                                                     
                                            -- крок 2            
                                            ) temp1 JOIN Speech_Rating
                                                ON Speech_Rating.speech_name = temp1.speech_name
                                                AND Speech_Rating.rating_value = temp1.max_rating_value
                                            JOIN TEDTalk
                                                ON TEDTalk.speech_name = temp1.speech_name
                                            JOIN Speech_Author
                                                ON temp1.speech_name = Speech_Author.speech_name
                                            JOIN Person
                                                ON Person.passport_id = Speech_Author.person_id
                                            
                                            WHERE Speech_Rating.rating_name = par_rating_name
                                                AND TEDTalk.event = par_event;
                                                
        BEGIN
            FOR speech_record IN speech_cursor 
            LOOP
                PIPE ROW(speech_record);
            END LOOP;
            
        END;
        
END TEDTalks_pkg;


--select * from TABLE(TEDTalks_pkg.Find_Speech_By_Rating_Event('TED2020KPI', 'Creative'));