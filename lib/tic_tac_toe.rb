class TicTacToe

  WIN_COMBINATIONS = [
                      [0,1,2], #top row
                      [3,4,5], #middle row
                      [6,7,8], #bottom row
                      [0,3,6], #first column
                      [1,4,7], #middle column
                      [2,5,8], #last column
                      [0,4,8], #primary diagonal
                      [2,4,6]  #secondary diagonal
                    ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i  - 1
  end

  def move(index, player="X")
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] != "" && @board[index] != " " && @board[index] != nil
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end

  def turn_count
    @board.count {|position| position == "X" || position == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
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

  def won?
    WIN_COMBINATIONS.find { |combination|
      (combination.all? { |index|
        position_taken?(index) && @board[index] == "X"  }) || (combination.all? { |index|
          position_taken?(index) && @board[index] == "O"  })
    }
  end

  def full?
    @board.all? do |position|
      !(position.nil? || position == " ")
    end
  end

  def draw?
    !won? && full?
  end

  def over?
     draw? || won?
  end

  def winner
    over? && won? ? @board[won?[0]] : nil
  end

  def play
    until over?
      turn
    end
    if winner
      puts("Congratulations #{winner}!")
    else
      puts("Cat's Game!")
    end
  end
end
