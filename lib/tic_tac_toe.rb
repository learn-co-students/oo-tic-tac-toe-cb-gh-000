class TicTacToe

  def initialize(boardnum = 9)
    @board = [" "] * boardnum
  end

  # Define your WIN_COMBINATIONS constant
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


    def one_line(array_name, index_1, index_2, index_3)
      puts " #{array_name[index_1]} | #{array_name[index_2]} | #{array_name[index_3]} "
    end

    def dash_line
      puts "-----------"
    end

    def display_board
      one_line(@board, 0, 1, 2)
      dash_line
      one_line(@board, 3, 4, 5)
      dash_line
      one_line(@board, 6, 7, 8)
    end

  def input_to_index(input)
    return input.to_i - 1
  end

  def valid_move?(index)
    if index.between?(0, 8)
      return !position_taken?(index)
    else
      return false
    end
  end

  def move(converted_input, character)
    @board[converted_input] = character
    return @board
  end


  def turn(character = "X")
    character = current_player
    puts "Please enter 1-9:"

    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      move(index, character)
      display_board
    else
      turn(character)
    end

  end


  # Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def won?
    counter = 0
    until counter == 8
      combo = WIN_COMBINATIONS[counter]

      if ( (@board[combo[0]] == "X" && @board[combo[1]] == "X" && @board[combo[2]] == "X") || (@board[combo[0]] == "O" && @board[combo[1]] == "O" && @board[combo[2]] == "O") )
        return combo
      else
        counter += 1
      end
    end

  end

  def full?
    j = 0

    @board.each do |square|
      if (square == "X" || square == "O")
        j += 1
      end
    end

    return (j == 9)
  end


  def draw?
    if (full? && (won? == nil) )
      return true
    end
  end


  def over?
    return (draw? || (won? != nil) )
  end


  def winner
    if won? != nil
      winning_combo = won?
      return @board[winning_combo[0]]

    else
      return nil
    end

  end

  def turn_count
    counter = 0

    @board.each do |space|
      if (space == "X" || space == "O")
        counter += 1
      end
    end

    return counter
  end

  def current_player
    turns = turn_count

    if turns % 2 == 0
      return "X"
    else
      return "O"
    end

  end


  # Define your play method below
  def play
    if won?
      puts "Congratulations #{winner}!"
    end

    while !over?
      character = current_player
      puts "It's your turn, Player #{character} "
      turn(character)
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
