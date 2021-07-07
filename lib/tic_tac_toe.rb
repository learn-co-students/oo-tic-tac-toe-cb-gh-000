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
    [6, 4, 2]
  ]
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def input_to_index(index)
    if index.to_i.to_s == index
      index = index.to_i
      index = index - 1
    else
      index = -1
    end
  end
  def move(index, value="X")
    @board[index]=value
  end
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
  def valid_move?(index)
    if position_taken?(index)
      false
    else
      if index > 9 || index < 0
        false
      else
        true
      end
    end
  end
  def turn
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
    if valid_move?(index)
      move(index, current_player())
      display_board()
    else
      while !valid_move?(index)
        puts "Please enter 1-9:"
        index = gets.strip
        index = input_to_index(index)
      end
      move(index, current_player())
      display_board()
    end
  end
  def turn_count
    turns = 0
    @board.each do |space|
      if space == "X" || space == "O"
        turns += 1
      end
    end
    return turns
  end
  def current_player
    turns = turn_count()
    if turns % 2 == 1
      "O"
    else
      "X"
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
      if !position_taken?(win_index_1) || !position_taken?(win_index_2) || !position_taken?(win_index_3)
         false
      else
        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return win_combination
        else
          false
        end
        if position_1 == "O" && position_2 == "O" && position_3 == "O"
          return win_combination
        else
          false
        end
      end
    end
    return false
  end
  def full?
    @board.all? do |space|
      space == "X" || space == "O"
    end
  end
  def draw?
    game_won = won?()
    if game_won
      return false
    elsif !full?()
      return false
    elsif full?() && !game_won
      return true
    end
  end
  def over?()
    if won?() || full?() || draw?()
      true
    else
      false
    end
  end
  def winner
    if won?()
      winning_board = won?()
      @board[winning_board[0]]
    else
      nil
    end
  end
  def play
    until over?()
      turn()
    end
    if won?()
      puts "Congratulations #{winner}!"
    elsif draw?()
      puts "Cat's Game!"
    end
  end
end
