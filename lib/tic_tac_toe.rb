class TicTacToe

  WIN_COMBINATIONS = [
    # horizontal win combinations
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],

    # vertical win combinations
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],

    # diagonal win combinations
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " "
  end

  def valid_move?(position)
    position.between?(0,8) && !position_taken?(position)
  end

  def turn
    loop do
      puts "Please enter 1-9:"
      input = input_to_index(gets.strip)
      if valid_move?(input)
        move(input, current_player)
        display_board
        break
      end
    end
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      position_1 = @board[combination[0]]
      position_2 = @board[combination[1]]
      position_3 = @board[combination[2]]
      if (position_1 == position_2 && position_2 == position_3) && (position_1 == "X" || position_1 == "O")
         return combination
      end
    end
    false
  end

  def full?
    !@board.detect{|position| position == " "}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end


  def winner
    winner = won?
    if !winner
      return nil
    end
    @board[winner[0]]
  end

  def play
    until(over?)
      turn
    end
    victor = winner
    if victor.nil?
      puts "Cat's Game!"
    else
      puts "Congratulations #{victor}!"
    end
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end
