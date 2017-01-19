class TicTacToe
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
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

  def turn_count
    c = 0
    @board.each do |i|
      if i.strip != ""
        c+=1
      end
    end
    return c
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end
  
  def position_taken?(index)
    return !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0, 8) && @board[index].strip == ""
      return true
    else
      return false
    end
  end
  def is_number?(string)
    true if Float(string) rescue false
  end

  def input_to_index(index)
    if  is_number?(index)
      return index.to_i-1
    else
      return -1
    end
  end

  def move(index, char)
    @board[index] = "#{char}"
  end

  def won?
    WIN_COMBINATIONS.each do |i|
      if @board[i[0]] =="X" && @board[i[1]] == "X" && @board[i[2]] == "X"
        return i
      elsif @board[i[0]] =="O" && @board[i[1]] == "O" && @board[i[2]] == "O"
        return i
      end
    end
    return false
  end

  def full?
    return !@board.include?(" ")
  end

  def draw?
    return !won? && full?
  end

  def over?
    return won? || draw? || full?
  end

  def winner
    winner_array = won?
    if winner_array
      return @board[winner_array[0]]
    else
      return nil
    end
  end

  def turn
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      while !valid_move?(index)
        index = gets.chomp.to_i
        index = input_to_index(index)
      end
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end