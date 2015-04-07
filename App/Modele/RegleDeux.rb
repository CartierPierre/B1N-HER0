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

	0.upto Math.sqrt(partie.grille().taille() - 1) do |x|
		0.upto Math.sqrt(partie.grille().taille() - 2) do |y|
 			if partie.grille().getTuile(x,y).etat() == 1 && partie.grille().getTuile(x,y+1).etat() == 1 && partie.grille().getTuile(x,y+2).etat() == 1 then
 					#Meme si plus que trois, il retourne faux 
 					return false
 					
    			elsif partie.grille().getTuile(x,y).etat() == 2 && partie.grille().getTuile(x,y+1).etat() == 2 && partie.grille().getTuile(x,y+2).etat() == 2 then
 					return false
    			end
    		end
    	end

		0.upto Math.sqrt(partie.grille().taille() - 1) do |y|
			0.upto Math.sqrt(partie.grille().taille() - 2) do |x|
    			if partie.grille().getTuile(x,y).etat() == 1 && partie.grille().getTuile(x+1,y).etat() == 1 && partie.grille().getTuile(x+2,y).etat() == 1 then
 					#Meme si plus que trois, il retourne faux 
 					return false
 					
    			elsif partie.grille().getTuile(x,y).etat() == 2 && partie.grille().getTuile(x+1,y).etat() == 2 && partie.grille().getTuile(x+2,y).etat() == 2 then
 					return false
    			end			
    		end
    	end
    	return true
    end
end
