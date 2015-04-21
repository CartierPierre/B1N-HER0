##
# Vue
#

require "gtk3"
include Gtk

require_relative "./Vue/Langue"
require_relative "./Vue/TuileGtk"
require_relative "./Vue/Vue"
require_relative "./Vue/VueChargerPartie"
require_relative "./Vue/VueClassement"
require_relative "./Vue/VueConnexion"
require_relative "./Vue/VueCredits"
require_relative "./Vue/VueDemarrage"
require_relative "./Vue/VueInscription"
require_relative "./Vue/VueMenuPrincipal"
require_relative "./Vue/VueNouvellePartie"
require_relative "./Vue/VueOptions"
require_relative "./Vue/VuePartie"
require_relative "./Vue/VueProfil"
require_relative "./Vue/VueResultatPartie"

##
# Modele
#

require "sqlite3"

require_relative "./Modele/Chrono"
require_relative "./Modele/Coup"
require_relative "./Modele/Etat"
require_relative "./Modele/GestionnaireNiveau"
require_relative "./Modele/GestionnaireSauvegarde"
require_relative "./Modele/GestionnaireScore"
require_relative "./Modele/GestionnaireUtilisateur"
require_relative "./Modele/Grille"
require_relative "./Modele/Niveau"
require_relative "./Modele/Niveau"
require_relative "./Modele/Option"
require_relative "./Modele/Partie"
require_relative "./Modele/RegleDeux"
require_relative "./Modele/RegleTrois"
require_relative "./Modele/RegleUn"
require_relative "./Modele/Sauvegarde"
require_relative "./Modele/Score"
require_relative "./Modele/Stockage"
require_relative "./Modele/Tuile"
require_relative "./Modele/Utilisateur"

##
# Controleur
#

require_relative "./Controleur/Controleur"
require_relative "./Controleur/ControleurChargerPartie"
require_relative "./Controleur/ControleurClassement"
require_relative "./Controleur/ControleurConnexion"
require_relative "./Controleur/ControleurCredits"
require_relative "./Controleur/ControleurDemarrage"
require_relative "./Controleur/ControleurInscription"
require_relative "./Controleur/ControleurMenuPrincipal"
require_relative "./Controleur/ControleurNouvellePartie"
require_relative "./Controleur/ControleurOptions"
require_relative "./Controleur/ControleurPartie"
require_relative "./Controleur/ControleurProfil"
require_relative "./Controleur/ControleurResultatPartie"
