##
# Script de test pour la classe GestionnaireSauvegarde
#
# Version 4
#

# Dépendances
require "sqlite3"
require "./GestionnaireSauvegarde.rb"
require "./GestionnaireUtilisateur.rb"
require "./Utilisateur.rb"
require "./Sauvegarde.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# On récupère l'instance du gestionnaire de sauvegarde
gs = GestionnaireSauvegarde.instance()

# On récupère un utilisateur
utilisateur = gu.findById(1)

# Nombre de sauvegardes
nbSauvegardes = gs.recupererNombreSauvegardeUtilisateur(utilisateur)
puts "L'utilisateur #{ utilisateur.nom } à #{nbSauvegardes} sauvegarde(s)"

# Lister les sauvegardes d'un utilisateur
listeSauvegardes = gs.recupererSauvegardeUtilisateur(utilisateur, 0, 10)
listeSauvegardes.each do |sauvegarde|
	puts " - #{sauvegarde.titre}"
end
