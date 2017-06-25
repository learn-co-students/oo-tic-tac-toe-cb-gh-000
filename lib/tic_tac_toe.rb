class TicTacToe

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  # Helper Methods
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

  def board=(board)
    @board=board
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

  # Define your play method below
  def play
    until (over?)
      turn
    end
    win = winner
    if win then
      puts "Congratulations #{win}!"
    else
      puts "Cat's Game!"
    end
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ];

  def won?
    board_positions = get_board_positions

    TicTacToe::WIN_COMBINATIONS.each do |condition|
      exist = condition.all? { |e| board_positions.include?(e)  }
      if exist then
        if @board[condition[0]] == @board[condition[1]] && @board[condition[2]] == @board[condition[0]] then
          return condition
        end
      end
    end
    return nil
  end

  def get_board_positions
    board_positions = Array.new
    index = 0
    @board.each do |str|
      board_positions << index if position_taken?(index)
      index += 1
    end
    return board_positions
  end

  def full?
    board_positions = get_board_positions
    return board_positions.length == 9
  end

  def draw?
    return full? && !won?
  end

  def over?
    return full? || won? || draw?
  end

  def winner
    won = won?
    return won ? @board[won[0]] : nil
  end

  def turn_count
    counter = 0
    @board.each  do | pos |
      counter += (pos != " ") ? 1 : 0
    end
    return counter
  end

  def current_player
    return turn_count.even? ? 'X' : 'O'
  end

end
