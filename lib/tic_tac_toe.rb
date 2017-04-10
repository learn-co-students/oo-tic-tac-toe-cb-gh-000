class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9," ")
  end


  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end


  def input_to_index(pos)
     pos.to_i - 1
  end

  def move(index,value)
    @board[index] = value
  end

  def position_taken?(index)
    if @board[index]==" " || @board[index]=="" || @board[index]==nil
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if (index>=0 && index<9 && !(position_taken?(index)))
      return true
    else
      return false
    end
  end


  def turn

    puts "Please enter 1-9:"
    position=gets.strip
    index=input_to_index(position)
    if(!valid_move?(index))
        turn
    end
    move(index,current_player)

    display_board
  end

  def turn_count
    count=0
    @board.each do |box|
      count = box!=" " ? count+1  : count
    end
    return count
  end

  def current_player
    if turn_count%2==0
      return "X"
    else
      return "O"
    end
  end

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def won?
    WIN_COMBINATIONS.each do |pos|
      if(@board[pos[0]] == @board[pos[1]] && @board[pos[1]] == @board[pos[2]] && @board[pos[0]]!= " ")
        return pos
      end
    end
    return false
  end

  def full?
    return !(@board.any? {|num| num == " " } )
  end

  def draw?
    return !(won?) && full?
  end

  def over?
    draw? || won?
  end

  def winner
    if (won?)
      return @board[won?[0]]
    else
      return nil
    end
  end

  def play
    until (over? || winner)
      turn
    end
    if (won?)
      puts "Congratulations #{winner}!"
    elsif (draw?)
      puts "Cat's Game!"
    end
  end


end
