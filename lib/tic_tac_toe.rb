class TicTacToe
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], # Row wins
                      [0,3,6], [1,4,7], [2,5,8], # Col wins
                      [0,4,8], [2,4,6]] # Diagonal wins

  def initialize(board = nil)
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    index = input.to_i - 1
    return index
  end # end input_to_index

  def move(index, character = "X")
    @board[index] = character
  end # end move

  def position_taken?(index)
    if (@board[index] == " " || @board[index] == "" || @board[index] == nil)
      return false
    else
      return true
    end
  end # end position_taken?

  def valid_move?(index)
    if (!position_taken?(index) && index.between?(0,8))
      return true
    else
      return false
    end
  end # end valid_move

  def current_player
    #if the turn count is an even number, that means O just went, so the next/current player is X
    num_turns = turn_count
    if num_turns % 2 == 0
      player = "X"
    else
      player = "O"
    end

    return player
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index) == true
      char = current_player
      move(index, char)
      display_board
    else
      turn
    end
  end # end turn

  def turn_count
    turn = 0
    @board.each do |index|
      if index == "X" || index == "O"
        turn += 1
      end
    end
    return turn
  end

  def won?
    WIN_COMBINATIONS.each do |ttt_win|
      win_1 = ttt_win[0]
      win_2 = ttt_win[1]
      win_3 = ttt_win[2]

      position_1 = @board[win_1]
      position_2 = @board[win_2]
      position_3 = @board[win_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X")
        return ttt_win
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return ttt_win
      end
    end
    #else
    return false
  end

  def full?
    @board.all? {|square| square == "X" || square == "O"}
  end

  def draw?
    if (full? && !won?)
      return true
    else
      return false
    end
  end

  def over?
    if (won? || draw?)
      return true
    else
      return false
    end
  end

  def winner
    index = []
    index = won?

    if (!index)
      return nil
    else
      if (@board[index[0]] == "X")
        return "X"
      else
        return "O"
      end
    end
    #else
    # return nil
  end

  def play
    while (!over?)
      turn
    end

    if (won?)
      puts "Congratulations #{winner}!"
    elsif (draw?)
      puts "Cat's Game!"
    end
  end

end
