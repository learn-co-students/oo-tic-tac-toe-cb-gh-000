class TicTacToe
  
        WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
        
      ]

  def play
    while !over? && !full? && !won? && !draw?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
 
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
 
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(userInput)
    userInput.to_i - 1
  end

  def move(index,token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
      true
    else
      false
    end
  end

  def valid_move?(index)
    if index < 0 || index > 8 || position_taken?(index)
      false
    else
      true
    end
  end

  def turn
    puts "Please enter a move"
    userInput = gets.strip
    userInput = input_to_index(userInput)
    while !valid_move?(userInput)
      puts "Please enter a move"
      userInput = gets.strip
      userInput = input_to_index(userInput)
    end
    move(userInput,current_player)
    display_board
  end

  def won?
    xIndex = []
    oIndex = []
    counter = 0
    @board.each do |chr|
      if chr == "X"
        xIndex.push(counter)
      elsif chr == "O"
        oIndex.push(counter)
      end
      counter += 1
    end
    WIN_COMBINATIONS.any? do |e|
      if (e - xIndex).empty? || (e - oIndex).empty?
        return e
      else
        false
      end
    end
  end

  def full?
    counter = 0
    @board.each { |chr|
      if chr == "X" || chr == "O"
        counter += 1
      end }
    if counter == 9
      true
    else
      false
    end
  end

  def draw?
    if won?
      false
    else
      if full?
        true
      else
        false
      end
  end
end
  
def over?
  if full?
    true
  else
    false
  end
end
def winner
  xIndex = []
  oIndex = []
  counter = 0
  @board.each do |chr|
    if chr == "X"
      xIndex.push(counter)
    elsif chr == "O"
      oIndex.push(counter)
    end
    counter += 1
  end
  WIN_COMBINATIONS.any? do |e|
    if (e - xIndex).empty?
      return "X"

    elsif (e - oIndex).empty?
      return "O"
    end


    end
    return nil
end    
  
end

