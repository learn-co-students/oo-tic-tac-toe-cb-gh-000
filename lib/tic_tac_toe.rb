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

  def initialize(board = [" "," "," "," "," "," "," "," "," "])
    @board = board
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    index >= 0 && index <= 8 && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    until valid_move?(index)
      puts "Please enter 1-9:"
      index = input_to_index(gets.strip)
    end
    move(index, current_player)
    display_board
  end

  def turn_count
    count = 0
    @board.each do |space|
      if space == "X" || space == "O"
        count += 1
      end
    end
    count
  end

  def current_player
    if (turn_count % 2) == 0
      "X"
    else
      "O"
    end
  end

  def won?
    WIN_COMBINATIONS.select do |combo|
      if ( position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]] )
        return combo
      end
    end
    false
  end

  def full?
    @board.all? do |space|
      space == "X" || space == "O"
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if won?
      return @board[won?[0]]
    else
      return nil
    end
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
