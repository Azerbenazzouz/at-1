-- REGIONS
-- LOCATIONS
-- DEPARTMENTS
-- JOBS
-- EMPLOYEES
-- JOB_HISTORY
-- EMP
-- COUNTRIES

-- ROLLBACK;
-- SYSDATE : DATE DU SYSTEM
-- SELECT table_name
-- FROM   user_tables;
-- EX 1
CREATE TABLE EMP AS
(SELECT * FROM EMPLOYEES
WHERE SALARY > 5000);

-- Table crÚÚe.

-- EX 2
CREATE TABLE DEP AS 
SELECT D.DEPARTMENT_ID AS DEP_ID , 
D.DEPARTMENT_NAME AS DEP_NAME ,
E.MANAGER_ID AS MANAGER_ID , 
L.CITY AS LOCATION_NAME
FROM DEPARTMENTS D 
JOIN EMPLOYEES E
ON D.MANAGER_ID = E.EMPLOYEE_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

-- DEP_ID DEP_NAME     MANAGER_ID     LOCATION_NAME
---------------------------------------------------
-- 60     IT           102            Southlake
-- 50     Shipping     100            South San Francisco

-- EX 3

INSERT INTO EMP 
SELECT * FROM EMPLOYEES
WHERE SALARY <= 5000;

-- 49 ligne(s) crÚÚe(s).

-- EX 4
UPDATE EMPLOYEES 
SET SALARY = (SELECT MAX(SALARY) 
              FROM EMPLOYEES 
              WHERE DEPARTMENT_ID = 20)
WHERE DEPARTMENT_ID = 10;

-- 1 ligne(s) mise(s) Ó jour.

-- EX 5
UPDATE EMPLOYEES E
SET SALARY = (SELECT MAX(SALARY)
              FROM EMPLOYEES
              WHERE DEPARTMENT_ID = E.DEPARTMENT_ID)
WHERE E.DEPARTMENT_ID = 10 OR E.DEPARTMENT_ID = 20;

-- 3 ligne(s) mise(s) Ó jour.

-- EX 6
UPDATE EMPLOYEES
SET HIRE_DATE = sysdate , EMAIL = 'BENAZZOUZAZER@GMAIL.COM' 
WHERE EMPLOYEE_ID = 108;

-- 1 ligne mise Ó jour.

-- EX 7
UPDATE EMPLOYEES E
SET SALARY = SALARY + (SELECT MAX(COMMISSION_PCT)
                          FROM EMPLOYEES
                          WHERE DEPARTMENT_ID = 20)
WHERE E.MANAGER_ID = 100;

-- 14 ligne(s) mise(s) Ó jour.

-- EX 8
UPDATE EMPLOYEES E
SET SALARY = SALARY + (SELECT MAX(COMMISSION_PCT)
                          FROM EMPLOYEES
                          WHERE DEPARTMENT_ID = E.DEPARTMENT_ID)
WHERE E.MANAGER_ID = 100;

-- 14 ligne(s) mise(s) Ó jour.

-- EX 9
UPDATE EMPLOYEES
SET COMMISSION_PCT = 0
WHERE COMMISSION_PCT IS NULL;

-- 72 ligne(s) mise(s) Ó jour.

-- EX 10
DELETE FROM EMPLOYEES E
WHERE E.HIRE_DATE < (SELECT HIRE_DATE
                     FROM EMPLOYEES
                     WHERE EMPLOYEE_ID = 112);

-- EX 11
DELETE FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                       FROM DEPARTMENTS
                       WHERE LOCATION_ID = (SELECT LOCATION_ID
                                            FROM LOCATIONS
                                            WHERE CITY = 'Oxford'));
-- EX 12
SELECT DEPARTMENT_ID
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMPLOYEES
                   GROUP BY DEPARTMENT_ID);
-- DEPARTMENT_ID
-- -------------
--            50


-- EX 13
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        GROUP BY DEPARTMENT_ID);
-- aucune ligne sÚlectionnÚe

-- EX 14
SELECT EMPLOYEE_ID , FIRST_NAME 
FROM EMPLOYEES
WHERE (FIRST_NAME LIKE 'N%' AND NOT DEPARTMENT_ID = 50) OR (NOT FIRST_NAME LIKE 'N%' AND DEPARTMENT_ID = 50);

-- EMPLOYEE_ID FIRST_NAME
-- ----------- --------------------
--         101 Neena
--         108 Nancy
--         120 Matthew
--         121 Adam
--         122 Payam
--         123 Shanta
--         124 Kevin
--         125 Julia
--         126 Irene
--         127 James
--         128 Steven

-- EMPLOYEE_ID FIRST_NAME
-- ----------- --------------------
--         129 Laura
--         130 Mozhe
--         131 James
--         132 TJ
--         133 Jason
--         134 Michael
--         135 Ki
--         136 Hazel
--         137 Renske
--         138 Stephen
--         139 John

-- EMPLOYEE_ID FIRST_NAME
-- ----------- --------------------
--         140 Joshua
--         141 Trenna
--         142 Curtis
--         143 Randall
--         144 Peter
--         154 Nanette
--         180 Winston
--         181 Jean
--         182 Martha
--         183 Girard
--         185 Alexis

-- EMPLOYEE_ID FIRST_NAME
-- ----------- --------------------
--         186 Julia
--         187 Anthony
--         188 Kelly
--         189 Jennifer
--         190 Timothy
--         191 Randall
--         192 Sarah
--         193 Britney
--         194 Samuel
--         195 Vance
--         196 Alana

-- EMPLOYEE_ID FIRST_NAME
-- ----------- --------------------
--         197 Kevin
--         198 Donald
--         199 Douglas

-- 47 ligne(s) sÚlectionnÚe(s).

-- EX 15
-- LISTER LE NOMBRE DE RECRUTEMENT PAR MOIS POUR L'ANNEE 1997
SELECT TO_CHAR(HIRE_DATE,'MM') AS MOIS ,COUNT(*) AS NOMBRE_DE_RECRUTEMENT
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY') = '1997'
GROUP BY TO_CHAR(HIRE_DATE,'MM')
ORDER BY TO_CHAR(HIRE_DATE,'MM');

-- MO NOMBRE_DE_RECRUTEMENT
-- -- ---------------------
-- 01                     3
-- 02                     2
-- 03                     6
-- 04                     1
-- 06                     2
-- 07                     2
-- 08                     4
-- 09                     2
-- 10                     3
-- 11                     1
-- 12                     2

-- EX 16
-- LISTER LE NOMBRE DE RECRUTEMENT PAR MOIS PAR CHAQUE ANNEE
SELECT TO_CHAR(HIRE_DATE,'YYYY') AS ANNEE ,TO_CHAR(HIRE_DATE,'MM') AS MOIS ,COUNT(*) AS NOMBRE_DE_RECRUTEMENT
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'YYYY') , TO_CHAR(HIRE_DATE,'MM')
ORDER BY TO_CHAR(HIRE_DATE,'YYYY') , TO_CHAR(HIRE_DATE,'MM');

-- ANNE MO NOMBRE_DE_RECRUTEMENT
-- ---- -- ---------------------
-- 1987 06                     1
-- 1987 09                     1
-- 1989 09                     1
-- 1990 01                     1
-- 1991 05                     1
-- 1993 01                     1
-- 1994 06                     4
-- 1994 08                     2
-- 1994 12                     1
-- 1995 05                     2
-- 1995 07                     1

-- ANNE MO NOMBRE_DE_RECRUTEMENT
-- ---- -- ---------------------
-- 1995 10                     1
-- 1996 01                     2
-- 1996 02                     2
-- 1996 03                     1
-- 1996 05                     1
-- 1996 06                     1
-- 1996 07                     1
-- 1996 08                     1
-- 1996 10                     1
-- 1997 01                     3
-- 1997 02                     2

-- ANNE MO NOMBRE_DE_RECRUTEMENT
-- ---- -- ---------------------
-- 1997 03                     6
-- 1997 04                     1
-- 1997 06                     2
-- 1997 07                     2
-- 1997 08                     4
-- 1997 09                     2
-- 1997 10                     3
-- 1997 11                     1
-- 1997 12                     2
-- 1998 01                     2
-- 1998 02                     3

-- ANNE MO NOMBRE_DE_RECRUTEMENT
-- ---- -- ---------------------
-- 1998 03                     5
-- 1998 04                     3
-- 1998 05                     1
-- 1998 06                     1
-- 1998 07                     3
-- 1998 08                     1
-- 1998 09                     1
-- 1998 11                     2
-- 1998 12                     1
-- 1999 01                     1
-- 1999 02                     3

-- ANNE MO NOMBRE_DE_RECRUTEMENT
-- ---- -- ---------------------
-- 1999 03                     3
-- 1999 04                     1
-- 1999 05                     1
-- 1999 06                     2
-- 1999 08                     1
-- 1999 10                     1
-- 1999 11                     2
-- 1999 12                     3
-- 2000 01                     4
-- 2000 02                     3
-- 2000 03                     2

-- ANNE MO NOMBRE_DE_RECRUTEMENT
-- ---- -- ---------------------
-- 2000 04                     2

-- 56 ligne(s) sÚlectionnÚe(s).
