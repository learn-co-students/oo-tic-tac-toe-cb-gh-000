
class TicTacToe
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
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
        pipe = "|"
        row1 = " #{@board[0]} " + pipe + " #{@board[1]} " + pipe + " #{@board[2]} "
        row2 = " #{@board[3]} " + pipe + " #{@board[4]} " + pipe + " #{@board[5]} "
        row3 = " #{@board[6]} " + pipe + " #{@board[7]} " + pipe + " #{@board[8]} "
        separator = "-----------"

        puts  row1 + "\n" + separator + "\n" + row2 + "\n" + separator + "\n" + row3
    end

    def input_to_index(input)
        number = input.to_i
        number = number - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
      !(@board[index].nil? || @board[index] == " ")
    end

    def valid_move?(index)
        # index = index - 1
        if index.between?(0, 8) == true && position_taken?(index) == false
            return true
        else
            return false
        end
    end

    def turn
        puts "Please enter 1-9:"
        input = input_to_index(gets.strip)
        if valid_move?(input)
            move(input, current_player)
            display_board
        else
            turn
        end
    end

    def turn_count
        turns = 0;
        @board.each do |space|
            if space == "X" || space == "O"
                turns += 1
            end
        end
        return turns
    end

    def current_player
        turn = turn_count
        if turn.even?
            return "X"
        else
            return "O"
        end
    end

    def won?
        counter = 0;
        WIN_COMBINATIONS.each do |trio|
            if trio.all? { |spot| position_taken?(spot) == true}  && (trio.all? {|spot| @board[spot] == "X"} || trio.all? {|spot| @board[spot] == "O"})
                return trio
            end
        end
        return false
    end

    def full?
        @board.all? do |spot|
            spot == "X" || spot == "O"
        end
    end

    def draw?
        won = won?;
        full = full?;

        if full == true && won == false
            return true
        else
            return false
        end
    end

    def over?
        if won? != false || full? == true || draw? == true
            return true
        else
            return false
        end
    end

    def winner
        if won? != false
            return @board[won?[0]]
        else
            return nil
        end
    end

    def play
        turn
        if over?
            if draw?
                puts "Cats Game!"
            elsif won?
                puts "Congratulations #{winner}!"
            end
        else
            play
        end
    end

end
