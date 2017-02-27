class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left Column
    [1,4,7], # Middle Column
    [2,5,8], # Right Column
    [0,4,8], # Diagonal 1
    [2,4,6], # Diagonal 2
    # ETC, an array for each win combination
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input = input.to_i
    index = input - 1
    return index
  end

  def move(index, character = "X")
    @board[index] = character
    return @board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if position_taken?(index) == true
      return false
    elsif index.between?(0, 8) == false
      return false
    else
      return true
    end
  end

  def turn_count
    counter = 0;
    @board.each do | move |
      if move == "X" || move == "O"
        counter += 1
      end
    end
    return counter
  end

  def current_player
    turnMove = turn_count
    return turnMove.even? ? "X" : "O"
  end

  def turn
    #get input
    puts "Please enter 1-9:"
    input = gets.strip

    #convert input to index
    index = input_to_index(input)

    if valid_move?(index)
      move(index, character = current_player)
      display_board
    else
      turn
    end
  end

  def won?
    # if the array is empty return false
    if @board.length == 0
      return false
    elsif
      #for each win_combination in WIN_COMBINATIONS
      WIN_COMBINATIONS.each do | win_combination |
        # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
        # grab each index from the win_combination that composes a win.
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = @board[win_index_1] # load the value of the board at win_index_1
        position_2 = @board[win_index_2] # load the value of the board at win_index_2
        position_3 = @board[win_index_3] # load the value of the board at win_index_3

        if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
          return win_combination # return the win_combination indexes that won.
        end
      end
    else
      return false
    end
  end

  def full?
    return !@board.any?{|i| i == " "}
  end

  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over?
    if won? || draw? || full?
      return true
    else
      return false
    end
  end

  def winner
    numberOfXs = @board.select{|i| i == "X"}
    numberOfOs = @board.select{|i| i == "O"}

    if numberOfXs.length > numberOfOs.length
      return "X"
    elsif numberOfXs.length < numberOfOs.length
      return "O"
    else
      return nil
    end
  end

  def play
    while !over?
      turn
    end

    if won?
      if winner == "X"
        puts "Congratulations X!"
      elsif winner == "O"
        puts "Congratulations O!"
      end
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
