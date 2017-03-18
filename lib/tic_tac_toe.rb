class TicTacToe
  def initialize(board=[" "," "," "," "," "," "," "," "," "])
    @board = board
  end
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[2,4,6],[0,4,8]]
  def display_board
       puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
       puts "-----------"
       puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
       puts"-----------"
       puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
     a = input.to_i
     b = a - 1
     return b
    end
    def move( index, value)
      @board[index] = value
    end
    def position_taken?(index)
      if @board[index] == " " || @board[index] == "" or @board[index]==nil
        false
      else
        true
      end
    end
    def valid_move?(index)
      if index.between?(0,9) && !position_taken?(index)
        true
      else
        false
      end
    end
    def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    while  !valid_move?(index)
    input = gets.strip
    index = input_to_index(input)
  end
  move(index,current_player)
  display_board

  end
    def turn_count
    count = 0
    @board.each { |position|
    if position =="X" ||position =="O"
      count += 1
    end
    }
    return count
    end
    def current_player
      if turn_count % 2 ==0
        "X"
      else
        "O"
      end
    end
    def won?
       won = false
       WIN_COMBINATIONS.each do |win_combination|
       win_index_1 = win_combination[0]
       win_index_2 = win_combination[1]
       win_index_3 = win_combination[2]
       po_1 = @board[win_index_1]
       po_2 = @board[win_index_2]
       po_3 = @board[win_index_3]
         if po_1=="X" && po_2 == "X" && po_3 == "X"
          return  won = [win_index_1,win_index_2,win_index_3]
        elsif po_1=="O" && po_2 == "O" && po_3 == "O"
          return  won = [win_index_1,win_index_2,win_index_3]
         end
      end
      return won
    end

    def full?
      return @board.all? do |po|
        po == "X" || po =="O"
      end
    end
    def draw?
      if  !won? &&full?
        return true
      else
        false
      end
    end


    def over?
      if draw? || full? || won?
        return true
      else return false
      end
    end
    def winner
       if won?
       won_combination = won?
       won_position = won_combination[0]
        return  @board[won_position]
      else
        return   nil
      end
    end
  def play
  until over?do
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
  end
end
