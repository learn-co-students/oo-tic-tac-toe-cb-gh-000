class TicTacToe
  def initialize()
    @board = Array.new(9, ' ')
  end

  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(index, data)
  @board[index] = data
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def valid_move?(index)
  if index >= 0
    if @board[index] && !position_taken?(index)
      return true
    else
      return false
    end
  else
    return false
  end
end

def turn
  display_board
  puts 'Please enter 1-9:'
  user_input = gets.strip()
  index = input_to_index(user_input)

  if valid_move?(index) == true
    move(index, current_player)
    display_board
  else
    turn
  end
end

def turn_count
  counter = 0

  @board.each do |i|
    if (i == "X" || i == "O")
      counter += 1
    end
  end

  return counter
end

def current_player
  if turn_count == 0
    return 'X'
  elsif turn_count % 2 == 0
    return 'X'
  else
    return 'O'
  end
end

def won?
  WIN_COMBINATIONS.find do |i|
    @board[i[0]] == @board[i[1]] && @board[i[0]] == @board[i[2]] && position_taken?(i[1])
  end
end

def full?
  if @board.any? { |e| e == '' || e == ' ' || e == nil }
    return false
  else
    return true
  end
end

def draw?
  if !won? && full?
    return true
  else
    return false
  end
end

def over?
  if won? || full? || draw?
    return true
  else
    return false
  end
end

def winner
  if won?
    won_token = won?
    return @board[won_token[0]]
  else
    return nil
  end
end

def play
  until over? do
    turn
  end

  if winner == 'X'
    puts 'Congratulations X!'
  elsif winner == 'O'
    puts 'Congratulations O!'
  elsif draw?
    puts "Cat's Game!"
  end
end

end
