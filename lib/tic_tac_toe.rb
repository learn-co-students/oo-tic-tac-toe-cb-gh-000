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
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def input_to_index(num)
    num.to_i - 1
  end

  def full?
    @board.each do |cell|
      if(cell == " ")
        return false
      end
    end
    return true
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def draw?
    return full? && !won?
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")then
        return win_combination
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O") then
        return win_combination
      end
    end
    if !full? then return false end
    return nil
  end

  def over?
    if(won? || draw? || full?) then
      return true
    else
      return false
    end
  end

  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    if valid_move?(index) then
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def winner
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")then
        return "X"
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O") then
        return "O"
      end
    end
    return nil
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    return @board[index] != " "
  end

  def valid_move?(index)
    return index >= 0 && index <= 8 && !position_taken?(index)
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def play
    while !over? do
      turn
    end
    if draw? then
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end
end
