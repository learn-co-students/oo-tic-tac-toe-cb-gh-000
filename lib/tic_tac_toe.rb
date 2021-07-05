class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]
  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    index.to_i - 1
  end

  def move(pos, val)
    @board[pos] = val
  end

  def position_taken?(pos)
     @board[pos]=="X" || @board[pos]=="O"
  end

  def valid_move?(pos)
    (pos >= 0 && pos <=8) && !position_taken?(pos)
  end

  def turn
    puts "Please enter a number between 1-9:"
    number = input_to_index(gets.strip)
    if valid_move?(number)
      move(number, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count = 0
    @board.each do |i|
      if i == "X" || i == "O"
        count += 1
      end
    end
    return count
  end
  def current_player
    n = turn_count
    if n%2 == 0
      return "X"
    end
    return "O"
  end

  def won?
    TicTacToe::WIN_COMBINATIONS.each do |win_comb|
      if (win_comb.all? { |i| @board[i] == "X"} || win_comb.all? { |i| @board[i]=="O"})
        return win_comb
      end
    end
    return false
  end

  def full?
    return @board.all?{|el| !(el==nil || el == " ")}
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    TicTacToe::WIN_COMBINATIONS.each do |win_comb|
      if win_comb.all? { |i| @board[i] == "X"}
        return "X"
      end
      if win_comb.all? { |i| @board[i] == "O"}
        return "O"
      end
    end
  return nil
  end

  def play
    display_board
    over = over?
    while !over
      turn
      over = over?
    end
    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end

end
