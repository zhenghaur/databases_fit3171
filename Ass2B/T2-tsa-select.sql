/******PLEASE ENTER YOUR DETAILS BELOW******/
/*T2-tsa-select.sql*/

/*Student ID: 32023952*/
/*Student Name: Lim Zheng Haur*/
/*Unit Code: FIT3171*/
/*Applied Class No: A01*/

/* Comments for your marker:




*/

/*2(a)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    town.town_id,
    town_name,
    poi_type.poi_type_id,
    poi_type_descr,
    COUNT(poi_id) AS poi_count
FROM
         tsa.point_of_interest
    JOIN tsa.poi_type
    ON point_of_interest.poi_type_id = poi_type.poi_type_id
    JOIN tsa.town
    ON town.town_id = point_of_interest.town_id
GROUP BY
    town.town_id,
    town_name,
    poi_type.poi_type_id,
    poi_type_descr
HAVING
    COUNT(poi_id) > 1
ORDER BY
    town.town_id;

/*2(b)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    m2.member_id,
    CASE
        WHEN m2.member_gname IS NULL THEN
            m2.member_fname
        ELSE
            m2.member_gname
            || ' '
            || m2.member_fname
    END                 AS member_name,
    m1.resort_id,
    resort_name,
    COUNT(m1.member_id) AS number_of_recommendations
FROM
         tsa.member m1
    JOIN tsa.member m2
    ON m1.member_id_recby = m2.member_id
    JOIN tsa.resort
    ON m1.resort_id = resort.resort_id
GROUP BY
    m2.member_id,
    m2.member_gname,
    m2.member_fname,
    m1.resort_id,
    resort_name
HAVING
    COUNT(m1.member_id) = (
        SELECT
            MAX(COUNT(m1.member_id)) AS number_of_recommendations
        FROM
                 tsa.member m1
            JOIN tsa.member m2
            ON m1.member_id_recby = m2.member_id
        GROUP BY
            m2.member_id
    )
ORDER BY
    resort_id,
    member_id;
    
/*2(c)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    point_of_interest.poi_id,
    poi_name,
    nvl(to_char(MAX(review_rating),
                '0'),
        'NR') AS max_rating,
    nvl(to_char(MIN(review_rating),
                '0'),
        'NR') AS min_rating,
    nvl(to_char(AVG(review_rating),
                '9.0'),
        'NR') AS avg_rating
FROM
    tsa.point_of_interest
    LEFT JOIN tsa.review
    ON point_of_interest.poi_id = review.poi_id
GROUP BY
    point_of_interest.poi_id,
    poi_name
ORDER BY
    point_of_interest.poi_id;

/*2(d)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    poi_name,
    poi_type_descr,
    town_name,
    lpad('Lat:'
         || to_char(town_lat, '999.000000')
         || ' Long:'
         || to_char(town_long, '999.000000'),
         35)         AS town_location,
    COUNT(review_id) AS review_completed,
    CASE
        WHEN COUNT(review_id) = 0 THEN
            'No reviews completed'
        ELSE
            to_char((COUNT(review_id) /(
                SELECT
                    COUNT(*)
                FROM
                    tsa.review
            ) * 100),
                    'FM99.00')
            || '%'
    END              AS percent_of_reviews
FROM
    tsa.point_of_interest
    LEFT JOIN tsa.review
    ON point_of_interest.poi_id = review.poi_id
    JOIN tsa.poi_type
    ON point_of_interest.poi_type_id = poi_type.poi_type_id
    JOIN tsa.town
    ON point_of_interest.town_id = town.town_id
GROUP BY
    poi_name,
    poi_type_descr,
    town_name,
    town_lat,
    town_long
ORDER BY
    town_name,
    review_completed DESC,
    poi_type_descr,
    poi_name;

/*2(e)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    r.resort_id,
    resort_name,
    member_no,
    member_name,
    date_joined,
    recommended_by_details,
    lpad(to_char(total_charges, '$99999'),
         13) AS total_charges
FROM
         (
        SELECT
            member.resort_id,
            resort_name,
            member.member_no,
            CASE
                WHEN member.member_gname IS NULL THEN
                    member.member_fname
                ELSE
                    member.member_gname
                    || ' '
                    || member.member_fname
            END                                               AS member_name,
            to_char(member.member_date_joined, 'dd-Mon-yyyy') AS date_joined,
            m2.member_no
            || ' '
            ||
            CASE
                WHEN m2.member_gname IS NULL THEN
                        m2.member_fname
                ELSE
                    m2.member_gname
                    || ' '
                    || m2.member_fname
            END
            AS recommended_by_details,
            SUM(mc_total)                                     AS total_charges
        FROM
                 tsa.member
            JOIN (
                SELECT
                    resort_id,
                    resort_name
                FROM
                         tsa.resort
                    JOIN tsa.town
                    ON resort.town_id = town.town_id
                WHERE
                    NOT ( upper(town_name) = upper('Byron Bay')
                          AND upper(town_state) = upper('NSW') )
            )          r
            ON member.resort_id = r.resort_id
            JOIN tsa.member_charge
            ON member.member_id = member_charge.member_id
            JOIN tsa.member m2
            ON member.member_id_recby = m2.member_id
        WHERE
            member.member_id_recby IS NOT NULL
        GROUP BY
            member.member_id,
            member.resort_id,
            resort_name,
            member.member_no,
            member.member_gname,
            member.member_fname,
            member.member_date_joined,
            m2.member_no,
            m2.member_gname,
            m2.member_fname
    ) r
    JOIN (
        SELECT
            resort.resort_id,
            ( SUM(mc_total) / COUNT(DISTINCT member.member_id) ) AS avg_charge
        FROM
                 tsa.resort
            JOIN tsa.member
            ON resort.resort_id = member.resort_id
            JOIN tsa.member_charge
            ON member.member_id = member_charge.member_id
        GROUP BY
            resort.resort_id
    ) resort_avg
    ON r.resort_id = resort_avg.resort_id
WHERE
    total_charges < avg_charge
ORDER BY
    resort_id,
    member_no;

/*2(f)*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/

SELECT
    resort_id,
    resort_name,
    poi_name,
    poi_town,
    poi_state,
    poi_opening_time,
    to_char(geodistance(town.town_lat, town.town_long, poi.town_lat, poi.town_long),
            '90.0')
    || ' Kms' AS distance
FROM
         tsa.resort
    JOIN tsa.town
    ON resort.town_id = town.town_id
    JOIN (
        SELECT
            poi_name,
            town_name             AS poi_town,
            town_state            AS poi_state,
            nvl(to_char(poi_open_time, 'HH:MI AM'),
                'Not Applicable') AS poi_opening_time,
            town_lat,
            town_long
        FROM
                 tsa.point_of_interest
            JOIN tsa.town
            ON point_of_interest.town_id = town.town_id
    ) poi
    ON geodistance(town.town_lat, town.town_long, poi.town_lat, poi.town_long) <= 100
    ;