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
    @board = Array.new(9, ' ')
  end

  def display_board
    for j in 0...3
      puts "-----------" if j > 0
      for i in 0...3
         if i > 0 then print "| #{@board[(j*3)+i]} " else print " #{@board[(j*3)+i]} " end
      end
      puts
    end
  end

  def input_to_index(input)
    if input.empty? then -1 else input.to_i - 1 end
  end

  def move(player_choice, player_char)
    @board[player_choice] = player_char
  end

  def position_taken?(index)
    return !(@board[index].nil? || @board[index].empty? || @board[index]==" ")
  end

  def valid_move?(index)
    if index > 8 || index < 0 || position_taken?(index) then false else true end
  end

  def turn
    puts "Please enter 1-9:"
    player_choice = input_to_index(gets)
    if valid_move?(player_choice)
      move(player_choice, current_player)
    else
      turn
    end
    display_board
  end

  def turn_count
    @board.select { |c| c != ' '}.count
  end

  def current_player
    if turn_count % 2 != 0 then 'O' else 'X' end
  end

    def won?
      WIN_COMBINATIONS.each do |cur_combination|
        if @board[cur_combination[0]] == @board[cur_combination[1]] && @board[cur_combination[1]] == @board[cur_combination[2]]
            return cur_combination unless @board[cur_combination[0]] == ' '
        end
      end
      return nil
  end

  def full?
    !@board.include?(' ')
  end

  def draw?
    full? && !won?
  end

  def over?
    return true if won? || draw?
  end

  def winner
    WIN_COMBINATIONS.each do |cur_combination|
      if @board[cur_combination[0]] == @board[cur_combination[1]] && @board[cur_combination[1]] == @board[cur_combination[2]]
          return @board[cur_combination[0]] unless @board[cur_combination[0]] == ' '
      end
    end
    return nil
  end

  def play
    until over? do
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
