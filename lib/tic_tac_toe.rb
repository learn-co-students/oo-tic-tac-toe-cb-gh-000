class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]
  def initialize(board= nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O" ? true : false
  end

  def valid_move?(input)
    input.between?(0,8) && !position_taken?(input) ? true : false
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Enter Input"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      token = current_player
      move(index,token)
    else
      turn
    end

    display_board
  end

  def won?
    token = current_player
    game_state = false
    WIN_COMBINATIONS.each do |i|
      if @board[i[0]] == "X" && @board[i[1]] == "X" && @board[i[2]] == "X" || @board[i[0]] == "O" && @board[i[1]] == "O" && @board[i[2]] == "O"
        return i
        break
      end
    end
    game_state
  end

  def full?
    turn_count == 9 ? true : false
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    if won?
      winning_combo = won?
      @board[winning_combo[0]]
    end
  end

  def play
    while !over?
      turn
    end

  if draw?
    puts "Cat's Game!"
  elsif won?
    puts "Congratulations #{winner}!"
  end
  end

end
