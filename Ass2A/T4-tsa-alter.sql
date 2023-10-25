/******PLEASE ENTER YOUR DETAILS BELOW******/
/*T4-tsa-alter.sql*/

/*Student ID: 32023952*/
/*Student Name: Lim Zheng Haur*/
/*Unit Code: FIT3171*/
/*Applied Class No: A01*/

/* Comments for your marker:




*/

/*4(a)*/

ALTER TABLE cabin ADD cabin_total_booking NUMBER(9) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN cabin.cabin_total_booking IS
    'cabin current number of booking';

DESC cabin;

UPDATE cabin
SET
    cabin_total_booking = (
        SELECT
            COUNT(*)
        FROM
            booking
        WHERE
                booking.resort_id = cabin.resort_id
            AND booking.cabin_no = cabin.cabin_no
    );

SELECT
    *
FROM
    cabin;

COMMIT;

/*4(b)*/

DROP TABLE role CASCADE CONSTRAINTS PURGE;

CREATE TABLE role (
    role_id             CHAR(1) NOT NULL,
    role_name           VARCHAR2(30) NOT NULL,
    role_jobdescription VARCHAR2(250) NOT NULL,
    CONSTRAINT role_pk PRIMARY KEY ( role_id )
);

COMMENT ON COLUMN role.role_id IS
    'role identifier';

COMMENT ON COLUMN role.role_name IS
    'name of role';

COMMENT ON COLUMN role.role_jobdescription IS
    'job description for role';

DESC role;

INSERT INTO role VALUES (
    'A',
    'Admin',
    'Take bookings, and reply to customer inquiries'
);

INSERT INTO role VALUES (
    'C',
    'Cleaning',
    'Clean cabins and maintain resort''s public area'
);

INSERT INTO role VALUES (
    'M',
    'Marketing',
    'Prepare and present marketing ideas and deliverables'
);

SELECT
    *
FROM
    role;

ALTER TABLE staff ADD role_id CHAR(1) DEFAULT 'A' NOT NULL;

DESC staff;

ALTER TABLE staff
    ADD CONSTRAINT staff_role FOREIGN KEY ( role_id )
        REFERENCES role ( role_id );

SELECT
    *
FROM
    staff;

COMMIT;
        
/*4(c)*/

DROP TABLE cleaning CASCADE CONSTRAINTS PURGE;

CREATE TABLE cleaning (
    cleaning_id   NUMBER(8) NOT NULL,
    cleaning_date DATE NOT NULL,
    resort_id     NUMBER(4) NOT NULL,
    cabin_no      NUMBER(3) NOT NULL,
    CONSTRAINT cleaning_pk PRIMARY KEY ( cleaning_id ),
    CONSTRAINT cleaning_nk UNIQUE ( cleaning_date,
                                    resort_id,
                                    cabin_no )
);

COMMENT ON COLUMN cleaning.cleaning_id IS
    'cleaning identifier';

COMMENT ON COLUMN cleaning.cleaning_date IS
    'date of cleaning';

COMMENT ON COLUMN cleaning.resort_id IS
    'Resort identifier, for this cleaning';

COMMENT ON COLUMN cleaning.cabin_no IS
    'Cabin number within the resort, for this cleaning';
    
DESC cleaning;

DROP TABLE cleaning_staff CASCADE CONSTRAINTS PURGE;

CREATE TABLE cleaning_staff (
    cleaning_id   NUMBER(8) NOT NULL,
    staff_id      NUMBER(5) NOT NULL,
    cleaning_from DATE NOT NULL,
    cleaning_to   DATE NOT NULL,
    CONSTRAINT cleaning_staff_pk PRIMARY KEY ( cleaning_id,
                                               staff_id )
);

COMMENT ON COLUMN cleaning_staff.cleaning_id IS
    'cleaning identifier';

COMMENT ON COLUMN cleaning_staff.staff_id IS
    'staff identifier';

COMMENT ON COLUMN cleaning_staff.cleaning_from IS
    'time cleaning from';

COMMENT ON COLUMN cleaning_staff.cleaning_to IS
    'time cleaning to';
    
DESC cleaning_staff;

ALTER TABLE cleaning
    ADD CONSTRAINT cleaning_cabin FOREIGN KEY ( resort_id,
                                                cabin_no )
        REFERENCES cabin ( resort_id,
                           cabin_no );

ALTER TABLE cleaning_staff
    ADD CONSTRAINT cleaningstaff_cleaning FOREIGN KEY ( cleaning_id )
        REFERENCES cleaning ( cleaning_id );

ALTER TABLE cleaning_staff
    ADD CONSTRAINT cleaningstaff_staff FOREIGN KEY ( staff_id )
        REFERENCES staff ( staff_id );
        
COMMIT;
