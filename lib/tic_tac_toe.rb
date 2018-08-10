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
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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

    def move(positon, token)
        @board[positon] = token
    end

    def position_taken?(index)
        !(@board[index] == " ")
    end

    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end

    def turn
        puts "Please a number in the range 1-9:"
        index = input_to_index(gets.strip)
        while !valid_move?(index)
            index = input_to_index(gets.strip)
        end
        move(index, current_player)
        display_board
    end

    def turn_count
        count = 0
        @board.size.times { |i| if position_taken?(i) then count += 1 end }
        count
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def won?
        WIN_COMBINATIONS.each do |comb|
            if @board[comb[0]] == @board[comb[1]] && @board[comb[1]] == @board[comb[2]] && (@board[comb[0]] == "X" || @board[comb[0]] == "O")
                return comb
            end
        end
        nil
    end

    def full?
        @board.size.times {|index| if !position_taken?(index) then return false end}
        true
    end

    def draw?
        full? && !won?
    end

    def over?
        full? || won? || draw?
    end

    def winner
        game_result = won?
        if game_result.nil?
            nil
        elsif @board[game_result[0]] == "X"
            "X"
        else
            "O"
        end
    end

end
