class VueProfil < Vue



    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        
        boutonAnnuler = Button.new("Retour")
        @cadre.add(boutonAnnuler)
        self.actualiser()
    end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler()
	end
end