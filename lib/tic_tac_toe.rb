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

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
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
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " " || @board[index] == "")
  end

  def valid_move?(index)
    if index.between?(0, 8)
      answer = !position_taken?(index)
    else
      answer = false
    end
    return answer
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    victory = false
    WIN_COMBINATIONS.each do |combination|
      if @board[combination[0]] == "X" && @board[combination[1]] == "X" && @board[combination[2]] == "X"
        victory = combination
        break
      elsif @board[combination[0]] == "O" && @board[combination[1]] == "O" && @board[combination[2]] == "O"
        victory = combination
        break
      end
    end  
    return victory
  end
  
  def full?
    is_full = @board.all? do |block|
      block == "X" || block == "O"
    end
  end
  def draw?
    if !won? && full?
      return true
    else
      return false
    end
  end

  def over?
    if full? || won? || draw?
      return true
    else
      return false
    end
  end

  def winner
    winner = won?
      if winner == false
        return nil
      else
        @board[winner[0]]
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

  def play
    until over? == true do
      turn
    end
    if won?
      victor = winner
      puts "Congratulations #{victor}!"
    else
      puts "Cats Game!"
    end
  end
end