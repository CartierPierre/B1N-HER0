##
# Vue
#

require "gtk3"
include Gtk

require_relative "./Vue/Vue"
require_relative "./Vue/Langue"
require_relative "./Vue/VueConnexion"
require_relative "./Vue/VueDemarrage"
require_relative "./Vue/VueInscription"
require_relative "./Vue/VueMenuPrincipal"
require_relative "./Vue/VueNouvellePartie"
require_relative "./Vue/VueOptions"
require_relative "./Vue/VuePartie"

##
# Modele
#

require "sqlite3"

require_relative "./Modele/Stockage"
require_relative "./Modele/GestionnaireUtilisateur"
require_relative "./Modele/Utilisateur"
require_relative "./Modele/Option"
require_relative "./Modele/GestionnaireNiveau"
require_relative "./Modele/Niveau"
require_relative "./Modele/GestionnaireScore"
require_relative "./Modele/Score"
require_relative "./Modele/GestionnaireSauvegarde"
require_relative "./Modele/Sauvegarde"
require_relative "./Modele/Etat"
require_relative "./Modele/Grille"
require_relative "./Modele/Niveau"
require_relative "./Modele/Tuile"
require_relative "./Modele/Chrono"
require_relative "./Modele/Coup"
require_relative "./Modele/Partie"
require_relative "./Modele/ThreadChrono"

##
# Controleur
#

require_relative "./Controleur/Controleur"
require_relative "./Controleur/ControleurConnexion"
require_relative "./Controleur/ControleurDemarrage"
require_relative "./Controleur/ControleurInscription"
require_relative "./Controleur/ControleurMenuPrincipal"
require_relative "./Controleur/ControleurNouvellePartie"
require_relative "./Controleur/ControleurOptions"
require_relative "./Controleur/ControleurPartie"

# Dir[File.dirname(__FILE__) + "/Modele/*.rb"].each {|file| require file }
# Sa marche sauf quand un bollos fait des ***** de tests directement dans les fichiers de classes
# Donc obligé de faire des require à la main pour éviter les erreurs
