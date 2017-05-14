class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def position_taken?
    !(@board[@index].nil? || @board[@index] == " ")
  end

  def current_player
    @char = turn_count.even? ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
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
  def input_to_index
    @index = @input.to_i
    @index -= 1
  end
  def move
    current_player
    @board[@index] = @char
  end
  def valid_move?
    if position_taken? == false && @index >= 0 && @index <= 8
      return true
    end
  end
  def won?
    WIN_COMBINATIONS.detect do |win|
      win_index_1 = win[0]
      win_index_2 = win[1]
      win_index_3 = win[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win
      end
    end
  end
  def full?
    @board.none? do |full|
      full.include?(" ")
    end
  end
  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end
  def over?
    if won? || full?
      return true
    else
      return false
    end
  end
  def winner
    WIN_COMBINATIONS.detect do |win|
      win_index_1 = win[0]
      win_index_2 = win[1]
      win_index_3 = win[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return "X"
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return "O"
      end
    end
  end
  def turn
    puts "Please enter 1-9:"
    @input = gets.strip
    @index = input_to_index
    if valid_move? == true
      move
      display_board
    else
      loop do
        puts "Podaj prawidlowy numer"
        @input = gets.strip
        @index = input_to_index
        if valid_move? == true
          move
          display_board
          break
        end
      end
    end
  end
  def play
    until over? == true
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
