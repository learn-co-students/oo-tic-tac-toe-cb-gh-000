class TicTacToe
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

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{ @board[0]} | #{ @board[1]} | #{ @board[2]} "
    puts "-----------"
    puts " #{ @board[3]} | #{ @board[4]} | #{ @board[5]} "
    puts "-----------"
    puts " #{ @board[6]} | #{ @board[7]} | #{ @board[8]} "
  end

  def input_to_index(input)
      index = input.to_i - 1
  end

  def move(index, value="X")
     @board[index] = value
  end

  def position_taken?(index)
    if  @board[index] == " " ||  @board[index] == "" ||  @board[index] == nil
      return false
    elsif  @board[index] == "X" ||  @board[index] == "O"
      return true
    end
  end

  def valid_move?(index)
    if index.between?(0, 8) == true && position_taken?(index) == false
      return true
    else
      return false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index =  input_to_index(input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|item| item == "X" || item == "O"}
  end

  def current_player
    turn_count  % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each{|combination|
      win_index_1 = combination[0]
      win_index_2 = combination[1]
      win_index_3 = combination[2]

      if ( @board[win_index_1] == "X" &&  @board[win_index_2] == "X" &&  @board[win_index_3] == "X" ||  @board[win_index_1] == "O" &&  @board[win_index_2] == "O" &&  @board[win_index_3] == "O")
        return combination
      end
    }
    false
  end

  def full?
    @board.all?{|item| item == "X" || item == "O"}
  end

  def draw?
   !won? && full?
  end

  def over?
    won? || draw? || full? ? true : false
  end

  def winner
    won? ? @board[won?[0]] : nil
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner }!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
