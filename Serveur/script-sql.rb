# Dépendances
require "sqlite3"

# Variables
pathFile = "test.txt"
pathDb = "./bdd.sqlite"
tableName = "grille"
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
# if !File.exists?(pathFile)
	# puts "Le fichier '#{pathFile}' n\'est pas présent !"
	# abort
# end

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
	# bdd.prepare("
		# CREATE TABLE :tableName (
			# id_grille INTEGER PRIMARY KEY AUTOINCREMENT,
			# difficulte INT,
			# dimension INT,
			# probleme TEXT,
			# solution TEXT
		# );
	# ")
	# bdd.bind_param(":tableName", tableName);
	# bdd.execute
	
	bdd.execute("
		CREATE TABLE grille (
			id_grille INTEGER PRIMARY KEY AUTOINCREMENT,
			difficulte INT,
			dimention INT,
			probleme TEXT,
			solution TEXT
		);
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
		
		bdd.execute("
			INSERT INTO grille
			VALUES (
				NULL,
				#{difficulte},
				#{dimention},
				'#{probleme}',
				'#{solution}'
			);
		")
		# bdd.bind_param(':difficulte', difficulte);
		# bdd.bind_param(':dimention', dimention);
		# bdd.bind_param(':probleme', probleme);
		# bdd.bind_param(':solution', solution);
		# bdd.execute
		
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
