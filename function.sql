-- умова завдання на функцію:
-- створити функцію, яка приймає назву конференції (TEDEvent) та назву рейтингу
-- повертає таблицю виступів, які проведені в рамках даної конференції та в яких переважає даний рейтинг
-- в таблиці буде id спікера, його ім'я та назва виступу

-- DROP TYPE speech_table;

CREATE OR REPLACE TYPE speech_row AS OBJECT (
    speaker_id VARCHAR2(10)
    , speaker_name VARCHAR2(100)
    , speech_name VARCHAR2(200)
);
/
CREATE OR REPLACE TYPE speech_table IS TABLE OF speech_row;
/
CREATE OR REPLACE FUNCTION Find_Speech_By_Rating_Event (
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
            PIPE ROW(speech_row(
                                speech_record.speaker_id
                                , speech_record.speaker_name
                                , speech_record.speech_name
            ));
        END LOOP;
        
    END;

