class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],  # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [0,3,6],  # Left row
    [1,4,7],  # Center row
    [2,5,8],  # Right row
    [0,4,8],  # First diagonal
    [2,4,6]   # Second diagonal
  ]

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

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, character = "X")
    @board[index] = character
  end

  def position_taken? (index)
    @board[index] != " " && @board[index] != "" && !!@board[index]
  end

  def valid_move? (index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board()
    else
      turn()
    end
  end

  def turn_count
    @board.select { |position| position == "X" || position == "O" }.size
  end

  def current_player
    turn_count() % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      moves = combination.collect { |position| @board[position] }.join
      if moves == "XXX" || moves == "OOO"
        return combination
      end
    end
    false
  end

  def full?
    !@board.any? { |value| value.nil? || value == "" || value == " " }
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw? || full?
  end

  def winner
    combination = won?
    if combination
      @board[combination[0]]
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

end
