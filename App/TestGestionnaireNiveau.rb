##
# Script de test pour la classe GestionnaireNiveau
#
# Version 4
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère l'instance du gestionnaire de niveau
gn = GestionnaireNiveau.instance()
gu = GestionnaireUtilisateur.instance()

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

niveau = gn.recupererNiveauAleaSelonDimDiff(12, 2)
if ( niveau != nil )
	puts "Un niveau avec une difficultée de 2 et une dimention de 12 a été trouvé : id = #{ niveau.id }"
end

# Premier niveau non terminé
utilisateur = gu.recupererUtilisateur( 1 )
niveau = gn.recupererNiveauSuivant( utilisateur, 12, 2 )
puts "Le premier niveau dispo est le #{ niveau.id }"
