class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

  def position_taken?(index)
    !(@board[index] == "" || @board[index] == " " || @board[index].nil?)
  end

  def won?
  WIN_COMBINATIONS.find do |combination|
    win_index1 = combination[0]
    win_index2 = combination[1]
    win_index3 = combination[2]
    pos1 = @board[win_index1]
    pos2 = @board[win_index2]
    pos3 = @board[win_index3]
    if pos1 == "X" && pos2 == "X" && pos3 == "X" || pos1 == "O" && pos2 == "O" && pos3 == "O"
      return combination
    else
      false
    end
  end
end

def full?
  i = 0
  while i < 9
    if !position_taken?(i)
      return false
    end
    i += 1
  end
  return true
end

def draw?
  !won? && full?
end

def over?
  won? || full? || draw?
end

def winner
  if won?
    combination = won?
    index = combination[0]
    position = @board[index]
    if position == "X"
      return "X"
    else
      return "O"
    end
  else
    return nil
  end
end

def valid_move?(index, ch)
  if !position_taken?(index) && index.between?(-1, 9)
    true
  else
    false
  end
end

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(input)
  if input.to_i == 0
    return -1
  else
    return Integer(input) - 1
  end
end

def move(index, ch)
  @board[index.to_i] = ch
end

def valid_move?(index)
  if position_taken?(index) == false && index >= 0 && index <= 8
    return true
  else
    return false
  end
end

def turn_count
  count = 0
  for i in 0..8
    if position_taken?(i)
      count += 1
    end
  end
  return count
end

def current_player
  if turn_count % 2 == 0
    return "X"
  else
    return "O"
  end
end


def turn
  ch = current_player
  moved = false
  while moved == false
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index, ch)
    display_board
    moved = true
  else
    puts "Invalid input, try again: "
  end
end
end

def play
  until over? do
    turn
  end

  if won?
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end
end

end
