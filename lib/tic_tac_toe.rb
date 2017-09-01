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

  def initialize(board = nil)
    @board = board || Array.new(9," ")
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

  def move(index ,token = "X")
    @board[index] = token
  end

  def position_taken?(index) #Indicate if the position
    if @board[index] == " "         #selected is free
      false
    else
      true
    end
  end

  def valid_move?(index)
    if index.between?(0,8)
      if position_taken?(index)
        false
      else
        true
      end
    else
      false
    end
  end

  def turn
    puts "Write a position (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count = 0
    @board.each do |element|
      if element != " "
        count+=1
      end
    end
    return count
  end

  def current_player
    if turn_count%2 != 0
      return "O"
    elsif turn_count%2 == 0
      return "X"
    end
  end

  def won?
    aux = 0
    if @board == [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      false
    else
      WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        pos_1 = @board[win_index_1] # load the value of the board at win_index_1
        pos_2 = @board[win_index_2] # load the value of the board at win_index_2
        pos_3 = @board[win_index_3] # load the value of the board at win_index_3

        if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
          return win_combination # return the win_combination indexes that won.
        elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
          return win_combination # return the win_combination indexes that won.
        else
          false
        end
      end
    end

    aux = 1 #if the game is a draw
    if aux != 0
      false
    end
  end

  def full? #Check if the board is not empty
    @board.each do |element|
      if element == " "
        false
        break
      else
        true
      end
    end
  end

  def draw? #Check if the game was a draw
    if !won?
      if full?
        true
      else
        false
      end
    else
      false
    end
  end

  def over? #Check if the game was finish
    if won? || draw? || full?
      true
    elsif @turn_count == 0
      false
    else
      false
    end
  end

  def winner #Return the token of the winner
    if won?
      if @board[won?[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end

  def play
    until over? == true
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
