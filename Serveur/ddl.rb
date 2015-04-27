##
# Crée le schéma de la base de données serveur
#

# Imports
require 'sqlite3'

# Variables
pathDb = "./bdd.sqlite" # Chemin de la base de donnée à créer
bdd = false

# Ouverture de la base de données ...
begin
	puts "Ouverture de la base de données ..."
	bdd = SQLite3::Database.new(pathDb)
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	ensure
		puts "OK"
end

# Création de la table des utilisateurs ...
begin
	puts "Création de la table des utilisateurs ..."
	bdd.execute("
		CREATE TABLE IF NOT EXISTS `utilisateur` (
			`id`								INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
			`version`							INTEGER NOT NULL,
			`nom`								TEXT NOT NULL UNIQUE,
			`mot_de_passe`						TEXT NOT NULL,
			`date_inscription`					INTEGER NOT NULL,
			`options`							TEXT NOT NULL
		);
	")
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	ensure
		puts "OK"
end

# Création de la table des niveaux ...
begin
	puts "Création de la table des niveaux ..."
	bdd.execute("
		CREATE TABLE IF NOT EXISTS `niveau` (
			`id`								INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
			`probleme`							TEXT NOT NULL,
			`solution`							TEXT NOT NULL,
			`difficulte`						INTEGER NOT NULL,
			`dimention`							INTEGER NOT NULL
		);
	")
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	ensure
		puts "OK"
end

# Création de la table des sauvegardes ...
begin
	puts "Création de la table des sauvegardes ..."
	bdd.execute("
		CREATE TABLE IF NOT EXISTS `sauvegarde` (
			`id`							INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
			`version`						INTEGER NOT NULL,
			`description`					TEXT NOT NULL,
			`date_creation`					INTEGER NOT NULL,
			`contenu`						TEXT NOT NULL,
			`id_utilisateur`				INTEGER NOT NULL,
			`id_niveau`						INTEGER NOT NULL,
			FOREIGN KEY(`id_utilisateur`) REFERENCES `utilisateur`(`id`),
			FOREIGN KEY(`id_niveau`) REFERENCES `grille`(`id`)
		);
	")
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	ensure
		puts "OK"
end

# Création de la table des scores ...
begin
	puts "Création de la table des scores ..."
	bdd.execute("
		CREATE TABLE IF NOT EXISTS `score` (
			`id`							INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
			`version`						INTEGER NOT NULL,
			`temps_total`					INTEGER NOT NULL,
			`nb_coups`						INTEGER NOT NULL,
			`nb_conseils`					INTEGER NOT NULL,
			`nb_aides`						INTEGER NOT NULL,
			`id_utilisateur`				INTEGER NOT NULL,
			`id_niveau`						INTEGER NOT NULL,
			FOREIGN KEY(`id_utilisateur`) REFERENCES `utilisateur`(`id`),
			FOREIGN KEY(`id_niveau`) REFERENCES `niveau`(`id`)
		);
	")
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	ensure
		puts "OK"
end

# Fermeture de la base de données
begin
	puts "Fermeture de la base de données ..."
	bdd.close if bdd
	rescue SQLite3::Exception => e
		puts "Erreur"
		puts e
		abort
	ensure
		puts "OK"
end

# Message fin
puts "La base de test a été créé avec succès"
