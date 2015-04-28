##
# Rempli une base de données de tests
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère les instances des gestionaires
gut = GestionnaireUtilisateur.instance()
gni = GestionnaireNiveau.instance()
gsa = GestionnaireSauvegarde.instance()
gsc= GestionnaireScore.instance()

# Insertion d'utilisateurs
# puts "Insertion d'utilisateurs ..."
# user1 = Utilisateur.creer('Test', 'azerty', Utilisateur::OFFLINE)
# begin
	# gut.sauvegarderUtilisateur(user1)
	# rescue SQLite3::ConstraintException => err
		# puts "L'utilisateur #{ user1.nom } (id:#{ user1.id }) existe déjà !"
# end

# user2 = Utilisateur.creer('Toto', 'azerty', Utilisateur::OFFLINE)
# begin
	# gut.sauvegarderUtilisateur(user2)
	# rescue SQLite3::ConstraintException => err
		# puts "L'utilisateur #{ user2.nom } (id:#{ user2.id }) existe déjà !"
# end

# user3 = Utilisateur.creer('Buddies', 'azerty', Utilisateur::OFFLINE)
# begin
	# gut.sauvegarderUtilisateur(user3)
	# rescue SQLite3::ConstraintException => err
		# puts "L'utilisateur #{ user3.nom } (id:#{ user3.id }) existe déjà !"
# end
# puts "Ok"

# Insertion de niveaux
puts "Insertion de niveau ..."
pathFile = "./BaseBineroParNiveau.txt" # Chemin du fichier de problèmes
file = false
line = ""
i = 0
tab = []
difficulte = 0
dimention = 0
probleme = ""
solution = ""

if !File.exists?(pathFile)
	puts "Le fichier '#{pathFile}' n\'est pas présent !"
	abort
end

begin
	puts "Ouverture du fichier ..."
	fichier = File.open(pathFile, "r")
	rescue File::Exception => err
		puts "Erreur"
		puts err
		abort
end

while (line = fichier.gets)

	line = line.gsub(/\r/,"")
	line = line.gsub(/\n/,"")
	
	tab = line.split(';')
	difficulte = tab[0].slice(9, tab[0].length)
	dimention = Math.sqrt(tab[1].length)
	probleme = tab[1]
	solution = tab[2]
	
	niveau = Niveau.creer( Grille.charger( probleme ), Grille.charger( solution ), difficulte, dimention )
	gni.insert(niveau)
	
    i = i + 1
	if( i>100 )
		puts "+ 100 niveaux"
		i = 0
	end
end

niveau1 = gni.recupererNiveau(1)
niveau2 = gni.recupererNiveau(2) 
niveau3 = gni.recupererNiveau(3)

puts "Ok"

# Insertion de scores

# puts "Insertion de scores ..."

# score1 = Score.creer(3600, 10, 10, 10, 1, 1)
# score2 = Score.creer(3600, 10, 10, 10, 1, 2)
# score3 = Score.creer(3600, 10, 10, 10, 2, 3)

# gsc.sauvegarderScore(score1)
# gsc.sauvegarderScore(score2)
# gsc.sauvegarderScore(score3)

# puts "Ok"

# Insertion de sauvegardes

# puts "Insertion de sauvegardes ..."

# sauvegarde1 = Sauvegarde.creer( "Description 0", Partie.creer( user1, niveau1 ) )
# sauvegarde2 = Sauvegarde.creer( "Description 1", Partie.creer( user2, niveau2 ) )
# sauvegarde3 = Sauvegarde.creer( "Description 2", Partie.creer( user3, niveau3 ) )

# gsa.sauvegarderSauvegarde(sauvegarde1)
# gsa.sauvegarderSauvegarde(sauvegarde2)
# gsa.sauvegarderSauvegarde(sauvegarde3)

# puts "Ok"

