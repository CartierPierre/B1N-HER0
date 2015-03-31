##
# Script de test pour la classe GestionnaireUtilisateur
#
# Version 4
#

# Dépendances
require "sqlite3"
require "./GestionnaireUtilisateur.rb"
require "./Utilisateur.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gestionnaireUtilisateur = GestionnaireUtilisateur.instance()

# Nombre d'utilisateurs
resultat = gestionnaireUtilisateur.count()
puts "Il y a #{resultat} utilisateur(s)"

# Liste des utilisateurs
users = gestionnaireUtilisateur.getAll(0, 10)
puts "Les 10 premiers utilisateurs sont :"
users.each do |u|
	puts " - #{u.nom}"
end

# Test ajout d'un utilisateur
testUser = Utilisateur.creer('Buddies', 'azerty', Utilisateur::OFFLINE)
puts "Création d'un utilisateur de test #{ testUser.nom } (id:#{ testUser.id })"
begin
	gestionnaireUtilisateur.persist(testUser)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur #{ testUser.nom } (id:#{ testUser.id }) existe déjà !"
end

# Test de suppression de l'utilisateur
puts "Suppression de l'utilisateur de test #{ testUser.nom } (id:#{ testUser.id })"
gestionnaireUtilisateur.delete(testUser)

# Test de connexion d'un client
client = gestionnaireUtilisateur.getForAuthentication('toto0', 'azerty')
if ( client == nil )
	puts "Les identifiants ne sont pas correctes"
else
	puts "Bonjour #{ client.nom }, votre id est #{ client.id }"
end

# Test mise à jour client
client.type = 0
gestionnaireUtilisateur.persist(client)
