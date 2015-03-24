require 'gtk3'
require "sqlite3"
include Gtk

require_relative './Controleur/Controleur'
require_relative './Controleur/ControleurDemarrage'
require_relative './Controleur/ControleurConnexion'
require_relative './Controleur/ControleurInscription'
require_relative './Controleur/ControleurMenuPrincipal'
require_relative './Controleur/ControleurNouvellePartie'
require_relative './Controleur/ControleurPartie'

require_relative './Vue/Vue'
require_relative './Vue/VueMenuPrincipal'
require_relative './Vue/VuePartie'
require_relative './Vue/VueConnexion'
require_relative './Vue/VueInscription'
require_relative './Vue/VueDemarrage'
require_relative './Vue/VueNouvellePartie'

require_relative './Modele/Grille'
require_relative './Modele/Tuile'
require_relative './Modele/Utilisateur'
require_relative './Modele/GestionnaireUtilisateur'
class BinHero

    @controleur

    attr_writer :controleur

    def initialize
        Gtk.init
        @controleur = ControleurDemarrage.new(self)
        Gtk.main
    end
end

binhero = BinHero.new()