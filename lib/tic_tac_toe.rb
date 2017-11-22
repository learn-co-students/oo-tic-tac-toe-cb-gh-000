class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Right column
    [1,4,7], # Middle column
    [2,5,8], # Left column
    [0,4,8], # Diagonals
    [2,4,6]  # Diagonals
  ]
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    self.turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
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

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !self.position_taken?(index)
  end


  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = self.input_to_index(input)
    if self.valid_move?(index)
      self.move(index, self.current_player)
      self.display_board
    else
      self.turn
    end
  end

  def won?
    if @board.empty? || !@board || @board.all? { |e| e == "" || e == " " || !e  }
      return false
    end
    WIN_COMBINATIONS.each do |e|
      temp = @board[e[0]]
      temp = nil if temp == " "
      if e.all? { |el| @board[el] == temp }
        return e
      end
    end
    nil
  end

  def full?
    @board.all? { |e| ["X", "O"].include?(e.upcase) }
  end

  def draw?
    self.full? && !self.won?
  end

  def over?
    self.full? || self.draw? || self.won?
  end

  def winner
    temp = self.won?
    return temp ? @board[temp[0]] : temp
  end

  def play
    until self.over?
      self.turn
    end
    if self.won?
      puts "Congratulations #{self.winner}!"
    else
      puts "Cat\'s Game!"
    end
  end
end
