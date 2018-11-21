class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0, 1, 2], # Top row
    [3, 4, 5], # Middle row
    [6, 7, 8], # Bottom row
    [0, 3, 6], # Left column
    [1, 4, 7], # Middle column
    [2, 5, 8], # Right column
    [0, 4, 8],
    [2, 4, 6]
  ]

  # with in the boardclass define display_board
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # take user_input and convert it to an Integer and subtracts 1, 1 argument string
  def input_to_index(input)
    return input.to_i - 1
  end

  # 3 arguments board, index, value
  def move(index, value)
    @board[index] = value
  end

  # evaluating the position selected and checking to see whether pos occupied
  def position_taken?(index)
    if @board[index] == nil or @board[index] == "" or @board[index] == " "
      return false
    elsif @board[index] == "X" or @board[index] == "O"
      return true
    end
  end

  # check the submitted position is present on the game board and not already filled
  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.count{|token| token == "X" or token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  # encapsulate the logic of a single complete turn
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      value = current_player
      move(index, value)
      display_board
    else
      turn
    end
  end

  # return false if there is no win combination present or the winning combination
  def won?
    i = 0
    while i < 9
      if @board[WIN_COMBINATIONS[i][0]] == "X" and @board[WIN_COMBINATIONS[i][1]] == "X" and @board[WIN_COMBINATIONS[i][2]] == "X"
        return WIN_COMBINATIONS[i]
      elsif @board[WIN_COMBINATIONS[i][0]] == "O" and @board[WIN_COMBINATIONS[i][1]] == "O" and @board[WIN_COMBINATIONS[i][2]] == "O"
        return WIN_COMBINATIONS[i]
      end
      i += 1
    end
  rescue NoMethodError
    return false
  end

  # check whether every element in the board contains X or O
  def full?
    return @board.all?{|pos| pos == "X" or pos == "O"}
  end

  # check whether it can be drawn
  def draw?
    if not won?
      return full?
    else
      return false
    end
  end

  # check whether game over
  def over?
    if won? or draw? or full?
      return true
    else
      return false
    end
  end

  # check winner
  def winner
    if over?
      i = 0
      while i < 9
        if @board[WIN_COMBINATIONS[i][0]] == "X" and @board[WIN_COMBINATIONS[i][1]] == "X" and @board[WIN_COMBINATIONS[i][2]] == "X"
          return "X"
        elsif @board[WIN_COMBINATIONS[i][0]] == "O" and @board[WIN_COMBINATIONS[i][1]] == "O" and @board[WIN_COMBINATIONS[i][2]] == "O"
          return "O"
        end
        i += 1
      end
    end
  end

  # play method
  def play
    until over?
      turn
    end
    if won?
      w = winner
      if w == "X"
        puts "Congratulations X!"
      elsif w == "O"
        puts "Congratulations O!"
      end
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
