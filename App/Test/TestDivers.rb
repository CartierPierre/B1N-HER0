##
# Script de test pour tous les gestionnaires
#
# Version 1
#

# Dépendances
require_relative "../requireTout.rb"

option = Option.creer(Option::TUILE_ROUGE, Option::TUILE_BLEUE, Langue::FR)
puts Marshal.dump(option)
