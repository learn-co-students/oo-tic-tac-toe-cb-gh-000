class TicTacToe
  WIN_COMBINATIONS=[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]
  def initialize()
    @board = Array.new(9," ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def input_to_index(index)
    index = index.strip.to_i - 1
    return index
  end

  def position_taken?(index)
    return !(@board[index].nil? || @board[index]==" ")
  end

  def move(index,value="X")
    @board[index]=value
  end

  def valid_move?(index)
    return !(index>8 || index<0 || position_taken?(index))
  end

  def turn
    puts "Please enter 1-9"
    input = gets.strip
    input = input_to_index(input)
    if valid_move?(input)
      move(input,current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |arr|
      if((@board[arr[0]]=="X" && @board[arr[1]]=="X" && @board[arr[2]]=="X") || (@board[arr[0]]=="O" && @board[arr[1]]=="O" && @board[arr[2]]=="O"))
        return arr
      end
    end
    return false
  end

  def full?
    @board.all? { |e| e=="X" || e=="O" }
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    tmp = won?
    if(tmp)
      return @board[tmp[0]]
    end
  end

  def play
    until over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end
end
