# Helper Method

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  # Horizontal Wins
  [0,1,2],
  [3,4,5],
  [6,7,8],
  # Vertical Wins
  [0,3,6],
  [1,4,7],
  [2,5,8],
  # Diagonal Wins
  [0,4,8],
  [2,4,6]
]

class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def won?
    WIN_COMBINATIONS.find do |win|
      if @board[win[0]] != "" && @board[win[0]] != " " && @board[win[0]] == @board[win[1]] && @board[win[1]] == @board[win[2]]
        return win
      end
    end
  end

  def full?
    @board.none? { |space| space == "" || space == " " }
  end

  def draw?
    full? && !won?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    winner = won?
    if winner != nil
      winner_index = winner[0]
      return @board[winner_index]
    end
  end

  def turn_count
    turns = 0
    @board.each do |space|
      if !(space == "" || space == " " || space == nil)
        turns +=1
      end
    end
    turns
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

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    valid_move = false
    until valid_move
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      valid_move = valid_move?(index)
    end
    move(index, current_player)
    display_board
  end

  def play
    until over? || draw?
      turn
    end
    if winner != nil
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
