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

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    char = current_player
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, char)
      display_board
    else
      turn
    end
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def turn_count
    count = 0
    @board.each do |spaces|
      if(spaces == "X" || spaces == "O")
        count += 1
      end
    end
    count
  end

  def current_player
    if turn_count % 2 == 0
      "X"
    else
      "O"
    end
  end

  def success?(array)
    pos0 = @board[array[0]]
    pos1 = @board[array[1]]
    pos2 = @board[array[2]]
    ((pos0 == "X" && pos1 == "X" && pos2 == "X") || (pos0 == "O" && pos1 == "O" && pos2 == "O"))
  end

  def won?
    WIN_COMBINATIONS.detect do |array|
      success?(array)
    end
  end

  def full?
    i = 0
    full = true
    while i < 9
      if !position_taken?(i)
        full = false
      end
      i += 1
    end
    full
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if won?
      pos = won?[0]
      @board[pos]
    else
      nil
    end
  end

  def play
    until over?
      turn
    end

    if won?
      char = winner
      puts "Congratulations #{char}!"
    else
      puts "Cat's Game!"
    end
  end

end
