class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # row wins
    [3,4,5],
    [6,7,8],
    [0,3,6], # column wins
    [1,4,7],
    [2,5,8],
    [0,4,8], # horizontal wins
    [2,4,6]
  ]

  def initialize
    @board = Array.new(9," ")
  end


  # Define display_board that accepts a board and prints
  # out the current state.
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

  def move(position, player= "X")
    @board[position] = player
  end

  def position_taken? (index)
    @board[index] != " " && @board[index] != "" && @board[index] != nil
  end

  def valid_move?(index)
    index.between?(0,8)  && !position_taken?(index)
  end

  def turn_count
    turns = 0
    @board.each do |pos|
      if pos == "X" || pos == "O"
        turns += 1
      end
    end
    return turns
  end

  def current_player
    turns = turn_count
    turns & 1 == 1 ? "O" : "X"
  end

  def turn
    # Get position of move
    puts "Please enter 1-9:"
    input = gets.strip

    # Correct the index
    index = input_to_index(input)

    if valid_move?(index)
      # make the move
      move(index, current_player)

      # display board after move
      display_board
    else
      turn
    end
  end

  def won?
    # initalise win status
    win_status = nil

    WIN_COMBINATIONS.each do |win_combination|
      # check if all positions are occupied
      win_positions_occupied = win_combination.all?{|position| position_taken?(position)}

      if win_positions_occupied
        # identify player
        player = @board[win_combination[0]]

        # check if all positions are occupied by player
        if win_combination.all?{|position| @board[position] == player}
          win_status = win_combination
          break
        end
      end
    end
    win_status
  end

  def full?
    @board.none?{|position| position == " " }
  end

  def draw?
    !won? && full?
  end

  def over?
    draw? || won?
  end

  def winner
    win_status = won?
    if win_status != nil
      return @board[win_status[0]]
    end
    return nil
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
