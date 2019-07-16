class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5],
    [6,7,8], [0,3,6],
    [1,4,7], [2,5,8],
    [0,4,8], [2,4,6]
  ]
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
    return index
  end

  def move(position, token)
    @board[position] = token
  end

  def position_taken?(position)
    if(@board[position] == "X" || @board[position] == "O")
      return true
    else
      return false
    end
  end

  def valid_move?(move)
    if(position_taken?(move) || move < 0 || move > 8)
      return false
    else
      return true
    end
  end

  def turn
    puts "Enter position 1-9"
    pos = input_to_index(gets)
    if(valid_move?(pos))
      move(pos, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count = 0
    @board.each do |el|
      if(el == "X" || el == "O")
        count += 1
      end
    end
    return count
  end

  def current_player
    if(turn_count%2 == 0)
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |comb|
      if (@board[comb[0]] == "X" && @board[comb[1]] == "X" && @board[comb[2]] == "X")
        return comb
      elsif (@board[comb[0]] == "O" && @board[comb[1]] == "O" && @board[comb[2]] == "O")
        return comb
      end
    end
    return nil
  end

  def full?
    @board.each do |el|
      if(el == " ")
        return false
      end
    end
    return true
  end

  def draw?
    if(!won? && full?)
      return true
    else
      return false
    end
  end

  def over?
    if(draw?|| won?)
      return true
    else
      return false
    end
  end

  def winner
    won = won?
    if(won)
       return @board[won[0]]
    end
    return nil
  end

  def play
    while(!over?)
      turn
    end

    if (won?)
      if(winner == "X")
        puts "Congratulations X!"
      else
        puts "Congratulations O!"
      end
    elsif (draw?)
      puts "Cat's Game!"
    end
  end
end
