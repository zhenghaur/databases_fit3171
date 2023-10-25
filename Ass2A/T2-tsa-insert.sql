/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T2-tsa-insert.sql*/

/*Student ID: 32023952*/
/*Student Name: Lim Zheng Haur*/
/*Unit Code: FIT3171*/
/*Applied Class No: A01*/

/* Comments for your marker:




*/

/*-**This command shows the outputs of triggers**---*/
/*-**Run the command before running the insert statements.**---*/
/*-**Do not remove**---*/
SET SERVEROUTPUT ON
/*-**end**---*/

/*------------------------------------*/
/*INSERT INTO cabin*/
/*------------------------------------*/

INSERT INTO cabin VALUES (
    1,
    1,
    3,
    6,
    'I',
    120,
    '3 king size beds'
);

INSERT INTO cabin VALUES (
    1,
    2,
    2,
    3,
    'I',
    60,
    '1 king size bed and 1 single bed'
);

INSERT INTO cabin VALUES (
    1,
    3,
    3,
    6,
    'I',
    120,
    '3 king size beds'
);

INSERT INTO cabin VALUES (
    1,
    4,
    4,
    10,
    'I',
    160,
    '3 king size beds and 4 single beds'
);

INSERT INTO cabin VALUES (
    2,
    1,
    4,
    8,
    'I',
    160,
    '8 single beds'
);

INSERT INTO cabin VALUES (
    2,
    2,
    2,
    6,
    'C',
    120,
    '3 double beds'
);

INSERT INTO cabin VALUES (
    2,
    3,
    1,
    2,
    'C',
    70,
    '1 double bed'
);

INSERT INTO cabin VALUES (
    2,
    4,
    3,
    6,
    'C',
    120,
    '6 single beds'
);

INSERT INTO cabin VALUES (
    3,
    1,
    1,
    2,
    'C',
    70,
    '2 single beds'
);

INSERT INTO cabin VALUES (
    3,
    2,
    4,
    10,
    'I',
    170,
    '2 double beds and 6 single beds'
);

INSERT INTO cabin VALUES (
    3,
    3,
    1,
    2,
    'C',
    60,
    '1 double bed'
);

INSERT INTO cabin VALUES (
    4,
    1,
    3,
    6,
    'I',
    120,
    '1 king size bed and 4 single beds'
);

INSERT INTO cabin VALUES (
    4,
    2,
    1,
    2,
    'I',
    70,
    '1 king size bed'
);

INSERT INTO cabin VALUES (
    4,
    3,
    4,
    8,
    'I',
    160,
    '2 king size beds and 4 single beds'
);

INSERT INTO cabin VALUES (
    5,
    1,
    2,
    5,
    'C',
    100,
    '2 double beds and 1 single bed'
);

INSERT INTO cabin VALUES (
    5,
    2,
    1,
    2,
    'C',
    80,
    '1 king size bed'
);

INSERT INTO cabin VALUES (
    5,
    3,
    3,
    6,
    'I',
    120,
    '3 double beds'
);

INSERT INTO cabin VALUES (
    5,
    4,
    2,
    5,
    'C',
    100,
    '2 double beds and 1 single bed'
);

INSERT INTO cabin VALUES (
    6,
    1,
    1,
    2,
    'I',
    70,
    '1 king size bed'
);

INSERT INTO cabin VALUES (
    6,
    2,
    4,
    10,
    'I',
    180,
    '2 king size beds and 3 double beds'
);

/*------------------------------------*/
/*INSERT INTO booking*/
/*------------------------------------*/

INSERT INTO booking VALUES (
    1,
    1,
    4,
    to_date('01/03/2023', 'dd/mm/yyyy'),
    to_date('08/03/2023', 'dd/mm/yyyy'),
    6,
    4,
    1120,
    2,
    1
);

INSERT INTO booking VALUES (
    2,
    3,
    3,
    to_date('02/03/2023', 'dd/mm/yyyy'),
    to_date('07/03/2023', 'dd/mm/yyyy'),
    2,
    0,
    240,
    22,
    5
);

INSERT INTO booking VALUES (
    3,
    6,
    1,
    to_date('04/03/2023', 'dd/mm/yyyy'),
    to_date('08/03/2023', 'dd/mm/yyyy'),
    2,
    0,
    280,
    20,
    11
);

INSERT INTO booking VALUES (
    4,
    4,
    1,
    to_date('06/03/2023', 'dd/mm/yyyy'),
    to_date('12/03/2023', 'dd/mm/yyyy'),
    2,
    3,
    720,
    3,
    8
);

INSERT INTO booking VALUES (
    5,
    2,
    1,
    to_date('11/03/2023', 'dd/mm/yyyy'),
    to_date('17/03/2023', 'dd/mm/yyyy'),
    8,
    0,
    960,
    4,
    3
);

INSERT INTO booking VALUES (
    6,
    3,
    3,
    to_date('12/03/2023', 'dd/mm/yyyy'),
    to_date('22/03/2023', 'dd/mm/yyyy'),
    2,
    0,
    600,
    10,
    5
);

INSERT INTO booking VALUES (
    7,
    5,
    1,
    to_date('12/03/2023', 'dd/mm/yyyy'),
    to_date('17/03/2023', 'dd/mm/yyyy'),
    4,
    1,
    500,
    13,
    10
);

INSERT INTO booking VALUES (
    8,
    1,
    4,
    to_date('14/03/2023', 'dd/mm/yyyy'),
    to_date('20/03/2023', 'dd/mm/yyyy'),
    4,
    5,
    960,
    8,
    1
);

INSERT INTO booking VALUES (
    9,
    3,
    1,
    to_date('14/03/2023', 'dd/mm/yyyy'),
    to_date('24/03/2023', 'dd/mm/yyyy'),
    2,
    0,
    700,
    11,
    5
);

INSERT INTO booking VALUES (
    10,
    2,
    3,
    to_date('17/03/2023', 'dd/mm/yyyy'),
    to_date('22/03/2023', 'dd/mm/yyyy'),
    2,
    0,
    350,
    7,
    3
);

INSERT INTO booking VALUES (
    11,
    5,
    3,
    to_date('20/03/2023', 'dd/mm/yyyy'),
    to_date('27/03/2023', 'dd/mm/yyyy'),
    4,
    2,
    840,
    24,
    10
);

INSERT INTO booking VALUES (
    12,
    4,
    1,
    to_date('22/03/2023', 'dd/mm/yyyy'),
    to_date('28/03/2023', 'dd/mm/yyyy'),
    2,
    4,
    720,
    12,
    8
);

INSERT INTO booking VALUES (
    13,
    3,
    2,
    to_date('25/03/2023', 'dd/mm/yyyy'),
    to_date('29/03/2023', 'dd/mm/yyyy'),
    4,
    6,
    680,
    22,
    5
);

INSERT INTO booking VALUES (
    14,
    3,
    3,
    to_date('27/03/2023', 'dd/mm/yyyy'),
    to_date('01/04/2023', 'dd/mm/yyyy'),
    2,
    0,
    300,
    14,
    7
);

INSERT INTO booking VALUES (
    15,
    5,
    4,
    to_date('01/04/2023', 'dd/mm/yyyy'),
    to_date('08/04/2023', 'dd/mm/yyyy'),
    2,
    3,
    400,
    13,
    10
);

INSERT INTO booking VALUES (
    16,
    6,
    1,
    to_date('10/04/2023', 'dd/mm/yyyy'),
    to_date('17/04/2023', 'dd/mm/yyyy'),
    2,
    0,
    490,
    21,
    11
);

INSERT INTO booking VALUES (
    17,
    1,
    4,
    to_date('18/04/2023', 'dd/mm/yyyy'),
    to_date('24/04/2023', 'dd/mm/yyyy'),
    5,
    4,
    960,
    9,
    2
);

INSERT INTO booking VALUES (
    18,
    4,
    2,
    to_date('19/04/2023', 'dd/mm/yyyy'),
    to_date('23/04/2023', 'dd/mm/yyyy'),
    2,
    0,
    280,
    3,
    9
);

INSERT INTO booking VALUES (
    19,
    1,
    2,
    to_date('23/04/2023', 'dd/mm/yyyy'),
    to_date('28/04/2023', 'dd/mm/yyyy'),
    2,
    1,
    300,
    2,
    1
);

INSERT INTO booking VALUES (
    20,
    6,
    1,
    to_date('26/04/2023', 'dd/mm/yyyy'),
    to_date('30/04/2023', 'dd/mm/yyyy'),
    2,
    0,
    280,
    20,
    11
);

COMMIT;