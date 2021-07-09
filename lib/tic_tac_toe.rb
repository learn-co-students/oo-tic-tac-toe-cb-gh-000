class TicTacToe

def initialize
  @board = [' ',' ',' ',' ',' ',' ',' ',' ',' ',]
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom Row
  [0,3,6], # First column
  [1,4,7],  # Second column
  [2,5,8],  # Third column
  [0,4,8],  # First diagonal
  [2,4,6]  # Second diagonal
]

def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(user_input)
  user_input = user_input.to_i
  index = user_input - 1
  return index
end

def move(index, token='X')
  @board[index] = token
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def valid_move?(index)
  !position_taken?(index) && index.between?(0,8)
end

def turn_count
  counter = 0
  @board.each do |space|
    if space == 'X' || space == 'O'
      counter += 1
    end
  end
  return counter
end

def current_player
  if turn_count % 2 == 0
    current_player = 'X'
  else
    current_player = 'O'
  end
  return current_player
end

def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
    else
      turn
    end
    display_board
end

def check_win_combination?(player, win_combo)
  win_combo.all? do |position|
    @board[position] == player
  end
end

def won?
  WIN_COMBINATIONS.each do |win_combo|
    if check_win_combination?('X', win_combo)
      return win_combo
    elsif check_win_combination?('O', win_combo)
      return win_combo
    end
  end
    return false
end

def full?
  if @board.include?(' ') || @board.include?('')
    return false
  else
    return true
  end
end

def draw?
  if !won? && full?
    return true
  end
end

def over?
  if won? || draw? || full?
    return true
  else
    return false
  end
end

def winner
  if !won?
    return nil
  else WIN_COMBINATIONS.each do |win_combo|
    if check_win_combination?('X', win_combo)
      return 'X'
    elsif check_win_combination?('O', win_combo)
      return 'O'
    end
  end
end
end

def play
  while !over? do
    turn
  end
  if won?
    @winner = winner
    puts "Congratulations " + @winner + "!"
  elsif draw?
    puts "Cat's Game!"
  else
    return nil
  end
end

end
