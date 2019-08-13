class TicTacToe
  WIN_COMBINATIONS = [
      [0,1,2], # Top row
      [3,4,5], # Middle row
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [6,4,2]
  ]
  # Define your WIN_COMBINATIONS constant
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

  def move(index, char)
    @board[index] = char
  end

  # Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index > -1 && index < @board.length && (@board[index] != 'O' && @board[index] != 'X')
      return true
    else
      return false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      char = current_player
      move(index, char)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |_it|
      if _it == "O" || _it == "X"
        counter+=1
      end
    end
    counter
  end

  def current_player
    if turn_count % 2 == 0
      "X"
    else
      "O"
    end
  end

  def won?(key = 0)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        if key == 1
          if position_1 == "X"
            return "X"
          else
            return "O"
          end
        else
          return win_combination # return the win_combination indexes that won.
        end
      end
    end
    return false
  end

  def full?
    @board.each do |_it|
      if _it != 'O' && _it != 'X'
        return false
      end
    end
    return true
  end

  def draw?
    !won? && full?
  end

  def over?
    if won? != false
      return true # draw
    elsif won? == false && full? == true
      return true # won
    else
      return false # in progress
    end
  end

  def winner
    if won? != false
      res = won?(1)
      return res
    else
      return nil
    end
  end

  def play
    while !over? && !draw?
      turn
    end
    a = winner
    if a == nil
      puts "Cat's Game!"
    else
      if a == 'X'
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    end
  end
end
