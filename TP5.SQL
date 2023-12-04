-- EX1
CREATE OR REPLACE VIEW Pieces_Jaunes
AS (SELECT *
   FROM PIECE
   WHERE COULEUR = 'jaunes');

-- Vue crÚÚe.

-- EX2
CREATE SYNONYM PJ
FOR Pieces_Jaunes;

-- Synonyme crÚÚ.

-- EX3
-- EX4
INSERT INTO PJ
VALUES ('P30', NULL, NULL , 'rouge');

-- 1 ligne crÚÚe.
-- OUI POSSIBLE
-- 11 ligne(s) sÚlectionnÚe(s).