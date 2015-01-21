# encoding: UTF-8

##
# Auteur CORENTIN DELORME
# Version 0.1 : Date : Tue Dec 16 09:04:38 CET 2014
#

##
# Représentation avec une HBox et une VBox

begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk2'
Gtk.init
def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

def onEvt(label,message)
	puts message
	label.set_text(message)
end

monApp = Gtk::Window.new

# Titre de la fenêtre
monApp.set_title("B1N-HER0")
# Taille de la fenêtre
#monApp.set_default_size(300,200)
# Réglage de la bordure
monApp.border_width=5
# On peut redimensionner
monApp.set_resizable(true)
# L'application est toujours centrée
monApp.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)

# Création du Layout
maBoxVert=Gtk::VBox.new()
monApp.add(maBoxVert)

# Boutons
monBoutQuitter=Gtk::Button.new(Gtk::Stock::QUIT)
monBoutNewGame=Gtk::Button.new("Nouvelle partie")

# Frame
frame=Gtk::Table.new(4,4,false)

tabBouton = []
i = 0
j = 0
0.upto(15) do |a|
	tabBouton.push(Gtk::Button.new())
	if a%2 == 0
		tabBouton.last.set_image(Gtk::Image.new("CaseBleue32.png"))
	else 
		tabBouton.last.set_image(Gtk::Image.new("CaseRouge32.png"))
	end
	tabBouton.last.set_relief(Gtk::RELIEF_NONE)
	frame.attach(tabBouton.last,i,i+1,j,j+1)
	i += 1
	if i >= 4
		i = 0
		j += 1
	end
end


# On ajoute le HBox puis le bouton quitter dans la VBox
maBoxVert.add(monBoutNewGame)
maBoxVert.add(frame)
maBoxVert.add(monBoutQuitter)

monBoutQuitter.signal_connect('clicked')  {onDestroy}

monApp.show_all
# Quand la fenêtre est détruite il faut quitter
monApp.signal_connect('destroy') {onDestroy}
Gtk.main
