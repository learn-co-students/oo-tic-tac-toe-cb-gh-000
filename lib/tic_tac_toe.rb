class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
  ]

  def display_board
    index = 0
    while index <= 6
      puts " #{@board[index]} | #{@board[index+1]} | #{@board[index+2]} "
      if index < 6
        puts "------------"
      end
      index += 3
    end
  end

  def input_to_index(input)
    input.to_i-1
  end

  def move(index, char)
    @board[index] = char
  end

  def position_taken?(index)
    return @board[index] != " "
  end

  def valid_move?(index)
    if index > @board.length-1 || index < 0 || position_taken?(index)
      false
    else
      true
    end
  end

  def turn_count
    unemptyCells =  @board.select {|cell|cell != " "}.length
  end

  def current_player
    if turn_count % 2 == 0
      "X"
    else
      "O"
    end
  end

  def turn
    input = gets
    index = input_to_index(input)
    while !valid_move?(index)
      input = gets
      index = input_to_index(input)
    end
    @board[index] = current_player
    display_board
  end

  def won?
    wincomb = nil
    WIN_COMBINATIONS.each{|combo|
      if @board[combo[0]] != " " && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        wincomb = combo
      end
    }
    wincomb
  end

  def draw?
    if full? && !won?
      true
    end
  end

  def full?
    if @board.select { |e| e == " " }.length == 0
      true
    end
  end

  def over?
    if won? || draw?
      true
    end
  end

  def winner
    winner = won?

    if winner != nil
    @board[winner[0]]
  else
     nil
  end
end

def play
  while !over?
  turn
end

if !draw?
puts "Congratulations #{winner}!"
else
  puts "Cat's Game!"
end
end
end
