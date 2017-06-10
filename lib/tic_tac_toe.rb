class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # First col
    [1,4,7], # Second col
    [2,5,8], # Third col
    [0,4,8], # Diagonal from upper left
    [2,4,6], # Diagonal from upper right
  ]
  def initialize
    @board = Array.new(9, " ")
  end
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(ind_str)
    ind_str.to_i - 1
  end
  def move(ind, player_char="X")
    @board[ind] = player_char
  end
  def position_taken?(ind)
    @board[ind] == "X" || @board[ind] == "O"
  end
  def valid_move?(ind)
    (ind >= 0 && ind < 9) && !position_taken?(ind)
  end
  def ask_input
    puts "Please enter 1-9:"
    input = gets.strip
    input_to_index(input)
  end
  def turn
    index = ask_input()
    while !valid_move?(index)
      index = ask_input()
    end
    move(index, current_player)
    display_board()
  end
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  def turn_count
    turns = 0
    @board.each do |move|
      if move == "X" || move == "O"
        turns += 1
      end
    end
    turns
  end
  def won?
    WIN_COMBINATIONS.each do |comb|
      ind_one, ind_two, ind_three = comb
      if ["X", "O"].include?(@board[ind_one]) &&
        (@board[ind_one] == @board[ind_two] && @board[ind_two] == @board[ind_three])
        return comb
      end
    end
    false
  end
  def full?
    @board.all? do |move|
      move == "X" || move == "O"
    end
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    indexes = won?()
    if indexes
      return @board[indexes[0]]
    end
  end
  def play
    while !over?()
      turn()
    end
    won_player = winner()
    if won_player
      puts "Congratulations #{won_player}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
