class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    @index = user_input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(position)
    if @board[position] == " "
      return false
    elsif @board[position] == ""
      return false
    elsif @board[position] == nil
      return false
    elsif @board[position] == "X" || @board[position] == "O"
      return true
    end
  end

  def valid_move?(position)
    if position > 8 || position < 0
      return false
    else
      !position_taken?(position)
    end
  end

  def turn
    puts "Please enter a number:"
    @user_input = gets.strip
    @position = input_to_index(@user_input)
    if valid_move?(@position) == true
      move(@position, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |token|
      if token == "X" || token == "O"
        counter += 1
      end
    end
    return counter
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combinations|
      win_index_1 = win_combinations[0]
      win_index_2 = win_combinations[1]
      win_index_3 = win_combinations[2]
      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combinations
      elsif position_1 == "O" && position_2 =="O" && position_3 == "O"
        return win_combinations
      end
    end
      return false
  end

  def full?
    @board.each do |blank|
      if blank == " "
        return false
      end
    end
    return true
  end

  def draw?
    won = won?
    full = full?
    if won != false
      return false
    end
    if won == false && full == true
      return true
    end
    if won == false && full == false
      return false
    end
  end

  def over?
    if won? != false || draw? == true || full? == true
      return true
    else
      return false
    end
  end

  def winner
    if won? == false
      return nil
    end
    win_arr = won?
    win_arr_1 = win_arr[0]
    if @board[win_arr_1] == "X"
      return "X"
    elsif @board[win_arr_1] == "O"
      return "O"
    end
  end

  def play
    until over? == true
      turn
    end
    if winner == "X"
      puts "Congratulations X!"
    elsif winner == "O"
      puts "Congratulations O!"
    elsif draw? == true
      puts "Cat's Game!"
    end
  end

end
