class TicTacToe

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

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

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, char)
    @board[index] = char
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    index < 9 && index > -1 && !position_taken?(index)
  end

  def turn_count
    9 - @board.count(" ")
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def turn
    puts "Enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    loop do
      if !valid_move?(index)
        puts "Enter 1-9:"
        user_input = gets.strip
        index = input_to_index(user_input)
        next
      end
      break
    end
    move(index, current_player())
    display_board
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if combo.all? { |index| @board[index] == "X" } || combo.all? { |index| @board[index] == "O" }
        return combo
      end
    end
    return false
  end

  def full?
    @board.all? { |char| char != " "}
  end

  def draw?
    full? && won? == false
  end

  def over?
    draw? || won? != false
  end

  def winner
    if won? != false
      return @board[won?[0]]
    end
    nil
  end

  # Play Spec

  def play
    until over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end

end
