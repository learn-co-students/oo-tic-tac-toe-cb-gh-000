class TicTacToe
  def initialize(board = nil)
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [0, 3, 6],
    [0, 4, 8],
    [1, 4, 7],
    [2, 5, 8],
    [3, 4, 5],
    [6, 4, 2],
    [6, 7, 8]
  ]

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def won?
    WIN_COMBINATIONS.detect do |combination|
      combination.all? do |index|
        position_taken?(index) && @board[index] == @board[combination[0]]
      end
    end
  end

  def full?
    @board.all? do |total|
      total == "X" || total == "O"
    end
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def winner
    if won?
      @board[won?[0]]
    end
  end

  def turn_count
    turns = 0
    @board.each do |turn|
      if turn == "X" || turn == "O"
        turns += 1
      end
    end
    turns
  end

  def current_player
    turn_count = turn_count()
    turn_count.even? ? "X" : "O"
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    current_player = current_player()

    if valid_move?(index)
      move(index, current_player)
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
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
