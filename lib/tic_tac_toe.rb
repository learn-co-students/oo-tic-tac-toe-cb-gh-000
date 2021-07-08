class TicTacToe
    def initialize()
        @board = Array.new(9, " ")
    end

    def position_taken?(index)
      !(@board[index].nil? || @board[index] == " ")
    end

    # Define your WIN_COMBINATIONS constant
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

    def won?()
      WIN_COMBINATIONS.each do |win_combination|
        if !(position_taken?(win_combination[0]) && position_taken?(win_combination[0]) &&
          position_taken?(win_combination[0]))
          false
        elsif ((@board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" &&
          @board[win_combination[2]] == "X") ||
          (@board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" &&
          @board[win_combination[2]] == "O"))
          return win_combination
        else
          false
        end
      end
      false
    end


    def full?()
        counter = 0
        while counter < 9
            if !position_taken?(counter)
                return false
            end

            counter += 1
        end
        true
    end

    def draw?()
        if won?() || !full?()
            return false
        end

        true
    end

    def over?()
        if full?() || won?() || draw?()
            return true
        end
        false
    end

    def winner()
        result = won?()
        result ? @board[result[0]] : nil
    end


    def display_board()
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

    def valid_move?(index)
      index.between?(0,8) && !position_taken?(index)
    end

    def turn()
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
      if valid_move?(index)
          character = current_player()
          move(index, character)
        display_board()
      else
        turn()
      end
    end

    # Define your play method below
    def play()
        while !over?() do
            turn()
        end

      if won?()
        puts "Congratulations #{winner()}!"
      elsif draw?()
        puts "Cat's Game!"
      end

    end


    def turn_count()
      counter = 0
      @board.each do |place|
        if place == "X" || place == "O"
          counter += 1
        end
      end
      counter
    end

    def current_player()
      turn_count().even? ? "X" : "O"
    end

end