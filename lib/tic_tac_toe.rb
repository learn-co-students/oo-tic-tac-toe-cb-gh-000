class TicTacToe
  def initialize(board=nil)
    @board = board || Array.new(9," ")
  end
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

  def display_board
    print " #{@board[0]} | #{@board[1]} | #{@board[2]} \n-----------\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n-----------\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move( index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end
  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    turns = 0
    @board.each do | position |
      if position != " "
        turns +=1
      end
    end
    turns
  end
  def current_player
    turn = turn_count
    if turn % 2 == 0
      "X"
    else
      "O"
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    while !valid_move?(index)
      input = gets.chomp
      index = input_to_index(input)
    end
    move(index,current_player)
    display_board
  end

  def won?
    counter=0
    condition = true
    combination = nil
    while counter < WIN_COMBINATIONS.size
      ind1 = WIN_COMBINATIONS[counter][0]
      ind2 = WIN_COMBINATIONS[counter][1]
      ind3 = WIN_COMBINATIONS[counter][2]
      pos1 = @board[ind1]
      pos2 = @board[ind2]
      pos3 = @board[ind3]
      if (pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O")
        combination = [ind1,ind2,ind3]
      end
      counter+=1
    end
    if combination == nil
      false
    else
      combination
    end
  end
  def full?
    !(@board.any?{|i| i==" "})
  end

  def draw?
    if full?
      if won?!=false
        false
      else
        true
      end
    else
      false
    end
  end
  def over?
    if draw?
      true
    elsif won?!=false
      true
    elsif !(full?)
      false
    end
  end

  def winner
    if over?
      if won?!=false
        var=won?
        @board[var[0]]
      else
        nil
      end
    end
  end

  def play
    while !over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    elsif winner!=nil
      puts "Congratulations #{winner}!"
    end
  end

end
