
class Boardcase
  attr_accessor :value

  def initialize
    @value = ""
  end
end

class Board
  attr_accessor :plateau

  def initialize
    @plateau = []
    3.times do | y |
      @plateau[y] = Hash.new
      3.times do | x |
        @plateau[y][:"#{x}"] = Boardcase.new
      end
    end
  end

  def puts_plateau
    3.times do | y |
      print "\n"
      unless y == 0 then print "---+---+---\n" end
      3.times do | x |
        char = "\s"
        unless @plateau[y][:"#{x}"].value == "" then char = @plateau[y][:"#{x}"].value end
        print "\s#{char}\s"
        if x < 2 then print "|" end 
      end
    end
    print "\n\n"
  end

  def check_plateau
    3.times do | nb | 
      unless  plateau[nb][:"0"].value == ""
        if  plateau[nb][:"0"].value ==  plateau[nb][:"1"].value && plateau[nb][:"0"].value == plateau[nb][:"2"].value 
          return  plateau[nb][:"0"].value
        end
      end
    end
    3.times do | nb | 
      unless  plateau[0][:"#{nb}"].value == ""
        if plateau[0][:"#{nb}"].value == plateau[1][:"#{nb}"].value && plateau[0][:"#{nb}"].value == plateau[2][:"#{nb}"].value
          return  plateau[0][:"#{nb}"].value
        end
      end
    end
    unless plateau[1][:"1"].value == ""
      if  plateau[0][:"0"].value == plateau[1][:"1"].value && plateau[1][:"1"].value == plateau[2][:"2"].value
        return plateau[1][:"1"].value
      end
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
    @player[0] = Player.new("O")
    @player[1] = Player.new("X")
    @board = Board.new
    @play = 0
  end

  def next_turn
    @play == 0 ? @play +=1 : @play -=1
    joueur = player[@play]
    tu_vas_jouer_oui?(joueur)
  end

  def tu_vas_jouer_oui?(joueur)
    while true
    line = 0
    column = 0
      while line < 1 || line > 3
        print "#{joueur.name} choisis la ligne où tu veux jouer\n"
        line = gets.chomp.to_i
      end
      line -=1
      while column < 1 || column > 3
        print "#{joueur.name} choisis la colonne où tu veux jouer\n"
        column = gets.chomp.to_i
      end
      column -=1
      if board.plateau[line][:"#{column}"].value == ""
        board.plateau[line][:"#{column}"].value = joueur.symbol
        break
      else
        puts "HaHAHAGHAHAAHAHAHAAhahahahahahahaHAHHAAHHAhahAHAh"
        puts "Tres marrant ça"
        puts "La case etait déjà prise, t'es repartis pour un tour couillon\n\n"
      end
    end
  end

  def c_fini
    victoire = board.check_plateau
    if victoire != ""
      board.puts_plateau
      puts "/!\-------------------/!\ "
      puts "#{player[play].name} à gagné ! Bravo a lui, il a vaincu l'autre gros naze"
      puts "/!\-------------------/!\ "
      true
    else
      false
    end
  end
end

class Player
  attr_accessor :name, :symbol
  @@all = 0

  def initialize(symbol)
    if @@all == 0
    print "\nrentre ici ton nom : "
    else
      print "\nBravo, ton 1er adversaire a rentré son nom"
      print "\n\nA l'autre joueurs de le faire : "
    end
    @name = gets.chomp.to_s
    @symbol = symbol
    @@all +=1

  end
end

jeu = Game.new
until jeu.c_fini
  jeu.board.puts_plateau
  jeu.next_turn
end

