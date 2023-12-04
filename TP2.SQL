-- DEPARTEMENT(NUM_DEP , NOM_DEP)
-- SALLE(NUM_S , NOM_S , #NUM_DEP)
-- POSTE(NUM_P, NOM_P, #NUM_S, #TYPELP)
-- LOGICIEL(NUM_L, NOM_L, DATE_ACH, VERSION, #TYPELP)
-- INSTALLER(NUM_P, NUM_L, DATE_INST)
-- TYPE(TYPELP, NOM_TYPE)

-- EX 1
SELECT NOM_TYPE
FROM POSTE NATURAL JOIN TYPE
WHERE NUM_P = 'P6';
-- NOM_TYPE
-- --------------------
-- System Unix

-- EX 2
SELECT NUM_P , NOM_P , NUM_S
FROM POSTE
WHERE TYP_LP LIKE 'UNIX';
-- NUM NOM_P      NUM
-- --- ---------- ---
-- P2  POSTE2     S01
-- P6  POSTE6     S11

-- EX 3
SELECT NUM_L , NOM_L
FROM LOGICIEL
WHERE TYP_LP LIKE 'UNIX';
-- NUM_L NOM_L
-- ----- ---------------
-- LOG1  Oracle7
-- LOG2  Oracle8
-- LOG4  Front page
-- LOG5  Open offic

-- EX 4
SELECT NUM_L
FROM INSTALLER
WHERE NUM_P = 'P7';

-- NUM_L
-- -----
-- LOG1


-- EX 5
SELECT NOM_L
FROM LOGICIEL
WHERE NOM_L LIKE '__a%';

-- NOM_L
-- ---------------
-- Oracle7
-- Oracle8

-- EX 6
SELECT NOM_DEP
FROM DEPARTEMENT
WHERE NOM_DEP LIKE '%t%' OR NOM_DEP LIKE '%t'OR NOM_DEP LIKE 't%';

-- NOM_DEP
-- --------------------
-- Informatique
-- Gestion
-- Gestion

-- EX 7
SELECT NOM_L
FROM LOGICIEL
WHERE NOM_L LIKE '%e' OR VERSION LIKE '5';

-- NOM_L
-- ---------------
-- Front page
-- Open offic

-- EX 8
SELECT NOM_P
FROM POSTE
WHERE NUM_S IN ('S01','S10','S21');

-- NOM_P
-- ----------
-- POSTE1
-- POSTE2
-- POSTE9

-- EX 9
SELECT NOM_L
FROM LOGICIEL
ORDER BY DATE_ACH , VERSION DESC;

-- NOM_L
-- ---------------
-- Oracle7
-- Oracle8
-- Open offic
-- Sql serveur
-- Office98
-- Front page
-- Sql *Plus

-- EX 10
SELECT NUM_L , NOM_L
FROM LOGICIEL
WHERE TYP_LP NOT LIKE 'UNIX' OR TYP_LP IS NULL
ORDER BY DATE_ACH DESC;

-- NUM_L NOM_L
-- ----- ---------------
-- LOG6  Sql *Plus
-- LOG7  Office98
-- LOG3  Sql serveur

-- EX 11
SELECT NUM_L , NOM_L
FROM LOGICIEL
WHERE DATE_ACH BETWEEN '01/01/2000' AND '01/01/2005';

-- NUM_L NOM_L
-- ----- ---------------
-- LOG1  Oracle7
-- LOG2  Oracle8
-- LOG3  Sql serveur
-- LOG4  Front page
-- LOG5  Open offic
-- LOG6  Sql *Plus
-- LOG7  Office98

SELECT NOM_L
FROM LOGICIEL
WHERE EXTRACT(YEAR FROM DATE_ACH) = 2003;

-- NOM_L
-- ---------------
-- Sql serveur
-- Front page
-- Sql *Plus
-- Office98

-- EX12
SELECT NOM_L
FROM LOGICIEL
WHERE NUM_L IN (SELECT NUM_L 
                FROM INSTALLER 
                WHERE NUM_P IN (SELECT NUM_P 
                                FROM POSTE 
                                WHERE NUM_S = 'S01'));

SELECT L.NOM_L
FROM LOGICIEL L
JOIN INSTALLER I ON L.NUM_L = I.NUM_L
JOIN POSTE P ON I.NUM_P = P.NUM_P
WHERE P.NUM_S = 'S01';


-- NOM_L
-- ---------------
-- Oracle7
-- Open offic
-- Sql serveur

-- EX 13
SELECT COUNT(*)
FROM INSTALLER
WHERE NUM_P IN ('P1','P3','P4','P7');

--   COUNT(*)
-- ----------
--          4

-- EX 14
SELECT NUM_P
FROM POSTE
WHERE NUM_S IN (SELECT NUM_S
                FROM SALLE
                WHERE NUM_DEP IN (SELECT NUM_DEP
                                FROM DEPARTEMENT
                                WHERE NOM_DEP = 'Informatique'));

SELECT P.NUM_P
FROM POSTE P
JOIN SALLE S ON P.NUM_S = S.NUM_S
JOIN DEPARTEMENT D ON S.NUM_DEP = D.NUM_DEP
WHERE D.NOM_DEP = 'Informatique';

-- EX 15
SELECT NUM_S
FROM SALLE
MINUS
SELECT NUM_S
FROM POSTE;

-- aucune ligne sÚlectionnÚe

SELECT NUM_S
FROM SALLE
WHERE NUM_S NOT IN (SELECT NUM_S
                    FROM POSTE);

-- aucune ligne sÚlectionnÚe

SELECT S.NUM_S
FROM SALLE S FULL OUTER JOIN POSTE P 
ON S.NUM_S = P.NUM_S
WHERE P.NUM_S IS NULL OR S.NUM_S IS NULL;


-- aucune ligne sÚlectionnÚe

-- EX 16
SELECT NUM_P
FROM INSTALLER
GROUP BY NUM_P
HAVING COUNT(NUM_P) = (SELECT MAX(COUNT(NUM_P))
                            FROM INSTALLER
                            GROUP BY NUM_P);

-- NUM
-- ---
-- P1
-- P5

-- EX 17
SELECT NUM_L
FROM LOGICIEL
MINUS
SELECT NUM_L
FROM INSTALLER;

-- NUM_L
-- -----
-- LOG2
-- LOG6
-- LOG7

-- EX 18
SELECT NUM_P
FROM INSTALLER
GROUP BY NUM_P
HAVING COUNT(NUM_L) = (SELECT COUNT(NUM_L)
                        FROM LOGICIEL);

-- aucune ligne sÚlectionnÚe

-- EX 19
SELECT NUM_P
FROM INSTALLER
WHERE NUM_L IN (SELECT NUM_L
                FROM INSTALLER
                WHERE NUM_P = 'P5');

-- NUM
-- ---
-- P1
-- P4
-- P5
-- P5
-- P7

-- EX 20
SELECT NUM_L
FROM INSTALLER
GROUP BY NUM_L
HAVING COUNT(NUM_L) > (SELECT COUNT(NUM_L)
                        FROM INSTALLER
                        WHERE NUM_L = 'LOG4');

-- NUM_L
-- -----
-- LOG1

-- EX 21
SELECT NUM_L
FROM INSTALLER
GROUP BY NUM_L
HAVING COUNT(NUM_L) = (SELECT MAX(COUNT(NUM_L))
                            FROM INSTALLER
                            GROUP BY NUM_L);

-- NUM_L
-- -----
-- LOG1

-- EX 22
SELECT NUM_L
FROM INSTALLER
GROUP BY NUM_L
HAVING COUNT(NUM_L) = (SELECT COUNT(NUM_P)
                        FROM POSTE);

-- aucune ligne sÚlectionnÚe

-- EX 27
SELECT A.NUM_L
FROM INSTALLER A
JOIN INSTALLER B 
ON A.NUM_L = B.NUM_L
WHERE A.DATE_INS LIKE B.DATE_INS
GROUP BY A.NUM_L;

-- NUM_L
-- -----
-- LOG4
-- LOG1
-- LOG5
-- LOG3

-- Lister les postes dans lesquelles ne sont installé aucun logiciel installé dans le poste p1

SELECT P.NUM_P
FROM POSTE P
WHERE P.NUM_P NOT IN (SELECT I.NUM_P
                        FROM INSTALLER I
                        WHERE I.NUM_L IN (SELECT I.NUM_L
                                            FROM INSTALLER I
                                            WHERE I.NUM_P = 'P1'));

-- NUM
-- ---
-- P9
-- P8
-- P3
-- P2
-- P6
