class TicTacToe
  
  def initialize()
    puts "Welcome to Tic Tac Toe!"
    @board = Array.new(9, " ")
  end
  
  
  # Define your play method below
  def play()
    while !over?
      turn()
     end
     if draw?
       puts "Cat's Game!"
     else
       puts "Congratulations #{winner}!"
    end
  end
  
   def turn()
    player = current_player
    puts "Player #{player}, Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, player)
      display_board()
    else
      turn()
    end
  end
   
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
   
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
   
  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
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
    [6,4,2],
    [0,4,8]
    ]
    
  def won?
    WIN_COMBINATIONS.each do |combo| 
      if @board[combo[0]] == @board[combo[1]] &&  @board[combo[1]] == @board[combo[2]]
       if combo.all? do |index| 
          position_taken?(index)
          end
         return combo
          break
        end
      end
     end
    return FALSE
  end
     
  def full?
    @board.each_with_index do |space, index|
      if  !position_taken?(index)
        return FALSE
      end
    end
    return TRUE
  end
  
  
  def draw?
    full? && !won?
  end  
  
  def over?
    won? || draw?
  end
  
  def winner
    winIndex = won?
    if winIndex == FALSE
      return nil
    end
    winChar = @board[winIndex[0]] 
    if winChar == "X" || winChar == "O"
      return winChar
    end
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(index, player = "X")
    @board[index] = player
  end
  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
end