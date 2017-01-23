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
# Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def won?
    WIN_COMBINATIONS.each do |win_combo|

      win_index_1 = win_combo[0]
      win_index_2 = win_combo[1]
      win_index_3 = win_combo[2]

      position_taken_1 = @board[win_index_1]
      position_taken_2 = @board[win_index_2]
      position_taken_3 = @board[win_index_3]

      if position_taken?(win_index_1) # check at least one position isn't an empty cell
        if position_taken_1 == position_taken_2 && position_taken_2 == position_taken_3
          return win_combo
        else
          false
        end
      end
    end
    false
  end

  def full?
    @board.all?{|position| position == "X" || position == "O"}
  end

  def draw?
    if won?
      false
    elsif full?
      true
    else
      false
    end
  end

  def over?
    if won? || draw?
      #puts "over!"
      true
    else
      puts "not over!"
      false
    end
  end

  def winner
    winning_positions = won?
    if winning_positions != false
      @board[winning_positions[0]]
    else
      nil
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # code your input_to_index and move method here!

  def input_to_index(user_input)
    board_number = user_input.to_i
    board_number = board_number - 1
  end

  def move(fill_position, player_char)
    @board[fill_position] = player_char
  end

  def valid_move?(index)
    if index.between?(0,9) && position_taken?(index) == false
      true
    else
      false
    end
  end

  def turn
    good_input = false
    while good_input == false
      puts "Please enter 1-9:"
      player_input = gets.strip
      player_input = input_to_index(player_input)
      if valid_move?(player_input) == true
        good_input = true
      end
    end
    move(player_input, current_player)
    display_board
  end

  def turn_count
    counter = 0
    @board.each do |tile|
    if tile == "X" || tile == "O"
      counter += 1
    end
    end
    counter
  end

  def current_player
    turn_number = turn_count
    if turn_number % 2 == 0
      return "X"
    else
      return "O"
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