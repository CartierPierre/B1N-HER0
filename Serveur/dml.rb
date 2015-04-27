##
# Rempli la base de données de niveaux
#

# Dépendances
require_relative "./Requires"

# On récupère les instances des gestionaires
gni = GestionnaireNiveau.instance()

# Insertion de niveaux
puts "Insertion de niveau ..."
pathFile = "./BaseBineroParNiveau.txt" # Chemin du fichier de problèmes
file = false
line = ""
i = 0
tab = []
difficulte = 0
dimention = 0
probleme = ""
solution = ""

if !File.exists?(pathFile)
	puts "Le fichier '#{pathFile}' n\'est pas présent !"
	abort
end

begin
	puts "Ouverture du fichier ..."
	fichier = File.open(pathFile, "r")
	rescue File::Exception => err
		puts "Erreur"
		puts err
		abort
end

while (line = fichier.gets)

	line = line.gsub(/\r/,"")
	line = line.gsub(/\n/,"")
	
	tab = line.split(';')
	difficulte = tab[0].slice(9, tab[0].length)
	dimention = Math.sqrt(tab[1].length)
	probleme = tab[1]
	solution = tab[2]
	
	niveau = Niveau.creer( probleme, solution, difficulte, dimention ) # Attention ! Ne passe pas par la classe Grille
	gni.insert(niveau)
	
    i = i + 1
	if( i>100 )
		puts "+ 100 niveaux"
		i = 0
	end
end

puts "Ok"
