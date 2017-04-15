class TicTacToe
  def initialize
    @board = [' ', ' ', ' ', ' ', ' ',
              ' ', ' ', ' ', ' ']
  end

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

  # Checks if the position is taken.
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == ' ')
  end

  # Displays the current board.
  def display_board
    puts(" #{@board[0]} | #{@board[1]} | #{@board[2]} ")
    puts('-----------')
    puts(" #{@board[3]} | #{@board[4]} | #{@board[5]} ")
    puts('-----------')
    puts(" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
  end

  # Parses the input to index.
  def input_to_index(input)
    input.to_i - 1
  end

  # Makes the move.
  def move(index, char)
    @board[index] = char
  end

  # Checks if the move is valid.
  def valid_move?(index)
    !(index < 0 || index > 8 || position_taken?(index))
  end


  # Asks the player to make the turn.
  def turn
    puts('Please enter 1-9:')
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  # Counts the turns played.
  def turn_count
    count = 0
    @board.each do |element|
      if element == 'X' || element == 'O'
        count += 1
      end
    end
    count
  end

  # Determines the current player.
  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  # Checks if won.
  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if (position_1 == 'X' && position_2 == 'X' && position_3 == 'X')
        || (position_1 == 'O' && position_2 == 'O' && position_3 == 'O')
        win_combination
      end
    end
    false
  end

  # Checks if the board is full.
  def full?
    @board.all? { |item| item == 'X' || item == 'O' }
  end

  # Checks if the game is draw.
  def draw?
    !won? && full?
  end

  # Checks if the game is over.
  def over?
    full? || won?
  end

  # Finds the winner of the game.
  def winner
    won? ? @board[won?[0]] : nil
  end

  # Plays the game.
  def play
    until over? do
      turn
    end
    if won?
      puts("Congratulations #{winner}!")
    elsif draw?
      puts("Cat's Game.")
    end
  end

end
