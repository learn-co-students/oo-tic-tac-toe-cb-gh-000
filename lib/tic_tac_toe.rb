class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8], # Top row
    [0,4,8],  # Middle row
    [2,4,6], # Top row
    [0,3,6],  # Middle row
    [1,4,7], # Top row
    [2,5,8]  # Middle row
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def play
    display_board

    while(!over?)
      turn
    end

    if(!draw?)
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def turn
    puts "Choose your board move (1-9):"
    move = gets.chomp

    my_index = input_to_index(move)

    if(valid_move?(my_index))
      move(my_index, current_player)
      puts "Move placed! Current board:"
      display_board
    else
      puts "Please choose a valid move..."
      turn
    end

  end

  def input_to_index(user_input)
    index_to_return = user_input.to_i - 1

    index_to_return
  end

  def move(index, move_turn)
    @board[index] = move_turn
  end

  def valid_move?(index)
    if(index >= 0 && index < 9) #position must be between 0 and 8, inclusively
      if(!position_taken?(index)) #position on board must be open
        return true #if conditions met, move is valid
      end
    end

    false
  end

  def position_taken?(index)
    if(@board[index] != " ")
      return true
    end
    false
  end

  def current_player
    num_turns = turn_count
    if(num_turns%2 == 0)
      "X"
    else
      "O"
    end
  end

  def turn_count
    @board.count { |token| token == "X" || token == "O" }
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      move_check = @board[combo[0]]
      if(move_check != " ")
        if(@board[combo[1]] == move_check and @board[combo[2]] == move_check)
          return combo
        end
      end
    end

    return false
  end

  def full?
    for i in 0..8 do #Check each index of the board
      if(@board[i] == " ") #if the board index is empty
        return false  #just return false, no need to check other sides
      end
    end

    #If all board spots taken, return true
    true
  end

  def draw?
    if(full? and !won?)
      true
    else
      false
    end
  end

  def over?
    if(won? or draw?)
      true
    else
      false
    end
  end

  def winner
    winning_combination = won?

    if(winning_combination)
      @board[winning_combination[0]]
    else
      nil
    end
  end

end
