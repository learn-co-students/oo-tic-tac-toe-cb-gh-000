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

  # Helper Methods
def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(index, token = "X")
  @board[index] = token
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index, current_player())
    display_board()
  else
    turn()
  end
end

def turn_count
  counter = 0
  @board.each do |element|
    if element == "X" || element == "O"
      counter += 1
    end

  end

return counter

end


def current_player
  if turn_count().even?
    return "X"
  else
    return "O"
  end

end


def won?
 WIN_COMBINATIONS.detect do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]

  position_1 = @board[win_index_1] # load the value of the board at win_index_1
  position_2 = @board[win_index_2] # load the value of the board at win_index_2
  position_3 = @board[win_index_3] # load the value of the board at win_index_3

 (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")

end
end

def full?
  @board.all? do |board_index|
    (board_index == "X") || (board_index == "O")
end
end

def draw?
    if (full?() && !won?())
      true
    elsif !won?() == false
      false
    else
      false
    end
end

def over?
if (won?() || draw?() || full?())
      true
  else
      false

end
end

def winner
  if won?()
    won?().each do |winning_index|
      if (@board[winning_index] == "X")
        return "X"
      elsif (@board[winning_index] == "O")
        return "O"
      else
        return false
      end
    end
  end

end

def play
  until over?()
turn()
end

if won?()
  puts "Congratulations #{ winner() }!"
elsif draw?()
  puts "Cat's Game!"
else
  false

end


end



end
