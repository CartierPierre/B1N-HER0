##
# Script de test pour la classe GestionnaireScore
#
# Version 4
#

# Dépendances
require "sqlite3"
require "./Stockage.rb"
require "./GestionnaireScore.rb"
require "./GestionnaireUtilisateur.rb"
require "./GestionnaireNiveau.rb"
require "./Score.rb"
require "./Utilisateur.rb"
require "./Niveau.rb"

# On récupère l'instance du gestionnaire de score
gsc= GestionnaireScore.instance()

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# On récupère l'instance du gestionnaire d'utilisateur
gn = GestionnaireNiveau.instance()

# On récupère un utilisateur
utilisateur = gu.recupererUtilisateur(1)

# On récupère un niveau
niveau = gn.recupererNiveau(1)

# Récupérer un score
score = gsc.recupererScore(2)
if( score != nil )
	puts "Le score avec l'id 2 existe"
end

# Nombre de scores
nbScores = gsc.recupererNombreScore()
puts "Il y à #{ nbScores } score(s) en tout"

# Lister les scores
scores = gsc.recupererListeScore(0, 10)
puts "Les scores sont :"
scores.each do |score|
	puts " - #{ score } "
end

# Nombre de scores d'un utilisateur
nbScores = gsc.recupererNombreScoreUtilisateur(utilisateur)
puts "L'utilisateur #{ utilisateur.nom } à #{ nbScores } score(s)"

# Lister les scores d'un utilisateur
scores = gsc.recupererListeScoreUtilisateur(utilisateur, 0, 10)
scores.each do |score|
	puts " - #{ score } "
end

# Nombre de scores sur un niveau
nbScores = gsc.recupererNombreScoreNiveau(niveau)
puts "Le niveau #{ niveau.id } à #{ nbScores } score(s)"

# Lister les scores d'un niveau
scores = gsc.recupererListeScoreNiveau(niveau, 0, 10)
scores.each do |score|
	puts " - #{ score } "
end

# Nombre de scores d'un utilisateur sur un niveau
nbScores = gsc.recupererNombreScoreUtilisateurNiveau(utilisateur, niveau)
puts "L'utilisateur #{ utilisateur.nom } à #{ nbScores } score(s) sur le niveau #{ niveau.id }"

# Lister les scores d'un utilisateur sur un niveau
scores = gsc.recupererListeScoreUtilisateurNiveau(utilisateur, niveau, 0, 10)
puts "Les scores de l'utilisateur #{ utilisateur.nom } sur le niveau #{ niveau.id } sont :"
scores.each do |score|
	puts " - #{ score } "
end
