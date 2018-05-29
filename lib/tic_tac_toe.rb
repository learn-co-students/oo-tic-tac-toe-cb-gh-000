

class TicTacToe
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

  def valid_move?(index)
    if index >= 0 && index <= 8
      if position_taken?(index) == false
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      return false
    else
      return true
    end
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, char)
    @board[index] = char
  end

  def turn_count
    count = 0
    @board.each do |element|
      if element == "X" || element == "O"
        count += 1
      end
    end
    return count
  end

  def turn
    loop do
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      if valid_move?(index) == true
        move(index, current_player)
        display_board
        break
      end
    end
  end

  def won?
    TicTacToe::WIN_COMBINATIONS.each do |combination|
      if ( @board[combination[0]] == "X" && @board[combination[1]] == "X" && @board[combination[2]] == "X" ) || ( @board[combination[0]] == "O" && @board[combination[1]] == "O" && @board[combination[2]] == "O" )
        return combination
      end
    end
    return false
  end

  def win?(char = "X")
      TicTacToe::WIN_COMBINATIONS.each do |combination|
        if @board[combination[0]] == char && @board[combination[1]] == char && @board[combination[2]] == char
          return combination
        end
      end
      return false
  end

  def full?
    !@board.any?{|element| element == " " || element == "" || element == nil}
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won? || full?
  end

  def winner
    if win?("X")
      return "X"
    elsif win?("O")
      return "O"
    else
      return nil
    end
  end

  def play
    until over? do
      turn
    end
    if won?
      # congratulation message
      puts "Congratulations #{winner}!"
    elsif draw?
      # message of draw
      puts "Cat's Game!"
    end
  end

  WIN_COMBINATIONS =
  [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
  ]

end
