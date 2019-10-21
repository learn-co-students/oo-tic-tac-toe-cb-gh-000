class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def board
    @board
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    return @board[index] != " "
  end

  def valid_move?(index)
    return (index >= 0 && index < 9 && !position_taken?(index))
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    return @board.count {|i| i == "X" || i == "O"}
  end

  def current_player
    return turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      n = combo[0]
      j = combo[1]
      k = combo[2]

      if @board[n] == "X" && @board[j] == "X" && @board[k] == "X"
        return combo
      elsif @board[n] == "O" && @board[j] == "O" && @board[k] == "O"
        return combo
      end
    end
    return false
  end

  def full?
    return @board.count {|i| i != " "} == 9
  end

  def draw?
    return !won? && full?
  end

  def over?
    return won? || full? || draw?
  end

  def winner
    if draw? || !won?
      return nil
    else
      a = won?
      return @board[a[0]]
    end
  end

  def play
    while (!over?)
      turn
    end

    a = winner

    if (winner != nil)
      puts "Congratulations #{a}!"
    else
      puts "Cat's Game!"
    end
  end
end