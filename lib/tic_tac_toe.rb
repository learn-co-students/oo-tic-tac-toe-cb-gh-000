class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  def board=(board)
    @board = board
  end

  def board
   @board
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
  ]

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(user_input, current_player = "X")
#    index = input_to_index(user_input)
    board[user_input] = current_player
  end

  def position_taken?(index)
    if board[index] == " "
      false
    elsif board[index] == ""
      false
    elsif board[index] == nil
      false
    elsif board[index] == "X"
      true
    elsif board[index] == "O"
      true
    end
  end

  def valid_move?(index)
    if position_taken?(index)
      false
    elsif index > 8
      false
    elsif index < 0
      false
    else
      true
    end
  end

  def turn_count
    counter = 0
    turn = 0
    while counter < 10
      if board[counter] == "X" || board[counter] == "O"
        turn += 1
        counter += 1
      else
        counter += 1
      end
    end
    turn
  end

  def current_player
    turn = turn_count
    if turn % 2 == 0
      current_player = "X"
    else
      current_player = "O"
    end
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

  def won?
    won = nil
    WIN_COMBINATIONS.each do |x|
      if board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X"
        won = x
      elsif board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"

        won = x
      end
    end
    return won
  end

  def full?
    full = false
    x = 0
    counter = 0
    while counter < 10
    if position_taken?(x) == true
      x += 1
      counter += 1
    else
      counter +=1
    end
    end
    if x == 9
      full = true
    end
    return full
  end

  def draw?
    draw = false
    if won? == nil && full? == true
      draw = true
    end
    return draw
  end

  def over?
    over = false
    if draw? == true || won? != nil
      over = true
    end
    return over
  end

  def winner
    won = nil
    WIN_COMBINATIONS.each do |x|
      if board[x[0]] == "X" && board[x[1]] == "X" && board[x[2]] == "X"
        won = "X"
      elsif board[x[0]] == "O" && board[x[1]] == "O" && board[x[2]] == "O"
        won = "O"
      end
    end
    return won
  end

  def play
    until over? == true
      turn
    end
    if draw? == true
      puts "Cat's Game!"
    end
    variable4 = winner
    puts "Congratulations #{variable4}!"
  end

end
