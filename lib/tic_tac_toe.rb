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
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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
    player = "X"

    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      player = current_player
      move(index, player)
      display_board
    else
      turn
    end
  end

  def current_player
    turns = turn_count

    if turns % 2 == 0
      player = "X"
    else
      player = "O"
    end

    player
  end

  def turn_count
    turns = 0
    counter = 0

    while counter <= @board.length
      if position_taken?(counter)
        turns += 1
      end

      counter += 1
    end

    turns-1
  end

  def won?
    WIN_COMBINATIONS.each do |comb|
      if position_taken?(comb[0])
        if @board[comb[0]] == @board[comb[1]] && @board[comb[0]] == @board[comb[2]]
          return comb
        end
      end
    end

    return false
  end

  def full?
    indexTaken = @board.select{ |index| index == "X" || index == "O"}

    if indexTaken.length != @board.length
      return false
    end

    return true
  end

  def draw?
    if full?
      if won?
        return false
      else
        return true
      end
    end
    return false
  end

  def over?
    if full? || won? || draw?
      return true
    end

    return false
  end

  def winner
    comb = []
    if over?
      comb = won?
      if comb
        player = @board[comb[0]]
        return player
      end
    end
  end

  def play
    while over? == false
      turn
    end

    if draw?
      puts "Cat's Game!"
    else
      player = winner
      puts "Congratulations #{player}!"
    end
  end
end
