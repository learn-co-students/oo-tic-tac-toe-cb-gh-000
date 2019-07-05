class TicTacToe
  def initialize ()
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " " ]
  end
  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "

  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, player)
      @board[index] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    (index > -1 && index < 9 && !position_taken?(index) )
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      player = current_player
      move(index, player)
      display_board
    else
      turn
    end
  end
  def turn_count
    count = 0
    @board.each {|value|
      if value == "X"
        count +=1
      end
      if  value == "O"
        count += 1
      end
    }
    return count
  end
  def current_player
    if turn_count.even?
      return "X"
    else
      return "O"
    end
  end
  def won?
    if @board.all?{|value| value == " "}
      return false
    else
      WIN_COMBINATIONS.each do |combi|
          if @board[combi[0]] == @board[combi[1]] && @board[combi[1]] == @board[combi[2]] && @board[combi[0]] != " "
            return combi
          end
      end
        return nil
      end
  end
  def full?
    @board.none?{|value| value == " "}
  end

  def draw?
    !won? && full?
  end

  def over?
    draw? || won?
  end

  def winner
  arr = won?
    if arr
      return @board[arr[0]]
    else
      return nil
    end
  end
  def play
    if !over?
      turn
      play
    else
      if draw?
        puts "Cat's Game!"
      else
        puts "Congratulations #{winner}!"
      end
    end
  end


end
