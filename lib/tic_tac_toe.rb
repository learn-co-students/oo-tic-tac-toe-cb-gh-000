class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

    WIN_COMBINATIONS = [
      [0,1,2], # Top row
      [3,4,5],  # Middle row
      [6,7,8],
      [0,4,8],
      [2,4,6],
      [0,3,6],
      [1,4,7],
      [2,5,8]
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

    def move(index, current_player="X")
      @board[index] = current_player
    end

    def position_taken?(location)
      @board[location] != " " && @board[location] != ""
    end

    def valid_move?(index)
      index.between?(0,8) && !position_taken?(index)
    end

    def turn()
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      current_player = current_player()
      if valid_move?(index)
        move(index, current_player)
        display_board()
      else
        turn()
      end
    end

      def turn_count
        counter = 0
        @board.each do |turn|
          if turn == "X" || turn == "O"
            counter += 1
          end
        end
        counter
      end

      def current_player
        input_type = turn_count() % 2 == 0 ? "X" : "O"
      end

      def won?()
        #iterate over each item in win combinations
        WIN_COMBINATIONS.each do |win_combo|
          win_index_1 = win_combo[0]
          win_index_2 = win_combo[1]
          win_index_3 = win_combo[2]

          position_1 = @board[win_index_1]
          position_2 = @board[win_index_2]
          position_3 = @board[win_index_3]
          if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
            return win_combo
          end
        end
        false
      end

      def full?()
        @board.none?{|i| i == " "}
      end

      def draw?()
        if full?() && !won?()
          true
        elsif !won?() && !full?()
          false
        end
      end


      def over?()
        full?() || won?() || draw?()
      end

      def winner()
        winning_combo = won?()
        if winning_combo
          return @board[winning_combo[0]]
        end
      end

      def play()
        while !over?()
          turn()
        end
        if won?()
          puts "Congratulations #{winner()}!"
        elsif draw?()
          puts "Cat's Game!"
        end
      end

end


new_board = TicTacToe.new()
puts new_board.display_board()
