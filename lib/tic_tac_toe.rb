class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], #WIN_COMBINATIONS [0] Top Row Win
    [3,4,5], #WIN_COMBINATIONS [1] Middle Row Win
    [6,7,8], #WIN_COMBINATIONS [2] Bottom Row Win
    [2,4,6], #WIN_COMBINATIONS [3] Top Right Diagonal to Bottom Left Win
    [0,4,8], #WIN_COMBINATIONS [4] Top Left Diagonal to Bottom Right Win
    [0,3,6], #WIN_COMBINATIONS [5] Left Horizontal Win
    [1,4,7], #WIN_COMBINATIONS [6] Middle Horizontal Win
    [2,5,8]  #WIN_COMBINATIONS [7] Right Horizontal Win
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    index.to_i - 1
  end

  def move (index, value)
  @board[index] = value
  end

  def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0,8) && !position_taken?(index)
      true
    else
      false
    end
  end

  def turn
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
    value = current_player
    if valid_move?(index)
      move(index, value)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|value| value == "X" || value == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

def won?
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = @board[win_index_1]
    position_2 = @board[win_index_2]
    position_3 = @board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
       false
    end
  end
   false
end

def full?
  if @board.any? { |position| position == "" || position == " " || position == nil }
     false
  else
     true
  end
end

def draw?
  if !won? && full?
    puts "Cat's Game!"
    true
  else
     false
  end
end

def over?
  if won? || full? || draw?
     true
  else
     false
  end
end

def winner
  if win_combination = won?
    @board[win_combination.first]
  end
end

def play
  until over?
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  else draw?
    puts "Cat's Game!"
  end
end
end
