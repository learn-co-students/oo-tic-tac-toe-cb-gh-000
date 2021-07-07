class TicTacToe
  def initialize(board=nil)
   @board = board || Array.new(9, " ")
  end
  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],[3,4,5],
    [6,7,8],[0,3,6],
    [1,4,7],[2,5,8],
    [0,4,8],[2,4,6]
  ]

  def display_board
    puts " #{@board[0]} " + "|" + " #{@board[1]} " + "|" + " #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} " + "|" + " #{@board[4]} " + "|" + " #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} " + "|" + " #{@board[7]} " + "|" + " #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, value)
    @board[index] = value
  end

  # re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O" ? true : false
  end

  # code your #valid_move? method here
  def valid_move?(index)
    !position_taken?(index) && index.between?(0, 8) ? true : false
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if !valid_move?(index)
      turn
    else
      move(index, current_player)
    end
    display_board
  end

  def turn_count
    i = 0
    @board.each do |boards|
      i += 1 if boards != " "
    end
    i
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
       @board[combo[0]] == @board[combo[1]] &&
       @board[combo[1]] == @board[combo[2]] &&
       position_taken?(combo[0])
     end
  end

  def full?
    !@board.include?(" ")
  end

  def draw?
    !won? && full?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    if won?
      @board[won?[0]]
    end
  end

  def play
    while !over?
      turn
    end
    if won?
       puts "Congratulations #{winner}!"
     elsif draw?
       puts "Cat\'s Game!"
     end
  end
end
