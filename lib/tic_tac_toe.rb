class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

    # Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  # Define your WIN_COMBINATIONS constant
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

  def move(index, token)
    @board[index] = token
  end

  def valid_move?(index)
    if index >= 0 && index <= 8
      value = @board[index]
      if value == "" || value == " " || value == nil
        true
      end
    else
      false
    end
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
    else
      puts "Enter a valid move"
      turn
    end
    display_board
  end

  def turn_count
    counter = 0
    @board.each do |token|
      if token == 'X' || token == 'O'
        counter+=1
      end
    end
    return counter
  end

  def current_player
    if turn_count.even?
      'X'
    else
      'O'
    end
  end

  def won?
    WIN_COMBINATIONS.find do |indexes|
      ["X", "O"].any? do |c|
        indexes.all?{|i| @board[i]==c}
      end
    end
  end

  def full?
    @board.none?{|c| c == " "}
  end

  def draw?
    full? and won? == nil
  end

  def over?
    won? or draw? or full?
  end

  def winner
    winner = won?
    if winner == nil
      nil
    else
      @board[winner[0]]
    end
  end

  def play
    while !over?
      turn
    end
    if winner != nil
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end

end
