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

  def initialize
    @board = [" "] * 9
  end

  # Check if board position at index is taken
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  # Check if game has been won
  def won?()
    WIN_COMBINATIONS.each do |combo|
      ["X", "O"].each do |mark|
        if combo.all?{|i| @board[i] == mark}
          return combo
        end
      end
    end
    return nil
  end

  # Check if borad is full
  def full?()
    !@board.any? { |e| e == " " }
  end

  # Check if game is a draw
  def draw?()
    full? && ! won?
  end

  # Check if game is over (won or draw)
  def over?()
    won? || draw?
  end

  # Return winner
  def winner()
    winner = won?
    if winner
      return @board[winner[0]]
    else
      return nil
    end
  end

  def turn_count()
    mvcount = 0
    @board.each do |mv|
      if mv == "X" || mv == "O"
        mvcount += 1
      end
    end
    return mvcount
  end

  def current_player()
    if turn_count() % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def valid_move?(index)
    if !index.between?(0, @board.length - 1)
      return false
    elsif @board[index] == " " || @board[index] == "" || @board[index] == nil
     return true
    else
     return false
    end
  end

  def move(index, piece)
    @board[index] = piece
  end

  def turn()
    is_valid = false
    until is_valid do
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      is_valid = valid_move?(index)
    end
    move(index, current_player())
    display_board()
  end

  def play()
    until over?() do
      turn()
    end
    if won?()
      game_winner = winner()
      puts "Congratulations #{game_winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
