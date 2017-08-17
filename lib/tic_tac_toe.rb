class TicTacToe

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

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

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return "#{input}".to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    @player = current_player
    puts "Please enter 1-9:"
    @input = gets.strip
    @index = input_to_index(@input)
    if valid_move?(@index)
      move(@index, @player)
      display_board
    else
      puts "Invalid input!"
      turn
    end
  end

  def turn_count
    return @board.count("X") + @board.count("O")
  end

  def current_player
    @counter = 0
    @counter = turn_count
    @player = @counter.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |member|

     @position_1 = @board[member[0]];
     @position_2 = @board[member[1]];
     @position_3 = @board[member[2]];

     if (@position_1 == "X" && @position_2 == "X" && @position_3 == "X")
       return member;
     elsif (@position_1 == "O" && @position_2 == "O" && @position_3 == "O")
       return member;
     end
    end
    return false;
  end

  def full?
    if @board.detect{|el| el == " "} == nil
      return true
    else
      return false
    end
  end

  def draw?
    if full? && !won?
      return true
    else
      return false
    end
  end

  def over?
    if full? || won? || draw?
      true
    else
      false
    end
  end

  def winner
    if won? && @board.count("O") > @board.count("X")
      return "O"
    elsif  won? && @board.count("X") > @board.count("O")
      return "X"
    else
      return nil
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else draw?
      puts "Cat's Game!"
    end
  end

end
