

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

  def won?
    WIN_COMBINATIONS.each do |combo|
      if (@board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && (@board[combo[2]] == "O" || @board[combo[2]] == "X"))
        return (combo)
      end
    end
    return (false)
  end

  def full?
    all = @board.select{|elem|  elem == "X" || elem == "O"}
    return (all.size == 9)
  end

  def draw?
    full? && !won?
  end

  def over?
    if (draw? || won?)
      return (true)
    else
      return (false)
    end
  end

  def winner
    combo = won?
    if (combo)
      return (@board[combo[0]])
    else
      return (nil)
    end
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
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

  def play
    i = 0
    while i < 9
      if (!over?)
        turn
      end
      i += 1
    end
    if (draw?)
      puts "Cat's Game!"
    elsif (won?)
      puts "Congratulations #{winner}!"
    end
    is_fool = full?
  end
end
