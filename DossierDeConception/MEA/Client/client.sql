/*
	Implémentation de la MEA client pour SQLite 3
*/

-- -----------------------------------------------------
-- Table `utilisateur`
-- -----------------------------------------------------
CREATE TABLE `utilisateur` (
	`id`								INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`uuid`								INTEGER NOT NULL UNIQUE,
	`nom`								TEXT NOT NULL,
	`mot_de_passe`						TEXT NOT NULL,
	`date_inscription`					INTEGER NOT NULL,
	`date_derniere_synchronisation`		INTEGER NOT NULL,
	`options`							TEXT NOT NULL,
	`type`								INTEGER NOT NULL
);


-- -----------------------------------------------------
-- Table `grille`
-- -----------------------------------------------------
CREATE TABLE `grille` (
	`id`								INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`uuid`								INTEGER NOT NULL UNIQUE,
	`probleme`							TEXT NOT NULL,
	`solution`							TEXT NOT NULL,
	`niveau`							INTEGER NOT NULL,
	`dimention`							INTEGER NOT NULL
);


-- -----------------------------------------------------
-- Table `sauvegarde`
-- -----------------------------------------------------
CREATE TABLE `sauvegarde` (
	`id`							INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`uuid`							INTEGER NOT NULL UNIQUE,
	`date_creation`					INTEGER NOT NULL,
	`contenu`						TEXT NOT NULL,
	`id_utilisateur`				INTEGER NOT NULL,
	`id_grille`						INTEGER NOT NULL,
	FOREIGN KEY(`id_utilisateur`) REFERENCES `utilisateur`(`id`),
	FOREIGN KEY(`id_grille`) REFERENCES `grille`(`id`)
);


-- -----------------------------------------------------
-- Table `resolution`
-- -----------------------------------------------------
CREATE TABLE `resolution` (
	`id`							INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`uuid`							INTEGER NOT NULL UNIQUE,
	`temps_total`					INTEGER NOT NULL,
	`nb_coups`						INTEGER NOT NULL,
	`nb_conseils`					INTEGER NOT NULL,
	`nb_aides`						INTEGER NOT NULL,
	`id_utilisateur`				INTEGER NOT NULL,
	`id_grille`						INTEGER NOT NULL,
	FOREIGN KEY(`id_utilisateur`) REFERENCES `utilisateur`(`id`),
	FOREIGN KEY(`id_grille`) REFERENCES `grille`(`id`)
);


/*
	Notes :
	CREATE UNIQUE INDEX `uuid_UX` ON `table`(`uuid`);
	IF NOT EXISTS
*/
