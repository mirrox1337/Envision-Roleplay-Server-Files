
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mekonomen', 'Mekonomen', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mekonomen', 'Mekonomen', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mekonomen', 'Mekonomen')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mekonomen',0,'recrue','Nyanställd',12,'{}','{}'),
	('mekonomen',1,'novice','Anställd',24,'{}','{}'),
	('mekonomen',2,'experimente','Erfaren',36,'{}','{}'),
	('mekonomen',3,'chief','Biträdande Chef',48,'{}','{}'),
	('mekonomen',4,'boss','Chef',0,'{}','{}')
;

ALTER TABLE `owned_vehicles` ADD `hasGPS` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'nxrp-mekonomen';