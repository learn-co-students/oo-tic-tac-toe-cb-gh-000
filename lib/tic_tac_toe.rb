
class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2], #Top row
    [3, 4, 5], #Middle row
    [6, 7, 8], #Bottom row
    [0, 4, 8], # left to right Diagonal
    [2, 4, 6], #right to left diagonal
    [0, 3, 6], #left column
    [1, 4, 7], #center column
    [2, 5, 8] #right column
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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

  def move(index, value = "X")
    @board[index] = value
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0,8) && position_taken?(index) != true
      return true
    end
    return false
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board()
    else
      turn()
    end
  end

  def turn_count
    count = 0
    @board.each do |square|
      if square == "X" || square == "O"
        count += 1
      end
    end
    return count
  end

  def current_player
    if turn_count() % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      if combination.all?{|index|  @board[index] == "X"} || combination.all?{|index| @board[index] == "O"}
        return combination
      end
    end
    return false
  end

  def full?
    @board.all?{|space| (space == "X" || space == "O")}
  end

  def draw?
    result = false
    if won?()
      result = false
    elsif full?()
      result = true
    else
      result = false
    end
  end

  def over?()
    full?() || draw?() || won?()
  end

  def winner
    result = nil
    won_result = won?()
    if over?()
      if won_result
        if (won_result.all?{|index| @board[index] == "X"})
          result = "X"
        else
          result = "O"
        end
      end
    end
    return result
  end

  def play
    until over?
      turn
    end
    message = winner
    if won?
      puts "Congratulations #{message}!"
    else
      puts "Cat's Game!"
    end
  end

end
