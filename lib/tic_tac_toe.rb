class TicTacToe
  def initialize()
    @board=[" "," "," "," "," "," "," "," "," "]
  end

WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = @board[win_index_1]
    position_2 = @board[win_index_2]
    position_3 = @board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X")||(position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  false
end

def full?
  full_board=@board.all? do |m|
    m=="X"||m=="O"
  end
end

def draw?
  if (!won?)&&full?
    true
  else
    false
  end
end

def over?
  if draw?||won?
    true
  else
    false
  end
end

def winner
  win=won?
  if win==false
    return nil
  elsif @board[win[0]]=="X"
    return "X"
  elsif @board[win[0]]=="O"
    return "O"
  end
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

def move(index, value)
  @board[index] = value
end

def valid_move?(index)
  if index>8 || index<0
    return false
  elsif !position_taken?(index)
    true
  else
    false
  end
end

def position_taken?(index)
  if @board[index] == " " || @board[index] == "" || @board[index] == nil
    false
  else
    true
  end
end

def turn
  puts "Please enter 1-9:"
  pos=gets.strip
  pos=input_to_index(pos)
  if valid_move?(pos)
    move(pos, current_player)
    display_board
  else
    puts "Invalid move."
    turn
  end
end

def turn_count
  counter=0
  @board.each do |t|
    if t=="X"||t=="O"
      counter+=1
    end
  end
  return counter
end

def current_player
  if turn_count%2==0
    "X"
  else
    "O"
  end
end

def play
  until over?
    turn
  end
  win=winner
  if win==nil
    puts "Cat's Game!"
  else
    puts "Congratulations #{win}!"
  end
end
end
