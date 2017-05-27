class TicTacToe

 WIN_COMBINATIONS = [
   [0, 1, 2],
   [3, 4, 5],
   [6, 7, 8],

   [0, 3, 6],
   [1, 4, 7],
   [2, 5, 8],

   [0, 4, 8],
   [2, 4, 6]
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

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, playerChar = "X")
    @board[index] = playerChar
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

  def turn_count
    @board.count { |c| c != " " }
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      if combo.all? { |i| @board[i] == "X" } || combo.all? { |i| @board[i] == "O" }
        return combo
      end
    end
  end

  def full?
    @board.all? { |c| c == "X" || c == "O" }
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    !won? ? nil :
    won?.all? { |i| @board[i] == "X" } ? "X" :
    won?.all? { |i| @board[i] == "O" } ? "O" : nil
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif
      puts "Cat's Game!"
    end
  end

end
