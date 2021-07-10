class TicTacToe

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

  def turn_count
    count = 0
    @board.each do |position|
      if (position == "X") || (position == "O")
        count += 1
      end
    end
    return count
  end

  def current_player
    count = turn_count
    if count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      combo.all?{|position| @board[position] == "X"} || combo.all?{|position| @board[position] == "O"}
    end
  end

  def full?
    !(@board.any?{|position| position == " "})
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
    if won? || draw? || full?
      true
    end
  end

  def winner
    combo = won?
    if combo
      return @board[combo[0]]
    else
      return nil
    end
  end

  def play
    until over?
      turn
    end
    if won?
      victor = winner
      if victor == "X"
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    else
      puts "Cat's Game!"
    end
  end

end
