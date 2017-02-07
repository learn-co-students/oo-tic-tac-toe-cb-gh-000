
class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
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

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
     @board[index] != " "
   end

   def valid_move?(index)
     if index.between?(0,8) && !position_taken?(index) then
       return true
     else
       return false
     end
   end

   def turn_count
     @board.count{|token| token == "X" || token == "O"}
   end

   def current_player
     if turn_count.odd? == true then
       current_player = "O"
     else
       current_player = "X"
     end
   end

   def turn
     puts "Please enter a number 1-9 for a position"
     input = gets.strip
     index = input_to_index(input)
     if valid_move?(index) == true then
       move(index, current_player)
     else
       puts "Invalid move, try again!"
       input = gets.strip()
     end
     display_board
   end

   def won?
     WIN_COMBINATIONS.detect do |combo|
       @board[combo[0]] == @board[combo[1]] &&
       @board[combo[1]] == @board[combo[2]] &&
       position_taken?(combo[0])
     end
   end

   def full?
     if @board.any? {|i| i == " "} then
       return false
     else
       return true
     end
   end

   def draw?
     if !won? && full? then
       return true
     else
       return false
     end
   end

   def over?
     if draw? then
       return true
     elsif won? then
       return true
     end
   end

   def winner
     if winning_combo = won? then
       @board[winning_combo.first]
     end
   end

   def play
     while !over?
       turn
     end
     if won? then
       puts "Congratulations #{winner}!"
     elsif draw? then
       puts "Cat's Game!"
     end
   end

end
