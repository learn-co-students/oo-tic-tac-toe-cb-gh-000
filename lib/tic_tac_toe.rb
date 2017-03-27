class TicTacToe
  def initialize(thisboard=[" "," "," "," "," "," "," "," "," "])
    @board = thisboard
  end
  WIN_COMBINATIONS=[
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
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    @index=input.to_i - 1
  rescue ArgumentError
    -1
  end
  
  def move(index, value)

    @board[index]=value
  end

  def position_taken?(index)
    if @board[index] == " " ||  @board[index] == "" ||  @board[index] == nil

      false
    elsif @board[index] == "X" || @board[index] == "O"
      true
    end

  end

  def valid_move?(index)
      if position_taken?(index) == false && index.between?(0,8)
        true
      elsif position_taken?(index) == true
        false

      elsif !index.between?(0,8)
        false

      end
  end
  
  def turn

    puts "Please enter 1-9:"
    input = gets.strip

    index=input_to_index(input)
    until valid_move?(index)
      puts "invalid move, please try again"
      input = gets.strip

      index=input_to_index(input)

    end
    move(index, current_player)
    display_board
  end

  
  def turn_count
    count=0
    @board.each do |iter|
      if iter == "X" || iter == "O"
        count+=1
      end
    end
    count
  end
  
  def current_player
    if turn_count%2 ==0
      "X"
    elsif turn_count%2==1
      "O"
    end
  end

  
  def won?

    position=Array.new
    combination=[]
    WIN_COMBINATIONS.each do|combination|
      combination.each do|index|
        position.push(@board[index])
      end
      if position == ["X", "X", "X"] || position == ["O","O", "O"]
        return combination
      else
        position.clear
      end

    end
    return false
  end

  
  def full?
    @board.each do|element|
      if element == " " || element == "" || element==nil
        return false
      end
    end
  end
  
  def draw?
    won = won?
    full = full?
    if won == false && full != false
      return true
    else
      return false
    end
  end

  
  def over?
    if won? || draw? || full?
      return true
    else
      return false
    end
  end

  def winner
    temp = Array.new
    index =[]
    if over? && won? !=false
      won_index = won?
      if won_index != false
        won_index.each do|index|
          temp.push(@board[index])
        end
        if temp == ["X", "X","X"]
          return "X"
        elsif temp ==["O", "O", "O"]
          return "O"
        end
      end
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"

    elsif draw?
      puts "Cat's Game!"
    end
  end







end