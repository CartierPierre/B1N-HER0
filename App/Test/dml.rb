##
# Crée une base de test
#

# Dépendances
require_relative "../requireTout.rb"

# On récupère les instances des gestionaires
gut = GestionnaireUtilisateur.instance()
gni = GestionnaireNiveau.instance()
gsa = GestionnaireSauvegarde.instance()
gsc= GestionnaireScore.instance()

# Test ajout d'un utilisateur
testUser = Utilisateur.creer('Buddies', 'azerty', Utilisateur::OFFLINE)
puts "Création d'un utilisateur de test #{ testUser.nom } (id:#{ testUser.id })"
begin
	gut.sauvegarderUtilisateur(testUser)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur #{ testUser.nom } (id:#{ testUser.id }) existe déjà !"
end
