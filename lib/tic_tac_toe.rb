# Helper Method
class TicTacToe
  def initialize()
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
end

def turn_count
  @board.count{|x|x=="X"||x=="O"}
end

def current_player
  i = turn_count
  i % 2 == 0 ? "X" : "O"
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

def move(index, token)
  @board[index] = token
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?( index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move( index, current_player)
    display_board
  else
    turn
  end
end

# Define your play method below
def play
  until over?
    puts "your turn"
    turn
  end
  if winner == "X"
    puts"Congratulations X!"
  elsif winner == "O"
    puts"Congratulations O!"
  else puts "Cat's Game!"
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8], # Down row

  [0,3,6], #1st column
  [1,4,7], #2nd column
  [2,5,8], #3d column

  [0,4,8], #horizontal 1
  [2,4,6] #horizontal 1
]
def won?
  a = []
  b = []
for i in 0..8 do
  if  @board[i] == "X"
    a<<i
  elsif @board[i] == "O"
    b<<i
  end
end


WIN_COMBINATIONS.each do |ar|
   if (ar - a).empty?
     return ar
   elsif (ar - b).empty?
     return ar
   end
  end
  return false
end

def full?
  a = []
  b = []
  for i in 0..8 do
    if  @board[i] == "X"
      a<<i
    elsif @board[i] == "O"
      b<<i
    end
  end
  return true if (a + b).length == 9
  return false
end

def draw?
  !won? && full?
end

def over?
  full? || !!won? || draw?
end

def winner
  x = won?
  if !x
    return nil
  end
  @board[won?[0]]
end
end
