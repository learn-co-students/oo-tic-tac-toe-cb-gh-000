class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], #toprow
    [3,4,5], #midrow
    [6,7,8], #botrow
    [0,3,6], #leftcol
    [1,4,7], #midcol
    [2,5,8], #rightcol
    [0,4,8], #trbl
    [2,4,6] #tlbr
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
    return index
  end

  def move(index, value)
    if valid_move?(index)
      @board[index] = value
      display_board
    else
      turn
    end
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index >= 0 && index <= 8 && !position_taken?(index)
  end

  def turn
    puts "Where would you like to go?"
    input = gets.strip
    index = input_to_index(input)
    value = current_player
    move(index, value)
  end

  def turn_count
    (@board.select{|i| i == "X" || i == "O"}).size
  end

  def current_player
    if turn_count.even?
      return "X"
    else
      return "O"
    end
  end

  def won?
    xwin = Array.new
    owin = Array.new
    index = 0

    @board.each do |position|
      if position_taken?(index) && position == "X"
        xwin << index
      elsif position_taken?(index) && position == "O"
        owin << index
      end
      index+=1
    end

    WIN_COMBINATIONS.each do |winner|
      if (winner & xwin) == winner||(winner & owin) == winner
        return winner
      end
    end

    return false
  end

  def full?
    !(@board.detect{|position| position == " " || position == "" || position == nil})
  end

  def draw?
    !(won?) && full?
  end

  def over?
    won? || draw?
  end

  def winner
    xwin = Array.new
    owin = Array.new
    index = 0

    @board.each do |position|
      if position_taken?(index) && position == "X"
        xwin << index
      elsif position_taken?(index) && position == "O"
        owin << index
      end
      index+=1
    end

    WIN_COMBINATIONS.each do |winner|
      if (winner & xwin) == winner
        return "X"
      elsif (winner & owin) == winner
        return "O"
      end
    end

   return nil
  end

  def play
    if over?
      if won?
        puts "Congratulations " + winner + "!"
      elsif draw?
        puts "Cat's Game!"
      end
    else
      turn
      play
    end
  end

end
