
class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize
    @board = Array.new 9, ' '
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index user_input
    user_input.to_i - 1
  end

  def move index, token
    @board[index] = token
  end

  def position_taken? location
    @board[location] != " " && @board[location] != ""
  end

  def valid_move? index
    index.between?(0, @board.size-1) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index input
    if valid_move? index
      move index, current_player
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.reject {|i| i == ' ' || i == "" }.size
  end

  def current_player
    %w[X O][turn_count % 2]
  end

  def wininfo
    combination = WIN_COMBINATIONS.find do |combination|
      combination.map do |position|
        @board[position]
      end.uniq.size == 1 && @board[combination[0]].strip != ''
    end
    {
      combination: combination ? combination : false,
      winner: combination ? @board[combination[0]] : nil
    }
  end

  def won?
    wininfo[:combination]
  end

  def full?
    @board.size.times.all? do |position|
      position_taken? position
    end
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    wininfo[:winner]
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
