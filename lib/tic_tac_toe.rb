class TicTacToe
  def initialize
    @board = Array.new(9," ")
  end

  WIN_COMBINATIONS=[
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index,value)
    @board[index] = value
  end

  def position_taken?(index)
    return @board[index]=="X" || @board[index]=="O"
  end

  def valid_move?(index)
    if index<0 || index>8
      return false
    end

    return @board[index] == " "
  end

  def turn_count
    return @board.count("X") + @board.count("O")
  end

  def current_player
    return turn_count % 2 ==0 ? "X" : "O"
  end

  def turn
    input = gets.strip
    index = input_to_index(input)
    until valid_move?(index) do
      input = gets.strip
      index = input_to_index(input)
    end
    move(index,current_player)
    display_board
  end

  def won?
    WIN_COMBINATIONS.each do |combi|
      if combi.all? { |e| @board[e]=="X"  } || combi.all? { |e| @board[e]=="O" }
        return combi
      end
    end
    return false
  end

  def draw?
    return full? && !(won?)
  end

  def full?
    return !(@board.any? { |e| e==" "  })
  end

  def over?
    return draw? || won?
  end

  def winner
    if won?
      return @board[won?[0]]
    else
      return nil
    end
  end

  def play
    puts "Enter position 1-9: "
    until over? do
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end


  end
end
