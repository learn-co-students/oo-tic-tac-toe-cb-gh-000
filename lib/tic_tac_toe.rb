class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2], # Top Horizontal
    [3, 4, 5], # Middle Horizontal
    [6, 7, 8], # Bottom Horizontal

    [0, 3, 6], # Left Vertical
    [1, 4, 7], # Middle Vertical
    [2, 5, 8], # Right Vertical

    [0, 4, 8], # Diagonal LR
    [2, 4, 6]  # Diagonal RL
  ]

  def initialize()
    @board = [" ", " ", " ",
              " ", " ", " ",
              " ", " ", " "]
  end

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(pos)
    pos = pos.to_i - 1
  end

  def move(index, piece)
    @board[index] = piece
  end

  def position_taken?(index)
    result = nil
    if @board[index] == " " ||
      @board[index] == "" ||
      @board[index] == nil
      result = false
    elsif @board[index] == "X" ||
      @board[index] == "O"
      result = true
    end
    result
  end

  def valid_move?(index)
    result = false
    if index >= 0 &&
     index <= 8  &&
     !position_taken?(index)
     result = true
    end
    result
  end

  def turn_count()
    count = 0
    @board.each do |cell|
      if cell == "X" || cell == "O"
        count += 1
      end
    end
    count
  end

  def current_player()
    count = turn_count()
    current = "X"

    if count % 2 == 0
      current = "X"
    else
      current = "O"
    end
    current
  end


  def turn()
    puts "Please enter 1-9:";
    input = gets.strip;
    index = input_to_index(input);

    if valid_move?(index)
      move(index, current_player)
      display_board()
    else
      turn()
    end
  end


  def won?()
    # Check if empty board
    empty = @board.all? do |pos|
      pos == " " || pos == "" || pos == nil
    end

    if empty
      return false
    end

    win = WIN_COMBINATIONS.detect do |win|
      win1 = win[0]
      win2 = win[1]
      win3 = win[2]

      pos1 = @board[win1]
      pos2 = @board[win2]
      pos3 = @board[win3]

      pos1 == "X" && pos2 == "X" && pos3 == "X" ||
      pos1 == "O" && pos2 == "O" && pos3 == "O"
    end
  end

  def full?()
    all_full = @board.all? do |pos|
      pos != " "
    end
  end

  def draw?()
    full?() && !won?()
  end

  def over?()
    draw?() || full?() || won?()
  end

  def winner()
    win = won?()
    if (win.class == Array)
      return @board[win[0]]
    else
      return nil
    end
  end

  def play()
    while !over?
      turn()
    end

    if winner
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
