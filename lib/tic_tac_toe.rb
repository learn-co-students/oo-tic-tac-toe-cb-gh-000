class TicTacToe
  WIN_COMBINATIONS = [[0,1,2],
                      [3,4,5],
                      [6,7,8],
                      [0,3,6],
                      [1,4,7],
                      [2,5,8],
                      [0,4,8],
                      [6,4,2]]

  def initialize
    @board = Array.new(9, ' ')
  end

  def current_player
    turn_count % 2 == 0 ? 'X' : 'O'
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

  def position_taken?(x)
    if @board[x]== 'X' || @board[x] == 'O'
      return true
    end
    false
  end

  def valid_move?(input)
    if input >= 0 && input <= 8 && !position_taken?(input)
      return true
    end
    false
  end

  def full?
    9 == @board.count{|token| token == "X" || token == "O"}
  end

  def won?
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    if combo = won?
      @board[combo[0]]
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def move(x, sym)
    @board[x] = sym
  end

  def turn
    user_input = gets.strip()
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      turn
    end
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end

end
