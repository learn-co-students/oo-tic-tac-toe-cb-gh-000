class TicTacToe

  # Winning piece placements
  WIN_COMBINATIONS = [
    # Horizontal
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    # Vertical
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    # Diagonal
    [0, 4, 8],
    [6, 4, 2],
  ]

  # Create new game instance
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "] # Create blank board state
  end

  # Print board with grid
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # Convert string position to board index
  def input_to_index(input)
    return input.to_i - 1
  end

  # Place piece on desired position of board
  def move(position, piece)
    @board[position] = piece
  end

  # Check if position is already taken
  def position_taken?(position)
    return (@board[position] == "X" || @board[position] == "O")
  end

  # Check if prospective move is valid
  def valid_move?(position)
    if position < 0 || position > 8
      return false
    else
      return !position_taken?(position)
    end
  end

  # Simulate a turn of TicTacToe
  def turn
    print "Pick a move 1-9: "
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  # Get amount of turns finished
  def turn_count
    return @board.count {|piece| piece == "X" || piece == "O"}
  end

  # Using turn count to determine current player
  def current_player
    return turn_count % 2 == 0 ? "X" : "O"
  end

  # Specify the details of a win or just no win
  def won?
    WIN_COMBINATIONS.each do |wincomb|
      data = [@board[wincomb[0]], @board[wincomb[1]], @board[wincomb[2]]]
      if data.uniq.size == 1 && (data[0] == "X" || data[0] == "O")
        return wincomb
      end
    end
    return
  end

  # Returns true if board is full of pieces
  def full?
    return turn_count == 9
  end

  # Returns if draw game has occured
  def draw?
    if won?
      return false
    else
      return full?
    end
  end

  # Returns if game is over
  def over?
    return won? || full? || draw?
  end

  # Returns who won given a winning board
  def winner
    win = won?
    if win
      return @board[win[0]]
    else
      return
    end
  end

  # Simulate game loop
  def play
    puts "Welcome to Tic Tac Toe!"
    display_board

    # Have players take turns until the game is over
    until over?
      turn
    end

    # If won or draw(else)
    if won?
      puts "Congratulations " + winner + "!"
    else
      puts "Cat's Game!"
    end

  end

end
