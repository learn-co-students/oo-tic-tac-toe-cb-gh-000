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

  def initialize
    @board = Array.new(9, " ")
  end

  def check_win_combination?(player, win_combination)
    win_combination.all? do |position|
      @board[position] == player
    end
  end

  def congratulate
    if winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

  def current_player
    turns = turn_count
    if turns % 2 > 0
      "O"
    else
      "X"
    end
  end

  def display_board
    divider = "-----------"
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts divider
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts divider
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def draw?
    (!won? && full?)
  end

  def full?
    @board.all? do |position|
      position == "X" || position == "O"
    end
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(position, player)
    @board[position] = player
  end

  def over?
    won? || draw? || full?
  end

  def play
    until over?
      turn
    end
    congratulate
  end

  def position_taken?(index)
    @board[index] == 'X' || @board[index] == 'O'
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

  def turn_count
    moves = 0
    @board.each do |space|
      if space == "X" || space == "O"
        moves += 1
      end
    end
    return moves
  end

  def valid_move?(index)
    if index < 0 || index > 8 || position_taken?(index)
      return false
    end
    return true
  end

  def winner
    if won?
      @board[won?[0]]
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      if check_win_combination?("X", win_combination)
        return win_combination
      elsif check_win_combination?("O", win_combination)
        return win_combination
      end
    end
    return false
  end

end
