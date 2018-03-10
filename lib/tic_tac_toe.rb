class TicTacToe
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

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    s = "-----------"

    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} ",s
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} ",s
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

  def valid_move?(position)
    position.between?(0,8) && !position_taken?(position)
  end

  def turn_count
    counter = 0

    @board.each do | token |
      counter = token == "X" || token == "O" ? counter + 1 : counter
    end

    return counter
  end

  def current_player
    turn_count.even? ? "X" : "O"
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

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      pos1 = @board[win_index_1]
      pos2 = @board[win_index_2]
      pos3 = @board[win_index_3]

      if pos1 == "X" && pos2 == "X" && pos3 == "X"
        return win_combination
      elsif pos1 == "O" && pos2 == "O" && pos3 == "O"
        return win_combination
      end
    end
    return false
  end

  def full?
    @board.each do |token|
      if token != "X" && token != "O"
        return false
      end
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    win_indexes = won?

    if win_indexes == false
      return nil
    else
      return @board[win_indexes[0]]
    end
  end

  def play
    9.times do
      if over?
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
        break
      end
      turn
    end
  end

end
