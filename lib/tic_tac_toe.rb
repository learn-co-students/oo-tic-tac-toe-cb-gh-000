class TicTacToe
  def initialize(board= nil)
    @board = board || Array.new(9," ")
  end

  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
]
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index,mark)
    @board[index]=mark
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0,8) && @board[index] == " "
      return true
    else
      return false
    end
  end

  def turn_count
    counter = 0
    @board.each do |occupied|
      if occupied != " "
        counter += 1
      end
    end
    counter
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end

  def won?
    win = []
    WIN_COMBINATIONS.each do |win_combination|
      index_1 = win_combination[0]
      index_2 = win_combination[1]
      index_3 = win_combination[2]
      win_combination.each do |index|
        if @board[index_1] == "X" && @board[index_2] == "X" && @board[index_3] == "X"
          win << index
        elsif @board[index_1] == "O" && @board[index_2] == "O" && @board[index_3] == "O"
          win << index
        end
      end
    end
    if win == []
      false
    else
      win.to_ary
    end
  end

  def full?
    if @board.detect{|empty_space| empty_space == " "}
      false
    else
      true
    end
  end

  def draw?
    if full? && !won?
      true
    else
      false
    end
  end

  def over?
    if won? || draw? || full?
      true
    else
      false
    end
  end

  def winner
    if won?
      array = won?
      index1 = array[0]
      if @board[index1] == "X"
        "X"
      elsif @board[index1] == "O"
        "O"
      elsif draw?
        nil
      end
    end
  end


  def play
    count = 0
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      if draw?
        puts "Cat's Game!"
      end
    end
  end
end
