class TicTacToe 
  
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
  
  def initialize()
    @board = Array.new(9, " ")
  end
  
  def display_board 
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input) 
    return input.to_i - 1
  end
  
  def move(index, player="X")
    @board[index] = player
  end
  
  def position_taken?(index)
    return (@board[index] == "X" || @board[index]=="O")
  end
  
  def valid_move?(index) 
    return (!position_taken?(index) && index.between?(0, @board.length-1))
  end
  
  def turn 
    puts "Please enter 1-9:"
    input = gets.strip 
    index = input_to_index(input) 
    if valid_move?(index)
      move(index, current_player)
      display_board
    else 
      turn 
    end
  end
  
  def turn_count
    return (@board.select {|pos| pos=="X" || pos=="O"}).length
  end
  
  def current_player 
    return turn_count%2==0 ? "X" : "O"
  end
  
  def won? 
    WIN_COMBINATIONS.each do |combination|
      if combination.all? {|pos| @board[pos] == "X"} || combination.all? {|pos| @board[pos] == "O"}
        return combination
      end
    end
    return false 
  end
  
  def full? 
    return @board.all?  {|pos| pos=="X" || pos=="O"}
  end
  
  def draw?
    return (!won? && full?)
  end
  
  def over? 
    return (draw? || won?)
  end
  
  def winner 
    return won? ?  @board[won?[0]] : nil
  end 
  
  def play 
    iter = 0
    loop do 
      if iter >= 9 || over?
        if winner == "X"
          puts "Congratulations X!"
        elsif winner == "O"
          puts "Congratulations O!"
        else 
          puts "Cat's Game!"
        end
        break 
      end
      iter+=1
      turn 
    end
  end
  
end