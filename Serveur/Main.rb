# Require
require "socket"
require_relative "./Requete"
require_relative "./Reponse"
require_relative "./Traitement"
require_relative "./Serveur"
require_relative "./Utilisateur"
require_relative "./Niveau"
require_relative "./Score"
require_relative "./Sauvegarde"
require_relative "./Stockage"
require_relative "./GestionnaireUtilisateur"
require_relative "./GestionnaireScore"
require_relative "./GestionnaireSauvegarde"
require_relative "./GestionnaireNiveau"

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
