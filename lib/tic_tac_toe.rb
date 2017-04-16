class TicTacToe

  def initialize()
    @board = Array.new(9, " ")
  end

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
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

  def won?()
    WIN_COMBINATIONS.each do |win|
      win_comb_1 = win[0]
      win_comb_2 = win[1]
      win_comb_3 = win[2]
      pos_1 = @board[win_comb_1]
      pos_2 = @board[win_comb_2]
      pos_3 = @board[win_comb_3]

      if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
        return ([win_comb_1, win_comb_2, win_comb_3])
      elsif pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
        return ([win_comb_1, win_comb_2, win_comb_3])
      end
    end
    return false
  end

  def full?()
    @board.each do |b|
      if b == " "
        return false
      end
    end
    return true
  end

  def draw?()
    full = full?
    won = won?
    if full == true && won == false
      return true
    else
      return false
    end
  end

  def over?()
    if won? != false || draw? == true
      return true
    else
      return false
    end
  end

  def winner()
    if won? != false
      position = won?[0]
      return @board[position]
    end
  end

  def input_to_index(move)
  return move.to_i - 1
  end

  def move(position, char)
    @board[position] = char
  end

  def valid_move?(board = @board, index)
    if position_taken?(board, index) == false && index <= 8 && index >= 0
      return true
    else
      return false
    end
  end

  # re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
  def position_taken?(board = @board, index)
    if board[index] == "X" || board[index] == "O"
      return true
    else
      return false
    end
  end

  def welcome()
    puts "Welcome to Tic Tac Toe!"
  end

  def turn()
    puts "Please enter 1-9:"
    position = gets.strip
    index = input_to_index(position)
    if valid_move?(index) == true
      move(index, current_player())
      display_board()
    else
      turn()
    end
  end

  def turn_count()
    turn_left = 0
    @board.each do |turn|
      if turn == "X" || turn == "O"
        turn_left += 1
      end
    end
    return turn_left
  end

  def current_player()
    turns = turn_count()
    if turns % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def play()
    until over? == true
      turn()
      if won?() != false
        puts "Congratulations #{winner()}!"
      end
    end
    if draw?() == true
      puts "Cat's Game!"
    elsif won?() != false
      puts "Congratulations #{winner()}!"
    end
  end



end
