class TicTacToe  

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
  
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end 
    
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  
  def move(index, current_player="X")
    @board[index] = current_player
  end
  
  
  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end
  
  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
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
    count = 0 
    @board.each do |item|
      if item == "O" || item == "X"  
        count +=1 
      end 
    end 
    return count 
  end
  
  
  def current_player
    if turn_count.odd?
      return "O"
    end 
    return "X"
  end 
  
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
  
  # Define your WIN_COMBINATIONS constant
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
    
  def won?
    WIN_COMBINATIONS.each do |win_combo|
      if win_combo.all? {|index| @board[index] == "X"}
        return win_combo
      end
      if win_combo.all? {|index| @board[index] == "O"}
        return win_combo
      end 
    end
    
    # Reached here => no winning combination detected
    return false
  end
  
  
  def full?
    @board.all? { |item | item == "X" || item == "O"}
  end
  
  
  def draw?
    if won?
      return false 
    elsif !full?
      return false 
    else
      return true
    end 
  end
  
  
  def over?
    if won? || draw? || full?
      return true 
    end 
    return false 
  end 
  
  
  def winner
    if won?
      won?.each {|index| return @board[index]}
    end
    return nil
  end 
  
  
  def play
    while !over?
      turn
    end 
    
    if won?
      puts "Congratulations #{winner}!"
    else 
      puts "Cat's Game!"
    end
  end 
  
end