class TicTacToe
  def initialize
    @board = [" "]*9
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [2, 5, 8],
    [1, 4, 7],
    [0, 3, 6],
    [6, 4, 2],
    [0, 4, 8]
  ]


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

  # code your #valid_move? method here
  def valid_move?(index)
    return index.between?(0, 8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets
    index = input_to_index(user_input)

    while !valid_move?(index)
      puts "Please enter 1-9:"
      user_input = gets
      index = input_to_index(user_input)
    end

    move(index, current_player = current_player())
    display_board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      position_1 = @board[win_combination[0]] # load the value of the board at win_index_1
      position_2 = @board[win_combination[1]] # load the value of the board at win_index_2
      position_3 = @board[win_combination[2]] # load the value of the board at win_index_3
      if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
        return win_combination # return the win_combination indexes that won.
      end
    end
    false
  end

  def full?
    return @board.all? {|items| items != " "}
  end

  def draw?
    if !won?
      return full?
    end
    return false
  end

  def over?
    return won? || draw?
  end

  def winner
    if won?
      return @board[won?[0]]
    end
  end

  def turn_count
    turns = 0
    @board.each{|item| turns += 1 if item != " "}
    return turns
  end

  def current_player
    turns = turn_count
    turns % 2 == 0 ? "X" : "O"
  end

  def play
    while !over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
