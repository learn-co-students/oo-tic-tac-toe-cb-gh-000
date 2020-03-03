class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, ' ')
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

  def move(index, player = 'X')
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index] == ' ' || @board.nil?)
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn
    puts "Please enter a number 1-9:"
    pos = gets.strip
    index = input_to_index(pos)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count {|pos| pos == 'X' || pos == 'O'}
  end

  def current_player
    turn_count % 2 == 0 ? 'X' : 'O'
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if combo.all? {|i| @board[i] == 'X'} || combo.all? {|i| @board[i] == 'O'}
        return combo
      end
    end
    return
  end

  def full?
    @board.none? {|pos| pos == ' '}
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    win = won?
    if win
      @board[win[0]]
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
