class TicTacToe
    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        puts "-----------------"
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "---------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "---------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        converted_input = user_input.to_i - 1
    end

    def move(position, token)
        @board[position] = token
    end

    def position_taken?(index)
        @board[index] == "X" || @board[index] == "O"
    end

    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end

    def turn_count
        @board.count { |i| i == "X" || i == "O" }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        player = current_player
        puts "#{player} Enter a number between 1-9: "
        user_input = gets
        converted_input = input_to_index(user_input)
        if valid_move?(converted_input)
            move(converted_input, player)
            display_board
            return true
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|
            @board[combo[0]] == @board[combo[1]] &&
            @board[combo[1]] == @board[combo[2]] &&
            position_taken?(combo[0])
        end
    end

    def full?
        @board.all? { |i| i == "X" || i == "O"}
    end

    def draw?
        !won? && full?
    end

    def over?
        won? || draw?
    end

    def winner
        if winning_combo = won?
            @board[winning_combo.first]
        end
    end

    def play
        turn until over?
        if won?
            winna = winner
            puts "Congratulations #{winna}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

    WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]]


end
