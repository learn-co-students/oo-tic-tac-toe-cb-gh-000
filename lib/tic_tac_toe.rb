class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def display_board
    separator = "-----------"
    row1 = " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    row2 = " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    row3 = " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    result = "#{row1}\n#{separator}\n#{row2}\n#{separator}\n#{row3}\n"
    print result
  end

  def input_to_index(user_input)
    return user_input.to_i - 1
  end

  def move(index, char="X")
    @board[index] = char
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each {|x| counter += 1 if x == 'X' || x == 'O'}
    counter
  end

  def current_player
    return turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |arr|
      temp = []
      arr.each {|i| temp << @board[i]}
      result = temp.join
      if result == "XXX" || result == "OOO"
        return arr
      end
    end
    return false
  end

  def full?
    @board.all? {|x| x == "O" || x == "X"}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    result = won?
    @board[result[0]] unless result == false
  end

  def play
    until over?
      turn
    end
    result = winner
    if !result.nil?
      puts "Congratulations #{result}!"
    else
      puts "Cat's Game!"
    end
  end
end
