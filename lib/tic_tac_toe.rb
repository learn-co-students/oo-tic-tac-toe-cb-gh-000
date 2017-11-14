class TicTacToe

  def initialize(board=nil)
    @board = board || Array.new(9," ")
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

  def move(index,player)
    @board[index] = player
  end

  def position_taken?(position)
    @board[position] == "X" || @board[position]  == "O"
  end

  def valid_move?(position)
    position.between?(0,8) && !position_taken?(position)
  end

  def turn
    puts "Please enter position between 1-9"
    position = input_to_index(gets.strip)
    until valid_move?(position)
      puts "Please enter position between 1-9"
      position = input_to_index(gets.strip)
    end
    player = current_player
    move(position,player)
    display_board
  end

  def turn_count
    @board.count{ |x| x == "X" || x == "O"}
  end

  def current_player
    turn_count % 2 == 0?"X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      if (@board[win_combination[0]]=="X" && @board[win_combination[1]]=="X" && @board[win_combination[2]]=="X") || (@board[win_combination[0]]=="O" && @board[win_combination[1]]=="O" && @board[win_combination[2]]=="O")
        return win_combination
      end
    end
    false
  end

  def full?
    @board.count{|x| x == " "} == 0
  end

  def draw?
   (!won? && full?)
  end

  def over?
    won? || full? || draw?
  end

  def winner
    a = won?
    !a ? nil : @board[a[0]]
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
