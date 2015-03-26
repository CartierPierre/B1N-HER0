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

# Test ajout d'un utilisateur
me = Utilisateur.creer('Buddies', 'azerty', Utilisateur::OFFLINE)
begin
	gestionnaireUtilisateur.persist(me)
	rescue SQLite3::ConstraintException => err
		puts "L'utilisateur Buddies existe déjà !"
end

# Test de connexion d'un client
client = gestionnaireUtilisateur.getForAuthentication('toto0', 'azerty')
if ( client == nil )
	puts "Les identifiants ne sont pas correctes"
else
	puts "Bonjour #{ client.nom }, votre id est #{ client.id }"
end

# Test mise à jour client
# client.type = 0
# gestionnaireUtilisateur.persist(me)
