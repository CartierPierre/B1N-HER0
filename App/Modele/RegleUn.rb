#Règle 1: autant de 1 et de 0 sur chaque ligne et sur chaque colonne 
load 'Grille.rb'

class RegleUn
		
	attr_reader:ligne, :colonne, :grille
		
	private_class_method :new
    
    	def RegleUn.creer()
        	new()
    	end
    	
    	def initialize()
    		new()
	end
	
	def appliquer(grille)
		@grille = grille
    		@ligne = grille.ligne()
    		@colonne = grille.colonne()
    		
    		i = 0
    		j = 0
    		nbCouleurUn = 0
    		nbCouleurDeux = 0
    		while i < @ligne do
    			while j < @colonne do
    				if grille.getTuile(i,j).etat() == 1 then
    					nbCouleurUn += 1
    				
    				elsif grille.getTuile(i,j).etat() == 2 then
    					nbCouleurDeux += 1
    				else
    				end
    				j += 1
    			end
    			if nbCouleurUn != nbCouleurDeux then
    				return false
    			end
    			i += 1
    		end
    		
    		i = 0
    		j = 0
    		nbCouleurUn = 0
    		nbCouleurDeux = 0
    		while j < @colonne do
    			while i < @ligne do
    				if grille.getTuile(i,j).etat() == 1 then
    					nbCouleurUn += 1;
    				
    				elsif grille.getTuile(i,j).etat() == 2 then
    					nbCouleurDeux += 1;
    				
    				else
    				end
    				i += 1
    			end
    			if nbCouleurUn != nbCouleurDeux then
    				return false
    			end
    			j += 1
    		end
    		return true
    	end
end
