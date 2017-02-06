class TicTacToe
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

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  # Display board
  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # input to index function
  def input_to_index(action)
    action.to_i - 1
  end

  # turn-counter
  def turn_count()
    @board.select{|i| i=="X" || i=="O"}.length
  end

  # current_player
  def current_player()
    if turn_count() % 2 != 0
      "O"
    else
      "X"
    end
  end

  ###########################################
  def move(pos, character)
    @board[pos] = character
  end
  ###########################################

  # position_taken
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  # valid move
  def valid_move?(index)
    if position_taken?(index) == false && index < 9 && index >= 0
      true
    else
      false
    end
  end

  # TURN
  def turn()
    puts("Please enter 1-9:")
    action = input_to_index(gets.strip())
    if valid_move?(action)
      move(action,current_player())
      display_board()
    else
      while valid_move?(action) != true do
        puts("Please enter 1-9:")
        action = input_to_index(gets.strip())
        # valid_move(@board, action)
      end
      move(action,current_player())
      display_board()
    end
  end

  # WIN_COMBINATIONS constan
  #  win checker
  def won?()
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]
      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination
        break
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
        break
      end
    end
    false
  end

  # isfull checker
  def full?()
    @board.all?{|a| a!="" && a!=" " && a!= nil}
  end

  # draw checker
  def draw?()
    if !won?() && full?()
      true
    end
  end

  # returns true if won/draw/full@board else false
  def over?()
    if won?() || draw?() || full?()
      true
    else
      false
    end
  end

  # returns the winner
  def winner()
    if !won?()
      nil
    else
      to_check = won?()
      f = @board[to_check[0]]
      s = @board[to_check[0]]
      t = @board[to_check[0]]
      if f == "X" && s == "X" && t == "X"
        "X"
      elsif f == "O" && s == "O" && t == "O"
        "O"
      end
    end
  end

  # play
  def play()
    display_board()
    while !over?() do
      turn()
    end
    if won?()
      puts("Congratulations #{winner()}!")
    elsif draw?()
      puts("Cat's Game!")
    end
  end
end
