require_relative 'Vue'

class VueDemarrage < Vue

 def initialize(modele,titre,controleur)
    super(modele,titre,controleur)
		vbox = Box.new(:vertical)
		hbox = Box.new(:honrizontal)
		@buttonConnexion = Button.new(:label => "Connexion")
		@buttonInscription = Button.new(:label => "Inscription")
        hbox.add(@buttonConnexion)
        hbox.add(@buttonInscription)
        vbox.add(hbox)

    end
end