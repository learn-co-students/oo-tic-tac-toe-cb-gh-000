class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    return user_input.to_i - 1
  end

  def move(position, char = "X")
    @board[position] = char
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0, 8)
      !position_taken?(index)
    else
      return false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    if !valid_move?(index)
      turn
    end
    move(index, current_player)
    display_board
  end

  def turn_count
    @board.count{|position| position == "X" || position == "O"}
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def won?
    WIN_COMBINATIONS.each do |win_index|
      if win_index.all?{|pos| @board[pos] == "X"} || win_index.all?{|pos| @board[pos] == "O"}
        return win_index
      end
    end
    return false
  end

  def full?
    @board.all?{|position| position == "X" || position == "O"}
  end

  def draw?
    !won? && full?
  end

  def over?
    draw? || won?
  end

  def winner
    winner = ""
    if won?
      return @board[won?[0]]
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end