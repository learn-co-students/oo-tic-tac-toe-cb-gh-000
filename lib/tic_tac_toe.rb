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

  def initialize(board=nil)
    @board = board || board = Array.new(9, " ")
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

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index] == nil || @board[index] == " ")
  end

  def valid_move?(index)
    return true if !position_taken?(index) && [0,1,2,3,4,5,6,7,8].include?(index)
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9"
    input = gets.strip
    index = input_to_index(input)
    player = current_player
    valid_move?(index) ? (move(index, player); display_board) : turn
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    pos_1 = @board[win_index_1]
    pos_2 = @board[win_index_2]
    pos_3 = @board[win_index_3]
    all_pos = [win_index_1, win_index_2, win_index_3].all? do |index|
      position_taken?(index)
    end

    ((return win_combination) if [pos_1, pos_2, pos_3].uniq.count == 1) if all_pos
    end
    return false
  end

  def full?
    num = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    all_pos = num.all? do |index|
      position_taken?(index)
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw? || full?
  end

  def winner
    winner = won?
    won? ? @board[winner[0]] : nil
  end

  def play
    until over?
        turn
      end
      puts "Congratulations #{winner}!" if won?
      puts "Cat's Game!" if draw?
  end
end
