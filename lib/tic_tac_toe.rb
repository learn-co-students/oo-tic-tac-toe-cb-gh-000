class TicTacToe

   WIN_COMBINATIONS =
   [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
   ]
   def initialize()
      @board = Array.new(9, " ")
   end

   def display_board()
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
   end

   def input_to_index(input)
      return input.to_i-1
   end

   def move(index, token = "X")
      @board[index] = token
   end

   def position_taken?(index)
      return @board[index] == "X" || @board[index]=="O"
   end

   def valid_move?(index)
      return (0..8).any? {|i| i == index } && !position_taken?(index)
   end

   def turn
      puts "Enter a number between 1-9!"
      input = input_to_index(gets.strip)
      if valid_move?(input)
         move(input, current_player)
         display_board
      else
         turn
      end
   end

   def turn_count
      return @board.count { |pos| pos == "X" || pos == "O"}
   end

   def current_player
      return turn_count.even? ? "X" : "O"
   end

   def won?
      WIN_COMBINATIONS.any? do |win_combo|
         if win_combo.all? { |index| position_taken?(index) && @board[index] == @board[win_combo[0]] }
            return win_combo
         end
      end
      return nil
   end

   def full?
      return (0..8).all? { |i| position_taken?(i)  }
   end

   def draw?
      return full? && !won?
   end

   def over?
      return won? || draw?
   end

   def winner
      winner = won?
      return winner ? @board[winner[0]] : nil
   end

   def play
      until over?
         turn
      end

      if won?
         puts "Congratulations #{winner}!"
      elsif draw?
         puts "Cat's Game!"
      end
   end

end
