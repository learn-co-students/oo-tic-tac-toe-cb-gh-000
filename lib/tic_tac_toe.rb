class TicTacToe
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(i)
    return i.to_i - 1
  end
  def move(i, t="X")
    @board[i] = t
  end
  def position_taken?(i)
    @board[i] != " " && @board[i] != ""
  end
  def valid_move?(i)
    i.between?(0,8) && !position_taken?(i)
  end
  def won?
    WIN_COMBINATIONS.any? do |e|
      if e.all? {|i| @board[i] == "X"} || e.all? {|i| @board[i] == "O"}
        return e
      end
    end
  end
  def full?
    return @board.all? {|e| e == "X" || e == "O"}
  end
  def draw?
    return !won? && full?
  end
  def over?
    return won? || draw? || full?
  end
  def winner
    return won? ? @board[won?[0]] : nil
  end
  def turn_count
    t = 0
    @board.each {|e| t += !e || e.strip == "" ? 0 : 1}
    return t
  end
  def current_player
    return turn_count % 2 == 0 ? "X" : "O"
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