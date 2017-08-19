class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], # Bottom row
    [0,3,6],  # left columns
    [1,4,7],  # middle columns
    [2,5,8],  # right columns
    [0,4,8],  # diagonals 1
    [2,4,6],  # diagonals 2
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    num = input.to_i
    num = num-1
  end

  def move(index, character = "X")
    @board[index] = character
  end

  def position_taken?(index)

    taken = nil
    if (@board[index] ==  " " || @board[index] == "" || @board[index] == nil)
      taken = false
    else
     taken = true
    end
    taken
  end

  def valid_move?(index)
    validity = nil
    if position_taken?(index)
      validity = false
    elsif !(index.between?(0,8))
      validity = false
    else
      validity = true
    end
  end

  def turn
    puts "Please enter a number (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      token = current_player
      move(index, token)
    else
      turn
    end
    display_board
  end

  def turn_count
    counter = 0
    @board.each do |element|
      if element == "X" || element == "O"
        counter += 1
      end
    end
    counter
  end

  def current_player
    turnn = nil
    value = turn_count
    if value.even?
      turnn = "X"
    else
      turnn = "O"
    end
    turnn
  end

  def won?
    status = nil
    WIN_COMBINATIONS.detect do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        status = win_combination # return the win_combination indexes that won.
      else
        status = false
      end
    end
    return status
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
    won? || draw?
  end

  def winner
    if combo = won?
      @board[combo[0]]
    end
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end
