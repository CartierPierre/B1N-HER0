require_relative 'Vue'

class Vuepartie < Vue
    def initialize
        super(modele,"B1N-HERO")
        @fenetre.border_width=5
        @fenetre.set_resizable(true)
        @fenetre.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)


        maBoxVert=Gtk::Box.new(:vertical)
        @fenetre.add(maBoxVert)
        monBoutQuitter=Gtk::Button.new(:stock_id => Gtk::Stock::QUIT)
        monBoutNewGame=Gtk::Button.new(:label =>"Nouvelle partie")
        frame=Gtk::Table.new(4,4,false)

        tabBouton = []
        i = 0
        j = 0
        0.upto(15) do |a|
        	tabBouton.push(Gtk::Button.new())
        	if a%2 == 0
        		tabBouton.last.set_image(Gtk::Image.new(:file=>'./img/CaseBleue32.png'))
        	else
        		tabBouton.last.set_image(Gtk::Image.new(:file=>'./img/CaseRouge32.png'))
        	end
        	tabBouton.last.set_relief(Gtk::ReliefStyle::NONE)
        	frame.attach(tabBouton.last,i,i+1,j,j+1)
        	i += 1
        	if i >= 4
        		i = 0
        		j += 1
        	end
        end

    end
end