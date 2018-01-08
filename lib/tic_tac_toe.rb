class TicTacToe
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
  
  def move(index, current_player)
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
  
  # Define your play method below
  def play
    9.times { turn }
  end
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
  
  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [2,5,8],
    [1,4,7]
  ]
  
  def turn_count
    count = 0
    @board.each do |x|
      count += (x == "X" || x == "O" ? 1 : 0)
    end
    count
  end
  
  def current_player
    return (turn_count % 2 == 0 ? "X" : "O")
  end
  
  def won?
    WIN_COMBINATIONS.each do |combo|
      if @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && (@board[combo[0]] == "X" || @board[combo[0]] == "O")
        return combo
      end
    end
    return false
  end
  
  def full? 
    !@board.any? { |place| (place != "X" && place != "O") }
  end
  
  def draw?
    full? && !won?
  end
  
  def over?
    draw? || won?
  end
  
  def winner
    winning = won?
    if !winning
      return nil
    end
    @board[winning[0]]
  end
  
  def play
    until over? do
      turn
    end
    if won? 
      puts "Congratulations #{winner}!"
    elsif draw? 
      puts "Cat's Game!"
    end
  end
end