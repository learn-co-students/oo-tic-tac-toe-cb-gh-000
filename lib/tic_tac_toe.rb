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

  PLAYER = ["X", "O"]
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    integer = input.to_i
    if integer == 0
      return -1
    end
    return integer - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    PLAYER.include?(@board[index])
  end

  def valid_move?(index)
    !(!@board[index] || PLAYER.include?(@board[index]) || !index.between?(0,8))
  end

  def turn
    index = 0
    loop do
      puts "Please choose your position in range of 1-9:"
      input = gets.strip
      index = input_to_index(input)
      if index != -1 && valid_move?(index)
        break
      end
    end
    move(index, current_player)
    display_board
  end

  def turn_count
    @board.select { |field| PLAYER.include?(field) }.length
  end

  def current_player
    (turn_count % 2 == 0) ? PLAYER[0] : PLAYER[1]
  end

  def won?
    WIN_COMBINATIONS.each do |win|
      if win.all? { |field|  @board[field] == PLAYER[0]}
        return win
      end
      if win.all? { |field|  @board[field] == PLAYER[1]}
        return win
      end
    end
    return false
  end

  def full?
    @board.all? { |field| PLAYER.include?(field)}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw? || full?
  end

  def winner
    if !won?
      return nil
    end
    return @board[won?[0]]
  end

  def play
    until over? do
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
  
end