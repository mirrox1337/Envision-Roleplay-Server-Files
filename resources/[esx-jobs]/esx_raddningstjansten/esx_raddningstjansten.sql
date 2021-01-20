USE `envision`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_raddningstjansten', 'Räddningstjänsten', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_raddningstjansten', 'Räddningstjänsten', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_raddningstjansten', 'Räddningstjänsten', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('raddningstjansten', 'Räddningstjänsten')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('raddningstjansten',0,'recruit','Aspirant',60,'{}','{}'),
	('raddningstjansten',1,'officer','Assisten',70,'{}','{}'),
	('raddningstjansten',2,'sergeant','Löjtnant',80,'{}','{}'),
	('raddningstjansten',3,'lieutenant','Styrkeledare',100,'{}','{}'),
	('raddningstjansten',4,'boss','Brandchef',120,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('disc_ammo_fireextinguisher', 'Brandpulver', 100, 0, 1);
