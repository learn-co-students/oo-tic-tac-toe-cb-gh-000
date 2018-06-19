class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]# ETC, an array for each win combination
  ]
  def initialize(board=nil)
    @board=board || Array.new(9," ")
  end

  # def current_player
  #   puts turn_count
  #   turn_count % 2 == 0 && turn_count!=0 ? "O" : "X"
  # end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def input_to_index(index)
    index.to_i - 1
  end
  def move(index,character)
    @board[index]=character
  end
  def valid_move?(index)
    (index>=0 && index<=8) && !position_taken?(index)
  end
  def turn
    puts "Please enter  1-9"
    input = gets.strip
    index =  input_to_index(input)
    if valid_move?(index)
      character = current_player
      move(index,character)
      display_board
    else
      puts "invalid move"
      turn
    end
  end


  def current_player
    count = turn_count
    if(count%2!=0 && count!=0)
      return "O"
    else
      return "X"
    end
  end

  def won?
    WIN_COMBINATIONS.each do |comb|
      if @board[comb[0]]==@board[comb[1]] && @board[comb[1]]==@board[comb[2]] && (@board[comb[0]]=="X" || @board[comb[0]]=="O")
        return comb
      end
    end
    return false
  end

  def full?
    @board.all?{|i| i=="X" || i=="O"}
  end

  def draw?
    (!won? && full?)
  end

  def over?
    !(!(won? || full? || draw?))
  end

  def winner
    combination = won?
    if((combination))
      return @board[combination[0]]
    else
      return nil
    end
  end
  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner()}!"
    else
      puts "Cat's Game!"
    end
  end


end
