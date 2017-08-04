class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [6,4,2]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, symbol = "X")
    @board[index] = symbol
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index) == true
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_positions =  [@board[win_combination[0]], @board[win_combination[1]], @board[win_combination[2]]]
      if win_positions == ["X","X","X"] || win_positions == ["O","O","O"]
        return win_combination
      end
    end
    return false
  end

  def full?
    !@board.any?{|position| position == " " || position == nil}
  end

  def draw?
    if won? == false && full? == true
      return true
    end
  end

  def over?
    if full? == true || won? == true || draw? == true
      return true
    end
  end

  def winner
    if won? != false
      return @board[won?[0]]
    else
      return nil
    end
  end

  def play
    until over? == true || draw? == true || won? != false
      turn
    end

    if won?!= false
      puts "Congratulations " + winner + "!"
    else
      puts "Cat's Game!"
    end
  end
end
