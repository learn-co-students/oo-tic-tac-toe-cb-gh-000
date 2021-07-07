class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8],
    [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]
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

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(index)
    return !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    return index.between?(0,8) && !position_taken?(index)
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
    @board.count{ |token| token == "X" || token == "O" }
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    for win_combination in WIN_COMBINATIONS do
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = @board[win_index_1]
        position_2 = @board[win_index_2]
        position_3 = @board[win_index_3]

        if (position_1 == "X" && position_2 == "X" && position_3 == "X")
          return win_combination
        end
        if (position_1 == "O" && position_2 == "O" && position_3 == "O")
          return win_combination
        end
    end
    return false
  end

  def full?
    @board.each do |element|
      if (element == " ")
        return false
      end
    end
    return true
  end

  def draw?
    if (!won? && full?)
      return true
    else
      return false
    end
  end

  def over?
    if (won? || draw? || full?)
      return true
    else
      return false
    end
  end

  def winner
    if (over?)
      win_combination = won?
      if (@board[win_combination[0]] == "X")
        return "X"
      elsif (@board[win_combination[0]] == "O")
        return "O"
      else
        return nil
      end
    end
  end

  def play
    until (over? == true)
      turn
    end

    if (won?)
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
