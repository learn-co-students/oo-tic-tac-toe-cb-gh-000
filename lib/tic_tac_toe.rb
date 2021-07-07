class TicTacToe
  def initialize
    @board = Array.new(9, " ")
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
  def won?
    WIN_COMBINATIONS.each do |combo|
      pos1 = combo[0]
      pos2 = combo[1]
      pos3 = combo[2]

      el1 = @board[pos1]
      el2 = @board[pos2]
      el3 = @board[pos3]

      if (el1 == "X" && el2 == "X" && el3 == "X")
        return combo
      elsif (el1 == "O" && el2 == "O" && el3 == "O")
        return combo
      else
        false
      end
    end
    false
  end


  def full?
    @board.each do |el|
      if (el == " ")
        return false
      end
    end
    return true
  end

  def draw?
    return (!won? && full?)
  end

  def over?
    return won? || draw?
  end

  def winner
    if won?
      arr = won?
      pos = arr[0]
      return @board[pos]
    else
      return nil
    end
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

def position_taken?(location)
  @board[location] != " " && @board[location] != ""
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn
  valid = false
  player = current_player
  while (!valid)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    valid = valid_move?(index)
  end
  move(index, player)
  display_board
end

def turn_count
  counter = 0
  @board.each do |el|
    if (el == " ")
      counter += 1
    end
  end
  return 9-counter
end

def current_player
  player = turn_count
  player = player % 2
  if player == 1
    return "O"
  else
    return "X"
  end
end

def play
  done = false
  while (!done) do
    turn
    done = over?
  end
  if (won?)
    win = winner
    puts "Congratulations #{win}!"
  else
    puts "Cats Game!"
  end
end


end
