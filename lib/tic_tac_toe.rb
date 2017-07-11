class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],  # Diagonal right
    [2,4,6] # Diagonal left
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

  def move(index, current_player="X")
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
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

  def turn_count
    turns = 0
    @board.each do |token|
      if token == "X" || token == "O"
        turns += 1
      end
    end
    turns
  end

  def current_player
    turns = turn_count
    turns % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
      # grab each index from the win_combination that composes a win.
      # print "#{win_combination}\n"
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the @board at win_index_1
      position_2 = @board[win_index_2] # load the value of the @board at win_index_2
      position_3 = @board[win_index_3] # load the value of the @board at win_index_3
      # print "These are the current positions: #{position_1}, #{position_2}, #{position_3}\n"

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        # print "These are the current positions: #{position_1}, #{position_2}, #{position_3}\n"
        return win_combination # return the win_combination indexes that won.
      else
        false
      end
    end
    false
  end

  def full?
    i = 0
    while i < @board.size
      if !position_taken?(i)
        false
        break
      end
      i += 1
    end
    i == 9 ? true : false
  end

  def draw?
    if !won? == false
      false
    else
      full?
    end
  end

  def over?
    won? || full? || draw? ? true : false
  end

  def winner
    if won?
      win_combination = won?
      # print win_combination
      return @board[win_combination[0]]
    else
      return nil
    end
  end

  # Define your play method below
  def play
    while !over?
      turn
      if won?
        break
      end
    end
    if won?
      puts "Congratulations #{winner}!"
      return
    else
      puts "Cat's Game!"
    end
  end
end

game = TicTacToe.new
board = ["X", " ", " ", " ", " ", " ", " ", " ", "O"]
game.instance_variable_set(:@board, board)

index = 1
puts game.position_taken?(index)
