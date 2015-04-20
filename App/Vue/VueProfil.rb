class VueProfil < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked') { onBtnAnnulerClicked }

        @cadre.add(@boutonAnnuler)
        self.actualiser()
    end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler()
	end
end