class TicTacToe
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

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, player = "X")
    @board[index] = player
  end

  def position_taken?(index)
    return @board[index] != " "
  end

  def valid_move?(index)
    return (index > -1 && index < 9) && @board[index] == " "
  end

  def turn_count
    return @board.count {|e| e != " "}
  end

  def current_player
    return turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    input = gets
    input = input_to_index(input)

    if valid_move?(input)
      move(input, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win|
      if @board[win[0]] == @board[win[1]] && @board[win[0]] == @board[win[2]] && (@board[win[0]] == "X" || @board[win[0]] == "O")
        return win
      end
    end

    return false
  end

  def full?
    return @board.all? { |e| e != " " }
  end

  def draw?
    return (!won? && full?)
  end

  def over?
    return won? || full?
  end

  def winner
    return won? ? @board[won?[0]] : nil
  end

  def play
    until over?
      turn

      if draw?
        break
      end
    end

    if won?
      puts "Congratulations #{winner}!"
    end
    if draw?
      puts "Cat's Game!"
    end
  end
end
