class TicTacToe
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[1,4,7],[2,5,8],[0,4,8],[6,4,2],[0,3,6]]
  def initialize(board=nil)
    @board=Array.new(9," ") || board
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def move(index,token)
    @board[index]=token
  end

  def input_to_index(index)
    index.to_i - 1
  end

  def turn
    puts "Please enter 1-9:"
    index=input_to_index(gets.strip)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count=0
    @board.each do |item|
      if item == "X" || item == "O"
        count+=1
      end
    end
    count
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if (@board[combo[0]]=="X" && @board[combo[1]]=="X" && @board[combo[2]]=="X") || (@board[combo[0]]=="O" && @board[combo[1]]=="O" && @board[combo[2]]=="O")
        return combo
      end
    end
    false
  end

  def full?
    @board.all? { |i| i=="X" || i=="O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    !!won?||full?||draw?
  end

  def winner
    !won? ? nil : @board[won?[0]]
  end

  def play
    until over?
      turn
    end
    won? ? puts("Congratulations #{winner}!") : puts("Cat's Game!")
  end
end
