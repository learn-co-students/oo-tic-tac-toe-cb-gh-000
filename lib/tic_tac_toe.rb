class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

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

  def move( index, current_player)
    @board[index] = current_player
  end

  def position_taken?( location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?( index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    @board.count {|pos|
       (pos == 'X' || pos == 'O')
     }
  end

  def current_player
    turn_count % 2 == 1 ? 'O' : 'X'

  end

  def won?
    WIN_COMBINATIONS.detect {|combination|
      @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]] && (position_taken?(combination[0]))
    }
  end

  def full?
    @board.all? {|element|
      element == 'O' || element == 'X'
    }
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    if won?
      @board[won?[0]]
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

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end

  end

end
