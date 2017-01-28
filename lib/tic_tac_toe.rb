class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end
WIN_COMBINATIONS = [
  [0,1,2],
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [3,4,5],
  [6,7,8]
]

def won?
  WIN_COMBINATIONS.each do |combination|
    if @board[combination[0]] == "X" && @board[combination[1]] == "X" && @board[combination[2]] == "X"
      return combination
    end
    if @board[combination[0]] == "O" && @board[combination[1]] == "O" && @board[combination[2]] == "O"
      return combination
    end
  end
  return false
end

def full?
  @board.each do |elem|
    return false if elem == " "
  end
  return true
end

def draw?
  if !won? && full?
    return true
  else
    return false
  end
end

def over?
  if won?
    return true
  elsif draw?
    return true
  else
    return false
  end
end

def winner
    win_status = won?
    if win_status
      return @board[win_status[0]]
    else return nil
    end
  end

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

def position_taken?(location)
  @board[location] != " " && @board[location] != ""
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn_count
  count = 0
  @board.each do |elem|
    if elem == "X" || elem == "O"
      count += 1
    end
  end
  return count
end
  
def current_player
  cur_turn = turn_count()
  if cur_turn % 2 == 0
    return "X"
  else
    return "O"
  end
end

def move(index, player)
  @board[index] = player
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index, current_player())
    display_board
  else
    turn()
  end
end

def play
  9.times do
    if over?
      pl_winner = winner()
      if pl_winner == nil
        puts "Cat's Game!"
      elsif pl_winner == "X"
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    else
      turn()
    end
  end
end

end