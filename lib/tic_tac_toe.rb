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
      [2,4,6],
  ]

    def display_board
      index = 0
      while index <= 6
        puts " #{@board[index]} | #{@board[index+1]} | #{@board[index+2]} "
        if index < 6
          puts "------------"
        end
        index += 3
      end
    end

    def input_to_index(input)
      input.to_i - 1
    end

    def move(index, token = "X")
      @board[index] = token
    end

    def position_taken?(index)
      if @board[index] == " " || @board[index] == "" || @board[index] == nil
        return false
      elsif @board[index] == "X" || @board[index] == "O"
        return true
      end
    end

    def valid_move?(index)
        if position_taken?(index)
          return false
        elsif index.between?(0, 8)
          return true
        elsif index.between?(0, 8) != position_taken?(index)
          return true
        else
            return false
        end
    end

    def turn

        puts "Please enter 1-9 for Player:"

        index = input_to_index(gets.strip)

        if valid_move?(index) && position_taken?(index) == false
          move(index, current_player())
          display_board
        else
          turn
        end
      end

      def turn_count

        counter = 0

        @board.each do |position|

            if position == "X" || position == "O"
              counter += 1
            end
        end
          return counter
      end

      def current_player
        if turn_count % 2 == 0
          "X"
        else
          "O"
        end
      end

      def won?

        WIN_COMBINATIONS.each do |combo|
          if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
            return combo
          end
        end
      return false
      end

      def full?
        !@board.include?(" ")
      end

      def draw?
        if !won? && full?
          true
        else
          false
        end
      end

      def over?
        if won? || draw? || full?
          return true
        end
        return false
      end

      def winner
        if won?
          @board[won?[0]]
        end
      end

      def play
         while !over?
           turn
         end
         if won?
           puts "Congratulations #{winner}!"
         elsif draw?
           puts "Cat's Game!"
         end
      end
end
