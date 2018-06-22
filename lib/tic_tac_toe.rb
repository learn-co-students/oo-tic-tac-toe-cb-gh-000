class TicTacToe
  WIN_COMBINATIONS=[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
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
  # Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def draw?
    if !won?&&full?
      return true
    end
  end


  #methods
  def won?
    WIN_COMBINATIONS.each do |win_combination|
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
        false
      end
    end
    return false
  end

  def full?
    @board.all?{|token| token == "X" || token == "O"}
  end



  def over?
    if draw?||won?||full?
      return true
    else
      return false
    end
  end

  def winner
    win_combination=won?
    if(win_combination!=false)
      winning=@board[win_combination[0]]
      return winning
    end
  end


# Helper Methods

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    is_x=true
    index = input_to_index(input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end


  # Define your play method below
  def play

    until over?
      turn
    end
    if won?
      if winner=="X"
        puts "Congratulations X!"
      elsif winner=="O"
        puts "Congratulations O!"
      end
    else
      puts "Cat's Game!"
    end
  end
end
