class TicTacToe
  def initialize(board = nil)
    @board=board || Array.new(9, " ")
  end
    def display_board
    @board.each_with_index do |cell,i|
      if i%3==0 and i>0
        puts "\n-----------"
      elsif i>0
        print "|"
      end
      print " #{cell} " 
    end
    print "\n"
  end
  
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end
  
  def valid_move?(index)
    b=false
    if index>=0 && index<@board.length && !position_taken?(index)
      b=true
    end
    return b
  end
  
  def input_to_index(index)
    return index.strip.to_i-1
  end
  
  def move(index, value)
    @board[index] = value
  end
  
  def turn
    puts "Please enter 1-9:"
    index=input_to_index(gets)
    valid=valid_move?(index)
    until valid do
      puts "Please enter 1-9:"
      index=input_to_index(gets)
      valid=valid_move?(index)
    end
    move(index, current_player)
    display_board
  end
  
  def turn_count
    n=0
    @board.each do |cell|
      if cell=="X" || cell=="O"
        n+=1
      end
    end
    return n
  end
  
  def current_player
    m=["X", "O"]
    return m[turn_count%2]
  end
  
  def self.get_win_combinations
    i=0
    n=0
    m=[]
    while i<3 do
      temp_m=[]
      j=0
      while j<3 do
        temp_m[j]=3*i+j
        j+=1
      end
      m[n]=temp_m
      n+=1
      i+=1
    end
    i=0
    while i<3 do
      temp_m=[]
      j=0
      while j<3 do
        temp_m[j]=3*j+i
        j+=1
      end
      m[n]=temp_m
      n+=1
      i+=1
    end
    i=0
    temp_m=[]
    while i<3 do
      temp_m[i]=3*i+i
      i+=1
    end
    m[n]=temp_m
    n+=1
    i=0
    temp_m=[]
    while i<3 do
      temp_m[i]=3*i+(2-i)
      i+=1
    end
    m[n]=temp_m
    return m
  end
  
  WIN_COMBINATIONS=self.get_win_combinations()
  
  def won?
    combination=nil
    WIN_COMBINATIONS.each do |win_combination|
      if win_combination.all?{|index| position_taken?(index)}
        if win_combination.all?{|index| @board[index] == "X"} ||
          win_combination.all?{|index| @board[index] == "O"}
          combination=win_combination
          break
        end
      end
    end
    return combination
  end
  
  def full?
    indexes=[]
    0.upto(@board.length-1){|i| indexes[i]=i}
    return indexes.all?{|index| position_taken?(index)}
  end
  
  def draw?
    return full? && !won?
  end
  
  def over?
    return won? || full? || draw?
  end
  
  def winner
    b=nil
    combination=won?
    if !combination.nil?
      b=@board[combination[0]]
    end
    return b
  end
  
  def play
    while !over? do
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
    puts "Cat's Game!"
    end
  end
end