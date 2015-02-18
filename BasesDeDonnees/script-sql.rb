#
# Script permettant l'importaion de problèmes au format texte dans une base de données sqlite
#

# Dépendances
require "sqlite3"

# Variables
pathFile = "./test.txt" # Chemin du fichier de problèmes
pathDb = "./bdd-test.sqlite" # Chemin de la base de donnée à créer
tableName = "grille" # Non de la table qui contiendra les problèmes

db = false
rq = false
file = false
line = ""
counter = 0
tab = []
difficulte = 0
dimention = 0
probleme = ""
solution = ""

# Test de la présence du fichier
if !File.exists?(pathFile)
	puts "Le fichier '#{pathFile}' n\'est pas présent !"
	abort
end

# Ouverture du fichier
begin

	puts "Ouverture du fichier ..."
	fichier = File.open(pathFile, "r")
	
	rescue File::Exception => err
		puts "Erreur"
		puts err
		abort
	
	ensure
		puts "OK"

end

# Ouverture de la base de données
begin
	
	puts "Ouverture de la BDD ..."
	bdd = SQLite3::Database.new(pathDb)
	
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	
	ensure
		puts "OK"
	
end

# Création de la table
begin
	
	puts "Création de la table ..."
	
	# req = bdd.prepare("
		# CREATE TABLE ? (
			# id_grille INTEGER PRIMARY KEY AUTOINCREMENT,
			# difficulte INT,
			# dimension INT,
			# probleme TEXT,
			# solution TEXT
		# );
		# TRUNCATE TABLE ?;
	# ")
	# stm.bind_param(1, tableName)
	# stm.bind_param(2, tableName)
	# bdd.execute
	
	bdd.execute("
		CREATE TABLE IF NOT EXISTS #{tableName} (
			id_grille INTEGER PRIMARY KEY AUTOINCREMENT,
			difficulte INT,
			dimention INT,
			probleme TEXT,
			solution TEXT
		);
		TRUNCATE TABLE #{tableName};
	")
	
	rescue SQLite3::Exception => err
		puts "Erreur"
		puts err
		abort
	
	ensure
		puts "OK"
	
end

# Importation
puts "Importation vers la BDD ..."
while (line = fichier.gets)
	
	tab = line.split(';')
	difficulte = tab[0].slice(9, tab[0].length)
	dimention = Math.sqrt(tab[1].length)
	probleme = tab[1]
	solution = tab[2]
	
	begin
		
		# req = bdd.prepare("
			# INSERT INTO grille
			# VALUES (
				# NULL,
				# :difficulte,
				# :dimention,
				# :probleme,
				# :solution
			# );
		# ")
		# req.bind_param('difficulte', difficulte)
		# req.bind_param('dimention', dimention)
		# req.bind_param('probleme', probleme)
		# req.bind_param('solution', solution)
		# bdd.execute
		
		bdd.execute("
			INSERT INTO #{tableName}
			VALUES (
				NULL,
				#{difficulte},
				#{dimention},
				'#{probleme}',
				'#{solution}'
			);
		")
		
		rescue SQLite3::Exception => err
			puts "Erreur"
			puts err
			abort
		
	end
	
	# puts bdd.get_first_value "SELECT SQLITE_VERSION()"
	
    # puts "#{counter}: #{line}"
    counter = counter + 1
	
end
puts "OK"

# Affichage de la table (test)
# begin

	# puts "Affichage de la table (test) ..."
	
	# puts bdd.execute("
		# SELECT * FROM grille;
	# ")
	
	# rescue SQLite3::Exception => e
		# puts "Erreur fermeture base de données"
		# puts e
		# abort
	
	# ensure
		# puts "OK"
	
# end

# Fermeture du fichier
begin

	puts "Fermeture du fichier ..."
	fichier.close()
	
	rescue File::Exception => err
		puts "Erreur"
		puts err
		abort
	
	ensure
		puts "OK"

end

# Fermeture de la base
begin

	puts "Fermeture de la BDD ..."
	bdd.close if bdd
	
	rescue SQLite3::Exception => e
		puts "Erreur fermeture base de données"
		puts e
		abort
	
	ensure
		puts "OK"
	
end

# Message fin
puts "L'importation de(s) #{counter} problème(s) est un succès"
