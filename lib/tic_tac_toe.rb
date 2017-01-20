class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def initialize(board=nil)
    @board = board || [" "] * 9
  end

  def display_board
    line = []
    Array.new(3) {|x| x * 3}.each { |x|
      t = @board[x..(x+2)]
      line.push(" " + t.join(" | ") + " ")
    }
    puts line.join("\n" + (["-"] * 11).join("") + "\n")
  end

  def input_to_index(input)
    input.match(/^\d+$/) ? input.to_i - 1 : -1
  end

  def move(index, char="X")
    @board[index] = char
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    (index < 0 || index >= @board.length) ? false : !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if !valid_move?(index)
      turn
    else
      move(index, current_player)
      display_board
    end
  end

  def turn_count
    return @board.select{|x| x != "" && x != " " && x != nil}.size
  end

  def current_player
    return turn_count.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.find do | pos |
      position_taken?(pos[0]) && @board[pos[0]] == @board[pos[1]] && @board[pos[1]] == @board[pos[2]]
    end
  end

  def full?
    (0..8).all?{|x| position_taken?(x)}
  end

  def draw?
    x = full?
    y = won?
    x && !y
  end

  def over?
    won? || draw?
  end

  def winner
    win_pos = won?
    win_pos ? @board[win_pos[0]] : nil
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
