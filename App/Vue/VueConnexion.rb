require_relative 'Vue'

class VueConnexion < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        vbox1 = Box.new(:vertical)
        hbox1 = Box.new(:horizontal)
        hbox2 = Box.new(:horizontal)
        hbox3 = Box.new(:horizontal)
		@buttonValider = Button.new(:stock_id => Stock::APPLY)
		@buttonAnnuler = Button.new(:stock_id => Stock::CANCEL)
        labelPseudo = Label.new("Pseudo",true)
        labelPassword = Label.new("Mot De Passe",true)
        entryPseudo = Entry.new
        entryPassword = Entry.new
        hbox1.pack_start(labelPseudo, :expand => false)
        hbox2.pack_start(labelPassword, :expand => false)
        hbox1.pack_end(entryPseudo)
        hbox2.pack_end(entryPassword)
        hbox3.pack_start(@buttonValider,:fill => true)
        hbox3.pack_end(@buttonAnnuler,:fill => true)
        vbox1.add(hbox1)
        vbox1.add(hbox2)
        vbox1.pack_end(hbox3, :expand => true, :fill => true)
        @fenetre.add(vbox1)


        @buttonValider.signal_connect('clicked')  { onBtnValiderClicked }
        @buttonAnnuler.signal_connect('clicked')  { onBtnAnnulerClicked }

        self.actualiser()
    end

	def onBtnValiderClicked
        @controleur.valider()
	end

	def onBtnAnnulerClicked
        @controleur.annuler()
	end
end