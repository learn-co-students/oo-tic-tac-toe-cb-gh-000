class TicTacToe
  def board
    @board
  end

  def initialize(board=[" "," "," "," "," "," "," "," "," "])
    @board = board
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} |"
    puts "-------------------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} |"
    puts "-------------------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} |"
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, mark)
    @board[index] = mark
  end

  def position_taken?(index)
    return !(@board[index] == " ")
  end

  def valid_move?(index)
    if index >= @board.size || index < 0
      return false
    end
    !position_taken?(index)
  end

  def turn_count
    count = 0
    @board.each do | b |
      if b != " "
        count = count + 1
      end
    end
    return count
  end

  def current_player
    if turn_count().even?
      return "X"
    else
      return "O"
    end
  end

  def turn
    puts "Please input a number(1-9):"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player())
      display_board
    else
      puts "Please input a number(1-9):"
      input = gets.strip
      index = input_to_index(input)
      move(index, current_player())
      display_board
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    return nil
  end

  def full?
    return turn_count() == @board.size
  end

  def draw?
    if !full?()
      return false
    elsif won?()
      return false
    else
      return true
    end
  end

  def over?
    return won?() || draw?()
  end

  def winner
    if won?().nil?
      return nil
    else
      return board[won?()[0]]
    end
  end

  def play
    while !over?()
      turn()
    end
    if won?()
      puts "Congratulations #{winner()}!"
    elsif draw?()
      puts "Cat's Game!"
    end
  end
end
