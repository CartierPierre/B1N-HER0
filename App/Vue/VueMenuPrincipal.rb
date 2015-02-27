require_relative 'Vue.rb'

class VueMenuPrincipal < Vue

	@buttonJouer
	@buttonClassement
	@buttonOptions
	@buttonProfil
	@buttonQuitter

	def initialize
		super()
		vbox = Box.new(:vertical)
		@buttonJouer = Button.new(:label => "Jouer")
		@buttonClassement = Button.new(:label => "Classement")
		@buttonOptions = Button.new(:label => "Options")
		@buttonProfil = Button.new(:label => "Profil")
		@buttonQuitter = Button.new(:stock_id => QUIT)
	end

	vbox.add(buttonJouer)
	vbox.add(buttonClassement)
	vbox.add(buttonOptions)
	vbox.add(buttonProfil)
	vbox.add(buttonQuitter)

end