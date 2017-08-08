class TicTacToe
  def initialize(board=Array.new(9) {" "})
    @board=board
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,4,8], # Right diagonal
    [2,4,6], # Left diagonal
    [0,3,6], # Left column
    [1,4,7], # Center column
    [2,5,8]  # Right column
  ]

  def display_board
    table=Array.new()
    table << " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    table.push("-----------")
    table.push(" #{@board[3]} | #{@board[4]} | #{@board[5]} ")
    table.push("-----------")
    table.push(" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
    for i in table
      puts i
    end
  end

  def input_to_index(index)
    return index.to_i - 1
  end

  def move(index,player="X")
    @board[index]=player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index > @board.length() || index < 0
      return false
    else
      return !position_taken?(index)
    end
  end

  def turn
    puts "Please enter 1-9:"
    index=input_to_index(gets.strip)

    if valid_move?(index)==false
      puts "Index move not valid."
      turn
    else
      move(index,current_player)
    end
    display_board
  end

  def turn_count
    cont=0
    @board.each do |var|
      if var==" "
        cont+=1
      end
    end
    return 9 - cont
  end

  def current_player
    num=turn_count
    if num.even?
      return "X"
    end
    return "O"
  end

  def won?
    res = nil
    WIN_COMBINATIONS.each do |combination|
      winX=combination.all? do |index|
        @board[index].eql?("X")
      end
      winO=combination.all? do |index|
        @board[index].eql?("O")
      end

      if winX==true || winO==true
        res = combination
      end

    end

    return res
  end

  def full?
    !@board.any? do |var|
      var.eql?(" ")
    end
  end

  def draw?
    if full? == true and won? == nil
      return true
    end

    return false
  end

  def over?
    full?||won?||draw?
  end

  def winner
    player=won?

    if player == nil
      return nil
    else
      @board[player[0]]
    end
  end

  def play
    while over? == false
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
