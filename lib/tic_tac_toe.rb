class TicTacToe
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
  def initialize()
    @board = [" "] * 9
  end
  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    !position_taken?(index) && ((0...@board.size) === index)
  end

  def turn()
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    player = current_player()
    if valid_move?(index)
      move(index, player)
      display_board()
    else
      turn()
    end
  end

  def turn_count()
    counter = 0
    @board.each do |value|
      if value != " "
        counter += 1
      end
    end
    return counter
  end

  def current_player()
    if turn_count() % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def comb_won?(comb)
    comb.all?{|i| @board[i] == "O"} || comb.all?{|i| @board[i] == "X"}
  end

def won?()
  won = false
  WIN_COMBINATIONS.each do |comb|
    if comb_won?(comb)
      won = true
      return comb
    end
  end
  if !won
    return nil
  end
end

def full?()
  @board.all?{|i| i == "O" || i == "X"}
end

def draw?()
  if !won?() and full?()
    return true
  else
    return false
  end
end

def over?()
  won?() || draw?() || full?()
end

def winner()
  won = won?()
  if won
    return @board[won[0]]
  else
    return nil
  end
end

def play()
  puts "Welcome to Tic Tac Toe!"
  display_board()
  until over?()
    turn()
  end
  if winner()
    puts "Congratulations #{winner()}!"
  elsif draw?()
    puts "Cat's Game!"
  end
end


end
