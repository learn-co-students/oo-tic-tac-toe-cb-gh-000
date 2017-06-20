class TicTacToe

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    @board = Array.new(9," ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    return index.to_i - 1
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index > -1 and index < 9 and !(position_taken?(index))
  end

  def move(index, value)
    @board[index] = value
  end

  def turn_count
    counter = 0
    @board.each do |e|
      counter += 1 unless e == " "
    end
    counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    win_combo = nil
    WIN_COMBINATIONS.each do |winning_combo|
      positions = [nil,nil,nil]
      winning_combo.each_with_index do |comboSpace, index|
          positions[index] = @board[comboSpace]
      end
      ["X","O"].each do | player |
        if positions.all?{|pos| pos==player}
          win_combo = winning_combo
        end
      end
    end
    win_combo
  end

  def full?
    @board.all?{|pos| pos != " "}
  end

  def draw?
    full? and not won?
  end

  def over?
    won? or draw?
  end

  def winner
    winning_positions = won?
    if !winning_positions.nil?
      winning_player = winning_positions[0]
      @board[winning_player]
    else
      nil
    end
  end

  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip.to_i)
    if valid_move?(index)
      player = current_player
      move(index, player)
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
    else
      puts "Cat's Game!"
    end
  end


end
