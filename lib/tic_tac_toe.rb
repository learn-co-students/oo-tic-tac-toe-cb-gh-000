class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2], # H1
    [3,4,5], # H2
    [6,7,8], # H3
    [0,3,6], # V1
    [1,4,7], # V2
    [2,5,8], # V3
    [0,4,8], # D1
    [6,4,2]  # D2
  ]

  def initialize(board = nil)
    # Initialize new board
    @board = board || Array.new(9, " ")
  end

  def current_player
    # Returns current player value based on turns
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    # Counts turns based on current tokens in play
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    # Displays from board array
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, value="X")
    @board[index] = value
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0, 8)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    # Iterate through win condition array for X and O
    WIN_COMBINATIONS.each do |win_combination|
      # For each potential win combination, iterate and check if
      # all indices of combination are filled by all X or all O
      winning_x = win_combination.all? do |index|
        @board[index].include?("X")
      end
      winning_o = win_combination.all? do |index|
        @board[index].include?("O")
      end
      # Return winning combination from array as soon as matching
      # X or O combination is found
      if winning_x
        return win_combination
      elsif winning_o
        return win_combination
      end
    end
    # If no win conditions are met, return false
    false
  end

  def full?
    @board.all? do |i|
      i == "X" || i == "O"
    end
  end

  def draw?
    (!won? && full?)
  end

  def over?
    won? || draw? || full?
  end

  def winner
    winning_combo = won?
    if won?
       @board[winning_combo[0]]
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
