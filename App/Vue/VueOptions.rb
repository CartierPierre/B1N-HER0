class VueOptions < Vue

    @boutonLangueFr
    @boutonLangueEn

    @boutonRetour

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        
        boxPrincipale = Box.new(:vertical)
        boxLangue = Box.new(:horizontal)

        boxLangue.add(Label.new(@controleur.options.langue.langueActuelle[:langue]))
        @boutonLangueFr = Button.new(:label => @controleur.options.langue.langueActuelle[:francais])
        @boutonLangueFr.signal_connect('clicked')  { onBtnLangueFrClicked }
        @boutonLangueEn = Button.new(:label => @controleur.options.langue.langueActuelle[:anglais])
        @boutonLangueEn.signal_connect('clicked')  { onBtnLangueEnClicked }

        boxLangue.add(@boutonLangueFr)
        boxLangue.add(@boutonLangueEn)

        @boutonRetour = Button.new(:label => @controleur.options.langue.langueActuelle[:retour])
        @boutonRetour.signal_connect('clicked')  { onBtnRetourClicked }

        boxPrincipale.add(boxLangue)
        boxPrincipale.add(@boutonRetour)

        @fenetre.add(boxPrincipale)
        self.actualiser()
    end

    def onBtnLangueFrClicked
        @controleur.setLangueFr()
    end

    def onBtnLangueEnClicked
        @controleur.setLangueEn()
    end

    def onBtnRetourClicked
        @controleur.retour()
    end
end