class TicTacToe

  def initialize(board = nil)
    @board = board || @board = Array.new(9, " ")
    puts "Welcome to Tic Tac Toe"
  end

  WIN_COMBINATIONS = [
    [0,1,2],  # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row

    [0,3,6],  # Left column
    [1,4,7],  # Middle column
    [2,5,8],  # Right column

    [0,4,8],  # Diagnol 1
    [6,4,2]   # Diagnol 2
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i
    index = index - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    if @board[index] == "" ||
      @board[index] == " " ||
      @board[index] == nil
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if index.between?(0,8) && !position_taken?(index)
      return true
    else
      return false
    end
  end

  def turn
    puts "Please Enter a number: 1 - 9"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      token = current_player
      move(index, token)
      display_board
    else
      puts "Invalid move! Please Try Again"
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |turn|
      if turn == "X" || turn == "O"
        counter += 1
      end
    end
    return counter
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index1 = win_combination[0]
      win_index2 = win_combination[1]
      win_index3 = win_combination[2]

      position1 = @board[win_index1]
      position2 = @board[win_index2]
      position3 = @board[win_index3]

      if (position1 == "X" && position2 == "X" && position3 == "X") ||
        (position1 == "O" && position2 == "O" && position3 == "O")
        return [win_index1, win_index2, win_index3]
      end
    end
    return false
  end

  def full?
    @board.none? do |turn|
      turn == "" || turn == " "
    end
  end

  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over?
    if won? || draw?
      return true
    else
      return false
    end
  end

  def winner
    if won?
      return @board[won?[0]]
    else
      return nil
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
