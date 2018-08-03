class TicTacToe

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
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

  def turn_count

    turns = 0

    @board.each do | value |

      if value == "X" || value == "O" then
        turns += 1
      end

    end

    turns

  end

  def current_player

    # Assumes X alway goes first

    #if turn_count(board) % 2 == 1 then
    #  "O"
    #else
    #  "X"
    #end

    turn_count % 2 == 1 ? "O" : "X"

  end

  def won?

    WIN_COMBINATIONS.each do |combination|

      combo_value = []

      combination.each do |position|

        if position_taken?(position)
          combo_value << @board[position]
        end

      end

      if combo_value.size == 3 && combo_value[0] == combo_value[1] && combo_value[1] == combo_value[2] then

        return combination

      end

    end

    false

  end

  def full?

    result = @board.all? do |position_value|
      position_value == "X" || position_value == "O"
    end

  end

  def draw?

    !won? && full?

  end

  def over?

    won? || draw?

  end

  def winner

    if won?

      #DBC, assumes won? array 3x same
      if @board[won?[0]] == "X"
        "X"
      elsif @board[won?[0]] == "O"
        "O"
      else
        nil
      end

    end

  end

  def play

    until over?

      turn

    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end

  end

end
