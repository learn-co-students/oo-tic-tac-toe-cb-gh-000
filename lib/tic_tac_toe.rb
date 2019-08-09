class TicTacToe
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
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
end

 def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

 def input_to_index(input)
    return input.to_i - 1
end

 def move(index, value)
    @board[index] = value
end

 def position_taken?(index)
    !(@board[index] == " " || @board[index] == "" || @board[index] == nil)
end

 def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
end

 def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

     until valid_move?(index)
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
    end

     move(index, current_player)
    display_board
end

 def turn_count
    counter = 0

     @board.each do |position|
        position == "X" || position == "O" ? counter += 1 : nil
    end

     counter
end

 def current_player
    turn_count % 2 == 0 ? "X" : "O"
end

 def won?
    WIN_COMBINATIONS.each do |combination|
        if(combination.all? {|i| @board[i] == "X"} || combination.all? {|i| @board[i] == "O"})
            return combination
        end
    end
    false
end

 def full?
    @board.none? {|position| position == " "}
end

 def draw?
    !won? && full?
end

 def over?
    draw? || won?
end

 def winner
    result = won?
     if result
        @board[result[0]]
    else
        nil
    end
end

 def play
    until over?
        turn
    end
     if won?
        puts "Congratulations #{winner}!"
    else
        puts "Cat's Game!"
    end
  end
end
