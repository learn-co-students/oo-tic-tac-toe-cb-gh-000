class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS =[
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

  def input_to_index(input)
    input.to_i - 1
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def move( index, value)
  @board[index] = value
  end

  def position_taken?(index)
    !(@board[index] == " " || @board[index] == "" || @board[index] == nil)
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def valid_move?(index)
  !position_taken?(index) and index.between?(0, 8)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      value = current_player
      move(index, value)
      display_board
    else
      puts "invalid input"
      turn
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
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
      end
    end
    return false
  end

  def full?
    @board.all?{|value| value == "X" or value == "O"}
  end

  def draw?
    won? == false and full?
  end

  def over?
    won? != false or draw? or full?
  end

  def winner
    winner = won?
    if winner != false
      if @board[winner[0]] == "X"
        "X"
      else
        "O"
      end
    else
      nil
    end
  end

  def play
    until over?
      turn
    end
    if won? != false
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
