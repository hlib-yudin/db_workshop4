INSERT INTO Country (country) VALUES ('Ukraine');
INSERT INTO Country (country) VALUES ('USA');
INSERT INTO Country (country) VALUES ('UK');

INSERT INTO City (city, country) VALUES ('Kyiv', 'Ukraine');
INSERT INTO City (city, country) VALUES ('New York', 'USA');
INSERT INTO City (city, country) VALUES ('London', 'UK');

INSERT INTO Street (street, city, country) VALUES ('Politekhnichna Str', 'Kyiv', 'Ukraine');
INSERT INTO Street (street, city, country) VALUES ('5th Avenue', 'New York', 'USA');
INSERT INTO Street (street, city, country) VALUES ('Baker Str', 'London', 'UK');

INSERT INTO Building (building_id, country, city, street, building_number) 
    VALUES (1, 'Ukraine', 'Kyiv', 'Politekhnichna Str', '36');
INSERT INTO Building (building_id, country, city, street, building_number) 
    VALUES (2, 'USA', 'New York', '5th Avenue', '5');
INSERT INTO Building (building_id, country, city, street, building_number) 
    VALUES (3, 'UK', 'London', 'Baker Str', '221B');
    
INSERT INTO Conference_Hall (building_id, hall_number) VALUES (1, 1);
INSERT INTO Conference_Hall (building_id, hall_number) VALUES (2, 2);
INSERT INTO Conference_Hall (building_id, hall_number) VALUES (3, 10);

INSERT INTO Person (person_name, passport_id) VALUES ('Elon Musk', 'A1');
INSERT INTO Person (person_name, passport_id) VALUES ('Bill Gates', 'B2');
INSERT INTO Person (person_name, passport_id) VALUES ('Oleg Chertov', 'C3');

INSERT INTO TEDEvent (event) VALUES ('TED2019');
INSERT INTO TEDEvent (event) VALUES ('TED2020');
INSERT INTO TEDEvent (event) VALUES ('TED2020KPI');

INSERT INTO Rating (rating_name) VALUES ('Funny');
INSERT INTO Rating (rating_name) VALUES ('Inspiring');
INSERT INTO Rating (rating_name) VALUES ('Creative');

INSERT INTO TEDTalk (speech_name, event) 
    VALUES ('Elon Musk: To Mars and beyond', 'TED2020');
INSERT INTO TEDTalk (speech_name, event) 
    VALUES ('Elon Musk: Moon Resorts', 'TED2020');
INSERT INTO TEDTalk (speech_name, event) 
    VALUES ('Oleg Chertov: Math and Broccoli', 'TED2020KPI');
    
INSERT INTO Speech_Author (speech_name, person_id)
    VALUES ('Elon Musk: To Mars and beyond', 'A1');
INSERT INTO Speech_Author (speech_name, person_id)
    VALUES ('Elon Musk: Moon Resorts', 'A1');
INSERT INTO Speech_Author (speech_name, person_id)
    VALUES ('Oleg Chertov: Math and Broccoli', 'C3');
    
INSERT INTO TEDTalk_Organized (speech_name, building_id, hall_number, speech_date, duration_sec)
    VALUES ('Elon Musk: To Mars and beyond', 2, 2, TO_DATE('20-04-2020 13:00', 'dd-mm-yyyy hh24:mi'), 700);
INSERT INTO TEDTalk_Organized (speech_name, building_id, hall_number, speech_date, duration_sec)
    VALUES ('Elon Musk: Moon Resorts', 2, 2, TO_DATE('20-04-2020 13:30', 'dd-mm-yyyy hh24:mi'), 500);
INSERT INTO TEDTalk_Organized (speech_name, building_id, hall_number, speech_date, duration_sec)
    VALUES ('Oleg Chertov: Math and Broccoli', 1, 1, TO_DATE('19-05-2020 15:00', 'dd-mm-yyyy hh24:mi'), 800);
    
INSERT INTO Speech_Audience (person_id, speech_name) VALUES ('A1', 'Oleg Chertov: Math and Broccoli');
INSERT INTO Speech_Audience (person_id, speech_name) VALUES ('B2', 'Oleg Chertov: Math and Broccoli');
INSERT INTO Speech_Audience (person_id, speech_name) VALUES ('B2', 'Elon Musk: To Mars and beyond');

INSERT INTO Speech_Rating (speech_name, rating_name, curr_date, rating_value)
    VALUES ('Oleg Chertov: Math and Broccoli', 'Creative', TO_DATE('01-06-2020', 'dd-mm-yyyy'), 1500);
INSERT INTO Speech_Rating (speech_name, rating_name, curr_date, rating_value)
    VALUES ('Oleg Chertov: Math and Broccoli', 'Funny', TO_DATE('01-06-2020', 'dd-mm-yyyy'), 500);
INSERT INTO Speech_Rating (speech_name, rating_name, curr_date, rating_value)
    VALUES ('Elon Musk: To Mars and beyond', 'Inspiring', TO_DATE('01-06-2020', 'dd-mm-yyyy'), 3000);
    
INSERT INTO Video (publisher_id, url, speech_name) 
    VALUES ('B2', 'www...elonmusk/mars', 'Elon Musk: To Mars and beyond');
INSERT INTO Video (publisher_id, url, speech_name) 
    VALUES ('B2', 'www...elonmusk/moon', 'Elon Musk: Moon Resorts');
INSERT INTO Video (publisher_id, url, speech_name) 
    VALUES ('B2', 'www...chertov/math', 'Oleg Chertov: Math and Broccoli');
    
INSERT INTO Video_Views (url, curr_date, views) VALUES ('www...elonmusk/mars', TO_DATE('01-08-2020', 'dd-mm-yyyy'), 10000);
INSERT INTO Video_Views (url, views) VALUES ('www...elonmusk/moon', 11000);
INSERT INTO Video_Views (url, views) VALUES ('www...chertov/math', 200000);

