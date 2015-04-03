#Règle 2: pas plus de 2 chiffres identiques côte à côte 

load 'Grille.rb'
load "Partie.rb"

class RegleDeux
		
    private_class_method :new
	
    def RegleDeux.creer()
        new()
    end
    	
    def initialize()
    	new()
    end
    
    def RegleDeux.appliquer(partie)
    
    	ligne = partie.grille().ligne()
    	colonne = partie.grille().colonne()

		0.upto(ligne - 1) do |x|
			0.upto(colonne - 2) do |y|
 				if grille.getTuile(x,y).etat() == 1 && grille.getTuile(x,y+1).etat() == 1 && grille.getTuile(x,y+2).etat() == 1
 					#Meme si plus que trois, il retourne faux 
 					return false
    			end
    			
    			if grille.getTuile(x,y).etat() == 2 && grille.getTuile(x,y+1).etat() == 2 && grille.getTuile(x,y+2).etat() == 2
 					return false
    			end
    		end
    	end

		0.upto(colonne - 1) do |y|
			0.upto(ligne - 2) do |x|
    			if grille.getTuile(x,y).etat() == 1 && grille.getTuile(x+1,y).etat() == 1 && grille.getTuile(x+2,y).etat() == 1
 					#Meme si plus que trois, il retourne faux 
 					return false
    			end
    			
    			if grille.getTuile(x,y).etat() == 2 && grille.getTuile(x+1,y).etat() == 2 && grille.getTuile(x+2,y).etat() == 2
 					return false
    			end			
    		end
    	end
    	return true
    end
end
