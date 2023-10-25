/******PLEASE ENTER YOUR DETAILS BELOW******/
/*T3-tsa-json.sql*/

/*Student ID: 32023952*/
/*Student Name: Lim Zheng Haur*/
/*Unit Code: FIT3171*/
/*Applied Class No: A01*/

/* Comments for your marker:




*/

/*3(a)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT TO GENERATE */
/* THE COLLECTION OF JSON DOCUMENTS HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SET PAGESIZE 200

SELECT
        JSON_OBJECT(
            '_id' VALUE town.town_id,
                    'name' VALUE town_name
                                 || ', '
                                 || town_state,
                    'location' VALUE
                JSON_OBJECT(
                    'latitude' VALUE town_lat,
                    'longtitude' VALUE town_long
                ),
                    'avg_temperature' VALUE
                JSON_OBJECT(
                    'summer' VALUE town_avg_summer_temp,
                    'winter' VALUE town_avg_winter_temp
                ),
                    'no_of_resorts' VALUE COUNT(resort_id),
                    'resorts' VALUE JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE resort.resort_id,
                            'name' VALUE resort_name,
                            'address' VALUE resort_street_address,
                            'phone' VALUE resort_phone,
                            'year_built' VALUE TO_NUMBER(to_char(resort_yr_built_purch
                            , 'yyyy')),
                            'company_name' VALUE company_name
                )
            )
        FORMAT JSON)
        || ','
FROM
         tsa.town
    JOIN tsa.resort
    ON town.town_id = resort.town_id
    JOIN tsa.company
    ON resort.company_abn = company.company_abn
GROUP BY
    town.town_id,
    town_name,
    town_state,
    town_lat,
    town_long,
    town_avg_summer_temp,
    town_avg_winter_temp
ORDER BY
    town.town_id;