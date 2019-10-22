class TicTacToe
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
    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
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
    def current_player
        countX = 0
        countO = 0
        @board.each do |mark|
            if mark == "O"
                countO += 1
            elsif mark =="X"
                countX += 1
            end
        end
        if countX <= countO
            "X"
        else
            "O"
        end
    end
    def position_taken?(location)
      @board[location] != " " && @board[location] != ""
    end
    def valid_move?(index)
      index.between?(0,8) && !position_taken?(index)
    end
    def turn_count
        count = 0
        @board.each do |mark|
            if mark == "O" || mark == "X"
                count += 1
            end
        end
        count
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
    def won?
        WIN_COMBINATIONS.each do |combination|
            marksOK = true #same & is one of "O", "X"
            if  @board[combination[0]] != @board[combination[1]] ||
                @board[combination[1]] != @board[combination[2]]
                marksOK = false
            end
            next if marksOK == false

            combination.each do |index|
                if @board[index] != "X" && @board[index] != "O"
                    marksOK = false
                    break
                end
            end
            next if marksOK == false

            return combination
        end
        return false
    end

    def full?
        @board.each do |mark|
            if mark != "X" && mark != "O"
                return false
            end
        end
        return true
    end

    def draw?
        isWon = won?
        isFull = full?
        if !isWon && isFull
            true
        else
            false
        end
    end

    def over?
        if won? || full?
            true
        else
            false
        end
    end
    def winner
        combination_won = won?
        if combination_won != false
            @board[combination_won[0]]
        else
            nil
        end
    end
    def play
        while !over?
            turn
            if draw?
                break
            end
        end
        if draw?
            puts("Cat's Game!")
        end
        if won?
            puts("Congratulations #{winner}!")
        end
    end
end
