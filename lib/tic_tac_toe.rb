class TicTacToe
  def initialize(board = Array.new(9," "))
    @board = board
  end
 WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
 def display_board
   puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
 end

 def input_to_index(input)
   index = input.to_i
   index = index - 1
   return index
 end

 def move(index , token ="X")
   @board[index] = token
 end

 def position_taken?(index)
   if @board[index] == "X" || @board[index] == "O"
     return true
   else
     return false
   end
 end

 def valid_move?(index)
   if index < 0 || index > 8
     return false
   end
   if position_taken?(index)
     return false
  end
   return true
 end

 def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index, current_player)
    display_board
  else
    turn
  end
end

def current_player
end

def turn_count
  count = 0
  @board.each do |i|
    if i != " "
      count += 1
  end
end
  return count
end

def current_player
  if turn_count % 2 == 0
    return "X"
  end
  if turn_count % 2 != 0
    return "O"
  end
end

def won?
  WIN_COMBINATIONS.each do |win_combo|
    index1 = win_combo[0]
    index2 = win_combo[1]
    index3 = win_combo[2]
    if @board[index1] == "X" && @board[index2] == "X" && @board[index3] == "X"
      return win_combo
    end
    if @board[index1] == "O" && @board[index2] == "O" && @board[index3] == "O"
      return win_combo
    end
  end
  else
return false
end


def full?
  if @board.all?{|i| i == "X" || i == "O"}
    return true
  else
    return false
  end
end

def draw?
  if !(won?) && full?
    return true
  else
    return false
  end
end


def over?
  if won?
    return true
  end
  if full?
    return true
  end
  return false
end

def winner
  if !(won?)
    return nil
  end

  if won?
    return @board[won?[0]]
  else
    return nil
  end
end

def play
  until over? || draw?
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  end
  if draw?
    puts "Cat's Game!"
  end
end

end
