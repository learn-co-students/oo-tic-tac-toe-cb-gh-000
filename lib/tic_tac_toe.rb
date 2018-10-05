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
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
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
  
  def move(index, current_player = 'X')
    @board[index] = current_player
  end
  
  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end
  
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end
  
  def turn_count
    counter = 0
    @board.each do |move|
      if move == 'X' or move == 'O'
        counter += 1
      end
    end
    return counter
  end
  
  def current_player
    if turn_count % 2 == 0
      return 'X'
    else
      return 'O'
    end
  end
  
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player())
      display_board()
      else
      turn()
    end
  end
  
  def won?
    WIN_COMBINATIONS.each do |combination|
      moves = [@board[combination[0]], @board[combination[1]], @board[combination[2]]]
      if moves.all?{|move| (move == "X")} || moves.all?{|move| (move == "O")}
        return combination
      end
    end
    return false
  end
  
  def full?
    @board.all? do |element|
      element == "X" || element == "O"
    end
  end
  
  def draw?
    # if the board is full and no win exists, then true
    return (full?() && !(won?()))
  end 
  
  def over?
    # if board won or is a draw or is full, returns true
    return won?() || draw?()
  end
  
  def winner
    if won?()
      return @board[won?()[0]]
    end
  end  
  
  def end_message
    if won?()
      puts "Congratulations #{winner()}!"
    else
      puts "Cat's Game!"
    end
  end
  
  # Define your play method below
  def play
    until over?() do
      turn()
    end
    end_message()
  end
    
end