INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Polis', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Polis', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Polis', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'Polis')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Aspirant',20,'{}','{}'),
	('police',1,'officer','Assistent',40,'{}','{}'),
	('police',2,'sergeant','Inspektör',60,'{}','{}'),
	('police',3,'lieutenant','Kommissarie',85,'{}','{}'),
	('police',4,'boss','Rikspolischef',100,'{}','{}')
;
