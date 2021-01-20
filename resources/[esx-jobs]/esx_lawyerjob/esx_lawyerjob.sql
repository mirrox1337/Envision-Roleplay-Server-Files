USE `oldfellas`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_lawyer', 'Advokat', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_lawyer', 'Advokat', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('lawyer', 'Advokat')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('lawyer',0,'recrue','Recrue',12,'{}','{}'),
	('lawyer',1,'novice','Novice',24,'{}','{}'),
	('lawyer',2,'experimente','Experimente',36,'{}','{}'),
	('lawyer',3,'chief',"Chef d\'équipe",48,'{}','{}'),
	('lawyer',4,'boss','Patron',0,'{}','{}')
;