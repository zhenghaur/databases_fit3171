/******PLEASE ENTER YOUR DETAILS BELOW******/
/*T3-tsa-dm.sql*/

/*Student ID: 32023952*/
/*Student Name: Lim Zheng Haur*/
/*Unit Code: FIT3171*/
/*Applied Class No: A01*/

/* Comments for your marker:

For task 3(c) booking_total_points_cost, 
I am unsure to use 220 * ( TO_DATE('28/05/2023', 'dd/mm/yyyy') - TO_DATE('26/05/2023', 'dd/mm/yyyy') )
or to select the value 220 from the cabin table.
I have decided in the end to submit with the query to obtain the cabin_points_cost_day.


*/

/*-**This command shows the outputs of triggers**---*/
/*-**Run the command before running the insert statements.**---*/
/*-**Do not remove**---*/
SET SERVEROUTPUT ON
/*-**end**---*/

/*3(a)*/

DROP SEQUENCE booking_seq;

CREATE SEQUENCE booking_seq START WITH 100 INCREMENT BY 10;

COMMIT;

/*3(b)*/

INSERT INTO cabin VALUES (
    (
        SELECT
            resort_id
        FROM
                 resort
            JOIN town
            ON resort.town_id = town.town_id
        WHERE
                UPPER(resort_name) = UPPER('Awesome Resort')
            AND town_lat = - 17.9644
            AND town_long = 122.2304
    ),
    4,
    4,
    10,
    'I',
    220,
    '3 king size beds and 2 double beds'
);

COMMIT;

/*3(c)*/

INSERT INTO booking VALUES (
    booking_seq.NEXTVAL,
    (
        SELECT
            resort_id
        FROM
                 resort
            JOIN town
            ON resort.town_id = town.town_id
        WHERE
                UPPER(resort_name) = UPPER('Awesome Resort')
            AND town_lat = - 17.9644
            AND town_long = 122.2304
    ),
    4,
    TO_DATE('26/05/2023', 'dd/mm/yyyy'),
    TO_DATE('28/05/2023', 'dd/mm/yyyy'),
    4,
    4,
    (
        SELECT
            cabin_points_cost_day
        FROM
            cabin
        WHERE
                resort_id = (
                    SELECT
                        resort_id
                    FROM
                             resort
                        JOIN town
                        ON resort.town_id = town.town_id
                    WHERE
                            UPPER(resort_name) = UPPER('Awesome Resort')
                        AND town_lat = - 17.9644
                        AND town_long = 122.2304
                )
            AND cabin_no = 4
    ) * ( TO_DATE('28/05/2023', 'dd/mm/yyyy') - TO_DATE('26/05/2023', 'dd/mm/yyyy') )
    ,
    (
        SELECT
            member_id
        FROM
            member
        WHERE
                member_no = 2
            AND resort_id = 9
    ),
    (
        SELECT
            staff_id
        FROM
            staff
        WHERE
                upper(staff_gname) = upper('Reeba')
            AND upper(staff_fname) = upper('Wildman')
            AND staff_phone = '0493427245'
    )
);

COMMIT;

/*3(d)*/

UPDATE booking
SET
    booking_to = booking_to + 1,
    booking_total_points_cost = booking_total_points_cost + 1 * (
        SELECT
            cabin_points_cost_day
        FROM
            cabin
        WHERE
                resort_id = (
                    SELECT
                        resort_id
                    FROM
                             resort
                        JOIN town
                        ON resort.town_id = town.town_id
                    WHERE
                            UPPER(resort_name) = UPPER('Awesome Resort')
                        AND town_lat = - 17.9644
                        AND town_long = 122.2304
                )
            AND cabin_no = 4
    )
WHERE
        resort_id = (
            SELECT
                resort_id
            FROM
                     resort
                JOIN town
                ON resort.town_id = town.town_id
            WHERE
                    UPPER(resort_name) = UPPER('Awesome Resort')
                AND town_lat = - 17.9644
                AND town_long = 122.2304
        )
    AND cabin_no = 4
    AND booking_from = TO_DATE('26/05/2023', 'dd/mm/yyyy');

COMMIT;

/*3(e)*/

DELETE FROM booking
WHERE
        resort_id = (
            SELECT
                resort_id
            FROM
                     resort
                JOIN town
                ON resort.town_id = town.town_id
            WHERE
                    UPPER(resort_name) = UPPER('Awesome Resort')
                AND town_lat = - 17.9644
                AND town_long = 122.2304
        )
    AND cabin_no = 4
    AND booking_from >= TO_DATE('04/05/2023', 'dd/mm/yyyy');

DELETE FROM cabin
WHERE
        resort_id = (
            SELECT
                resort_id
            FROM
                     resort
                JOIN town
                ON resort.town_id = town.town_id
            WHERE
                    UPPER(resort_name) = UPPER('Awesome Resort')
                AND town_lat = - 17.9644
                AND town_long = 122.2304
        )
    AND cabin_no = 4;

COMMIT;