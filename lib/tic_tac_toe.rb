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

  PLAYER_WON = [
    ["X", "X", "X"],
    ["O", "O", "O"]
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def board
    @board
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(inp)
    inp.to_i - 1
  end

  def move(index, token="X")
    @board[index] = token
  end

  def position_taken?(index)
    ["X", "O"].include?(@board[index])
  end

  def valid_move?(index)
    index >= 0 && index <= 8 && !position_taken?(index)
  end

  def turn_count
    k = 0
    @board.each do |place|
      if ["X", "O"].include?(place) then
        k += 1
      end
    end
    k
  end

  def current_player
    ["X", "O"][turn_count % 2]
  end

  def turn
    puts "Please enter 1-9:"
    inp = gets
    index = input_to_index(inp.split[0])
    until valid_move?(index) do
      inp = gets
      index = input_to_index(inp.split[0])
    end
    move(index, current_player)
    display_board()
  end

  def won?
    wc = []
    won = false
    WIN_COMBINATIONS.any? do |coomb|
      cc = [@board[coomb[0]], @board[coomb[1]], @board[coomb[2]]]
      wc = coomb
      won = PLAYER_WON.include?(cc)
      won
    end
    if won then
      wc
    else
      false
    end
  end

  def full?
    turn_count == 9
  end

  def draw?
    full? && won? == false
  end

  def over?
    draw? || won? != false
  end

  def winner
    win = won?
    if win == false then
      nil
    else
      p @board[win[0]]
    end
  end

  def play
    until over? do
      turn
    end

    if draw? then
      puts "Cat\'s Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end
end

game = TicTacToe.new
