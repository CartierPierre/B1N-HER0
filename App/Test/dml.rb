##
# Rempli une base de données de tests
#

# Dépendances
require_relative "../requireTout.rb"

# On récupère les instances des gestionaires
gut = GestionnaireUtilisateur.instance()
gni = GestionnaireNiveau.instance()
gsa = GestionnaireSauvegarde.instance()
gsc= GestionnaireScore.instance()

# Insertion de'tilisateurs
user1 = Utilisateur.creer('Test', 'azerty', Utilisateur::OFFLINE)
begin
	gut.sauvegarderUtilisateur(user1)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur #{ user1.nom } (id:#{ user1.id }) existe déjà !"
end

user2 = Utilisateur.creer('Toto', 'azerty', Utilisateur::OFFLINE)
begin
	gut.sauvegarderUtilisateur(user2)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur #{ user2.nom } (id:#{ user2.id }) existe déjà !"
end

user3 = Utilisateur.creer('Buddies', 'azerty', Utilisateur::OFFLINE)
begin
	gut.sauvegarderUtilisateur(user3)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur #{ user3.nom } (id:#{ user3.id }) existe déjà !"
end

# Insertion de niveaux

niveau1 = Niveau.creer( Grille.charger( "00_________1____0___11_______0_0_1__" ),  Grille.charger( "001011010011110100001101110010101100"), 1, 6)
niveau2 = Niveau.creer( Grille.charger( "_1_1___0____0___0__________10__01__10____0___00__10_0__1_________0__1_1_0______0_____1__0______1_____1____0___0__11_0_________0_______1_0_______"),  Grille.charger( "110110100100011001010110100101101001011010011001010101010110101010101010001011001101010100110011101011001100100101100101010010011011101100110010"), 2, 12)
niveau3 = Niveau.creer( Grille.charger( "0___0____1__0_1_0________________1___0_1_1__1__1__0____________1"),  Grille.charger( "0110011011010010001011011010110001010011011010011001011010011001"), 6, 8)

gni.insert(niveau1)
gni.insert(niveau2)
gni.insert(niveau3)

# Insertion de scores

score1 = Score.creer(3600, 10, 10, 10, 1, 1)
score2 = Score.creer(3600, 10, 10, 10, 1, 2)
score3 = Score.creer(3600, 10, 10, 10, 2, 3)

gsc.sauvegarderScore(score1)
gsc.sauvegarderScore(score2)
gsc.sauvegarderScore(score3)

# Insertion de sauvegardes

sauvegarde1 = Sauvegarde.creer( "Description 0", Partie.creer( user1, niveau1 ) )
sauvegarde2 = Sauvegarde.creer( "Description 1", Partie.creer( user2, niveau2 ) )
sauvegarde3 = Sauvegarde.creer( "Description 2", Partie.creer( user3, niveau3 ) )

gsa.sauvegarderSauvegarde(sauvegarde1)
gsa.sauvegarderSauvegarde(sauvegarde2)
gsa.sauvegarderSauvegarde(sauvegarde3)
