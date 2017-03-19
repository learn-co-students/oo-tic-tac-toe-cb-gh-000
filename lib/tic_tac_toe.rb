class TicTacToe
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
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    number = index.to_i - 1
  end

  def move(index, character)
    @board[index] = character;
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      character = current_player
      move(index, character)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |turn|
      if turn != " "
        counter += 1
      end
    end

    return counter
  end

  def current_player
    counter = turn_count
    if counter % 2 == 0
      turn = "X"
    else
      turn = "O"
    end
  end

  def won?
    x_turns = x_index
    o_turns = o_index
    if x_turns.empty? && o_turns.empty?
      return nil
    end
    WIN_COMBINATIONS.detect do |win_combination|
      (x_turns & win_combination).sort == win_combination.sort || (o_turns & win_combination).sort == win_combination.sort
    end
  end

  def full?
    empty_turns = @board.select do |position|
      position.strip == ""
    end

    empty_turns.empty?
  end

  def draw?
    (won? == nil) && full?
  end

  def over?
    draw? || won?
  end

  def winner
    x_turns = x_index
    o_turns = o_index
    winner = nil
    if won? != nil
      if (x_turns & won?).sort == won?.sort
        winner = "X"
      elsif (o_turns & won?).sort == won?.sort
        winner = "O"
      end
    end
  end

  # Define your play method below
  def play
    until over?
      turn
    end

    if winner == "X"
      puts "Congratulations X!"
    elsif winner == "O"
      puts "Congratulations O!"
    else
      puts "Cat's Game!"
    end

  end

  def x_index
    @board.each_index.select do |i|
      @board[i] == "X"
    end
  end

  def o_index
    @board.each_index.select do |i|
      @board[i] == "O"
    end
  end

end