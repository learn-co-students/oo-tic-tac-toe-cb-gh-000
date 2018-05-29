class TICTACTOE
  def initialize()
    @board=[ " " , " " ," "," "," "," "," "," "," "]
  end

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(x)
    return x.to_i-1
  end

  def move(ind,turn)
    @board[ind]=turn
  end

  def position_taken?(position)
    if(@board[position]=="X" || @board[position]=="O")
      return true
    else
      return false
    end
  end

  def valid_move?(pos)
    position=input_to_index(pos)
    if(position_taken?(position))
      return false
    else
      return true
    end
  end

  def turn_count()
    count=0
    @board.each do |tmp|
      if(tmp=="X" || tmp=="O")
          count+=1
      end
    end
    return count
  end

  def current_player()
    if(turn_count()%2==0)
      return "X"
    end
    return "O"
  end

  def turn()
    puts "Please enter 1-9:"
    inp=gets.strip
    if (!valid_move?(inp))
      #turn(board)
      return
    end
    move(ind,current_player())
    display_board()
  end

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def won?()
    WIN_COMBINATIONS.each do |poss|
      if(@board[poss[0]]=="X" && @board[poss[1]]=="X" && @board[poss[2]]=="X")
        return poss
      end
      if(@board[poss[0]]=="O" && @board[poss[1]]=="O" && @board[poss[2]]=="O")
        return poss
      end
    end
    return nil
  end

  def full?()
    @board.each do |x|
      if(x!="X" && x!="O")
        return nil
      end
    end
    return true
  end

  def draw?()
    if(full?())
      x=won?()
      if(x!=nil)
        return false
      end
      return true
    end
  return false
  end

  def over?()
    if(won?() || draw?())
      return true
    end
    return false
  end

  def winner()
    x=won?()
    if(x!=nil)
      return @board[x[0]]
    end
    return nil
  end

  def play()
    while(!over?())
      turn()
    end


    if(winner()==nil)
      puts "Cat's Game!"
    end

    if(winner()=="X")
      puts "congratulates the winner X"
    else
      puts "congratulates the winner O"
    end

  end
end
