class TicTacToe

    def initialize
        @board=Array.new(9, " ")
    end

    def board
        @board
    end

    def board=(board)
        @board=board
    end

    WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        if input >= "1" && input <="9"
            return input.to_i-1
        else
            return -1
        end
    end

    def move(index,value="X")
        @board[index]=value
    end

    def position_taken?(index)
        !(@board[index].nil? || @board[index] == " ")
    end

    def valid_move?(index)
        if index <9 && index >=0 && !position_taken?(index)
            return true
        else
            return false
        end
    end

    def turn_count
        counter=0
        @board.each do |position|
            if position != " "
                counter+=1
            end
        end
        return counter
    end

    def current_player
        if turn_count%2==0
            return "X"
        else
            return "O"
        end
    end

    def won?
     winComb=[]
     WIN_COMBINATIONS.each do |comb|
         if @board[comb[0]]!=" "&&@board[comb[1]]!=" "&&@board[comb[2]]!=" "
             if @board[comb[0]]==@board[comb[1]]&&@board[comb[0]]==@board[comb[2]]
                 break winComb=comb
             else
                 winComb=false
             end
         else
             winComb=false
         end
     end
     winComb
    end

    def full?
        full=true
        @board.each do |pos|
            if pos==" "
                full=false
            end
        end
        full
    end

    def draw?
        draw=true
        if won?
            draw=false
        elsif !full?
            draw=false
        end
        draw
    end

    def over?
        over=false
        if draw?
            over=true
        elsif won?
            over=true
        else
        end
        over
    end


    def winner
        winner=""
        if won?
            return @board[won?[0]]
        end
    end

    def turn
        display_board
        puts "Please enter 1-9:"
        input=gets.strip
        index=input_to_index(input)
        if valid_move?(index)
            move(index,current_player)
            
        else
            turn
        end

    end

    def play
        until over? do
            turn
        end
        if won?
            puts "Congratulations #{winner}!"

        elsif draw?
            puts "Cat's Game!"

        end
    end



end
