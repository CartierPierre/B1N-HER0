class VueOptions < Vue

    @labelLangue

    @boutonLangueFr
    @boutonLangueEn

    @boutonRetour

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        
        boxPrincipale = Box.new(:vertical)
        boxLangue = Box.new(:horizontal)

        @labelLangue = Label.new(@controleur.options.langue.langueActuelle[:langue])
        boxLangue.add(@labelLangue)
        @boutonLangueFr = Button.new(:label => @controleur.options.langue.langueActuelle[:francais])
        @boutonLangueFr.signal_connect('clicked')  { onBtnLangueFrClicked }
        @boutonLangueEn = Button.new(:label => @controleur.options.langue.langueActuelle[:anglais])
        @boutonLangueEn.signal_connect('clicked')  { onBtnLangueEnClicked }

        boxLangue.add(@boutonLangueFr)
        boxLangue.add(@boutonLangueEn)

        @boutonRetour = Button.new(:label => @controleur.options.langue.langueActuelle[:retour])
        @boutonRetour.signal_connect('clicked')  {onBtnRetourClicked}

        boxPrincipale.add(boxLangue)
        boxPrincipale.add(@boutonRetour)

        @cadre.add(boxPrincipale)
        self.actualiser()
    end

    def actualiserLangue() 
        @boutonLangueFr.set_label(@controleur.options.langue.langueActuelle[:francais])
        @boutonLangueEn.set_label(@controleur.options.langue.langueActuelle[:anglais])
        @boutonRetour.set_label(@controleur.options.langue.langueActuelle[:retour])
        @labelLangue.set_label(@controleur.options.langue.langueActuelle[:langue])
    end

    def onBtnLangueFrClicked
        @controleur.setLangueFr()
        self.actualiserLangue()
    end

    def onBtnLangueEnClicked
        @controleur.setLangueEn()
        self.actualiserLangue()
    end

    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end
end