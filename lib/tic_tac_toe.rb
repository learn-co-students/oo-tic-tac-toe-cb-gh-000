class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
]

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} |"
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} |"
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} |"
end

def input_to_index(number)
  if number.is_a? Integer
    return number
  else
    return number.to_i - 1
  end
end

def move(index, token = "X")
  @board[index] = token
end

def position_taken?(index)
  if @board[index] == "" || @board[index] == " " || @board[index] == nil
    return false
  else
    return true
  end
end

def valid_move?(index)
  if(position_taken?(index) == false && index.between?(0,8))
    return true
  else
    return false
  end
end

def turn
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(index)
    player = current_player
    move(index, player)
    display_board
  else
    turn
  end
end

def won?
  result = false
  WIN_COMBINATIONS.each do |combo|
      if @board[combo[0]] == "X" && @board[combo[1]] == "X" && @board[combo[2]] == "X"
        result = [combo[0], combo[1], combo[2]]
      elsif @board[combo[0]] == "O" && @board[combo[1]] == "O" && @board[combo[2]] == "O"
        result = [combo[0], combo[1], combo[2]]
      end
  end
  return result
end

def full?
  full_board = @board.all? do |number|
     number != " " && number != "" && number != nil
  end
  return full_board
end

def draw?
  won = won?
  isFull = full?
  if won == false && isFull == true
    return true
  elsif won != false && isFull == false
    return false
  elsif won == false && isFull == false
    return false
  end
end

def over?
  if draw? || full? || won? != false
    return true
  else
    return false
  end
end

def winner
  token = won?
  if token != false
    return @board[token[0]]
  else
    return nil
  end
end

def turn_count
  count = 0
  @board.each do |num|
    if num == "X" || num == "O"
      count += 1
    end
  end
  return count
end

def current_player
  player = turn_count
  if player > 0 && player.odd?
    return "O"
  else
    return "X"
  end
end

def play
  while over? != true do
    turn
  end

  if winner != nil
    boss = winner
    if boss == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  else
    puts "Cat's Game!"
  end
end
end
