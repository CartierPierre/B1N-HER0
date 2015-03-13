# Dépendances
require "sqlite3"
require "./GestionnaireUtilisateur.rb"

gu = GestionnaireUtilisateur.new()

rs = gu.count()

row = rs.next
puts row.join "\s"
