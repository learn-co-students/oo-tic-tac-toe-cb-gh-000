class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  def initialize
    @board = []
    9.times do
      @board << " "
    end
  end

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

  def move(index, player="X")
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,9) && !position_taken?(index)
  end

  def turn
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
    else
      puts "invalid"
      turn
    end
    display_board
  end

  def turn_count
    9 - @board.select { |e| e == " " }.size
  end

  def current_player
    if turn_count % 2 == 0
      'X'
    else
      'O'
    end
  end

  def won?
    WIN_COMBINATIONS.find { |win_combination|
      win_combination.all? { |index| @board[index] == 'X' } || win_combination.all? { |index| @board[index] == 'O' }
    }
  end

  def full?
    !@board.any? { |e| e == " " }
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won?
  end

  def winner
    if won?
      @board[won?[0]]
    else
      nil
    end
  end

  def play
    until over? || draw?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
