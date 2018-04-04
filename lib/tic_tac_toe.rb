class TicTacToe
  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]
  def initialize
    @board=[" "," "," "," "," "," "," "," "," "]
  end

  # Helper Method

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
]


def input_to_index(user_input)
  user_input.to_i - 1
end

def move( index, current_player)
  @board[index] = current_player
end

def position_taken?(location)
  @board[location] != " " && @board[location] != ""
end

def valid_move?( index)
  index.between?(0,8) && !position_taken?(index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?( index)
    move(index,current_player)
    display_board
  else
    turn
  end
end

def turn_count
  @board.count{|token| token == "X" || token == "O"}
end


def current_player
  turn_count % 2 == 0 ? "X" : "O"
end

def won?
  WIN_COMBINATIONS.each do |combination|
      if (@board[combination[0]]=="O" && @board[combination[1]]=="O" && @board[combination[2]]=="O") ||
         (@board[combination[0]]=="X" && @board[combination[1]]=="X" && @board[combination[2]]=="X")
          return combination
      end
    end
    return false
  end

def full?
  index=0
  while index<9
    if !position_taken?(index)
      return false
    end
    index +=1
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
  if won?||draw?||full?
    return true
  else
    return false
  end
end

def winner
  array=won?
  if array!=false
    return @board[array[0]]
  else
    return nil
  end
end

def play()
  flag=over?
  if won?
    winnerName=winner
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  else
    puts "Where would you like to go?"
    input = gets
    index=input_to_index(input)
    if valid_move?(index)
      move(index,current_player)
      display_board
      flag=over?
        if won?
          winnerName=winner
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        else
          play
        end
      end


  end
end


end
