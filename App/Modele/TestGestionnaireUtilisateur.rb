# Dépendances
require "sqlite3"
require "./GestionnaireUtilisateur.rb"
require "./Utilisateur.rb"
require "singleton"

# gestionnaireUtilisateur = GestionnaireUtilisateur.new()
gestionnaireUtilisateur = GestionnaireUtilisateur.instance()


resultat = gestionnaireUtilisateur.count()
puts "Il y a #{resultat} utilisateur(s)"


client = gestionnaireUtilisateur.getForAuthentication('toto0', 'azerty')
if ( client == nil )
	puts "Les identifiants ne sont pas correctes"
else
	puts "Bonjour #{ client.nom }, votre id est #{ client.id }"
end


# puts "Ces derniers sont :"
# resultat = gestionnaireUtilisateur.getAll(0, 10)
# puts resultat


Utilisateur.creer(1, 1, 'Toto', 'azerty', 1, 1, 1, 1, 1)
