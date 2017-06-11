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

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(position, char)
    @board[position] = char
  end

  def position_taken?(index)
     index == " " || index == "" || index == nil || @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn()
    puts "Please enter 1-9:"
    input = gets.strip
    index= input_to_index(input)
    if !valid_move?(index)
      turn()
    end

    move(index, current_player())
    display_board()
  end

  def turn_count()
    @board.count{|e| e == "X" || e == "O"}
  end

  def current_player()
    turn_count() % 2 == 0 ? "X" : "O"
  end

  def won?()
    WIN_COMBINATIONS.each do |win_combination|
      values = [
        @board[win_combination[0]],
        @board[win_combination[1]],
        @board[win_combination[2]]
      ]
      if values.all? { |e| e == "X" } || values.all? { |e| e == "O" }
        return win_combination
      end
    end

    false
  end

  def full?()
    @board.all? { |e| e == "X" || e == "O" }
  end

  def draw?()
    full?() && !won?()
  end

  def over?()
    full?() || draw?() || (!full?() && won?())
  end

  def winner()
    game_won = won?()

    if game_won
      return @board[game_won[0]]
    end
  end

  def play()
    until over?()
      turn()
    end

    if won?()
      puts "Congratulations #{winner()}!"
    elsif draw?()
      puts "Cat's Game!"
    end
  end
end
