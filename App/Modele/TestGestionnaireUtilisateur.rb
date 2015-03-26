# Dépendances
require "sqlite3"
require "./GestionnaireUtilisateur.rb"
require "./Utilisateur.rb"


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

# Test de connexion
client = gestionnaireUtilisateur.getForAuthentication('toto0', 'azerty')
if ( client == nil )
	puts "Les identifiants ne sont pas correctes"
else
	puts "Bonjour #{ client.nom }, votre id est #{ client.id }"
end
