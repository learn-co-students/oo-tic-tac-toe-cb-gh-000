class TicTacToe
  WIN_COMBINATIONS = [
              [0,1,2],
              [3,4,5],
              [6,7,8],
              [0,3,6],
              [1,4,7],
              [2,5,8],
              [0,4,8],
              [6,4,2]
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

  def input_to_index(input)
    input.to_i - 1
  end

  def move(position, token)
    @board[position] = token
  end

  def valid_move?(position)
    if position > 8 || position < 0
      false
    else
      if position_taken?(position)
        false
      else
        true
      end
    end
  end

  def position_taken?(position)
    if @board[position] != " "
      true
    else
      false
    end
  end

  def turn_count
    @board.select{|i| i == "X" || i == "O"}.length
  end

  def current_player
    if turn_count.even?
      "X"
    else
      "O"
    end
  end

  def turn
    i = gets
    index = input_to_index(i)

    if valid_move?(index)
      move(index,current_player)
      display_board
    else
      i = gets
    end
  end

  def won?
    winning_arr = []
    WIN_COMBINATIONS.each do |arr|
      if @board[arr[0]] != " " && @board[arr[0]] == @board[arr[1]] && @board[arr[1]] == @board[arr[2]]
        winning_arr.push(arr[0]).push(arr[1]).push(arr[2])
      end
    end

    if winning_arr == []
      false
    else
      winning_arr
    end
  end

  def full?
    if !won? && @board.select{|i| i == " "}.length == 0
      true
    end
  end

  def draw?
    if full? && !won?
      true
    end
  end

  def over?
    if draw? || won?
      true
    else
      false
    end
  end

  def winner
    if won? != false
      @board[won?[0]]
    end
  end

  def play
    until over?
      turn
    end

    if won? != []
      puts "Congratulations #{winner}!"
    end

    if draw?
      puts "Cat's Game!"
    end

  end
end
