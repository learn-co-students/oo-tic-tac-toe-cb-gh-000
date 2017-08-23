class TicTacToe
  def initialize(board=nil)
    @board = board || Array.new(9," ")
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

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
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
    counter = 0
    for i in 1..9
      if position_taken?(i-1)
        counter+=1
      end
    end
    counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    for win_combination in WIN_COMBINATIONS
      pos_1 = @board[win_combination[0]]
      pos_2 = @board[win_combination[1]]
      pos_3 = @board[win_combination[2]]
      if position_taken?(win_combination[0]) && pos_1 == pos_2 && pos_2 == pos_3
        return win_combination
      end
    end
    false
  end


  def full?
    for i in 0..8
      if !position_taken?(i)
        return false
      end
    end
    true
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      return @board[won?[0]]
    end
    nil
  end
  def play
    #this tutorial is so anal it won't let me pass the specs without using an until loop rather than while
    until over? do
        turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
