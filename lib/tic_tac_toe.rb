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

   def initialize(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @board = board
  end

   def board=(board)
    @board = board
  end

   def board
    @board
  end

   def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

   def input_to_index(i)
    return i.to_i-1
  end

   def move(index,player)
    @board[index] = player
  end

   def position_taken?(index)
   return @board[index]=="O" || @board[index]=="X" ? true:false
  end


   def valid_move?(index)
    if index.between?(0,8)
      return ! position_taken?(index)
    else
      return false
    end
  end

   def turn()
     check = 0
     while check == 0
      puts "Position Input: "
      input = gets.strip
      index = input_to_index(input)
      if valid_move?(index)
        player = current_player()
        move(index,player)
        display_board()
        check = 1
      end
    end
  end

   def turn_count()
    return @board.select{|i| i!=" "}.size
  end

   def current_player()
    return turn_count() % 2 == 0 ? "X":"O"
  end

   def won?()
    chkwon = 0
    WIN_COMBINATIONS.each do |win_combination|

    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

     position_1 = @board[win_index_1]
    position_2 = @board[win_index_2]
    position_3 = @board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
        chkwon = 1
        return win_combination
     end
   end
   if chkwon == 0
     return false
   end
  end

   def full?()
   return @board.none?{|i| i ==" "}
  end

   def draw?()
    if !won?() && full?()
      return true
    else
      return false
    end
  end

   def over?()
   if won?()
     return true
   elsif draw?()
     return true
   else
     return false
   end
  end

   def winner()
   win_combination = won?()
   if win_combination != false
    return @board[win_combination[0]]
   else
     return nil
   end
  end

   def play()
    while !over?()
      turn()
    end
    if won?()
      puts "Congratulations " + winner() +"!"
    else
      puts "Cat's Game!"
    end
  end
end
