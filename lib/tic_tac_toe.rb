class TicTacToe
def initialize(board = nil)
@board = board || Array.new(9, " ")
end

def display_board
puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
puts "-----------"
puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
puts "-----------"
puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

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

def input_to_index(input)
input.to_i - 1
end

def position_taken?(index)
!(@board[index] == " " ||@board[index] == "" || @board[index] == nil)
end

def move (index, player_token)
  @board[index] = player_token
  return @board
end

def valid_move?(index)
  if index.between?(0, 8)
   return !(position_taken?(index))
  end
  return false
end


def turn_count
@board.count {|token| token == "O" || token == "X"}
end

def current_player
((turn_count) -1).even?  ? curr_player = "O" : curr_player = "X"
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
  move(index, current_player)
else
  puts "invalid"
  turn
end
  display_board
end

def won?
WIN_COMBINATIONS.each do |checked_position|
  positions = checked_position.select {|index| position_taken?(index)}
  if positions.count == 3
  if (@board [positions[0]] == @board [positions[1]]) && (@board [positions[0]] == @board [positions[2]])
    return positions
  end
  end
end
return false
end

def full?
@board.all? {|element| element == "X" || element == "O"}
end

def draw?
if (!won?) && full?
puts "Cat's Game!"
return true
end
end

def over?
won? || draw?|| full?
end

def winner
if positions = won?
  return @board[positions[0]]
end
end


def play
  puts "Welcome to Tic Tac Toe!"
  display_board
  turns = 0
  while turns < 9 do
  if over?
    break
  end
  turn
  turns += 1
end
if possible_winner = winner
puts "Congratulations #{possible_winner}!"
else
puts "It has been a draw"
end
end
end
