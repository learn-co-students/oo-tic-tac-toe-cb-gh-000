class TicTacToe

  def initialize()
    @board = []
    for i in 0...9
      @board << " "
    end

  end

  def play()
    display_board()

    until over?()
      turn()
    end

    if(won?())
      puts "Congratulations #{winner()}!"
    elsif(draw?())
      puts "Cat's Game!"
    end

  end

  # Helper? methods

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board()
    val = "   "
    for i in 0...3
      line = ""
      for j in 0..2
        val = " #{@board[3*i+j]} "
        if j!=2
            line += val+"|"
        else
            line += val
        end
      end
      puts line
      if i != 2
        puts "-----------"
      end
    end
  end

  def input_to_index(n)
    index = n.to_i - 1
  end

  def move(index,letter)
    @board[index] = letter
  end

  def position_taken?(index)
    !(@board[index] == " " || @board[index] == "")
  end

  def valid_move?(index)
   !(index<0 || @board[index]==nil || position_taken?(index))
  end


  def turn()
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
    until(valid_move?(index))
      puts "Please enter 1-9:"
      index = gets.strip
      index = input_to_index(index)
    end
      move(index, current_player())
      display_board()
  end

  def turn_count()
    count = 0
    @board.each do |letter|
      if (letter == "X" || letter == "O")
        count +=1
      end
    end
    return count
  end


  def current_player()
    ((turn_count()+2)%2 == 0) ? "X" : "O"
  end


  def won?()
    comb =  false

    WIN_COMBINATIONS.each do |w|
      arr = []
      filled = w.all? do |i|
        arr << @board[i]
        position_taken?(i)
      end
      if filled
        if(arr[0] == arr[1])
          if(arr[1] == arr[2])
            comb = w
          end
        end
      end
    end
    return comb
  end

  def full?()
    isit = true
    for i in 0...9
      if(!position_taken?(i))
        isit = false
        break
      end
    end
    return isit
  end

  def draw?()
    full?() && !won?()
  end

  def over?()
    full?() || won?() || draw?()
  end

  def winner()
    token = nil
    a = won?()
    if a
      token = @board[a[0]]
    end
    return token
  end



end
