-- EX 1
SELECT EMPLOYEE_ID , LAST_NAME , DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE LOCATION_ID IN (SELECT LOCATION_ID
                                              FROM LOCATIONS
                                              WHERE CITY LIKE 'T%'));

-- EMPLOYEE_ID LAST_NAME                 DEPARTMENT_ID
-- ----------- ------------------------- -------------
--         202 Fay                                  20
--         201 Hartstein                            20
-- EX 2
SELECT FIRST_NAME , COALESCE(to_char(COMMISSION_PCT * SALARY ) , 'Aucune Commission.') AS "Commission des salaries"
FROM EMPLOYEES;

-- Ex 3
SELECT UPPER(FIRST_NAME) , EMPLOYEE_ID 
FROM EMPLOYEES
WHERE ( DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 20 ) AND JOB_ID IN (SELECT JOB_ID
                                                               FROM JOBS
                                                               WHERE JOB_TITLE LIKE 'Stock Clerk')
ORDER BY FIRST_NAME DESC;

-- UPPER(FIRST_NAME)    EMPLOYEE_ID
-- -------------------- -----------
-- TRENNA                       141
-- TJ                           132
-- STEVEN                       128
-- STEPHEN                      138
-- ..........

-- Ex 4
SELECT FIRST_NAME , LAST_NAME , HIRE_DATE
FROM EMPLOYEES 
WHERE HIRE_DATE < (SELECT HIRE_DATE
                   FROM EMPLOYEES
                   WHERE FIRST_NAME = 'Sarah');

-- FIRST_NAME           LAST_NAME                 HIRE_DAT
-- -------------------- ------------------------- --------
-- Steven               King                      17/06/87
-- Neena                Kochhar                   21/09/89
-- Lex                  De Haan                   13/01/93
-- Alexander            Hunold                    03/01/90

-- Ex 5
SELECT FIRST_NAME , SALARY 
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT EMPLOYEE_ID
                     FROM EMPLOYEES
                     WHERE LAST_NAME LIKE 'King');

-- FIRST_NAME               SALARY
-- -------------------- ----------
-- Neena                     17000
-- Lex                       17000
-- Den                       11000
-- Matthew                    8000
-- Adam                       8200
-- Payam                      7900
-- Shanta                     6500
-- Kevin                      5800
-- John                      14000
-- Karen                     13500
-- Alberto                   12000

-- FIRST_NAME               SALARY
-- -------------------- ----------
-- Gerald                    11000
-- Eleni                     10500
-- Michael                   13000

-- 14 ligne(s) sÚlectionnÚe(s).

-- EX 6
SELECT FIRST_NAME , LAST_NAME 
FROM EMPLOYEES
WHERE LAST_NAME NOT LIKE 'King' AND MANAGER_ID IN (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE LAST_NAME LIKE 'King');

-- FIRST_NAME           LAST_NAME
-- -------------------- -------------------------
-- Patrick              Sully
-- Allan                McEwen
-- Lindsey              Smith
-- Louise               Doran
-- Sarath               Sewall

-- EX 7
SELECT LAST_NAME , HIRE_DATE , SALARY
FROM EMPLOYEES
WHERE LAST_NAME NOT LIKE 'Kochhar' AND SALARY IN (SELECT SALARY
                                                  FROM EMPLOYEES
                                                  WHERE LAST_NAME = 'Kochhar') AND COMMISSION_PCT IN (SELECT COMMISSION_PCT
                                                                                                        FROM EMPLOYEES
                                                                                                        WHERE LAST_NAME = 'Kochhar');
-- aucune ligne sÚlectionnÚe

-- EX 8
SELECT FIRST_NAME , LAST_NAME 
FROM EMPLOYEES
WHERE HIRE_DATE > ALL (SELECT HIRE_DATE
                   FROM EMPLOYEES
                   WHERE DEPARTMENT_ID = 20);

-- FIRST_NAME           LAST_NAME
-- -------------------- -------------------------
-- Laura                Bissot
-- Peter                Hall
-- John                 Chen
-- Ismael               Sciarra
-- Shanta               Vollman
-- Stephen              Stiles
-- Mozhe                Atkinson
-- Clara                Vishney
-- Louise               Doran
-- Shelli               Baida
-- Tayler               Fox

-- 62 ligne(s) sÚlectionnÚe(s).

-- EX 9
SELECT FIRST_NAME , LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (SELECT EMPLOYEE_ID
                          FROM JOB_HISTORY);

-- FIRST_NAME           LAST_NAME
-- -------------------- -------------------------
-- Steven               King
-- Alexander            Hunold
-- Bruce                Ernst
-- David                Austin
-- Valli                Pataballa
-- Diana                Lorentz
-- Nancy                Greenberg
-- Daniel               Faviet
-- John                 Chen
-- Ismael               Sciarra
-- Jose Manuel          Urman 

-- 100 ligne(s) sÚlectionnÚe(s).

-- EX 10
SELECT A.FIRST_NAME , B.JOB_TITLE
FROM EMPLOYEES A NATURAL JOIN JOBS B
WHERE A.MANAGER_ID IS NULL;

-- FIRST_NAME           JOB_TITLE
-- -------------------- -----------------------------------
-- Steven               President

-- EX 11
SELECT D.DEPARTMENT_NAME , L.CITY , SUM(E.EMPLOYEE_ID) AS "Nombre d'employes" , AVG(Round(E.SALARY))
FROM DEPARTMENTS D NATURAL JOIN EMPLOYEES E NATURAL JOIN LOCATIONS L
GROUP BY D.DEPARTMENT_NAME , L.CITY ; 

SELECT D.DEPARTMENT_NAME , L.CITY , SUM(E.EMPLOYEE_ID) AS "Nombre d'employes" , AVG(Round(E.SALARY))
FROM DEPARTMENTS D 
JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
GROUP BY D.DEPARTMENT_NAME , L.CITY ; 

-- DEPARTMENT_NAME                CITY                           Nombre d'employes
-- ------------------------------ ------------------------------ -----------------
-- AVG(ROUND(E.SALARY))
-- --------------------
-- Finance                        Seattle                                      663
--                 8600

-- Marketing                      Toronto                                      403
--                 9500


-- 11 ligne(s) sÚlectionnÚe(s).

-- EX 12
SELECT J.JOB_TITLE , COUNT(E.EMPLOYEE_ID) AS "Nombre d'employes"
FROM JOBS J NATURAL JOIN EMPLOYEES E
GROUP BY J.JOB_TITLE
HAVING COUNT(E.EMPLOYEE_ID) > 1
ORDER BY COUNT(E.EMPLOYEE_ID) DESC;

-- JOB_TITLE                           Nombre d'employes
-- ----------------------------------- -----------------
-- Sales Representative                               30
-- Shipping Clerk                                     20
-- Stock Clerk                                        20
-- Accountant                                          5
-- Sales Manager                                       5
-- Purchasing Clerk                                    5
-- Programmer                                          5
-- Stock Manager                                       5
-- Administration Vice President                       2
