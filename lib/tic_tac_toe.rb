class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  WIN_COMBINATIONS = [
    [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
  ]
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(user_input)
    "#{user_input}".to_i - 1
  end
  def move(index,value)
    @board[index] = "#{value}"
    display_board
  end
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if position_taken?(index) == true
      false
    elsif index > 9 || index < 0
      false
    else
      true
    end
  end
  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip.to_i

    index = input_to_index(user_input)

    if valid_move?(index)
      move(index, current_player)
    else
      puts "Please enter 1-9:"
      user_input = gets.strip.to_i
    end
  end
  def turn_count
  @board.count { |x| x != " " }
end

def current_player
  turn_count % 2 == 0 ? "X" : "O"
end

def won?
    win_combinations = []
    i = 0
  while i < WIN_COMBINATIONS.length do
      win_combinations = WIN_COMBINATIONS[i]
    position_1 = @board[win_combinations[0]]
    position_2 = @board[win_combinations[1]]
    position_3 = @board[win_combinations[2]]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combinations
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combinations
    else
        false
    end
    i += 1
  end
end
def full?
  if @board.include?(" ")
    false
  else
    true
  end
end

def draw?
  if won? || full? == false
    false
  else
    true
  end
end

def over?
  if won? || draw? || full?
    true
  end
end

def winner
  if won?
    win_combination = won?
    return @board[win_combination[0]]
  else
    nil
  end
end
def play
  until over?
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
end
end
