BEGIN
    DBMS_OUTPUT.enable;
END;
/
SET SERVEROUTPUT ON;

DECLARE
    CURSOR speech_cursor IS
                            SELECT 
                                Person.person_name as person_name
                                , TEDTalk.speech_name as speech_name
                                , TEDTalk.event as event
                            FROM
                                TEDTalk JOIN Speech_Author
                                    ON TEDTalk.speech_name = Speech_Author.speech_name
                                JOIN Person
                                    ON Speech_Author.person_id = Person.passport_id;
                                    
    v_person_name PERSON.person_name%TYPE;
    v_speech_name TEDTALK.speech_name%TYPE;
    v_event TEDTALK.event%TYPE;
    v_id PERSON.passport_id%TYPE;

    CURSOR function_cursor IS
                                SELECT *
                                FROM Table(Find_Speech_By_Rating_Event('TED2020KPI', 'Creative'));

BEGIN
    DBMS_OUTPUT.put_line('Testing a procedure');
    DBMS_OUTPUT.put_line('Following calls will cause an error');
    DBMS_OUTPUT.put_line('');
    Add_Speaker_To_Event_Proc('H0', 'speech3', 'TED2020');
    Add_Speaker_To_Event_Proc('B2', 'speeech1', 'TED3000');
    
    DBMS_OUTPUT.put_line('----------------------------------------');
    DBMS_OUTPUT.put_line('Following call will be OK');
    DBMS_OUTPUT.put_line('');
    Add_Speaker_To_Event_Proc('B2', 'new speech', 'TED2020');
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('Let``s check:');
    DBMS_OUTPUT.put_line('----------------------------------------');
    
    
    FOR cur_record IN speech_cursor
    LOOP 
        v_person_name := cur_record.person_name;
        v_speech_name := cur_record.speech_name;
        v_event := cur_record.event;
        DBMS_OUTPUT.put_line('Person_name: ' || v_person_name || '    Speech_name: "' ||
            v_speech_name || '"    Event: ' || v_event);
    END LOOP;
    
    DBMS_OUTPUT.put_line('');
    DBMS_OUTPUT.put_line('As you can see, a new line was added. We added Bill Gated to the TED2020 conference.');
    DBMS_OUTPUT.put_line('----------------------------------------');
    DBMS_OUTPUT.put_line('Testing a function');
    DBMS_OUTPUT.put_line('Calling Find_Speech_By_Rating_Event("TED2020KPI", "Creative")');
    DBMS_OUTPUT.put_line('');
    
    FOR cur_record IN function_cursor
    LOOP
        v_person_name := cur_record.speaker_name;
        v_speech_name := cur_record.speech_name;
        v_id := cur_record.speaker_id;
        DBMS_OUTPUT.put_line('Person_id: ' || v_id || '    Person_name: ' ||
            v_person_name || '    Speech_name: "' || v_speech_name || '"');
    END LOOP;
    
END;

