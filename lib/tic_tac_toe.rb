class TicTacToe
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
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

  def input_to_index(input)
    index = input.to_i
    index - 1
  end

  def move(index, character = "X")
    @board[index] = character
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    !(index > 8 || index < 0) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.chomp
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |win_index|
      position_1 = position_taken?(win_index[0]) ? @board[win_index[0]] : 1
      position_2 = position_taken?(win_index[1]) ? @board[win_index[1]] : 3
      position_3 = position_taken?(win_index[2]) ? @board[win_index[2]] : 1
      position_1 == position_2 && position_2 == position_3
    end
  end

  def full?
    @board.all? do |square|
      square == "X" || square == "O"
    end
  end

  def draw?
    (!won? && full?)
  end

  def over?
    won? || full? || draw?
  end

  def winner
    if over? && !draw?
      return @board[won?[0]]
    end
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
