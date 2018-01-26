class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
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

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
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

  #def turn_count(board)
    #counter = 0
    #board.each do |index|
      #if index == "X" || index == "O"
        #counter += 1
      #end
    #end
    #counter
  #end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    status= false
    WIN_COMBINATIONS.each do |win_array|
      if @board[win_array[0]] == "X" && @board[win_array[1]] == "X" && @board[win_array[2]] == "X" || @board[win_array[0]] == "O" && @board[win_array[1]] == "O" && @board[win_array[2]] == "O"
        return win_array
      end
    end
    status
  end

    def full?
      !@board.include?(" ")
    end

    def draw?
      !won? && full?
    end

    def over?
      won? || full? || draw?
    end

    def winner
      won = won?
      !over? || !won? ? nil : @board[won[0]]
    end

    def play
      until over?
        turn
      end

      if won?
        puts "Congratulations #{winner}!"
      end

      if draw?
        puts "Cat's Game!"
      end
    end

  end
