##
# Crée une base de test
#

# Dépendances
require "sqlite3"

# Variables
pathDb = "./test.sqlite" # Chemin de la base de donnée à créer
db = false
rq = false

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

# Création de la table utilisateur ...
begin
	puts "Création de la table utilisateurs ..."
	bdd.execute("
		CREATE TABLE IF NOT EXISTS `utilisateur` (
			`id`								INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
			`uuid`								INTEGER UNIQUE,
			`nom`								TEXT NOT NULL,
			`mot_de_passe`						TEXT NOT NULL,
			`date_inscription`					INTEGER NOT NULL,
			`date_derniere_synchronisation`		INTEGER NOT NULL,
			`options`							TEXT NOT NULL,
			`type`								INTEGER NOT NULL
		);
		TRUNCATE TABLE utilisateurs;
	")
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	ensure
		puts "OK"
end

# Insertion d'utilisateurs ...
begin
	puts "Insertion d'utilisateurs ..."
	bdd.execute("
		INSERT INTO utilisateur VALUES
		(NULL, NULL, 'toto0', 'azerty', 0, 0, 'SERIALISATION', 0),
		(NULL, NULL, 'toto1', 'azerty', 0, 0, 'SERIALISATION', 0),
		(NULL, NULL, 'toto2', 'azerty', 0, 0, 'SERIALISATION', 0);
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
