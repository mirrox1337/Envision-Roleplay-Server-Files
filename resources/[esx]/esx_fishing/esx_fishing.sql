USE `essentialmode`;

CREATE TABLE `fishes` (
  `id` int(11) NOT NULL,
  `owner_identifier` varchar(50) NOT NULL,
  `owner_name` varchar(50) NOT NULL,
  `weight` float NOT NULL,
  `name` varchar(50) NOT NULL,
  `sex` varchar(50) NOT NULL,
  `hooked_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `fishes`
ADD PRIMARY KEY (`id`);

ALTER TABLE `fishes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('Fishing Rod', 'Fiskespö', 1, 0, 1),
('Fishing Lure', 'Fiskebete', -1, 0, 1),
('Small Pike', 'Liten gädda', 20, 0, 1),
('Small Bass', 'Liten havsborre', 40, 0, 1),
('Small Salmon', 'Liten lax', 20, 0, 1),
('Pike', 'Gädda', 10, 0, 1),
('Bass', 'Havsborre', 20, 0, 1),
('Salmon', 'Lax', 10, 0, 1),
('Big Pike', 'Stor gädda', 5, 0, 1),
('Big Bass', 'Stor havsborre', 10, 0, 1),
('Big Salmon', 'Stor lax', 5, 0, 1);
('Small Trout', 'Liten öring', 20, 0, 1),
('Small Rainbow', 'Liten regnbåge', 20, 0, 1),
('Small Char', 'Liten röding', 20, 0, 1),
('Trout', 'öring', 10, 0, 1),
('Rainbow', 'Regnbåge', 10, 0, 1),
('Char', 'Röding', 10, 0, 1),
('Big Trout', 'Stor öring', 5, 0, 1),
('Big Rainbow', 'Stor regnbåge', 5, 0, 1),
('Big Char', 'Stor röding', 5, 0, 1);