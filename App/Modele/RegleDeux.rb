#Règle 2: pas plus de 2 chiffres identiques côte à côte 

class RegleDeux
		
    private_class_method :new
	
    def RegleDeux.creer()
        new()
    end
    	
    def initialize()
    	new()
    end
    
    def RegleDeux.appliquer(partie)
	0.upto partie.grille().taille() - 1 do |x|
		0.upto partie.grille().taille() - 3 do |y|
			if partie.grille().getTuile(x,y).etat() == Etat.vide && partie.grille().getTuile(x,y+1).etat() == Etat.vide && partie.grille().getTuile(x,y+2).etat() == Etat.vide then 
 			elsif Etat.egale?(partie.grille().getTuile(x,y).etat(),partie.grille().getTuile(x,y+1).etat()) && Etat.egale?(partie.grille().getTuile(x,y+1).etat(),partie.grille().getTuile(x,y+2).etat()) then
 					#Meme si plus que trois, il retourne faux 
 					return false
    		end
    	end
    end
    
	0.upto partie.grille().taille() - 1 do |y|
		0.upto partie.grille().taille() - 3 do |x|
			if partie.grille().getTuile(x,y).etat() == Etat.vide && partie.grille().getTuile(x+1,y).etat() == Etat.vide && partie.grille().getTuile(x+2,y).etat() == Etat.vide then
    		elsif Etat.egale?(partie.grille().getTuile(x,y).etat(),partie.grille().getTuile(x+1,y).etat()) && Etat.egale?(partie.grille().getTuile(x+1,y).etat(),partie.grille().getTuile(x+2,y).etat()) then
 					#Meme si plus que trois, il retourne faux 
 					return false
    		end	
    	end
    end
    return true
    end
end
