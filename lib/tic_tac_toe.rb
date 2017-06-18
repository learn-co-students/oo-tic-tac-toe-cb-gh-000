class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]

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

  def move(index, current)
    @board[index] = current
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index , current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |element|
      counter += 1 if (element== "X" || element == "O")
    end
    return counter
  end

  def current_player
    turn_count % 2 == 0 ? ?X : ?O
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      one = @board[combo[0]]
      two = @board[combo[1]]
      three = @board[combo[2]]
      return combo if ((one == "X" && two == "X" && three == "X") || (one == "O" && two == "O" && three == "O"))
    end
    false
  end

  def full?
    @board.all? { |e|  e == "X" || e == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    combo = won?
    combo ? @board[combo[0]] : nil
  end

  def play
    until over?
      turn
    end
    if winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
