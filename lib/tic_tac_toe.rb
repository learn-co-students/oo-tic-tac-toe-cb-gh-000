class TicTacToe
  def initialize(board = [" "," "," "," "," "," "," "," "," "])
    @board = board

  end
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

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


  def valid_move?(index)
    @board
    index.between?(0,8) && !position_taken?(index)
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def turn_count
    conter = 0
    @board.each do | element |
  if element != " "

    conter += 1

  end
  end
  conter
    end



    def move(index, current_player = "X")
      @board[index] = current_player
    end

    def current_player
      if turn_count % 2 == 0
     "X"
  else
    "O"

  end
  end

    def turn
       puts " enter a number 1-9:"
      user_input = gets.strip
      index = input_to_index(user_input)

      if valid_move?(index)
        move(index, current_player)
        display_board

      else
        turn
      end
    end

    def won?
      WIN_COMBINATIONS.each do |combination|

        return combination if position_taken?(combination[0]) && @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]]
      end

    false
    end


    def full?
      !(@board.include?(" ") || @board.include?(nil))
    end

    def draw?
      !won? && full?
    end

    def over?
      full? || won? || draw?
    end

    def winner
      (combination = won?) ? @board[combination[0]] : nil
    end

    def play
        until   over?

    turn

        end
        if won?
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"

        end
    end

end
