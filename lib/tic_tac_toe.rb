class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def play
    until over? do
      turn
    end
    if over?
      if draw?
        puts "Cat's Game!"
      elsif winner
        puts "Congratulations " + winner + "!"
      end
    end
  end

  # Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      winCombo = combo.all? do |index|
        @board[index] == "X"
      end
      if winCombo
        return combo
      end
      winCombo = combo.all? do |index|
        @board[index] == "O"
      end
      if winCombo
        return combo
      end
    end
    return false
  end

  def full?
    @board.none? {|gameitem| gameitem == " "} #=> true
  end

  def draw?
    !won? && full?
  end

  def over?
    if draw? || won?
      return true
    else
      return false
    end
  end

  def winner
    itemList = won?
    if itemList
      return @board[itemList[0]]
    else
      return nil
  end
  end

  def turn_count
    round = 0
    @board.each do |boarditem|
      if boarditem  == "X" or boarditem  == "O"
        round +=1
      end
    end
    return round
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
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
      move(index, current_player)
      display_board
    else
      turn
    end
  end

end
