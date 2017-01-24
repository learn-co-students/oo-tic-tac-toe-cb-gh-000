class TicTacToe
  def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end

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


  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i
    index - 1
  end

  def move(index,player)
    @board[index] = player
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      false
    elsif @board[index] == "X" || @board[index] =="O"
      true
    end
  end

  def valid_move?(index)
    if position_taken?(index) == false && index <= 8 && index >= 0
      true
    else
      false
    end
  end

  def turn
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      player = current_player
      if valid_move?(index)
        move(index,player)
      else
        turn
      end
    display_board
  end

  def turn_count
    counter = 0
    @board.each do |count|
      if count == "X" || count == "O"
        counter += 1
      end
    end
    counter
  end

  def current_player
    counter = turn_count
    if counter % 2 == 0
      current_player = "X"
    else
      current_player = "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |val|

      if @board[val[0]] == "X" && @board[val[1]] == "X" && @board[val[2]] == "X"
        return val
      end
      if @board[val[0]] == "O" && @board[val[1]] == "O" && @board[val[2]] == "O"
        return val
      end
    end
    if full?
      return false
    end
    if @board == [" "," "," "," "," "," "," "," "," "]
      return false
    end
  end

  def full?
    full_board = true
    @board.each do |val|
      if val.nil? || val == " "
        full_board = false
      end
    end
    return full_board
  end

  def draw?
    if won?
      return false
    elsif full?
      return true
    else
      return false
    end
  end

  def over?
    if draw?
      return true
    elsif won?
      return true
    elsif full?
      return true
    else
      return false
    end
  end

  def winner
    if won?
      return @board [won?[1]]
    else
      return nil
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
