# Dépendances
require "sqlite3"
require "./GestionnaireUtilisateur.rb"
require "./Utilisateur.rb"

gestionnaireUtilisateur = GestionnaireUtilisateur.new()


resultat = gestionnaireUtilisateur.count()
puts "Il y a #{resultat} utilisateur(s)"


client = gestionnaireUtilisateur.getForAuthentication('toto0', 'azerty')
if ( client == nil )
	puts "Les identifiants ne sont pas correctes"
else
	puts "Bonjour #{ client.motDePasse }"
end


# puts "Ces derniers sont :"
# resultat = gestionnaireUtilisateur.getAll(0, 10)
# puts resultat
