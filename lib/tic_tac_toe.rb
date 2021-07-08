class TicTacToe
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

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board()
    display_row(0)
    puts "-----------"
    display_row(1)
    puts "-----------"
    display_row(2)
  end

  def display_row(row_index)
    puts " #{@board[3 * row_index]} | #{@board[3 * row_index + 1]} | #{@board[3 * row_index + 2]} "
  end

  def input_to_index(user_input)
    return user_input.to_i - 1
  end

  def move(index, char)
    @board[index] = char
  end

  def position_taken?(index)
    square = @board[index]
    return filled?(square)
  end

  def filled?(square)
    return !(square.nil? || square == "" || square == " ")
  end

  def valid_move?(index)
    return !(non_existent_square?(index) || position_taken?(index))
  end

  def non_existent_square?(index)
    return !index.between?(0, @board.length - 1)
  end

  def turn_count()
    return @board.select{ |square| filled?(square) }.length
  end

  def current_player()
    return turn_count.even? ? "X" : "O"
  end

  def turn()
    index = get_input
    until valid_move?(index)
      index = get_input
    end
    move(index, current_player)
    display_board
  end

  def get_input()
    input_to_index(gets.strip)
  end

  def won?()
    winning_combination = WIN_COMBINATIONS.detect{|combo|
      filled?(@board[combo[0]]) &&
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]]
    }
    return winning_combination
  end

  def full?()
    return @board.all? { |square| filled?(square) }
  end

  def draw?()
    return !won? && full?
  end

  def over?()
    return draw? || won?
  end

  def winner
    winning_combination = won?
    return winning_combination.nil? ? nil : @board[winning_combination[0]]
  end

  def play()
    until over?
      turn()
    end
    puts winner.nil? ? "Cat's Game!" : "Congratulations #{winner}!"
  end
end
