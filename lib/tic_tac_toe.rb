# TicTacToe - game class for tic-tac-toe
#
# WIN_COMBINATIONS -  constant holding the 8 winning configurations for
#                     tic-tac-toe
# SEPARATOR -         row separator for board display
# @board -            board to store the game state of TicTacToe
#
# initialize - read in an initial board state
# => board -          the initial board state

# display_board - write the board to the CLI

# input_to_index - convert input to a board spaces
# => input -          user input as a string "1"-"9"
# <= integer          integer conversion of the input
#
# move -              writes a move to the board
# => index -          index of the space to make a move
# => token -          symbol to place on the board, (default: "X")
#
# position_taken? - tests to see if a position is occupied
# => index -          index of the position to check
# <= boolean          true if the position is occupied, false otherwise
#
# valid_move? - checks a position and determines if the move is valid_move
# => index -          the space to check for validity
# <= boolean          true if the position is present on the game board and
#                     not already filled, false otherwise
## turn_count - Determine the number of turns that have been played by
#                     referencing the @board variable
# <= integer          the number of turns that have been played
#
# current player - Determines which player's turn it is
# <= string           "X" or "O" as appropriate
#
# turn - logical method to execute a turn of tic-tac-toe
# 1) Asks the user to specify a position in the range 1-9.
# 2) Receives the user's input.
# 3) Translate the input into an index value.
# 4) If the move is valid, make the move and display the board.
# 5) If the move is invalid, ask for a new move until a valid move is received.
#

# won? - determines if a winning combination has been reached
# <= array(integer)   array of integers corresponding to a winning combination
# <= nil              if no winning combination is present
#
# full? - determine if the board has no open spaces
# <= boolean          true if the board is completely filled, false otherwise
#
# draw? - determine if the game is drawn.
# <= boolean          true if the board is full and no winning combination is
#                     present, false otherwise.
#
# over? - determine if the game is over
# <= boolean          true if the board contains a winning combination or if
#                     the board is drawn, false otherwise
#
# winner - determine who the winner is
# <= string           'X' or 'O' depending who the winner is
#
# play - executes the game loop and process
# 1) Until the game is over, loop turns.
# 2)  If the game hase been won, or the game is a draw, write a string to the
#     CLI reporting the outcome of the game.
class TicTacToe
    WIN_COMBINATIONS = [  # row cominations
                        [0,1,2],
                        [3,4,5],
                        [6,7,8],
                        # column combinations
                        [0,3,6],
                        [1,4,7],
                        [2,5,8],
                        # diagonal combinations
                        [0,4,8],
                        [2,4,6]]
    SEPARATOR = "-----------"

    def initialize
      board = []
      9.times{board << " "}
      @board = board
    end

    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts SEPARATOR
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts SEPARATOR
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
      index = input.to_i
      index -= 1
      return index
    end

    def move(index, token)
      @board[index] = token
    end

    def position_taken?(index)
      return !( @board[index] == ' '  ||
                @board[index] == ''   ||
                @board[index] == nil)
    end

    def valid_move?(index)
      if index < 0 || index > 8
        return false
      end

      return !position_taken?(index)
    end

    def turn_count
      count = 0

      @board.each do |space|
        if space == 'X' || space == 'O'
          count += 1
        end
      end

      return count
    end

    def current_player
      return (turn_count % 2 == 0) ? 'X' : 'O'
    end

    def turn
      index = -1
      loop do
        puts "Please enter 1-9:"
        input = gets.strip()
        index = input_to_index(input)
        if valid_move?(index) == true
          break
        end
      end

      move(index, current_player)
      display_board
    end

    def won?
      x_spaces = (0..8).select{|idx| @board[idx] == 'X'}
      o_spaces = (0..8).select{|idx| @board[idx] == 'O'}

      WIN_COMBINATIONS.each do |win|
        if  win & x_spaces == win ||
            win & o_spaces == win
            return win
        end
      end

      return nil
    end

    def full?
      return @board.all?{|space| space == 'X' || space == 'O'}
    end

    def draw?
      win = won?
      return win == nil && full? == true
    end

    def over?
      return won? != nil || draw?
    end

    def winner
      win = won?

      if win != nil
        return @board[win[0]]
      end

      return nil
    end

    def play
      until over?
        turn
      end
      token = winner
      if token == nil
        puts "Cat's Game!"
      else
        puts "Congratulations #{token}!"
      end
    end
end
