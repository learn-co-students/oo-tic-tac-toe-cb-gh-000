WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  def move(index, value="X")
    @board[index] = value
    @board
  end
  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      return false
    else
      return true
    end
  end
  def turn_count
    iterator = 0
    @board.each { |cell| iterator += 1 if cell == "X" || cell == "O" }
    iterator
  end
  def current_player
    return "X" if turn_count % 2 == 0
    "O"
  end
  def valid_move?(index)
    return false if position_taken?(index) || index < 0 || index > 8
    true
  end
  def input_to_index(num)
    num.to_i - 1
  end
  def display_board
      print " #{@board[0]} | #{@board[1]} | #{@board[2]} \n-----------\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n-----------\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
  end
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination# return the win_combination indexes that won.
      end
    end
    false
  end
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end
  def full?
    @board.all? do |cell|
      cell == "X" || cell == "O"
    end
  end
  def draw?
    return true  if full? && !won?
    false
  end
  def over?
    return true if won? || draw? || full?
    false
  end
  def winner
    if won?
      win_index = won?[0]
      who_won = @board[win_index]
      return who_won
    else
      nil
    end
  end
  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
