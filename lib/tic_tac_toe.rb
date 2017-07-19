class TicTacToe

  def initialize()
    @board = [" "," "," "," "," "," "," "," "," "]
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

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    return user_input.to_i - 1
  end

  def move(position,char)
    @board[position] = char
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if index.between?(0,8) == true
      if position_taken?(index) == false
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def turn()
    puts "Please enter 1-9:"

    index = gets.chomp
    index = input_to_index(index)

    if valid_move?(index) == true
      move(index,current_player())
      display_board()
    else
      turn()
    end
    end

    def turn_count()
    counter = 0

    @board.each do | element |

      if element ==  "X" || element == "O"
        counter += 1
      end
    end
      return counter
    end

    def current_player()

      if turn_count().even? == true
        return "X"
      elsif turn_count().odd? == true
        return "O"
      end
    end

    def won?()

    counter = 0
    loop do
        win_combination = WIN_COMBINATIONS[counter]

        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = @board[win_index_1] # load the value of the board at win_index_1
        position_2 = @board[win_index_2] # load the value of the board at win_index_2
        position_3 = @board[win_index_3] # load the value of the board at win_index_3



        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return win_combination
        elsif  position_1 == "O" && position_2 == "O" && position_3 == "O"
            return win_combination
          else
             false
          end

          counter += 1

          if counter == 8
            break
          end

      end
    end

    def full?()

      @board.none? {|i| i.include?(" ")}

    end

    def draw?()

    !won?() && full?()
    end

    def over?()
      won?() || draw?()
    end

    def winner()

    if won?()

      winner_array = won?()
      index = winner_array[0]

      winner = @board[index]

      if winner == "X"
        return "X"
      elsif winner == "O"
        return "O"
      end
    else
      return nil

    end

    end

    def play()
      display_board()

      until over?()
        turn()
      end

      if(won?())
        puts "Congratulations #{winner()}!"
      elsif(draw?())
        puts "Cat's Game!"
      end

    end
  end
