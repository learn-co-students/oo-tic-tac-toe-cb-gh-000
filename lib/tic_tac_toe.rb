class TicTacToe
  def initialize()
    @board = Array.new(9, " ")
  end
  WIN_COMBINATIONS =[
    [0,1,2],#horizontal
    [3,4,5],
    [6,7,8],
    [0,3,6], #vertical
    [1,4,7],
    [2,5,8],
    [0,4,8], #diagonals
    [2,4,6]
  ]
  def input_to_index(usersMove)
  index = usersMove.to_i - 1
  end
  def move(index, player_char = "X")
  @board[index] = player_char
  end
  def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
  end
  def valid_move?(index)
    if index.between?(0,9) && !position_taken?(index)
      true
    else
      false
    end
  end
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index,current_player
      display_board
    else
      turn
    end
  end
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  def won?
      if !@board.include?("X") && !@board.include?("Y")
        return false
      end
      winner = Array.new

      WIN_COMBINATIONS.each{|combination|
        x_wins = @board[combination[0]].strip == "X" && @board[combination[1]].strip == "X" && @board[combination[2]].strip == "X"
        y_wins = @board[combination[0]].strip == "O" && @board[combination[1]].strip == "O" && @board[combination[2]].strip == "O"

        if x_wins || y_wins
          winner = combination
        end

      }
      if winner.empty?
        return false
      else
        return winner
      end
  end
  def full?
    !@board.include?(" ")

  end
  def draw?
    full? && !won?
  end
  def over?
    won? || draw? || full?
  end
  def winner

     row = won?
     if row == false
       return nil
    else
      return @board[row[0]]
    end
  end
  def play
    while over? == false
      turn
    end
    if won?
      wins = winner(board)
      "Congratulations #{wins}!"
    elsif draw?
      "Draw"
    end
  end
end
