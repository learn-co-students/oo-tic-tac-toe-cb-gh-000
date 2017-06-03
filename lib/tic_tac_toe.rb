class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
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

  def move(index, value)
    @board[index] = value
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    input = input_to_index(input)
    if valid_move?(input)
      move(input, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count = 0
    @board.each do |space|
      if space == "X" || space == "O"
        count += 1
      end
    end
    count
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.find { |win_combination|
      @board[win_combination[0]] == "X" &&
      @board[win_combination[1]] == "X" &&
      @board[win_combination[2]] == "X" ||
      @board[win_combination[0]] == "O" &&
      @board[win_combination[1]] == "O" &&
      @board[win_combination[2]] == "O"
    }
  end

  def full?
    @board.all? { |space| space == "X" || space == "O" } ? true : false
  end


  def draw?
    !won? && full? ? true : false
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    won? ? @board[won?[0]] : nil
  end

  def play
    until over? do
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
