class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
 
  def current_player
    return turn_count % 2 == 0 ? "X" : "O"
  end
 
  def turn_count
    return @board.count{|token| token == "X" || token == "O"}
  end
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # Helper Method
  def position_taken?(index)
     return !(@board[index].nil? || @board[index] == " ")
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], #Bot Row
    [0,3,6], #left col
    [1,4,7], #mid col
    [2,5,8], #right col
    [0,4,8], #right diag
    [6,4,2]  #left diag
  ]

  def won?
    WIN_COMBINATIONS.each do |iter|
      winnerX = iter.all? do |posistion| @board[posistion] == "X"  end
      winnerO = iter.all? do |posistion| @board[posistion] == "O"  end
      if winnerX || winnerO
        return iter 
      end
    end
    return false
  end

  def full?
    isFull = @board.all? do |value| (value == "X" || value == "O") end
    if isFull
      return true
    end
    return false
  end

  def draw? 
    if full? && !won?
      return true
    end
    return false
  end

  def over?
    if full? || won? || draw?
      return true
    end
    return false
  end

  def winner
    if champion = won?
      return @board[champion[0]]
    end
    return nil
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def valid_move?(index)
    if !position_taken?(index) && (index < 9 && index >=0)
      return true
    end
    return false 
  end

  def turn
    puts "Please input a number between 1-9."
    user_move = gets.chomp
    user_move = input_to_index(user_move)
    if valid_move?(user_move)
      move(user_move, current_player)
      display_board
    else
      turn
    end
  end 

  def play
    while(!over?)
      turn
    end
    if won?      
      puts "Congratulations #{winner}!" 
    elsif draw?
      puts "Cat's Game!"
    end
  end

end