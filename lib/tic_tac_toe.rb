# Object-Oriented Tic Tac Toe
class TicTacToe # class starts
  def initialize
    @board = Array.new(9, " ")
  end

  # Nested Array of each Win combination
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

  # Current board representation
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # Converts string user input to board array index
  def input_to_index(user_input)
    user_input.to_i - 1
  end

  # Move the token 'X' or 'O' to user-specified board position
  def move(index, current_player = "X")
    @board[index] = current_player
  end

  # Checks for empty board positions
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  # Checks if the user's move is valid
  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  # Enacts a single complete turn
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

  # Counts the total #turns played
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  # Determines the player at the beginning of each turn_count
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  # Processes a win combination array
  def won?
    board_empty = @board.all? {|element| element == " "}
    result_array = false
    if board_empty
      return false
    else
      WIN_COMBINATIONS.each do |win_combination|
        winning_positions_taken = position_taken?(win_combination[0]) &&
                                position_taken?(win_combination[1]) &&
                                position_taken?(win_combination[2])

        if winning_positions_taken
          # All Xs
          all_Xs = (@board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X")

          # All Os
          all_Os = (@board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O")

          if all_Xs || all_Os
            result_array = win_combination
            # break
          end
        end
      end
    end
    return result_array
  end # end won?

  # Checks if board is full
  def full?
    return !@board.include?(" ")
  end

  # Checks if game is a tie
  def draw?
    !won? && full?
  end

  # Checks if game is over
  def over?
    if won? || full? || draw?
      return true
    end
  end

  # Evaluates the moves, and confirms the winner
  def winner
    if won?
      return @board[won?[0]]
    end
  end

  # The main method which simulates the complete game
  def play
    until over?
      if turn_count < 10
        turn
      end
    end
    if won?
      puts "Congratulations #{winner}!"
      # break
    elsif draw?
      puts "Cat's Game!"
    end
  end

end # class ends here
