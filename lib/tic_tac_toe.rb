class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2], # First row
    [3, 4, 5], # Second row
    [6, 7, 8], # Third row
    [0, 3, 6], # First column
    [1, 4, 7], # Second column
    [2, 5, 8], # Third column
    [0, 4, 8], # Top-left to bottom-right diagonal
    [2, 4, 6]  # Top-right to bottom-left diagonal
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player="X")
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
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

    @board.each do |cell|
      if cell == "X" || cell == "O"
        counter += 1
      end
    end

    counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?

    WIN_COMBINATIONS.each do |win_combination|
      position_1 = win_combination[0]
      position_2 = win_combination[1]
      position_3 = win_combination[2]

      if @board[position_1] == "X" && @board[position_2] == "X" && @board[position_3] == "X"
        return win_combination
      end

      if @board[position_1] == "O" && @board[position_2] == "O" && @board[position_3] == "O"
        return win_combination
      end

    end

    false
  end

  def full?
    index = 0

    while index < @board.size
      if position_taken?(index)
        index += 1
      else
        return false
      end
    end

    true
  end

  def draw?
    full = full?
    won = won?

    if full && !won
      true
    else
      false
    end
  end

  def over?
    if draw? || won?
      true
    else
      false
    end
  end

  def winner
    win_combination = won?

    win_combination ? @board[win_combination[0]] : nil
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    end

    if draw?
      puts "Cat's Game!"
    end
  end
end
  
