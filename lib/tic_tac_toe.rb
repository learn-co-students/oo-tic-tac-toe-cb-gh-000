

class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  def initialize(board=nil)
    @board=board || @board = Array.new(9," ")


  end



  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end



  def input_to_index(input)
    input.to_i-1
  end

  def move(index,token)
    @board[index] = token
  end

  def position_taken?(index)
       @board[index]!=" "
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end

  def turn
      puts "Enter a number between 1 and 9 "
      index = input_to_index(gets.to_i)
      if valid_move?(index)
        move(index,current_player)
        display_board
      else
        turn
      end
  end

  def turn_count
    count = 0
    @board.each do |cell|
      count +=1 if cell!=" "
    end
    count
  end

  def current_player
    turn_count % 2 ==0 ? "X":"O"
  end


  def won?

    WIN_COMBINATIONS.each do |win_combination|
      if @board[win_combination[0]] == @board[win_combination[1]] && @board[win_combination[1]] == @board[win_combination[2]] && @board[win_combination[1]] != " "
      return win_combination
    end
    end
    false
  end


  def full?
      state = @board.find{|cell| cell==" "}
      state ? false : true
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won?
  end

  def winner
    winner_state = won?
    winner_state ? @board[winner_state[0]] : nil
  end





  def play
    until won? || over? || draw?
      turn
    end
    winnerr = winner
    if winnerr
      puts "Congratulations #{winnerr}!"
    else
      puts "Cat's Game!"
    end

  end


end
