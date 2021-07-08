class TicTacToe
  WIN_COMBINATIONS =  [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def play
    until over?
      turn
    end
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
  
  def display_board
    time = 0
    while time < 3
      puts " #{@board[time * 3]} | #{@board[time * 3 + 1]} | #{@board[time * 3 + 2]} "
      if time < 2
        puts "-----------"
      end
      time += 1
    end
  end
  
  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, charactor)
    @board[index] = charactor
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0,8)
      if @board[index] == " " || @board[index] == "" || !@board[index]
        true
      end
    end
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
    count = 0
    @board.each do |move|
      if move == "X" || move == "O"
        count += 1
      end
    end
    count
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      state1 = @board[combination[0]]
      state2 = @board[combination[1]]
      state3 = @board[combination[2]]
      return combination if position_taken?(combination[0]) && state1 == state2 && state2 == state3
    end
    false
  end

  def full?
    !(@board.include?(" ") || @board.include?(nil))
  end

  def draw?
    !won? && full?
  end

  def over?
    full? || won? || draw?
  end

  def winner
    (combination = won?) ? @board[combination[0]] : nil
  end
end