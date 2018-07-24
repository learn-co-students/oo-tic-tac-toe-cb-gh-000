class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4 ,6]
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def play
    until over? || draw? || won? do
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, current_symbol)
    @board[index] = current_symbol
  end

  def position_taken?(index)
     !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(position)
    !position_taken?(position) && position.between?(0, 8)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if !valid_move?(index)
      puts "invalid"
      turn
    else
      move(index, current_player)
      display_board
    end
  end

  def turn_count
    turns = @board.select do |symbol|
      symbol == "X" || symbol == "O"
    end
    return turns.length
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    combo = WIN_COMBINATIONS.select do |combination|
      start = @board[combination[0]]
      combination.none?{|index| !position_taken?(index) || @board[index] != start}
    end
    combo == [] ? false : combo[0]
  end

  def full?
    !@board.any?{|symbol| symbol == "" || symbol == " "}
  end

  def draw?
    if full? && !won?
      return true
    end
    return false
  end

  def over?
    full? || won? ? true : false
  end

  def winner
    !won? ? nil : @board[won?[0]]
  end
end
