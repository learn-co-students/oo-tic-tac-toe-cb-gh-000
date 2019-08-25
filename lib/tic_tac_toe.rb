class TicTacToe

  def initialize
    @board = Array.new(9, " ")
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

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def position_taken?(index)
    return @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    if index >= 0 && index < 9
      return !position_taken?(index)
    else return nil end
  end

  def move(index, value = "X")
    @board[index] = value
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Invalid input."
      turn
    end
  end

  def turn_count
    count = 0
    @board.each do |tile|
      if tile == "X" || tile == "O"
        count += 1
      end
    end
    return count
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else return "O" end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      index1 = win_combination[0]
      index2 = win_combination[1]
      index3 = win_combination[2]

      if (@board[index1] == "X" && @board[index2] == "X" && @board[index3] == "X") || (@board[index1] == "O" && @board[index2] == "O" && @board[index3] == "O")
        return win_combination
      end
    end

    return nil
  end

  def full?
    i = 0
    while i < @board.length
      if !position_taken?(i)
        return false
      end
      i += 1
    end
    return true
  end

  def draw?
    return full? && !won?
  end

  def over?
    return full? || won? || draw?
  end

  def winner
    winning_tiles = won?
    if winning_tiles == nil
      return nil
    end
    if @board[winning_tiles[0]] == "X"
      return "X"
    elsif @board[winning_tiles[0]] == "O"
      return "O"
    end
  end

  def play
    puts "Welcome to Tic Tac Toe!"
    display_board
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
