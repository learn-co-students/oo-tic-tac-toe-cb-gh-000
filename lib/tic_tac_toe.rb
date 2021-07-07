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

  def initialize board = nil
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index input
    input.to_i - 1
  end

  def move index, token = "X"
    @board[index] = token
  end

  def position_taken? index
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move? index
    if (index >= 0 && index <= 8) && !position_taken?(index)
      true
    else
      false
    end
  end

  def turn_count
    count = 0
    @board.each do |cell|
      if cell == 'O' || cell == 'X'
        count += 1
      end
    end
    count
  end

  def current_player
   (turn_count % 2 == 0 ) ? "X" : "O"
  end

  def turn
    # we are using recursion here
    # get input
    # convert input to index
    # if index is valid
    #   make the move for input
    # else
    #   ask for input again until you get a valid input
    # end
    puts "Please enter 1-9:"
    input = input_to_index (gets.to_i)
    if valid_move? input
      token = current_player
      move(input, token)
      display_board
    else
      turn
    end
  end

  def valid_move? index
    if (index >= 0 && index <= 8) && !position_taken?(index)
      true
    else
      false
    end
  end

  def won?
    for win_combination in WIN_COMBINATIONS do
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination
      end
    end
    false
  end

  def full?
    @board.all? {|position| position == "X" || position == "O"}
  end

  def draw?
    # if full? && !won? return true
    # if !won? && !full? return false
    # if won? return false

    if full? && !won?
      return true
    end
  end

  def over?
    if won? || draw? || full?
      return true
    end
  end

  def winner
    has_won = won?
    if has_won
      return @board[has_won[0]]
    end
  end

  def play
    # until the game is over
    #   take turns
    # end
    #
    # if the game was won
    #   congratulate the winner
    # else if the game was a draw
    #   tell the players it has been a draw
    # end

    while !over? do
      turn
    end

    winner = winner()
    if winner
      puts "Congratulations #{winner}!"
    end

    if draw?
      puts "Cat's Game!"
    end
  end
end
