class TicTacToe
  def initialize board = nil
    @board ||= Array.new(9," ")
  end

  def board
    @board
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

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts "-----------"
  end

  def input_to_index input
    @index = input.to_i - 1
  end

  def move index,token="X"
    @board[index] = token
  end

  def position_taken? index
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move? index
    !position_taken?(index) && index.between?(0,9)
  end

  def turn
    puts "please enter where you want to go (1-9): "
    input = gets.strip
    token = current_player
    index = input_to_index(input)
    if valid_move? index
      move(index,token)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
    end
  end

  def full?
    @board.all? {|token| token == "X" || token == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won?
  end

  def winner
    if winning_combo = won?
       @board[winning_combo.first]
    end
  end

  def play
    until over? || draw?
      turn
    end
    if won?
      puts "Congratulations #{winner.upcase}!"
    else draw?
      puts "Cat's Game!"
    end
  end




end
