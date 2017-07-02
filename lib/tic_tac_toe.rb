class TicTacToe

  WIN_COMBINATIONS = [
    # horizontal
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
   # vertical
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
   # diagonal
    [0, 4, 8],
    [6, 4, 2]
  ]

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
    input.to_i - 1
  end

  def move(index, player = "X")
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index] == " " || @board[index].nil?)
  end

  def valid_move?(index)
    position_taken?(index) == false && index.between?(0, 8)
  end

  def turn_count
    turn = 0
    @board.each_with_index do |square, index|
      if position_taken?(index) && (square == "X" || square == "O")
        turn += 1
      end
    end
    turn
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    input = gets.strip
    index = input_to_index(input)
    player = current_player
    if valid_move?(index)
      move(index, player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      win1 = combo[0]
      win2 = combo[1]
      win3 = combo[2]
      if @board[win1] == "X" && @board[win2] == "X" && @board[win3] == "X"
        return combo
      elsif @board[win1] == "O" && @board[win2] == "O" && @board[win3] == "O"
        return combo
      end
    end
    false
  end

  def full?
    full = true
    @board.each_with_index do |square, index|
      if position_taken?(index) == false
        full = false
      end
    end
    full
  end

  def draw?
    won? == false && full?
  end

  def over?
    draw? || full? || won?
  end

  def winner
    winner = won?
    @board[winner[0]] if winner
  end

  def play
    until over?
      turn
    end
    if winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
