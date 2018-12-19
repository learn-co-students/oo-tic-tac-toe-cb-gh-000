class TicTacToe
  def initialize(board=nil)
    @board=board||Array.new(9," ")
  end

  def display_board
   puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
 end

 WIN_COMBINATIONS= [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

  def input_to_index(user_input)
    index=user_input.to_i - 1
  end

  def move(user_input,player)
    @board[user_input] = player
  end

  def position_taken?(user_input)
    !(@board[user_input].nil? || @board[user_input] == " ")
  end

  def valid_move?(user_input)
    user_input.between?(0,8) && !position_taken?(user_input)
  end

  def turn_count
    @cnt = 0
    @board.each do |state|
      if state !=' '
        @cnt+=1
      end
    end
    return @cnt
  end

  def current_player
     turn_count
  if @cnt%2==0
    @player = 'X'
  else
    @player = 'O'
  end
end

  def turn
    puts "Please enter 1-9:"
    user_input =gets.strip
    index=input_to_index(user_input)
    until valid_move?(index)
      return turn
    end
      current_player
      move(index,@player)
      display_board
  end

  def won?
    WIN_COMBINATIONS.any? do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination # return the win_combination indexes that won.
      else
        false
      end
      if position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination # return the win_combination indexes that won.
      else
        false
      end

    end
  end

  def full?
  @board.all?{|i| i!=' '}
end


  def draw?
    if full?
    if !won?
      return true
    else
      return false
    end
  end
end

 def over?
   full?||draw?||won?
 end

 def winner
  @winner=won?
  if @winner.class != Array
    return nil
  else
    @winner.all? do |i|
      if @board[i]=="X"
        return "X"
      elsif @board[i]=='O'
        return 'O'
      end
    end
  end
end

  def play
    while !over?
      turn
    end
    if winner
      puts("Congratulations #{winner}!")
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
