class TicTacToe
  WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  def initialize
    @board = Array.new(9," ")
  end
  def display_board
    puts " "+@board[0]+" | "+@board[1]+" | "+@board[2]+" "
    puts "-----------"
    puts " "+@board[3]+" | "+@board[4]+" | "+@board[5]+" "
    puts "-----------"
    puts " "+@board[6]+" | "+@board[7]+" | "+@board[8]+" "
  end
  def input_to_index(index)
    pos = index.to_i - 1
    return pos
  end
  def move(index,token="X")
    turn = current_player
    @board[index]=turn
  end
  def position_taken?(index)
    if @board[index] == " "
      return false
    else
      return true
    end
  end
  def valid_move?(pos)
    if pos >= 0 && pos < 9
      x = true
    else
      x = false
    end
    return x && !position_taken?(pos)
  end
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
  def turn
    puts "Please enter 1-9:"
    x = gets.chomp
    x = input_to_index(x)
    truth = valid_move?(x)
    if truth
      move(x)
      display_board
    else
      turn
    end
  end
  def won?
    WIN_COMBINATIONS.each do |(a,b,c)|
      x = @board[a]
      y = @board[b]
      z = @board[c]
      if x == y && y == z && z != " "
        return Array([a,b,c])
      end
    end
    return false
  end
  def full?
    !@board.include?(" ")
  end
  def draw?
    return full? && !won?
  end
  def over?
    return won? || full?
  end
  def winner
    x = won?
    x ? @board[x[0]] : nil
  end
end
