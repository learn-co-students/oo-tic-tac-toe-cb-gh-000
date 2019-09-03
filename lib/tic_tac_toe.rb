class TicTacToe
        def initialize(board = nil)
                @board = board || Array.new(9, " ")
        end

        WIN_COMBINATIONS = [
                [0, 1, 2],
                [3, 4, 5],
                [6, 7, 8],
                [0, 3, 6],
                [1, 4, 7],
                [2, 5, 8],
                [2, 4, 6],
                [0, 4, 8]
        ]

        def display_board
                puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
                puts "-----------"
                puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
                puts "-----------"
                puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        end

        def input_to_index(user_input)
                return user_input.to_i - 1
        end

        def move(index, player = "X")
                @board[index] = player
        end

        def position_taken?(index)
                !(@board[index].nil? || @board[index] == " ")
        end

        def valid_move?(index)
                !position_taken?(index) && index.between?(0, 8)
        end

        def turn
                index = nil
                while index == nil
                        puts "Please enter a number from 1-9:"
                        input = input_to_index(gets.strip)
                        if valid_move?(input)
                                index = input
                        end
                end
                move(index, current_player)
                display_board
        end

        def turn_count
                @board.count{|token| token == "X" || token == "O"}
        end

        def current_player
                turn_count.odd? ? "O" : "X"
        end

        def won?
                WIN_COMBINATIONS.detect do |win_combination|
                        @board[win_combination[0]] == @board[win_combination[1]] &&
                        @board[win_combination[1]] == @board[win_combination[2]] &&
                        position_taken?(win_combination.first)
                end
        end

        def full?
                @board.all? {|index| index != " "}
        end

        def draw?
                !won? && full?
        end

        def over?
                won? || full?
        end

        def winner
                if win_comb = won?
                        return @board[win_comb.first]
                end
        end

        def play
                until over?
                        turn
                end
                if won?
                        puts "Congratulations! Player #{winner} won!"
                elsif draw?
                        puts "It's a draw!"
                else
                        "The game is over."
                end
        end
end
