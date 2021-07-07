class TicTacToe

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # left-right diagonal
  [6,4,2]  # right-left diagonal
  ]


def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(index,current_player)
  @board[index] = current_player
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  @index = input_to_index(input)
  if valid_move?(@index)
    move(@index,current_player)
    display_board
  else
    turn
  end
end

def play

  until over?
    turn
  end

  if won?
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end
end

#..............#
#Helper Methods#
#..............#


def won?

  WIN_COMBINATIONS.detect do |win|
    position_taken?(win[0]) && (@board[win[0]] == @board[win[1]] && @board[win[1]] == @board[win[2]])
  end
end

def full?
  @board.all?{|index| index == "X" || index == "O"}
end

def draw?
  !won? && full?
end

def over?
  won? || draw? || full?
end

def winner
  if over?
    @board[won?[0]]
  end
end


def turn_count
  counter = 0
  @board.each do |position|
    if (position == "X" || position == "O")
      counter += 1
    end
  end
  counter
end

def current_player
  turn_count.even? ? "X" : "O"
end

def position_taken?(index)
  !(@board[index].nil? || @board[index] == " " || @board[index] == "")
end

end #class
