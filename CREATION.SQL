CREATE TABLE DEPARTEMENT (
NUM_DEP CHAR(2) CONSTRAINT pk_dep PRIMARY KEY,
NOM_DEP VARCHAR(20)
);

CREATE TABLE SALLE (
NUM_S CHAR(3) CONSTRAINT pk_salle PRIMARY KEY,
NOM_S VARCHAR(10),
NUM_DEP CHAR(2),
CONSTRAINT fk_salle FOREIGN KEY (NUM_DEP) REFERENCES DEPARTEMENT (NUM_DEP)
);

create table POSTEE(
NUM_P char(3) CONSTRAINT pk_POSTEe PRIMARY KEY,
NOM_P varchar(10),
NUM_S char(3),
CONSTRAINT fk_POSTEe FOREIGN KEY (NUM_S) REFERENCES salle (NUM_S)
);

create table LOGICIEL(
NUM_L char(5) CONSTRAINT pk_logiciel PRIMARY KEY,
NOM_L varchar(15),
DATE_ACH date,
VERSION varchar(7)
);

create table INSTALLER(
NUM_P char(3),
NUM_L char(5),
DATE_INS date,
CONSTRAINT pk_installer PRIMARY KEY (NUM_P,NUM_L),
CONSTRAINT fk_POSTEe_installer FOREIGN KEY (NUM_P) REFERENCES POSTEE (NUM_P),
CONSTRAINT fk_logiciel FOREIGN KEY (NUM_L) REFERENCES LOGICIEL (NUM_L)
);

ALTER TABLE DEPARTEMENT ADD DATE_CRE DATE DEFAULT '01/01/1995';
ALTER TABLE DEPARTEMENT ADD NB NUMBER(3) NOT NULL;
ALTER TABLE DEPARTEMENT RENAME COLUMN NB TO CAPACITE_Max;

ALTER TABLE LOGICIEL ADD RELEASE VARCHAR(10);

ALTER TABLE SALLE MODIFY NOM_S VARCHAR(30);

CREATE TABLE TYPE (
    TYP_LP VARCHAR(6) CONSTRAINT pk_typ PRIMARY KEY,
    NOM_TYPE VARCHAR(20)
)

ALTER TABLE LOGICIEL DROP COLUMN RELEASE;
ALTER TABLE TYPE ADD CONSTRAINT fk_type PRIMARY KEY (TYP_LP);
ALTER TABLE LOGICIEL ADD TYP_LP VARCHAR(6);
ALTER TABLE POSTEE ADD TYP_LP VARCHAR(6);

ALTER TABLE LOGICIEL ADD CONSTRAINT fk_logiciel_type FOREIGN KEY (TYP_LP) REFERENCES TYPE (TYP_LP);
ALTER TABLE POSTEE ADD CONSTRAINT fk_POSTEe_type FOREIGN KEY (TYP_LP) REFERENCES TYPE (TYP_LP); 

-- CREATE TABLE DEP COPY OF DEPARTEMENT;
CREATE TABLE DEP AS SELECT * FROM DEPARTEMENT;
ALTER TABLE DEP RENAME TO DEP1;
ALTER TABLE DEP1 ADD CONSTRAINT check_dep CHECK (CAPACITE_Max < 5000);
ALTER TABLE DEP1 ADD CONSTRAINT unique_dep UNIQUE (NOM_DEP);
DROP TABLE DEP1;


insert into DEPARTEMENT(num_dep,nom_dep)values('d1','Informatique');

insert into DEPARTEMENT(num_dep,nom_dep)values('d2','Gestion');

insert into DEPARTEMENT(num_dep,nom_dep)values('d3','Gestion');

insert into salle values('S01','Salle1','d1');

insert into salle values('S02','Salle2','d1');

insert into salle values('S03','Salle3','d1');

insert into salle values('S11','Salle11','d2');

insert into salle values('S12','Salle12','d2');

insert into salle values('S21','Salle21','d3');

insert into POSTE(num_p,nom_p,num_s)values('P1','POSTE1','S01');

insert into POSTE(num_p,nom_p,num_s)values('P2','POSTE2','S01');

insert into POSTE(num_p,nom_p,num_s)values('P3','POSTE3','S02');

insert into POSTE(num_p,nom_p,num_s)values('P4','POSTE4','S03');

insert into POSTE(num_p,nom_p,num_s)values('P5','POSTE5','S11');

insert into POSTE(num_p,nom_p,num_s)values('P6','POSTE6','S11');

insert into POSTE(num_p,nom_p,num_s)values('P7','POSTE7','S12');

insert into POSTE(num_p,nom_p,num_s)values('P8','POSTE8','S12');

insert into POSTE(num_p,nom_p,num_s)values('P9','POSTE9','S21');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG1', 'Oracle7', TO_DATE('13-05-00', 'dd-mm-yy'), '7.3.2');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG2', 'Oracle8', TO_DATE('15-05-00', 'dd-mm-yy'), '8.0');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG3', 'Sql serveur', TO_DATE('12-04-03', 'dd-mm-yy'), '7');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG4','Front page', TO_DATE('03-06-03', 'dd-mm-yy'), '5');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG5','Open offic', TO_DATE('03-06-02', 'dd-mm-yy'), '5');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG6','Sql *Plus', TO_DATE('03-06-03', 'dd-mm-yy'), '2.0');

insert into logiciel(num_l, nom_l, date_ach, version)values('LOG7','Office98', TO_DATE('03-06-03', 'dd-mm-yy'), '98');

insert into installer values('P1','LOG1',TO_DATE('15-05-00', 'dd-mm-yy'));

insert into installer values('P1','LOG3',TO_DATE('01-05-03', 'dd-mm-yy'));
 
insert into installer values('P2','LOG5',TO_DATE('05-06-02', 'dd-mm-yy'));

insert into installer values('P2','LOG7',TO_DATE('15-jul-00', 'dd-mm-yy'));

insert into installer values('P3','LOG5',TO_DATE('16-jul-00', 'dd-mm-yy'));

insert into installer values('P4','LOG1',TO_DATE('15-05-00', 'dd-mm-yy'));

insert into installer values('P5','LOG7',TO_DATE('15-sep-00', 'dd-mm-yy'));

insert into installer values('P5','LOG1',TO_DATE('19-05-00', 'dd-mm-yy'));

insert into installer values('P5','LOG4',TO_DATE('13-05-03', 'dd-mm-yy'));

insert into installer values('P7','LOG1',TO_DATE('13-05-09', 'dd-mm-yy'));


insert into type values('TX','Terminal x_window');

insert into type values('UNIX','System Unix');

insert into type values('PCNT','Pc Windows NT');

insert into type values('PCWS','Pc Windows 98');

insert into type values('NC','Network computer');

insert into type values('UB','Pc ubunto');

UPDATE POSTE
SET typ_lp = 'TX'
WHERE num_p = 'P1';

UPDATE POSTE
SET typ_lp = 'TX'
WHERE num_p = 'P4';

UPDATE POSTE
SET typ_lp = 'NC'
WHERE num_p = 'P8';

UPDATE POSTE
SET typ_lp = 'NC'
WHERE num_p = 'P9';

UPDATE POSTE
SET typ_lp = 'UNIX'
WHERE num_p = 'P6';

UPDATE POSTE
SET typ_lp = 'UNIX'
WHERE num_p = 'P2';

UPDATE logiciel
SET typ_lp = 'UNIX'
WHERE num_l = 'LOG1';

UPDATE logiciel
SET typ_lp = 'UNIX'
WHERE num_l = 'LOG2';

UPDATE logiciel
SET typ_lp = 'UNIX'
WHERE num_l = 'LOG4';

UPDATE logiciel
SET typ_lp = 'UNIX'
WHERE num_l = 'LOG5';
-- autre version ✨❤️
UPDATE logiciel
SET typ_lp = 'UNIX'
WHERE num_l in (LOG1, LOG2,LOG4 et LOG5);