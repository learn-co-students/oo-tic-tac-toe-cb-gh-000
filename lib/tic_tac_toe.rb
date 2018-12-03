class TicTacToe
  WIN_COMBINATIONS  = [[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[2,5,8],
[0,4,8],
[6,4,2]
]
  def initialize(board = nil)
     @board = board || Array.new(9, " ")
   end


  def display_board
    puts  " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts  " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts  "-----------"
    puts  " #{@board[6]} | #{@board[7]} | #{@board[8]} "
   end

   def input_to_index(user_input)
    l= user_input.to_i - 1
  return l
  end

  def move( index, current_player )
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?( index)
    index.between?(0,8) && !position_taken?( index)
  end
  def turn
    puts "enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?( index)
        move( index,current_player)
        display_board
    else
      turn
    end
  end

  def turn_count
  i=0
  k=0
  while (k < @board.length ) do
  if @board[k] == "O" || @board[k] == "X"
    i = i + 1
    end
    k = k + 1
  end
  return i
  end

  def current_player
    l = turn_count

    if l % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
      # grab each index from the win_combination that composes a win.
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1] # load the value of the board at win_index_1
      position_2 = @board[win_index_2] # load the value of the board at win_index_2
      position_3 = @board[win_index_3] # load the value of the board at win_index_3

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return win_combination # return the win_combination indexes that won.
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        return win_combination
      else
      end
    end
    return false
    end

    def full?
    i=0
  while @board[i] == "X" || @board[i] == "O" do
  i = i + 1
  end
  if i < @board.length
    return false
  else return true
  end
  end

  def draw?
  if full? &&  !won?
    return true
  else
    return false
  end
  end

  def over?
    if full? ||  won? || draw?
      return true
    else return false
    end
  end

  def winner
  if won? != false
   position=won?[0]
  if @board[position] == "X"
    return "X"
  else @board[position] == "O"
    return "O"
  end
  else
    return nil
  end
  end
  def play
    while over? == false do
       turn
    end
    if  won? != false
    puts"Congrats #{winner}!"
  elsif  draw? == true
    puts"Cat's Game!"
  end


end


end
