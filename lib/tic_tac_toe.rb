class TicTacToe
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [2,5,8],
    [1,4,7],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    @user_input.to_i - 1
  end

  def move(index, player)
    @board[@index] = player
  end

  def position_taken?(index)
    !(@board[@index].nil? || @board[@index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    @input = gets.strip
    @index = input_to_index(@input)
    if valid_move?(@index)
      move(@index, @current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    x = @board.reject{|i| i==" "}
    x.length
  end

  def current_player
    turn_count%2==0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |com|
      i1 = com[0]
      i2 = com[1]
      i3 = com[2]
      char = @board[i1]
      if position_taken?(@i1) and position_taken?(i2) and position_taken?(i3) then
        if @board[i2]==char and @board[i3]==char then
          return com
        end
      end
    end
    return false
  end

  def full?
    @board.none?{|i| i==" "}
  end

  def draw?
    f = full?
    w = won?

    f and w ? false : true
  end

  def over?
    full? or won? ? true : false
  end

  def winner
    pos = won?
    pos ? @board[pos[0]] : nil
  end

  def play
    until over? do
      turn
      break if draw?
    end

    if won? then
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end