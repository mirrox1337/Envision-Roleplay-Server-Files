USE `essentialmode`;

ALTER TABLE `characters` 
ADD COLUMN `lastdigits` VARCHAR(255) NULL DEFAULT NULL;




ALTER TABLE `users`
ADD COLUMN `lastdigits` VARCHAR(255) NULL DEFAULT NULL;

