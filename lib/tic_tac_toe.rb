class TicTacToe

  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6],[1,4,7],[2,5,8]]

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

  def move(index, current_player ="X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index,current_player())
      display_board()
    else
      turn()
    end
  end

  def turn_count
    count = 0
    @board.each do |element|
      if element != " "
        count += 1
      end
    end
    return count
  end

  def current_player
    if turn_count() % 2 == 0
      "X"
    else turn_count() % 2 == 1
      "O"
    end
  end

  def won? ()

    #empty field
    empty = @board.all? do |field|
      field == " "
    end

    if empty
      return false
    end

    #win
    WIN_COMBINATIONS.each do |set1|
      if (@board[set1[0]] == @board[set1[1]] && @board[set1[1]]  == @board[set1[2]])
        if (@board[set1[0]] != " ")
          return set1
        end
      end
    end

    #draw

    if(full?() == true)
      return false
    end

  end

  def full? ()
    emptyfield = @board.detect do |field|
      field == " "
    end

    if (emptyfield == nil)
      return true
    else
      return false
    end
  end


  def draw?

      wina = won?()
    if !(wina == false)
      return false
    end

    if(full?() == true)
      return true
    end
  end

  def over? ()
  if draw?()
    return true
  end

  if won?()
    return true
  else
    return false
  end
end

def winner ()

  if draw?()
    return nil
  end
  if won?()

  WIN_COMBINATIONS.each do |set1|
    if (@board[set1[0]] == @board[set1[1]] && @board[set1[1]]  == @board[set1[2]])
      if (@board[set1[0]] == "X")
        return "X"
      end
      if (@board[set1[0]] == "O")
        return "O"
      end
    end
  end
end
end

def play()
  while !over?()
    turn()
  end
  if won?()
    puts "Congratulations #{winner()}!"
  elsif draw?()
    puts "Cat's Game!"
  end
end


end
