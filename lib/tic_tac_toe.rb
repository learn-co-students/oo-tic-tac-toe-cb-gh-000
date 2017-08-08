class TicTacToe

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def input_to_index(index)
    return index.to_i - 1
  end

  def move(index, char)
    @board[index] = char
  end

  def position_taken?(index)
    if @board[index] == " " or @board[index] == "" or @board[index] == nil
      return false
    elsif @board[index] == "X" or @board[index] == "O"
      return true
    end
  end

  def valid_move?(position)
    index = position.to_i
    if position_taken?(index) == false && index.between?(0, 8)
      return true
    else
      return false
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
   WIN_COMBINATIONS.each do |win_combination|
     win_positions =  [@board[win_combination[0]], @board[win_combination[1]], @board[win_combination[2]]]
     if win_positions == ["X","X","X"] || win_positions == ["O","O","O"]
       return win_combination
     end
   end
   return false
  end

  def full?
   if @board.detect{|i| i == " "}
     return false
   else
     return true
   end
  end

  def draw?
   if full? == true && won? == false
     return true
   end
  end

  def over?
   if draw? == true or won?!= false
     return true
   else
     return false
   end
  end

  def winner
   if won? != false
     return @board[won?[0]]
   else
     return nil
   end
  end

  def play
    # main loop of the game won't stop until game is over
    until over? == true
      turn
    end

    winner_sym = winner
    if won? != false
      puts "Congratulations #{winner_sym}!"
    else
      puts "Cat's Game!"
    end
  end

end
