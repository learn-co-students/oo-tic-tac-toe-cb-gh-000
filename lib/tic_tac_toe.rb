class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    # Helper Method
    def position_taken?(board, index)
      !(@board[index].nil? || @board[index] == " ")
    end

    def won?
        WIN_COMBINATIONS.any? do |win_combination|
            win_c_1 = win_combination[0]
            win_c_2 = win_combination[1]
            win_c_3 = win_combination[2]

            if (@board[win_c_1] == 'X' && @board[win_c_2] == 'X' && @board[win_c_3] == 'X')
                return win_combination
            elsif (@board[win_c_1] == 'O' && @board[win_c_2] == 'O' && @board[win_c_3] == 'O')
                return win_combination
            else
                false
            end
        end
    end

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
        !position_taken?(index) && index.between?(0,8)
    end

    def turn_count
        @board.count{|square| square != " " }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            turn
        end
        display_board
    end

    def full?
        @board.all? {|unit| unit != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        full? || won? || draw?
    end

    def winner
        if won?
            @board[won?[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end
