##
# Script de test pour la classe GestionnaireSauvegarde
#
# Version 4
#

# Dépendances
require "sqlite3"
require "./GestionnaireSauvegarde.rb"
require "./Utilisateur.rb"

# On récupère l'instance du gestionnaire de sauvegarde
gs = GestionnaireSauvegarde.instance()
