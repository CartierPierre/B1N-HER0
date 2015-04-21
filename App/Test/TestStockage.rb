##
# Script de test pour la classe stockage, en particulier la couche réseau
#
# Version 1
#

# Dépendances
require_relative "../requireTout.rb"

stockage = Stockage.instance()

puts stockage.testConnexion()
