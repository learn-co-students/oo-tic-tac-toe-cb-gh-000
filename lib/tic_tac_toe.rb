class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(i)
    (i.to_i) - 1
  end

  def move(i, player="X")
    @board[i] = player
  end

  def position_taken?(i)
    !(@board[i] == " " || @board[i] == "" || @board[i] == nil)
  end

  def valid_move?(i)
    (i >= 0 && i <= 8) && !position_taken?(i)
  end

  def turn_count()
    counter = 0
    @board.each do |square|
      if square == "X" || square == "O"
        counter += 1
      end
    end
    counter
  end

  def current_player()
    turn_count.even? ? "X" : "O"
  end

  def turn()
    puts "Please enter 1-9:"
    input = gets
    parsed_input = input_to_index(input)
    cp = current_player()
    if valid_move?(parsed_input)
      move(parsed_input, cp)
      display_board()
    else
      turn()
    end
  end

  def won?()
    has_won = false
    WIN_COMBINATIONS.each do |win_combo|
      win_pos_1 = win_combo[0]
      win_pos_2 = win_combo[1]
      win_pos_3 = win_combo[2]

      pos_1 = @board[win_pos_1]
      pos_2 = @board[win_pos_2]
      pos_3 = @board[win_pos_3]

      if position_taken?(win_pos_1) && position_taken?(win_pos_2) &&
         position_taken?(win_pos_3)

         pos_1 = @board[win_pos_1]
         pos_2 = @board[win_pos_2]
         pos_3 = @board[win_pos_3]

         if pos_1 == pos_2 && pos_2 == pos_3
           has_won = win_combo
           break
         end
      end
    end
    has_won
  end

  def full?()
    is_full = @board.all? do |square|
      square == "X" || square == "O"
    end
  end

  def draw?()
    !won?() && full?()
  end

  def over?()
    won?() || full?() || draw?()
  end

  def winner()
    w = won?()
    if w != false
      @board[w[0]]
    else
      nil
    end
  end

  def play()
    until over?() do
      turn()
    end

    if won?()
      w = winner()
      puts "Congratulations #{w}!"
    elsif draw?()
      puts "Cat's Game!"
    end
  end
  
end