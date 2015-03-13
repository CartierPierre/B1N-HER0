require_relative 'Vue'

class VuePartie < Vue
    @tailleGrille
    @temps
    @buttonUndo
    @buttonRedo
    @buttonConseil
    @buttonRestart

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        boxVertMain = Box.new(:vertical)
        boxJeu = Box.new(:horizontal)
        boxFooter = Box.new(:horizontal)
        monBoutQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        monBoutNewGame = Button.new(:label =>"Nouvelle partie")

        @tailleGrille = @modele.taille()

        frame = Table.new(@tailleGrille,@tailleGrille,false)

        tabBouton = []
        i = 0
        j = 0
        0.upto((@tailleGrille*@tailleGrille)-1) do |a|
        	tabBouton.push(Button.new())
        	if @modele.getTuile(i,j).etat() == 1
        		tabBouton.last.set_image(Image.new(:file => './Vue/img/CaseBleue32.png'))
        	elsif @modele.getTuile(i,j).etat() == 2
        		tabBouton.last.set_image(Image.new(:file => './Vue/img/CaseRouge32.png'))
        	end
        	frame.attach(tabBouton.last,i,i+1,j,j+1)
        	i += 1
        	if i >= @tailleGrille
        		i = 0
        		j += 1
        	end
        end

        @temps = Label.new("0:00")

        @buttonUndo = Button.new()
        @buttonUndo.set_image(Image.new(:file => './Vue/img/undo.png'))
        @buttonRedo = Button.new()
        @buttonRedo.set_image(Image.new(:file => './Vue/img/redo.png'))
        @buttonConseil = Button.new()
        @buttonConseil.set_image(Image.new(:file => './Vue/img/conseil.png'))
        @buttonRestart = Button.new()
        @buttonRestart.set_image(Image.new(:file => './Vue/img/restart.png'))

        boxFooter.add(@buttonUndo)
        boxFooter.add(@buttonRedo)
        boxFooter.add(@buttonConseil)
        boxFooter.add(@buttonRestart)

        boxJeu.add(frame)
        boxJeu.add(@temps)

        boxVertMain.add(boxJeu)
        boxVertMain.add(boxFooter)

        @@fenetre.add(boxVertMain)

        self.actualiser()

    end
end