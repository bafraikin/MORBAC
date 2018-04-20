
#ça c'est une case, ça aurait pu etre un hash mais felix voulait que ce soit
#une classe. 
class Boardcase
  attr_accessor :value

  def initialize
    @value = "" #la valeur est initié à vide, ça va pas mal servir
  end
end

class Board
  attr_accessor :plateau

  def initialize
    @plateau = []
    3.times do | y |
      @plateau[y] = Hash.new #un hash par ligne
      3.times do | x |
        @plateau[y][:"#{x}"] = Boardcase.new #dans chaque hash 3 key
      end                                    #qui contiennent une case 
    end
  end

  #pour la fonction suivante le plus important est la variable 'char' que tu vas trouver
  #un peu perdu au debut de la 2eme boucle
  #l'objectif est que pour chaque case on verifie si la case est vide ""
  #Si oui char reste inchangé
  #Si non on met la valeur de la case dans char. ça permet de faire un seul puts general
  #qui s'adapte en fonction de la case.
  #'\s' correspond à un espace, mais c'est plus visuel que ' '

  def puts_plateau
    3.times do | y |
      print "\n"
      unless y == 0 then print "---+---+---\n" end #affiche les lignes intermediaire
      3.times do | x |                            #sauf la 1ere ligne, ça fait + souag!
        char = "\s" 
        unless @plateau[y][:"#{x}"].value == "" then char = @plateau[y][:"#{x}"].value end
        print "\s#{char}\s" 
        if x < 2 then print "|" end 
      end
    end
    print "\n\n"
  end


  def check_plateau
    3.times do | nb | #check si les lignes sont bonne #{nb} change de ligne
      unless  plateau[nb][:"0"].value == ""
        if  plateau[nb][:"0"].value ==  plateau[nb][:"1"].value && plateau[nb][:"0"].value == plateau[nb][:"2"].value 
          return  plateau[nb][:"0"].value
        end
      end
    end
    3.times do | nb |   #check si les colonnes sont bonnes #{nb} change de colonne
      unless  plateau[0][:"#{nb}"].value == ""
        if plateau[0][:"#{nb}"].value == plateau[1][:"#{nb}"].value && plateau[0][:"#{nb}"].value == plateau[2][:"#{nb}"].value
          return  plateau[0][:"#{nb}"].value
        end
      end
    end
    unless plateau[1][:"1"].value == "" #1ere diagonale 
      if  plateau[0][:"0"].value == plateau[1][:"1"].value && plateau[1][:"1"].value == plateau[2][:"2"].value
        return plateau[1][:"1"].value
      end                               #2eme diagonale
      if  plateau[0][:"2"].value == plateau[1][:"1"].value && plateau[1][:"1"].value == plateau[2][:"0"].value
        return plateau[1][:"1"].value
      end
    end
    ""
  end
end

class Game
  attr_accessor :player, :board, :play


  def initialize
    @player = []
    @player[0] = Player.new("O")  # va demander le gets de l'initialisation de la class player
    @player[1] = Player.new("X")  # pareil
    @board = Board.new  # va remplir un tableau vide
    @play = 0           #variable qui va me permettre de changer de joueur, je sais pas si c'est le mieux mais
  end                   #c'est la solution de la fatigue

  def next_turn
    @play == 0 ? @play +=1 : @play -=1   #change la valeur de play, donc change de joueur
    tu_vas_jouer_oui?(player[play])
  end

  def tu_vas_jouer_oui?(joueur)   
    while true   #boucle infini de gros porc pour empecher de rejouer sur une case deja prise
      line = 0
      column = 0
      while line < 1 || line > 3  #tant que le joueur n'a pas un choix serieux la boucle tourne.
        print "#{joueur.name.capitalize} choisis la ligne où tu veux jouer\n"
        line = gets.chomp.to_i
      end
      line -=1  #le joueur lambda ne sait pas qu'un tableau commence à 0. C'est une ruse de gitan
      while column < 1 || column > 3
        print "#{joueur.name.capitalize} choisis la colonne où tu veux jouer\n"
        column = gets.chomp.to_i
      end
      column -=1
      if board.plateau[line][:"#{column}"].value == ""   # si la case est bien vide on laisse le joueur la remplir
        board.plateau[line][:"#{column}"].value = joueur.symbol
        break  #va casser la boucle infini
      else
        puts "HaHAHAGHAHAAHAHAHAAhahahahahahahaHAHHAAHHAhahAHAh"   # sinon on le troll
        puts "Tres marrant ça"
        puts "La case etait déjà prise, t'es repartis pour un tour couillon\n\n"
        puts "mais d'abord tu attends 5 sec"
        sleep 5
      end
    end
  end

  def c_fini
    plein = 0
    @board.plateau.each do | ligne |
      ligne.each_value do | casel |

      if casel.value != ""
        plein +=1
      end
    end
    end

    if board.check_plateau != "" #la fonction renvoit la valeur 
      board.puts_plateau
      puts "/!\\-------------------/!\\" #quand je suis fatigué, je suis d'humeur taquine
      puts "#{player[play].name} a gagné ! Bravo a lui, il a vaincu l'autre gros naze"  #grace à @play je sais qui etait en train
      puts "/!\\-------------------/!\\"                                   #de jouer et donc qui a gagné
      true # va casser notre boucle 'until'
    elsif plein == 9
      puts "EGALIT" + "é".upcase # flemme de recherche google le raccourcis
      puts "bon ben personne n'a su gagner"
      puts "C'est quand meme la fin de la partie"
      true
    else
      false  #va continuer la boucle
    end
  end
end

class Player
  attr_accessor :name, :symbol

  def initialize(symbol)  #c'est la class game qui gere les symbol
    print "\nrentre ici ton nom : "
    @name = gets.chomp.to_s
    @symbol = symbol
  end
end

loop do
  jeu = Game.new  #on initié le tableau et les joueurs
  until jeu.c_fini  #la boucle verifie la condition et en meme temps l'applique! Une ligne de sauvé !! Pfiou
    jeu.board.puts_plateau  # affiche le plateau et son etat
    jeu.next_turn   
  end
  print "\npeut etre une autre partie ? o/n\n: "
  (gets.chomp.to_s == "o") ? next : break
end

