class TicTacToe
	WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]

	def initialize(board = nil)
		@board = board || Array.new(9," ")
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

	def move(index, current_player)
	  @board[index] = current_player
	end

	def position_taken?(location)
	  @board[location] != " " && @board[location] != ""
	end

	def valid_move?(index)
	  index.between?(0,8) && !position_taken?(index)
	end

	# Array -> number
	# Returns the number of occupied places in the Array

	def turn_count
		count = 0
		@board.each do |cell|
			if (cell == "X" || cell == "O")
				count += 1
			end
		end
		count
	end

	# Array -> String
	# Determines wheteher it is X's move or O's move

	def current_player
		count = turn_count
		count % 2 == 0 ? "X" : "O"
	end

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

	def play
	  while !over?
	    turn
	  end
	  if won?
	    puts "Congratulations #{winner}!"
	  elsif draw?
	    puts "Cat's Game!"
	  end
	end


	# Array -> Array
	# Determines if the game is won be any of the players

	def won?
	  WIN_COMBINATIONS.detect do |combo|
	    @board[combo[0]] == @board[combo[1]] &&
	    @board[combo[1]] == @board[combo[2]] &&
	    position_taken?(combo[0])
	  end
	end

	# Array -> Boolean
	# Returns True if the board array is full, false otherwise

	def full?
	  @board.all?{|token| token == "X" || token == "O"}
	end

	# Array -> Boolean
	# Returns true if the board has not been won and is full and false if the board is not won and the board is not full

	def draw?
	   !won? && full?
	end

	# Array -> Boolean
	# Determines if the game is over

	def over?
	  won? || draw?
	end

	# Array -> String
	# Returns the winner of the game if there is one

	def winner
	  if won?
	    return @board[won?[0]]
	  else
	    nil
	  end
	end

end
