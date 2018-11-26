class TicTacToe
  attr_reader :board

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
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def display_board
    board_row_templates = [
      [' ', ' ', ' ', '|', ' ', ' ', ' ', '|', ' ', ' ', ' '],
      '-----------',
    ]

    places_counter = 0

    (0..4).each_with_index do |r|
      row = board_row_templates[r % 2]

      # Row dividers
      puts row if row.class == String

      # Content row - inject X/Os before this
      if row.class == Array
        cur_row = row
        cur_row[1] = @board[places_counter + 0].gsub(/^$/, ' ')
        cur_row[5] = @board[places_counter + 1].gsub(/^$/, ' ')
        cur_row[9] = @board[places_counter + 2].gsub(/^$/, ' ')

        places_counter += 3

        puts cur_row.join ''
      end
    end
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index >= 0 && index < @board.length
      if @board[index] == ' '
        return true
      end
    end

    false
  end

  def turn
    puts 'Please enter 1-9:'
    input = gets.chomp

    index = input_to_index(input)

    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts 'Invalid move.  Try again.'
      turn
    end
  end

  def turn_count
    count = 0

    @board.each do |i|
        count += 1 if i != ' '
    end

    count
  end

  def current_player
    return 'X' unless turn_count % 2 == 1
    return 'O'
  end

  def won?
    return false unless @board.detect { |i| i != ' ' }

    WIN_COMBINATIONS.each do |win|
      places = [@board[win[0]], @board[win[1]], @board[win[2]]]

      unless places.detect { |i| i == ' ' }
        return win if places.all? { |i| i == places[0] }
      end
    end

    false
  end

  def full?
    @board.none? { |i| i == ' ' }
  end

  def draw?
    if full?
      if won?
        false
      else
        true
      end
    else
      false
    end
  end

  def over?
    if full? || won?
      true
    else
      false
    end
  end

  def winner
    win_type = won?

    if win_type
      return @board[win_type[0]]
    end

    nil
  end

  def play
    until over?
      turn
      break if draw?
    end

    if won?
      game_winner = winner
      puts "Congratulations #{game_winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
