class TicTacToe
  
  def initialize
    @board = Array.new(9, " ")
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
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    input.to_i - 1
  end
  
  def move(index, character = "X")
    @board[index] = character
  end
  
  def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
      return true
    else
      return false
    end
  end
  
  def valid_move?(index)
    if index.between?(0, 8)
      if @board[index] == "X" || @board[index] == "O"
        return false
      else
        return true
      end
    else 
      return false
    end
  end
  
  def turn
    puts "Please specify your move? 1-9"
    a = gets.strip
    as = input_to_index(a)
    if valid_move?(as)
      move(as, current_player)
      display_board
    else
      return turn
    end
  end
  
  def turn_count
      count = 0
  @board.each do |space|
    if space == "X" || space == "O"
      count += 1
    end
  end
  return count
  end
  
  def current_player
  number = turn_count
  if number.even?
    return "X"
  elsif number.odd?
    return "O"
  else
    return "X"
  end
end
  
  def won?
  count = 0
  c1 = 0
  @board.each do |ca|
    if ca != "X" && ca != "O"
      count += 1
    end
  end

alpha = nil
  if count < 9
    WIN_COMBINATIONS.each do |combination|
      win_op_1 = combination[0]
      win_op_2 = combination[1]
      win_op_3 = combination[2]
      position_1 = @board[win_op_1]
      position_2 = @board[win_op_2]
      position_3 = @board[win_op_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        alpha = combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        alpha = combination
      end
    end
if alpha == nil
  return false
else
  return alpha
end
elsif count == 9
  return false
end
end

def full?
  asdf = @board.all? do |asd|
    asd == "X" || asd == "O"
  end
  if asdf == true
  return true
elsif asdf == false
    return false
end
end
  
  def draw?
  if full? == true && won? == false
    return true
  else
    return false
  end
end

  def over?
    if draw? == true 
    return true
    elsif full? == true
    return true
    elsif won? != false
    return true
  else
    return false
  end
end
  
  def winner
  val = won?
  if val == false
    return nil
  else
    winner = @board[val[0]]
  return winner
end
end

def play
  puts "Welcome to Tic Tac Toe!"
  display_board
  until over? == true
    turn
  end
  
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
  puts "Cat's Game!"
  end
  puts "end of game"
end
  
end