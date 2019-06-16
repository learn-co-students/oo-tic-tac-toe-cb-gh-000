class TicTacToe

  def initialize(board = [" "," "," "," "," "," "," "," "," "])
    @board = board
  end

  WIN_COMBINATIONS = [
    #Horizontal
    [0,1,2],
    [3,4,5],
    [6,7,8],
    #Vertical
    [0,3,6],
    [1,4,7],
    [2,5,8],
    #Diagonal
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
    input = input.to_i
    index = input - 1
  end

  def move(index,token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    if @board[index] == "X" || @board[index] == "O"
      true
    else
      false
    end
  end

  def valid_move?(index)
    if index.between?(0,8)
      if position_taken?(index)
        false
      else
        true
      end
    else
      false
    end
  end

  def turn
    puts "Enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      puts "Invalid move. Try Again."
      turn
    end
  end

  def turn_count
    @board.count{ |token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      if @board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X"
        return win_combination
      elsif @board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O"
        return win_combination
      else
        false
      end
    end
    false
  end

  def full?
    if @board.include?(" ")
      false
    else
      true
    end
  end

  def draw?
    if full? && !won?
      true
    else
      false
    end
  end

  def over?
    if won? || full? || draw?
      true
    else
      false
    end
  end

  def winner
    if won?
      @board[won?[0]]
    else
      nil
    end
  end

  def play
    until over?
      turn
      display_board
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    else
      nil
    end
  end
end # TIC TAC TOE CLASS
