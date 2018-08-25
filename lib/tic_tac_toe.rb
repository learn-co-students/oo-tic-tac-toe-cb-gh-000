class TicTacToe
  def initialize(board = nil)
    @board = Array.new(9, " ")
    display_board
  end
  WIN_COMBINATIONS = [
  #rows
  [0,1,2], [3,4,5], [6,7,8],
  #columns
  [0,3,6], [1,4,7], [2,5,8],
  #diagonals
  [0,4,8], [2,4,6]
  ]
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(user_input)
  @index = user_input.to_i - 1
  end
  def move(index, value = "X")
    @board[index] = value
  end
  def position_taken?(index)
  @board[index] != " " && @board[index] != "" && @board[index] != nil
  end
  def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
  end
  def turn
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  valid_move?(index) ? move(index, current_player) && display_board : turn
  end
  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  def won?
  WIN_COMBINATIONS.each do |win_combination|
      if ( @board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X" || @board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O" )
        return win_combination
      end
    end
      return false
    end
    def full?
      if @board.any?{|empty| empty == "" || empty == " " || empty == nil }
        false
      else
        true
      end
    end
    def draw?
      won? ? (return false) : ()
      full? ? (return true) : (false)
    end
    def over?
      full? || draw?|| won?
    end
    def winner
      won? ? (return "#{@board[won?[0]]}") : ()
    end
    def play
      until over?
        turn
      end
      message = winner
      if won?
        puts "Congratulations #{message}!"
      else
        puts ("Cat's Game!")
      end
    end
end
