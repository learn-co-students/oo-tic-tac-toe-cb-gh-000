class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

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

  def play
    until over?
      turn
    end

    if won?
      winner_id = winner
      puts "Congratulations #{winner_id}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end


  def turn_count
    @board.count { |token| token == "X" || token == "O" }
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(move_cell)
    x = move_cell.to_i
    if x > 0
      return move_cell.to_i - 1
    elsif x == 0
      return -1
    else
      return 0
    end
  end

  def move(index, player)
    @board[index] = "#{player}"
    return @board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    potential_move = @board[index]

    if position_taken?(index) || index < 0 || index > 8
      return false
    end

    return true
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    curr_player = current_player

    if valid_move?(index)
      move(index, curr_player)
    else
      while true
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)

        if index >= 1 || index <= 9
          break
        end
      end
    end

    display_board
  end

  def full?
    return !@board.include?(" ")
  end

  def won?
    winning_combo = false

    WIN_COMBINATIONS.each do | combo |
      win_index_1 = combo[0]
      win_index_2 = combo[1]
      win_index_3 = combo[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]


      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return combo
      end
    end

    return false
  end
  
  def draw?
    if !won? && full?
      return true
    end

    return false
  end

  def over?
    if draw? || won?
      return true
    end

    return false
  end

  def winner
    if over? && !draw?
      winning_combo = won?
      index = winning_combo[0]
      return @board[index]
    end

    return nil
  end
  
end