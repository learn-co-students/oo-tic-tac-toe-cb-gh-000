class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2],[3, 4, 5],[6, 7, 8],
    [0, 3, 6],[1, 4, 7],[2, 5, 8],
    [0, 4, 8],[2, 4, 6]
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = (input.to_i - 1)
  end

  def move(index, character = "X")
    return @board[index] = character
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(position)
    position.between?(0, 8) && !position_taken?(position)
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
    counter = 0

    @board.each do |token|
      if token == "X" || token == "O"
        counter += 1
      end
    end

    counter
  end

  def current_player
    if turn_count % 2 == 0
      "X"
    else
      "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |comb|
      if (@board[comb[0]] == "X" && @board[comb[1]] == "X" && @board[comb[2]] == "X") || (@board[comb[0]] == "O" && @board[comb[1]] == "O" && @board[comb[2]] == "O")
        return comb
      end
    end
    false
  end

  def full?
    @board.all? { |token| token == "X" || token == "O"  }
  end

  def draw?
    !won? && full?
  end

  def over?
    draw? || won?
  end

  def winner
    winner = won?

    if winner
      if @board[winner[0]] == "X" && @board[winner[1]] == "X" && @board[winner[2]] == "X"
        "X"
      else
        "O"
      end
    end
  end

  def play

    until over?
      turn
    end

    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end

  end
end
