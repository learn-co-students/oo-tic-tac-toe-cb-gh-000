class TicTacToe
  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Middle row
    [0,3,6],  # Middle row
    [1,4,7],  # Middle row
    [2,5,8],  # Middle row
    [0,4,8],  # Middle row
    [6,4,2],  # Middle row
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def full?
    @board.detect{|i| i == " "} == nil
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    if won?
      @board[won?[0]]
    end
  end

  def won?
    counter = -1
    until counter == WIN_COMBINATIONS.size - 1
      counter += 1
      if  @board[WIN_COMBINATIONS[counter][0]] == "X" && @board[WIN_COMBINATIONS[counter][1]] == "X" && @board[WIN_COMBINATIONS[counter][2]] == "X" ||
        @board[WIN_COMBINATIONS[counter][0]] == "O" && @board[WIN_COMBINATIONS[counter][1]] == "O" && @board[WIN_COMBINATIONS[counter][2]] == "O"
        return WIN_COMBINATIONS[counter] # return the win_combination indexes that won.
      end
    end
    return false
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
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

  def turn(current_player)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn(current_player)
    end
  end

  # Define your play method below
  def play
    while !over?
      puts "Current Player: #{current_player}"
      turn(current_player)
    end
    if winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end
