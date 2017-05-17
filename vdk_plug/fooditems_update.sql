ALTER TABLE items
ADD COLUMN food varchar(255) NOT NULL DEFAULT '0',
ADD COLUMN water varchar(255) NOT NULL DEFAULT '0',
ADD COLUMN needs varchar(255) NOT NULL DEFAULT '0'

INSERT INTO `items` (`id`, `libelle`, `food`, `water`, `needs`) VALUES
(30, 'Sandwich', '30', '0', '-5'),
(31, 'Cola', '0', '20', '-10');
