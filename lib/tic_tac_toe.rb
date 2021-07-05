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
    @board=[" "," "," "," "," "," "," "," "," "]
  end

  def line
    puts "-----------"
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    line
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    line
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index,character="X")
    @board[index]=character
  end

  def position_taken?(index)
    if @board[index]==nil
      return false
    elsif @board[index].strip==""
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if index.between? 0,8 and !position_taken? index
      return true
    end
  end

  def turn
    puts "Please enter 1-9:"
    turn = input_to_index gets.strip.to_i
      if valid_move? turn
        move turn,current_player
        display_board
      else
        turn()
      end
  end


def turn_count
  count = 0
  @board.each do |str|
    if str.strip!=""
      count+=1
    end
  end
  return count
end

def current_player
  count = turn_count
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end
def won?
  WIN_COMBINATIONS.each do |w|
    n=["X","O"]
    count = 0
    2.times do
      if @board[w[0]]==n[count] and @board[w[1]]==n[count] and @board[w[2]]==n[count]
        return w
      else
        count+=1
      end
    end
  end
  return false
end

def full?
 not @board.any? { |e| e.strip=="" }
end

def draw?
  not won? and full?
end

def over?
  draw? or won?
end

def winner
  arr = won?
  if arr
    return @board[arr[0]]
  else
    return nil
  end
end

def play
  9.times do
  if not over?
    turn
  elsif won?
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end

end
end
end
