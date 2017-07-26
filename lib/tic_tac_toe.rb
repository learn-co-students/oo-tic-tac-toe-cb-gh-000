class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS=[[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def input_to_index(input)
    index=input.to_i
    index=index-1
    return index
  end

  def move(index,player_char)
    @board[index]=player_char
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def position_taken?(index)
    if (@board[index]==" " || @board[index]=="" || @board[index]==nil)
      return false
    elsif (@board[index]=="X" || @board[index]=="O")
      return true
    end
  end

  def valid_move?(index)
    if (index>=0 && index <=8 && @board[index]==" ")
      return true
    end
  end
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def turn
    puts "Please enter 1-9:"
    num=gets.strip
    input_to_index(num)
    index=num.to_i
    index=index-1
    while !(valid_move?(index))
      puts "Please enter 1-9:"
      num=gets.strip
      input_to_index(num)
      index=num.to_i
      index=index-1
    end
    move(index,current_player)
    display_board
  end

  def won?
    x=Array.new
    o=Array.new
    num=0
    until num==9 do
      if @board[num]=="X"
        x << num
      elsif @board[num]=="O"
        o << num
      end
      num=num+1
    end
    num=0
    until num==WIN_COMBINATIONS.length do
      i=0
      j=0
      WIN_COMBINATIONS[num].each do|n|
        if x.include? n
          i=i+1
        end
        if o.include? n
          j=j+1
        end
      end
      if i==3
        return WIN_COMBINATIONS[num]
      elsif j==3
        return WIN_COMBINATIONS[num]
      end
      num=num+1
    end
    return false
  end

  def full?
    num=0
    until num==9 do
      if @board[num]==" "
        return false
      end
      num=num+1
    end
    return true
  end

  def draw?
    full?
    won?
    x=Array.new
    o=Array.new
    num=0
    until num==9 do
      if @board[num]=="X"
        x << num
      elsif @board[num]=="O"
        o << num
      end
      num=num+1
    end
    num=0
    until num==WIN_COMBINATIONS.length do
      i=0
      j=0
      WIN_COMBINATIONS[num].each do|n|
        if x.include? n
          i=i+1
        end
        if o.include? n
          j=j+1
        end
      end
      if i==3 || j==3
        return false
      end
      num=num+1
    end
    return true
  end

  def over?
    full?
  end

  def winner
    x=Array.new
    o=Array.new
    num=0
    until num==9 do
      if @board[num]=="X"
        x << num
      elsif @board[num]=="O"
        o << num
      end
      num=num+1
    end
    num=0
    until num==WIN_COMBINATIONS.length do
      i=0
      j=0
      WIN_COMBINATIONS[num].each do|n|
        if x.include? n
          i=i+1
        end
        if o.include? n
          j=j+1
        end
      end
      if i==3
        return "X"
      elsif j==3
        return "O"
      end
      num=num+1
    end
  end

  def play
    while !(over?) do
      won?
      if winner=="X"
        puts "Congratulations X!"
        break
      elsif winner=="O"
        puts "Congratulations O!"
        break
      else
        turn
      end
    end
    if over? && winner !="X" && winner !="O"
      puts "Cat's Game!"
    end
  end
end
