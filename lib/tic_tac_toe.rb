class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
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

  def move(index, player = "X")
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != ""
  end

  def valid_move?(index)
    if index.between?(0,8) && position_taken?(index) != true
      true
    else
      false
    end
  end

  def turn_count
    counter = 0
    @board.each do |item|
      if item == "X" || item == "O"
        counter += 1
      else
        nil
      end
    end
    counter
  end

  def current_player
    if turn_count.even?
      "X"
    else
      "O"
    end
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

  def won?
    WIN_COMBINATIONS.detect do |win_index|
      if @board[win_index[0]] == "X" && @board[win_index[1]] == "X" && @board[win_index[2]] == "X"
        return win_index
      elsif @board[win_index[0]] == "O" && @board[win_index[1]] == "O" && @board[win_index[2]] == "O"
        return win_index
      else
        false
      end
    end
  end

  def full?
    !@board.include?(" ")
  end


  def draw?
    if won?
      return false
    elsif full?
      return true
    else
      return false
    end
  end

  def over?
    if full? || won?
      true
    else
      false
    end
  end

  def winner
    winner = won?
    if !winner
      nil
    else
      @board[winner[0]]
    end
  end

  def play
    while !over?
      turn
      if draw? || won?
        break
      end
    end
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
  end
end
