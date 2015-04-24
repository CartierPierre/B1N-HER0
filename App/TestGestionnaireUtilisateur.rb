##
# Script de test pour la classe GestionnaireUtilisateur
#
# Version 7
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# Nombre d'utilisateurs
resultat = gu.recupererNombreUtilisateur()
puts "Il y a #{resultat} utilisateur(s)"

# Liste des utilisateurs
users = gu.recupererListeUtilisateur(0, 10)
puts "Les 10 premiers utilisateurs sont :"
users.each do |u|
	puts " - #{u.nom}"
end

# Test ajout d'un utilisateur
testUser = Utilisateur.creer('SuperTestUser', 'azerty', Utilisateur::OFFLINE)
puts "Création d'un utilisateur de test #{ testUser.nom } (id:#{ testUser.id })"
begin
	gu.sauvegarderUtilisateur(testUser)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur #{ testUser.nom } existe déjà !"
		abort
end

# Test de suppression de l'utilisateur
puts "Suppression de l'utilisateur de test #{ testUser.nom } (id:#{ testUser.id })"
gu.supprimerUtilisateur(testUser)

# Test de connexion d'un client
client = gu.connexionUtilisateur('Test', 'azerty')
if ( client == nil )
	puts "Les identifiants ne sont pas correctes"
	abord
else
	puts "Bonjour #{ client.nom }, votre id est #{ client.id }"
end

# Test mise à jour client
client.motDePasse = "azerty"
gu.sauvegarderUtilisateur(client)

# Statistiques
client.statistique.mettreAJour()
puts "#{ client.nom } à terminé #{ client.statistique.nbGrillesReso } grille avec un total de #{ client.statistique.scoreTotal } points "
