class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(position, current_player)
    @board[position] = current_player
  end

  def position_taken?(position)
    !(@board[position].nil? || @board[position] == " ")
  end

  def valid_move?(position)
    position.between?(0,8) && !position_taken?(position)
  end

  def turn()
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player())
      display_board()
    else
      turn()
    end
  end

  def turn_count()
    @board.count{|position| position == "X" || position == "O"}
  end

  def current_player()
    turn_count() % 2 == 0 ? "X" : "O"
  end

  def won?()
    if @board.all?{|position| position == " "}
      return false
    end

    WIN_COMBINATIONS.each do |combinations|
      if combinations.all?{|position| @board[position] == "X"} ||
        combinations.all?{|position| @board[position] == "O"}
        return combinations
      end
    end

    return false
  end

  def full?()
    @board.all?{|position| position == "X" || position == "O"}
  end

  def draw?()
    !won?() && full?()
  end

  def over?()
    won?() || draw?()
  end

  def winner()
    if !won?()
      return nil
    end

    if won?().all?{|position| @board[position] == "X"}
      return "X"
    end

    if won?().all?{|position| @board[position] == "O"}
      return "O"
    end
  end

  def play()
    while !over?() do
      turn()
    end

    if draw?()
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner()}!"
    end
  end
end
