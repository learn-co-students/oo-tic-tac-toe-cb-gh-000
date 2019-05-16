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
    input = user_input.to_i - 1
    if !input.instance_of? Fixnum
      return -1
    else
      return input
    end
  end

  def move(index,  current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0,8) == false || position_taken?(index) == true
      return false
    else
      return true
    end
  end

  def turn
    puts ("Please enter 1-9:")
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts ("Please enter 1-9:")
      input = gets.strip
      index = input_to_index(input)
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}

  end

  def current_player
    (turn_count % 2 == 0) ? "X" : "O"
  end

  def won?
     WIN_COMBINATIONS.each do |combination|
       win_index_1 = combination[0]
       win_index_2 = combination[1]
       win_index_3 = combination[2]
       if @board[win_index_1] == "X" && @board[win_index_2] == "X" && @board[win_index_3] == "X"
         return combination
       elsif @board[win_index_1] == "O" && @board[win_index_2] == "O" && @board[win_index_3] == "O"
         return combination
       end
     end
     return false
   end

   def full?
     @board.all? do |i|
       if i == " " || i.nil?
         false
       else
         true
       end
     end
   end

   def draw?
     if won? == false && full? == true
       return true
     else
       return false
     end
   end

   def over?
     if won? == true || draw? == true || full? == true
       true
     else
       false
     end
   end

   def winner
     win_array = won?
     if !won?
       return nil
     elsif @board[win_array[0]] == "X"
       return "X"
     else
       return "O"
     end
   end

   def play
     counter = 0
     until counter == 9
         if over?
           puts "Game is over"
         end
         if !won?
           if draw?
             puts "Cat's Game!"
             nil
           else
             turn
           end
         else
           puts "Congratulations #{winner}!"
         end
       counter += 1;
     end
   end

end
