class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9," ")
  end

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

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n"
    puts "-----------\n"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} \n"
    puts "-----------\n"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
  end

  def turn
    player = current_player
    puts "Player #{player}'s turn. Please enter [1-9]:"
    input = gets.strip
    index = input_to_index(input)
    if (valid_move?(index))
      move(index,player)
      display_board
    else
      turn
    end
  end

  def play
    display_board

    while (!over?)
      turn
    end

    winr = winner
    if winr
      puts "Congratulations #{winr}!"
    else
      puts "Cat's Game!"
    end
  end

  def turn_count
    counter = 0
    @board.each do |index|
      if (index == "X" || index == "O")
        counter += 1
      end
    end
    return counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def valid_move?(index)
    (!position_taken?(index)) && @board[index] && index >= 0
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def move(index, value)
    @board[index] = value
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      combX = combination.select do |index|
        @board[index] == "X"
      end
      if combX.size === 3
        return combX
      end

      combO = combination.select do |index|
        @board[index] == "O"
      end
      if combO.size === 3
        return combO
      end
    end
    return false
  end

  def full?
    @board.all? do |index|
      index == "X" || index == "O"
    end
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    win = won?
    if win
      return @board[win[0]]
    end
  end
end
