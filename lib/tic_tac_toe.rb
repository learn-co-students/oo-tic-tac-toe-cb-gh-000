class TicTacToe
  def initialize(board = nil)
    @board = board || @board = Array.new(9, " ")
  end
  
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
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(next_move)
    next_move.to_i - 1
  end
  
  def move(index, value)
    @board[index] = value
  end
  
  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end
  
  def valid_move?(index)
    index >= 0 && index < 9 && !position_taken?(index)
  end
  
  def turn_count
    @board.count{|grid| grid=="X" || grid =="O"}
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def turn
    next_move = gets.strip
    index = input_to_index(next_move)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end
  
  def won?
    WIN_COMBINATIONS.each do |winArr|
      if position_taken?(winArr[0]) &&
           position_taken?(winArr[1]) &&
            position_taken?(winArr[2])
            
        value1 = @board[winArr[0]]
        value2 = @board[winArr[1]]
        value3 = @board[winArr[2]]
        
        if value1 == value2 && value1 == value3
          return winArr
        end
       end
    end
    false
  end
  
  def full?
    @board.all? {|grid| grid == "X" || grid == "O"}
  end
  
  def draw?
    full? && !won?
  end
  
  def over?
    draw? || won?
  end
  
  def winner
    won? ? @board[won?[0]] : nil
  end
  
  def play
    until over?
      turn
    end
    
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end