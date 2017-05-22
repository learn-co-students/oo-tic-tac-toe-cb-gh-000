class TicTacToe
  WIN_COMBINATIONS = [
    [0,4,8],
    [6,4,2],
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]

def initialize
  @board = [" "," "," "," "," "," "," "," "," "]
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

def move(index, current_player)
  @board[index] = current_player
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def valid_move?(index)
  return index.between?(0,8) && !position_taken?(index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index,current_player)
    display_board
  else
    turn
  end
end

def turn_count
  counter = 0
  @board.each do |symbol|
    if symbol == "X" || symbol == "O"
       counter += 1
    end
  end
  return counter

end

def current_player
if turn_count % 2 == 0
return "X"
elsif turn_count % 2 == 1
return "O"
end
end

def won?
  WIN_COMBINATIONS.detect do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

   position_1 = @board[win_index_1] # load the value of the board at win_index_1
   position_2 = @board[win_index_2] # load the value of the board at win_index_2
   position_3 = @board[win_index_3] # load the value of the board at win_index_3

    if position_taken?(win_index_1) && position_taken?(win_index_2) && position_taken?(win_index_3)
        if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
          return win_combination # return the win_combination indexes that won.
        else
          return false
        end
      end
  end
end

def full?
  @board.any? do |index|
     " " || "" || false
    end
    return !@board.any?{|i| i == " "}
  end

def draw?
   if !won? && full?
     return true
   elsif !won? && !full?
     return false
   elsif won? && full?
      return false
    end
  end

  def over?
    if won? || full? && draw?
      return true
      else
      return false
        end
  end
#============================================
  def winner

    if won?
      if @board[won?[0]] == "O"
        return "O"
      else
        return "X"
      end
    else
      return nil
    end

  end
  # Define your play method below
  def play
  until over? || won? || draw?
    turn
  end
if won?
    puts "Congratulations"
elsif draw?
    puts "Cat's Game!"
  end
  end

#---------------
end
