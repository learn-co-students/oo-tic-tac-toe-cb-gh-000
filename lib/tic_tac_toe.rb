class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

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

  def move(index, character="X")
    @board[index] = character
    display_board
  end

  def position_taken?(index)
    if @board[index] == " " || @board [index] == nil
      false
    else
      true
    end
  end

  def valid_move?(index)
    if index.between?(0,8) && !position_taken?(index)
      true
    else
      false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      player = current_player
      move(index,player)
    else
      turn
    end
  end

  def turn_count
    turn_counter = 0
    @board.each do |position|
      if position == "X" || position == "O"
        turn_counter += 1
      end
    end
    turn_counter
  end

  def current_player
    turns_played = turn_count
    if turns_played.even?
      "X"
    elsif turns_played.odd?
      "O"
    else
      nil
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      win_index_1 = combo[0]
      win_index_2 = combo[1]
      win_index_3 = combo[2]

      if (@board[win_index_1] == @board[win_index_2] && @board[win_index_2] == @board[win_index_3]) && @board[win_index_1] != " "
        return combo
      end
    end
    nil
  end

  def full?
    @board.none? {|position| position == " "}
  end

  def draw?
    if won? || !full?
      false
    else
      true
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
    winner = won?
    if winner != nil
      winner_index = winner[0]
      return @board[winner_index]
    end
    nil
  end

  def play
    until over? || draw?
      turn
    end

    if won?
      winner_char = winner
      puts "Congratulations #{winner_char}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
