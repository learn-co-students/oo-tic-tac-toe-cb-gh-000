class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8],
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
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

  def move(index, player = "X")
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if !position_taken?(index)
      return !(index < 0 || index > 8)
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

  def turn_count
    count = 0
    @board.each do |place|
      if place != " "
        count += 1
      end
    end
    return count
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      if @board[win_index_1] == 'X' && @board[win_index_2] == 'X' && @board[win_index_3] == 'X'
        return win_combination
      elsif @board[win_index_1] == 'O' && @board[win_index_2] == 'O' && @board[win_index_3] == 'O'
        return win_combination
      end
    end
    false
  end

  def full?
    @board.none?{|i| i == " "}
  end

  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over?
    if won? || draw? || full?
      return true
    else
      return false
    end
  end

  def winner
    win_combination = won?
    if !win_combination
      return nil
    end
    return @board[win_combination[0]]
  end

  def play
    until over? == true
       turn
       if won? != false
         puts "Congratulations #{winner}!"
       end
     end
     if draw? == true
       puts "Cat's Game!"
     elsif won? != false
       puts "Congratulations #{winner}!"
     end
  end

end
