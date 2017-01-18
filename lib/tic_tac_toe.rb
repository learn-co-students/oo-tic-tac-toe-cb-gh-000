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

  def initialize
    @board = Array.new(9, ' ')
  end

  def turn
    index = -1
    loop do
      puts 'Where do you want to move?'
      input = gets.strip
      index = input_to_index(input)
      break if valid_move?(index)
    end
    move(index, current_player)
    display_board
  end

  def display_board
    (0..2).each do |i|
      puts " #{@board[(i*3)]} | #{@board[(i*3)+1]} | #{@board[(i*3)+2]} "
      puts '-----------' unless i == 2
    end
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != ' ' && @board[index] != '' && @board[index] != nil
  end

  def valid_move?(index)
    (index <= 8 && index >= 0) && !position_taken?(index)
  end

  def turn_count
    ret = 0
    (0..8).each { |i| ret += 1 if position_taken?(i) }
    ret
  end

  def current_player
    turn_count % 2 == 0 ? 'X' : 'O'
  end

  def won?
    WIN_COMBINATIONS.each do |w|
      next unless position_taken?(w[0])
      c = @board[w[0]]
      return w if @board[w[1]] == c && @board[w[2]] == c
    end
    false
  end

  def full?
    (0..8).all? { |i| position_taken?(i) }
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    won? ? @board[won?[0]] : nil
  end

  def play
    until over?
      turn
    end
    if draw?
      puts 'Cat\'s Game!'
    else
      puts "Congratulations #{winner}!"
    end
  end
end
