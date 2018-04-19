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
  attr_accessor :player, :board, :turn, :play


  def initialize
    @player = []
    @player[0] = Player.new("O")
    @player[1] = Player.new("X")
    @board = Board.new
    @turn = 0
    @play = 0
  end

  def next_turn
    line = 0
    column = 0
    while line < 1 || line > 3
      print "choisis la ligne où tu veux jouer\n"
      line = gets.chomps.to_i
    end
    line -=1
    while column < 1 || column > 3
      print "choisis la colonne où tu veux jouer\n"
      column = gets.chomps.to_i
    end
    column -=1
   @play == 0 ? @play +=1 : @play -=1
   @plateau.check_plateau != "" ? "" : "" 
     @turn += 1
  end

  def c_gagne(symbol)
  end
end


class Player
  attr_accessor :name, :symbol

  def initialize(symbol)
    print "\nrentre ici ton nom : "
    @name = gets.chomp.to_s
    @symbol = symbol
  end
end

coucou = Game.new
coucou.board.puts_plateau

