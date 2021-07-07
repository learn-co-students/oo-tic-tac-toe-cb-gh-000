class TicTacToe
  def initialize(board=[" "," "," "," "," "," "," "," "," "])
    @board=board
  end
  def board=(board)
    @board=board
  end
  def board()
    @board
  end

WIN_COMBINATIONS=[
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
  user_input.to_i-1
 end

 def move(index,token="X")
   @board[index]=token
 end

 def position_taken?(index)
   @board[index]=="X"||@board[index]=="O" #return true if fill
 end

 def valid_move?(index)
   (index<9&&index>=0)&&!position_taken?(index)
 end

 def turn_count()
   return @board.reject do|rejected_array|
     rejected_array==" "
     end.size
 end

 def current_player()
   turn_count()%2==0?"X":"O"
 end

 def turn()
   loop_variable=0
  until loop_variable==1
   puts "Enter number 1-9:"
   user_input=gets
   index=input_to_index(user_input)
    if valid_move?(index)==true
     move(index,current_player())
     display_board()
     loop_variable=1
    end
  end
 end

 def won?()
   check=0
     WIN_COMBINATIONS.each do |win_combination|
       win_index_1 = win_combination[0]
       win_index_2 = win_combination[1]
       win_index_3 = win_combination[2]

       position_1 = @board[win_index_1]
       position_2 = @board[win_index_2]
       position_3 = @board[win_index_3]
       if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
         check=1
         return win_combination
       end
     end
    if check==0
      return false
    end
 end

 def full?()
   @board.none? do|no_element|
     no_element==" "
   end
 end

 def draw?()
   !won?()&&full?()
 end

 def over?()
   won?()||draw?()
 end

 def winner()
   win=won?()
   if win!=false
     return @board[win[0]]
   else
     return nil
   end
 end

 def play()
   while !over?()
     turn()
   end
   if won?()
     puts "Congratulations "+winner()+"!"
   else
     puts "Cat's Game!"
   end
 end
end
