class TicTacToe

  def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]


  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    user_input = index.to_i - 1
  end

  def move(index,value)
    @board[index]= value
  end

  # re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
  def position_taken?(index)
     @board[index] =="" || @board[index]== " " || @board[index]== nil ? false : true
  end

  def valid_move?(index)
       position_taken?(index) == false && index.between?(0,8) == true ? true : false
  end

  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    if valid_move?(index) == true
      move(index,current_player)
      display_board
    else
      turn
    end

  end


  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end


  def current_player
    #replacement if
    turn_count.even? ? "X" : "O"
  end


  def won?
    result = false
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        result = win_combination
      end
    end
      result
  end

  def full?
   !@board.include?(" ")
  end

  def draw?
  !won? && full? ?  true : false
  end

  def over?
  draw? || full? || won? ? true : false
  end

  def winner
    over? ? @board[won?[0]] : nil
  end

  def play
    while over? == false
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"

    end


  end





end
