class TicTacToe
    WIN_COMBINATIONS = [
                          [0,1,2],
                          [3,4,5],
                          [6,7,8],
                          [0,3,6],
                          [1,4,7],
                          [2,5,8],
                          [0,4,8],
                          [6,4,2]
    ]

  def initialize
    @board = Array.new(9," ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    return user_input.to_i-1
  end

  def move(index,player)
    @board[index.to_i]=player
  end

  def position_taken?(index)
    while index.to_i.between?(0,8)
      if @board[index.to_i] == "X" || @board[index.to_i] == "O"
        return true
      else
        return false
      end
    end
    return false
  end

  def valid_move?(index)
    if index.to_i.between?(0,8)
      if position_taken?(index)
        return false
      end
      return true
    end
end

def turn_count
  count=0
  @board.each { |e|
    if e == "X" || e == "O"
      count+=1
    end
   }
   return count
end

def current_player
  if turn_count%2 == 0
  return  "X"
  end
  "O"
end

def move(index,player)
  @board[index]=player
end

def turn
  puts "Enter 1-9"
  user_input=gets.strip
  index=input_to_index(user_input)
  player=current_player
  if valid_move?(index)
    move(index,player)
    display_board
  else
    turn
  end
end

def won?
  WIN_COMBINATIONS.each { |e|
    if @board[e[0]] == @board[e[1]] && @board[e[0]] == @board[e[2]] && @board[e[0]] != " "
      return e
    end
   }
   return false
end

def full?
  if !won?
    @board.all? { |e|
      e == "X" || e == "O"
     }
  end
end

def draw?
  if full?
    return true
  end
end

def over?
  if draw? || won?
    return true
  end
return false
end

def winner
  if won?
    current_player == "X"? "O" : "X"
  end
end

def play
  while !over?
    turn
  end
  if over?
    if winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat\'s Game!"
    end
  end

end
end
