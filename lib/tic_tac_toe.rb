class TicTacToe
  WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  def initialize(new_board = nil)
    @board = new_board || Array.new(9, " ")
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

  def move(index, current_player="X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
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
    @board.each do |cell|
      if cell == "X" || cell == "O"
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
    WIN_COMBINATIONS.each do |win_p|
      win_ind1 = win_p[0]
      win_ind2 = win_p[1]
      win_ind3 = win_p[2]

      position_1 = @board[win_ind1]
      position_2 = @board[win_ind2]
      position_3 = @board[win_ind3]
      if position_1 == position_2 && position_1 == position_3 && position_1 != "" && position_1 != " " && position_1 != nil
        return win_p
      end
    end
    return false
  end

  def full?
    return @board.none? { |e|  e == "" || e == " " || e == nil}
  end

  def draw?
    return !won? && full?
  end

  def over?
    return draw? || won?
  end

  def winner
    if winner = won?
      return @board[winner[0]]
    end
  end

  def play
    until over? || won?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
