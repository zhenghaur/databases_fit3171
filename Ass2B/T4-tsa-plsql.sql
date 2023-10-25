/******PLEASE ENTER YOUR DETAILS BELOW******/
/*T4-tsa-plsql.sql*/

/*Student ID: 32023952*/
/*Student Name: Lim Zheng Haur*/
/*Unit Code: FIT3171*/
/*Applied Class No: A01*/

/* Comments for your marker:

*/

SET SERVEROUTPUT ON

/*4(a) */
/* Create a sequence for REVIEW PK*/

DROP SEQUENCE review_seq;

CREATE SEQUENCE review_seq START WITH 1;

/* Complete the procedure below*/
CREATE OR REPLACE PROCEDURE prc_insert_review (
    p_member_id      IN NUMBER,
    p_poi_id         IN NUMBER,
    p_review_comment IN VARCHAR2,
    p_review_rating  IN NUMBER,
    p_output         OUT VARCHAR2
) AS
    var_member_id_found NUMBER;
    var_poi_id_found    NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO var_member_id_found
    FROM
        member
    WHERE
        member_id = p_member_id;

    SELECT
        COUNT(*)
    INTO var_poi_id_found
    FROM
        point_of_interest
    WHERE
        poi_id = p_poi_id;

    IF ( var_member_id_found = 0 ) THEN
        p_output := 'Invalid member ID, new review process cancelled';
    ELSE
        IF ( var_poi_id_found = 0 ) THEN
            p_output := 'Invalid point of interest ID, new review process cancelled';
        ELSE
            INSERT INTO review VALUES (
                review_seq.NEXTVAL,
                p_member_id,
                sysdate,
                p_review_comment,
                p_review_rating,
                p_poi_id
            );

            p_output := 'New review for point of interest '
                        || p_poi_id
                        || ' has been recorded';
        END IF;
    END IF;

END prc_insert_review;
/

/* Write Test Harness for 4(a)*/

DECLARE
    output VARCHAR2(200);
BEGIN
    /*call the procedure - invalid member_id*/
    prc_insert_review(5, 1, 'Test comment', 4, output);
    dbms_output.put_line(output);
END;
/

DECLARE
    output VARCHAR2(200);
BEGIN
    /*call the procedure - invalid poi_id*/
    prc_insert_review(1, 5, 'Test comment', 4, output);
    dbms_output.put_line(output);
END;
/

DECLARE
    output VARCHAR2(200);
BEGIN
    /*call the procedure - success*/
    prc_insert_review(1, 1, 'Test comment', 4, output);
    dbms_output.put_line(output);
END;
/

ROLLBACK;

/*4(b) */
/*Write your trigger statement, */
/*finish it with a slash(/) followed by a blank line*/

CREATE OR REPLACE TRIGGER new_member_trigger BEFORE
    INSERT ON member
    FOR EACH ROW
DECLARE
    resort_id_recby NUMBER;
BEGIN
    SELECT
        resort_id
    INTO resort_id_recby
    FROM
        member
    WHERE
        member_id = :new.member_id_recby;

    IF resort_id_recby <> :new.resort_id THEN
        raise_application_error(-20001, 'new member may only be recommended by another member within the same resort'
        );
    END IF;

    UPDATE member
    SET
        member_points = member_points + 10
    WHERE
        member_id = :new.member_id_recby;

END;
/

/* Write Test Harness for 4(b)*/

/* Test trigger - insert member with and member recommended by within the same resort - success*/
INSERT INTO member VALUES (
    5,
    1,
    3,
    NULL,
    NULL,
    'TEST HADDRESS',
    'TEST EMAIL',
    '0123456789',
    sysdate,
    1000,
    1
);

/* Test trigger - insert member with and member recommended by NOT within the same resort - failure*/
INSERT INTO member VALUES (
    6,
    1,
    4,
    NULL,
    NULL,
    'TEST HADDRESS',
    'TEST EMAIL',
    '0123456789',
    sysdate,
    1000,
    2
);

ROLLBACK;