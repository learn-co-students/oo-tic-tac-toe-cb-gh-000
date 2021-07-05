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
  @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

end

def display_board
  puts" #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts" #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts" #{@board[6]} | #{@board[7]} | #{@board[8]} "
end



def input_to_index(index_as_string)
  return (index_as_string.to_i ) -1
end


def move(index, x_or_o="X")
  @board[index]=x_or_o
end



def position_taken?(index)
  @board[index] == "X" || @board[index] == "O"
end


def valid_move?(index)
  if index< 0 || index> 8
    return false
  else
    return !(position_taken?(index))
  end
end


def turn
  puts "Please enter 1-9:"
  index=input_to_index(gets.strip)
  if valid_move?(index)
    move(index, current_player())
    display_board()
  else
    turn()
end
end



def turn_count
  turns_completed=0
  @board.each do |name|
    if name== "X" || name=="O"
    turns_completed += 1
  end
end
return turns_completed

end




def current_player
  turns=turn_count()
  return turns.even? ? "X" : "O"
end





def won?
  WIN_COMBINATIONS.each do |win_combination|
   index_1=win_combination[0]
   index_2=win_combination[1]
   index_3=win_combination[2]

   position_1 = @board[index_1]
   position_2 = @board[index_2]
   position_3 = @board[index_3]
   if position_1 == "X" && position_2 == "X" && position_3 == "X"
     return win_combination # return the win_combination indexes that won.
   elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
       return win_combination # return the win_combination indexes that won.
   end
 end
 return false
 end


 def full?
   chars_only= @board.select{|el| el == "X" || el=="O" }
   if chars_only.length == 9
     return true
  else
    return false
  end
end



def draw?
  if won?() == false && full?()
    return true
  else
    return false
  end
end

def over?()
  return won?()!= false || draw?() || full?()
end


def winner()
  outcome= won?()
  if outcome==false
    return nil
  else
    return @board[outcome[0]]
end
end




def play()
  until over?()==true
    turn()
  end
  if winner()!= nil
    char = winner()
    puts "Congratulations #{char}!"


end
puts "Cat's Game!"
end

end
