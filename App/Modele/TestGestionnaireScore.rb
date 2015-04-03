##
# Script de test pour la classe GestionnaireScore
#
# Version 1
#

# Dépendances
require "sqlite3"
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
utilisateur = gu.findById(1)

# On récupère un niveau
niveau = gn.recupererNiveau(1)

# Nombre de scores
nbScores = gsc.recupererNombreScore()
puts "Il y à #{ nbScores } score(s)"

# Lister les scores
scores = gsc.recupererListeScore(0, 10)
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
