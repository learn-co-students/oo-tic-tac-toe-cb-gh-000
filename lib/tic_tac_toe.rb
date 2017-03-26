class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
  ]


  def initialize
    @board = Array.new(9, " ")
  end

  def won?
    WIN_COMBINATIONS.each do |wincombo|
        if (@board[wincombo[0]] == "X" && @board[wincombo[1]] == "X" && @board[wincombo[2]] == "X") || (@board[wincombo[0]] == "O" && @board[wincombo[1]] == "O" && @board[wincombo[2]] == "O")
          return wincombo
        end
      end
      false
  end

  def full?
    @board.all? do |square|
      square.include?("X") || square.include?("O")
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    if draw? || won? || full?
      true
    end
  end

  def winner
    wincombo = won?
    if wincombo != false
      return @board[wincombo[0]]
    end
    nil
  end

  def turn_count
    turns = 0
    @board.each do |square|
      if square.include?("X")  || square.include?("O")
        turns += 1
      end
    end
    turns
  end

  def current_player
    turns = turn_count
    if turns % 2 == 0
      "X"
    else
      "O"
    end
  end

  def valid_move?(index)
    if index >= 0 && index <=8 && !position_taken?(index)
      true
    else
      false
    end
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index].nil?
      false
    else
      true
    end
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
  end

  def move(index, token)
    @board[index] = token
    return @board
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    token = current_player
      if valid_move?(index)
        move(index, token)
        display_board
    else
      turn
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
