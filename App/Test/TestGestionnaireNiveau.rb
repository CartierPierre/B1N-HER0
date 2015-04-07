##
# Script de test pour la classe GestionnaireNiveau
#
# Version 3
#

# Dépendances
require_relative "../requireTout.rb"

# On récupère l'instance du gestionnaire de niveau
gn = GestionnaireNiveau.instance()

# Nombre de niveaux
nbNiveaux = gn.recupererNombreNiveau()
puts "Il y a #{ nbNiveaux } niveau(x) :"

# Lister les niveaux
niveaux = gn.recupererListeNiveau(0, 10)
niveaux.each do |niveau|
	puts " - niveau #{niveau.id}, difficulte #{ niveau.difficulte }, dimention #{ niveau.dimention }"
end

# On cherche un niveau spécifique
niveau = gn.recupererNiveau(1)
if ( niveau != nil )
	puts "Le niveau 1 existe : difficulte #{ niveau.difficulte }, dimention #{ niveau.dimention }"
end

# Liste les difficulté dipsonibles sur une dimention de niveau donnée
puts "Les difficultées dipsonibles pour une grille de taille 12 sont :"
difficultes = gn.recupererListeDifficulte(12)
difficultes.each do |difficulte|
	puts " - difficulte #{ difficulte }"
end