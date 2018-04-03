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

def initialize
  @board = Array.new(9, " ")
end

def display_board()
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(index, value = "X")
  @board[index] = value
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def valid_move?(input)
  if input < 0 || input > 8
    return false
  end
  if position_taken?(input)
    return false
  end
  return true
end

def turn()
  turn_validity = true
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

def turn_count()
  count = 0
  @board.each do |i|
    if (i != " ")
      count += 1
    end
  end
  return count
end

def current_player()
  count = turn_count()
  if (count % 2) == 0
    return "X"
  else
    return "O"
  end
end

def won?()
  WIN_COMBINATIONS.each do |y|
    win_index_1 = y[0]
    win_index_2 = y[1]
    win_index_3 = y[2]

    position_1 = @board[win_index_1]
    position_2 = @board[win_index_2]
    position_3 = @board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return y
    elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return y
    end
  end
  return nil
end

def full?()
  @board.none? do |i|
    i == " "
  end
end

def draw?()
  if (!won?() && full?())
    return true
  else
    return false
  end
end

def over?()
  if (won?() || full?() || draw?())
    return true
  else
    return false
  end
end

def winner()
  if draw?()
    return nil
  end

  win_pos = won?()
  if !win_pos
    return nil
  end
  winner = @board[win_pos[1]]
end

def play()
  while !over?() do
    turn()
  end

  win = winner()

  if win == nil
    puts "Cat's Game!"
  else
    puts "Congratulations #{win}!"
  end
end

end
