class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
    display_board
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

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def full?
    @board.all? do |token|
      token == "X" || token == "O"
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw? || full?
  end

  def won?
    WIN_COMBINATIONS.detect do |group|
      win_index_1 = group[0]
      win_index_2 = group[1]
      win_index_3 = group[2]
      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
      (position_1 == "O" && position_2 == "O" && position_3 == "O")
    end
  end

  def winner
    if won?
      combo = won?
      @board[combo[0]]
    else
      return nil
    end
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    while !valid_move?(index)
      puts "Invalid move. Try again."
      input = gets.chomp
      index = input_to_index(input)
    end
    move(index,current_player)
    display_board
  end

  def play
    while !over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    elsif winner != nil
      puts "Congratulations #{winner}!"
    end
  end
end
