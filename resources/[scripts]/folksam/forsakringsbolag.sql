
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_forsakring', 'Försäkringsbolag', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_forsakring', 'Försäkringsbolag', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_forsakring', 'Försäkringsbolag', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('forsakring', 'Försäkringsbolag')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('forsakring',0,'recrue','Provanställd',45,'{}','{}'),
	('forsakring',1,'novice','Säljare',60,'{}','{}'),
	('forsakring',2,'experimente','Erfaren säljare',80,'{}','{}'),
	('forsakring',3,'kung','Biträdande VD',100,'{}','{}'),
	('forsakring',4,'boss','VD',120,'{}','{}')
;

ALTER TABLE `owned_vehicles` ADD `forsakrad` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'forsakringsbolag';