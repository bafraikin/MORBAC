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

    if line
    end

    if column
    end

    if diago
    end

  end
end

class Game
  attr_accessor :player, :board, :turn

  def initialize
    @player = []
    @player[0] = Player.new("O")
    @player[1] = Player.new("X")
    @board = Board.new
    @turn = 0
  end

  def next_turn
    @turn +=1

  end

end


class Player
  attr_accessor :name, :symbol
  def initialize(symbol)
    @name = gets.chomp.to_s
    @symbol = symbol
  end
end

coucou.board.puts_plateau
coucou.board.plateau[0][:"0"].value = "X"
coucou.board.plateau[1][:"1"].value = "X"
coucou.board.plateau[2][:"2"].value = "X"
coucou.board.puts_plateau


