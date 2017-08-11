class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
    [0,1,2], #top row
    [3,4,5], #middle
    [6,7,8], #bottom row
    [0,3,6], #left columnt
    [1,4,7], #middle
    [2,5,8],  #right
    [0,4,8], #diagonal left
    [2,4,6] #diagonal right
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

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    @input = gets.strip
    @index = input_to_index(@input)
    @player = current_player
    if valid_move?(@index)
      move(@index, @player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @counter = 0;
    @board.each do |member|
      if member == "X" || member == "O"
              @counter += 1;
      end
    end
    return @counter;
  end

  def current_player
  if(turn_count % 2 == 1)
      return "O";
    else
      return "X";
    end
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
    if @board.any? { |member| member == " " }
      return false;
    else
      return true;
    end
  end

  def draw?
    if won?
      return false;
    elsif full?
      return true;
    else
      return false;
    end
  end

  def over?
    if draw?
      return true;
    elsif won?
      return true;
    else
      return false;
    end
  end

  def winner
    if draw?
      return nil;
    elsif won?
      @member = won?
      @grab_letter = @member[0];
      return @board[@grab_letter]
    else
      return nil;
    end
  end

  def play
    while !over?
      turn
    end

    if(won?)
      puts "Congratulations " + winner + "!"
    else
      puts "Cat's Game!"
    end
  end
#end of class
end
