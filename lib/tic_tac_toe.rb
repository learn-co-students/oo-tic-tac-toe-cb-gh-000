class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def display_board
    for row in 0..2
      for col in 0..1
        print " #{@board[row * 3 + col]} |"
      end
      puts " #{@board[row * 3 + 2]} "
      if row < 2
        puts "-----------"
      end
    end
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(pos, player)
    @board[pos] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index_valid = index >= 0 && index < @board.length
    !@board.empty? && index_valid  && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    if valid_move?(index)
      @board[index] = current_player
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.find_all {|cell| (cell == "X" || cell == "O")}.count
  end

  def current_player
    if turn_count % 2 == 0 then "X" else "O" end
  end

    def won?
      WIN_COMBINATIONS.detect do |combination|
        player = @board[combination[0]]
        combination.all? do |cell|
          position_taken?(cell) && @board[cell] == player
        end
      end
    end

    def full?
      @board.all? {|cell| cell == "X" || cell == "O"}
    end

    def draw?
      !won? && full?
    end

    def over?
      won? || draw?
    end

    def winner
      if winning_combination = won?
        @board[winning_combination[0]]
      end
    end

    def play
      while !over? do
        turn
      end
      if winning_player = winner
        puts "Congratulations #{winning_player}!"
      else
        puts "Cat's Game!"
      end
    end
  end
