-- EX 1
SELECT *
FROM PIECE
-- EX 2
SELECT NUM_P , NOM_P
FROM PIECE
WHERE Couleur = 'rouge';
-- EX 3
SELECT Num_S
FROM COMMANDE
-- EX 4
SELECT NOM_P , POIDS * 1.2 AS Poids_Emballe
FROM PIECE
-- EX 5
SELECT Num_S
FROM COMMANDE
WHERE Qtite <= 10 and NOM_P LIKE 'P1';
-- EX 6
SELECT NOM_P
FROM PIECE
WHERE 

-- EX 7
SELECT NOM_P
FROM PIECE
WHERE POIDS NOT IN (30,50,70);

SELECT NOM_P
FROM PIECE
WHERE NOM_P NOT IN (SELECT NOM_P
                      FROM PIECE 
                      WHERE POIDS IN (30,50,70));

SELECT NOM_P
FROM PIECE
WHERE POIDS != 30 AND POIDS != 50 AND POIDS != 70;
-- EX 8
SELECT NUM_P
FROM PIECE
WHERE COULEUR = 'rouge' AND POIDS BETWEEN 50 AND 100;
-- EX 9
SELECT * 
FROM PIECE
WHERE NOM_P LIKE '%re';
-- EX 10
SELECT *
FROM PIECE
WHERE NOM_P LIKE '_a%' AND POIDS BETWEEN 50 AND 100; 
-- EX 11
SELECT Num_S,COUNT(Num_S)
FROM commande
GROUP BY Num_S;
-- EX 12
SELECT Num_S,COUNT(Qtite)
FROM commande
GROUP BY Num_S;
-- EX 13
SELECT COULEUR,AVG(POIDS)
FROM PIECE
GROUP BY COULEUR;
-- EX 14
-- SELECT Num_S , COUNT(Num_S)
-- FROM commande
-- WHERE Qtite > 50
-- GROUP BY Num_S;
SELECT COUNT(Num_S)
FROM commande
WHERE Qtite > 50;
-- EX 15
SELECT Num_S , MIN(Qtite) , MAX(Qtite)
FROM commande
GROUP BY Num_S;
-- EX 16
SELECT Num_S , SUM(Qtite)
FROM commande
GROUP BY Num_S
HAVING SUM(Qtite) > 100;
-- EX 17
SELECT Num_P , SUM(Qtite)
FROM commande
WHERE NuM_P IN ('P1','P2','P3')
GROUP BY Num_P;
-- EX 18
SELECT NUM_S 
FROM commande
WHERE NUM_P = 'P1' AND Qtite >= 10
ORDER BY Num_S ASC;
-- EX 19
SELECT Num_S , COUNT(Num_S) AS Nb_Commande
FROM commande
GROUP BY Num_S
ORDER BY Nb_Commande ASC;
-- EX 20
SELECT NOM_P
FROM piece
ORDER BY COULEUR DESC , POIDS DESC;
-- LISTER LES COULEURS DES PIECES COMMANDER PAR LE SERVICE S1
SELECT COULEUR
FROM PIECE
WHERE NUM_P IN (SELECT NUM_P
                FROM COMMANDE
                WHERE NUM_S = 'S1');

                
-- EX 20
SELECT NUM_P , NOM_P
FROM PIECE natural join COMMANDE
WHERE NUM_S = 'S1';
-- NUM NOM_P
-- --- --------------------
-- P1  Ecran
-- ::::: OU :::::
SELECT NUM_P , NOM_P
FROM PIECE
WHERE NUM_P IN (SELECT NUM_P
                FROM COMMANDE
                WHERE NUM_S = 'S1');
-- NUM NOM_P
-- --- --------------------
-- P1  Ecran


-- EX 21
SELECT NUM_P , NOM_P , POIDS
FROM PIECE NATURAL JOIN COMMANDE
WHERE NUM_S = 'S5';
-- NUM NOM_P                     POIDS
-- --- -------------------- ----------
-- P2  Bus                          15
-- P3  Afficheur                   144


-- EX 22
SELECT NUM_P , NOM_P
FROM PIECE NATURAL JOIN COMMANDE
WHERE NUM_S = (SELECT NUM_S 
               FROM SERVICE 
               WHERE NOM_S = 'Gestion');
-- NUM NOM_P
-- --- --------------------
-- P2  Bus


-- EX 23

SELECT COMMANDE.NUM_S
FROM COMMANDE JOIN COMMANDE COMMANDE2
ON COMMANDE.NUM_S = COMMANDE2.NUM_S
WHERE COMMANDE.NUM_P = 'P3' AND COMMANDE2.NUM_P = 'P7' AND COMMANDE.Qtite = COMMANDE2.Qtite;
-- aucune ligne sÚlectionnÚe


-- EX 24
SELECT PIECE.NUM_P,COUNT(COMMANDE.NUM_P) AS Nb_Piece 
FROM PIECE LEFT OUTER JOIN COMMANDE
ON PIECE.NUM_P = COMMANDE.NUM_P
GROUP BY PIECE.NUM_P;
-- NUM   NB_PIECE
-- --- ----------
-- P1           1
-- P10          1
-- P2           2
-- P3           1
-- P4           1
-- P5           0
-- P6           0
-- P7           1
-- P8           0
-- P9           1


-- EX 25
SELECT UNIQUE PIECE.NUM_P
FROM PIECE FULL OUTER JOIN COMMANDE
ON PIECE.NUM_P = COMMANDE.NUM_P
WHERE POIDS < 50 OR NUM_S = 'S2';
-- NUM
-- ---
-- P10
-- P2
-- P9


-- EX 26
 SELECT PIECE.NUM_P 
FROM PIECE LEFT OUTER JOIN COMMANDE
ON PIECE.NUM_P = COMMANDE.NUM_P
WHERE COMMANDE.NUM_P IS NULL;
-- NUM
-- ---
-- P8
-- P5
-- P6

-- ---------------------------------------------------------
-- EX 27
SELECT NUM_P
FROM PIECE
INTERSECT
SELECT NUM_P
FROM COMMANDE
WHERE NUM_S = 'S2' AND Qtite < 50;
-- NUM
-- ---
-- P9


-- EX 28
SELECT NUM_P
FROM PIECE
WHERE POIDS > 50
INTERSECT 
SELECT NUM_P
FROM COMMANDE
WHERE NUM_S IN (SELECT NUM_S
                FROM COMMANDE
                GROUP BY NUM_S
                HAVING COUNT(NUM_S) >= 2);
-- NUM
-- ---
-- P3
-- P9


-- EX 29
SELECT NUM_S
FROM SERVICE
MINUS
SELECT NUM_S
FROM COMMANDE;
-- NUM
-- ---
-- S10
-- S3
-- S7
-- S9

-- Ex 30
SELECT NUM_P , NOM_P
FROM PIECE
WHERE POIDS > (SELECT AVG(POIDS)
               FROM PIECE);

-- NUM NOM_P
-- --- --------------------
-- P4  Mémoire
-- P5  USB
-- P6  Carte
-- P9  clavier

-- Ex 31
SELECT NUM_S
FROM COMMANDE
WHERE NUM_P = 'P3' AND Qtite <= (SELECT AVG(Qtite)
                                FROM COMMANDE
                                WHERE NUM_P = 'P3');

-- NUM
-- ---
-- S5

-- Ex 32
SELECT *
FROM PIECE A
WHERE POIDS < (SELECT AVG(POIDS)
               FROM PIECE B
               WHERE A.COULEUR = B.COULEUR);

-- NUM NOM_P                     POIDS COULEUR
-- --- -------------------- ---------- --------------------
-- P1  Ecran                       200 noir
-- P2  Bus                          15 rouge
-- P3  Afficheur                   144 noir
-- P10 Souris                       15 vert

-- Ex 33
SELECT NOM_P
FROM PIECE
WHERE NUM_P IN (SELECT NUM_P
                FROM COMMANDE
                WHERE NUM_S IN (SELECT NUM_S
                                FROM SERVICE
                                WHERE NOM_S LIKE 'Gestion'));

-- NOM_P
-- --------------------
-- Bus

-- Ex 34
SELECT NUM_S
FROM COMMANDE 
WHERE Qtite >ALL (SELECT Qtite
               FROM COMMANDE
               WHERE NUM_S = 'S4');

-- NUM
-- ---
-- S2

-- EX 35
SELECT NOM_S
FROM SERVICE 
WHERE NUM_S IN (SELECT NUM_S
                FROM COMMANDE
                WHERE NUM_S = 'S4' );

-- NOM_S
-- --------------------
-- Commande

-- EX 38
SELECT NUM_S
FROM COMMANDE
GROUP BY NUM_S
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                FROM COMMANDE
                GROUP BY NUM_S);

-- NUM
-- ---
-- S2
-- S5

-- EX 39
SELECT NOM_S
FROM SERVICE 
WHERE NUM_S IN (SELECT NUM_S
                FROM COMMANDE);
-- NOM_S
-- --------------------
-- Technique
-- Informatique
-- Commande
-- Financier
-- Gestion
-- Vente

-- EX 40
SELECT COUNT(NOM_S)
FROM SERVICE 
WHERE NUM_S NOT IN (SELECT NUM_S
                FROM COMMANDE);

-- COUNT(NOM_S)
-- ------------
--            4

-- EX 41
SELECT NOM_S
FROM SERVICE
WHERE NUM_S IN (SELECT NUM_S
                FROM COMMANDE
                GROUP BY NUM_S
                HAVING COUNT(DISTINCT NUM_P) = (SELECT COUNT(DISTINCT NUM_P)
                                                FROM PIECE));

-- aucune ligne sÚlectionnÚe

