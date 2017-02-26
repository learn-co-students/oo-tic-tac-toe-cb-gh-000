class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8]
  ]
  def initialize()
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i
    index -= 1
  end

  def move(index, char="X")
    @board[index] = char
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if position_taken?(index) || index > 8 || index < 0
      return false
    else
      return true
    end
  end

  def turn
    puts "Please enter 1-9:"
    index = gets.strip
    index = input_to_index(index)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      while !valid_move?(index)
        puts "Please enter 1-9:"
        index = gets.strip
        index = input_to_index(index)
      end
    end
  end

  def turn_count
    count = 0
    @board.each {|i|
      if i != " " && i != ""
        count += 1
      end
    }
    return count
  end

  def current_player
    count = turn_count
    count % 2 == 0 ? "X" : "O"
  end

  def won?
    won = []
    combo = []
    WIN_COMBINATIONS.each do |combination|
      p_1 = @board[combination[0]]
      p_2 = @board[combination[1]]
      p_3 = @board[combination[2]]
      if p_1 == "X" && p_2 == "X" && p_3 == "X"
        won << "X"
        combo = combination
      elsif p_1 == "O" && p_2 == "O" && p_3 == "O"
        won << "O"
        combo = combination
      end
    end
    if won.find{|i| i == "X"} && won.find{|i| i == "O"}
      return false
    elsif won.find{|i| i == "X"} || won.find{|i| i == "O"}
      return combo
    else
      return false
    end
  end

  def full?
    if @board.find{|i| i == " "} || @board.find{|i| i == ""}
      return false
    else
      return true
    end
  end

  def draw?
    i = full?
    j = won?
    if i && !j
      return true
    else
      return false
    end
  end

  def over?
    draw = draw?
    win = won?
    if draw
      return true
    elsif win
      return true
    else
      return false
    end
  end

  def winner
    if won?
      combo = won?
      winner = @board[combo[0]]
      return winner
    else
      return nil
    end
  end

  def play
    while !over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    end
    name = winner
    puts "Congratulations #{name}!"
  end
end
