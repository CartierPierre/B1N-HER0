# Dépendances
require_relative "./Requires"

# Création d'un serveur
serveur = Serveur.creer()

# Lancement du serveur
serveur.demarrer( 10101, "./binhero.log" )

# Attente
saisie = ""
while( saisie != "stop" )
	puts "Entrez stop pour arreter le serveur."
	saisie = gets.chomp()
end

# Arrêt du serveur
serveur.arreter()
