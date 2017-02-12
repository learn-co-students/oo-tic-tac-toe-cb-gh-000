class TicTacToe
  def initialize()
    @board = Array.new(9, " ")
  end

  def board
    @board
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

  def display_board()
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(input)
    input = input.to_i - 1
  end

  def move(index,token = "X")
    board[index] = token
  end

  def position_taken? (index)
    (board[index] == "X" || board[index] == "O") ? true : false
  end

  def valid_move? (index)
    (index.between?(0,8) && !position_taken?(index)) ? true : false
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if (valid_move?(index))
        move(index, current_player())
        display_board()
    else
      turn()
    end
  end

  def turn_count
    board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    (turn_count() % 2 == 0) ? "X" : "O"
  end

  def won?
    temp = false
    WIN_COMBINATIONS.each do |row|
      win_index_1 = row[0]
      win_index_2 = row[1]
      win_index_3 = row[2]
      if (board[win_index_1] == "X" && board[win_index_2] == "X" && board[win_index_3] == "X")
        temp = row
      elsif(board[win_index_1] == "O" && board[win_index_2] == "O" && board[win_index_3] == "O")
        temp = row
      end
    end
    temp
  end

  def full?
   full = true
   board.each do |val|
     if (val.nil? || val == " " || val == "")
        full = false
      end
   end
   full
  end

  def draw?
    temp = true
    (!won?() && full?()) ? temp : temp = false
  end


  def over?
    if (won?() || draw?())
      true
    else
      false
    end
  end

  def winner
    val = nil
    if (won?())
      temp = won?()
      val = board[temp[0]]
    end
  end

  def play
    while !over?()
      turn()
    end
    if (won?())
       val = winner()
       puts "Congratulations #{val}!"
    elsif (draw?())
       puts "Cat's Game!"
    end
  end
end
