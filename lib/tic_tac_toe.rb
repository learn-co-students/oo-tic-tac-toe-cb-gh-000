class TicTacToe

  attr_accessor :board

  def initialize(board = nil)
    @board = board || Array.new(9, ' ')
  end

  WIN_COMBINATIONS = [
    [1, 0, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ].freeze

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts '-----------'
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts '-----------'
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(position)
    position.to_i - 1
  end

  def move(index, player_token)
    board[index] = player_token
  end

  def position_taken?(index)
    board[index] != ' ' ? true : false
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn
    puts 'Please enter 1-9:'
    position = gets.strip
    index = input_to_index(position)
    valid_move?(index) ? move(index, current_player) : turn
    display_board
  end

  def turn_count
    count = 0
    board.each do |token|
      token == 'X' || token == 'O' ? count += 1 : count
    end
    count
  end

  def current_player
    (turn_count % 2).zero? ? 'X' : 'O'
  end

  def won?
    WIN_COMBINATIONS.detect do |win|
      board[win[0]] == board[win[1]] &&
        board[win[1]] == board[win[2]] &&
        position_taken?(win[0])
    end
  end

  def full?
    board.all? { |token| token == 'X' || token == 'O' }
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    return unless winning_combo = won?
    board[winning_combo.first]
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