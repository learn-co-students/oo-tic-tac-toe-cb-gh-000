class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  # all possible combinations that can produce a win
  WIN_COMBINATIONS = [
    [0,1,2], # top row
    [3,4,5], # middle row
    [6,7,8], # bottom row
    [0,3,6], # left column
    [1,4,7], # center column
    [2,5,8], # right column
    [0,4,8], # left diagonal
    [2,4,6] # right diagonal
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # convert text input to index(int) to reference board array
  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, character = "X")
    @board[index] = character
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    !position_taken?(index) && (index >= 0 && index <= 8)
  end

  def turn_count
    turns = 0;
    @board.each do | cell |
      if cell == "X" || cell == "O"
        turns += 1
      end
    end
    turns
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  # ask user where to go and validate
  # if valid make move and display board
  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    until valid_move?(index)
      puts "Please enter 1-9:"
      index = input_to_index(gets.strip)
    end
    move(index, current_player)
    display_board
  end

  def won?
    WIN_COMBINATIONS.detect do | combination |
      combination.all? {|index| @board[index] == "X"} || combination.all? {|index| @board[index] == "O"}
    end
  end

  def full?
    @board.all? {|pos| !(pos.nil? || pos == " ")}
  end

  # returns true if the board is full but has not been won
  # returns false if the board has been won
  def draw?
    !won? && full?
  end

  def over?
    won? || draw? || full?
  end

  # if the game has been won, returns the winner
  def winner
    if won?
      winning_row = won?
      winner = @board[winning_row[0]]
    else
      nil
    end
  end

  def play
    until over? do
      turn
    end
    if winner == "X"
      puts "Congratulations X!"
    elsif winner == "O"
      puts "Congratulations O!"
    else
      puts "Cat's Game!"
    end
  end

end # def class TicTacToe
