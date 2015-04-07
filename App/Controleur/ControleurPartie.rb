require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = Partie.creer(nil,Niveau.creer(
                    1,
                    2,
                    Grille.creer(6).charger("00_________1____0___11_______0_0_1__"),
                    Grille.creer(6).charger("001011010011110100001101110010101100"),
                    1,
                    6
                ))
		@vue = VuePartie.new(@modele,"Jeu",self)
	end	

    def options()
        #changerControleur(ControleurOptions.new(@jeu))
    end

end