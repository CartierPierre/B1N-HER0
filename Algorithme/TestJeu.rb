# encoding: UTF-8

##
# Auteur TIANQI WEI
# Version 0.1 : Date : Wed Feb 11 17:43:37 CET 2015
#

require_relative './Jeu.rb'
require_relative './Vue/Takuzu.rb'

m = Jeu.creer(4,4)

m.to_s

m.mettreBleu(0,1)
m.mettreRouge(0,0)


m.to_s

if(m.estOccupe?(1,1))
	puts "il est occupe"
else
	puts "il n'est pas occupe"

end