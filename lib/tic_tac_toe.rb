class TicTacToe
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(str)
  num = str.to_i
  num-1
  end

  def move(index, value)
    @board[index] = value
  end

  #  #position_taken? method here
  def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
  end
  # #valid_move? method here
  def valid_move?(index)
    if(index.between?(0,8) && !position_taken?(index))
      return true
    else
      return false
    end
  end

  # #turn method here:
def turn
  puts "Please enter 1-9:"
  val = gets.strip
  index  = input_to_index(val)

  if(valid_move?(index)==true)
    move(index, current_player)
    display_board
  else
    turn
  end
end

# #turn_count method here:
def turn_count
  count=0
  @board.each {|mark|
    if(mark == "X"|| mark == "O")
      count = count+1
    end
  }
  count
end

  # #current_player method here:
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  # which combination won the game:
def won?
  i = 0
  WIN_COMBINATIONS.each{|win_combination|
    if @board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X"
      i +=1
      return win_combination
    elsif @board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O"
      i +=1
      return win_combination
    end
  }
  if i == 0
    return false
  end
end
# is the board full?
def full?
if @board.include?(" ")
  return false
else
  return true
end
end

#Is it a draw?
def draw?
if(full? == true && won? == false )
  return true
else
  return false
end
end

#Is the game over?
def over?
if(draw? || won?)
  return true
else
  return false
end
end

#who is the winner
  def winner
  i = 0
  WIN_COMBINATIONS.each{|win_combination|
    if @board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X"
      i +=1
      return "X"
    elsif @board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O"
      i +=1
      return "O"
    end
  }
  if i == 0
    return nil
  end
  end

#The play method is the main method of the tic tac toe application and is responsible for the game loop.
  def play
    until over?
      turn
  end
  if (won?)
    puts "Congratulations #{winner}!"
  elsif(draw? == true)
    puts "Cat's Game!"
  end
end

end
