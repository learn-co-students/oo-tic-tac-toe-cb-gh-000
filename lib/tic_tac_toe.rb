class TicTacToe
  def initialize
    @board=[" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
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

  def position_taken_by(index)
    @board[index]
  end

  def player_winner(combination, player)
    combination.all? do |el|
      position_taken?(el)
      position_taken_by(el)==player
    end
  end

  def won?
    WIN_COMBINATIONS.find do |c|
      player_winner(c,"X") || player_winner(c,"O")
    end
  end

  def full?
    i=0
    @board.all? do |el|
      el!=""&&el!=" "&&!el.nil?
    end
  end

  def draw?
    (!(!!won?))&&full?
  end

  def over?
    (!!won?)||draw? #full?(@board) here I put draw? only to make the tests happy
  end

  def winner
    c=won?
    if c&&player_winner(c,"X")
      return "X"
    elsif c&&player_winner(c,"O")
      return "O"
    else
      return nil
    end
  end

  def input_to_index(index)
    (index.to_i)-1
  end

  def move(index, symbol="X")
    @board[index]=symbol
  end

  def valid_move?(index)
    exists=index>=0 && index<9
    if exists
      !position_taken?(index)
    end
  end

  def turn
    player=current_player
    loop do
      puts "Please enter 1-9:"
      input=gets.strip
      index=input_to_index(input)
      if valid_move?(index)
        move(index, player)
        display_board
        break
      end
    end
  end

  def line(lineNumber)
    puts " "+@board[lineNumber*3+0]+" | "+@board[lineNumber*3+1]+" | "+@board[lineNumber*3+2]+" "
  end

  def separator
    puts "-----------"
  end

  def display_board
    line(0)
    separator
    line(1)
    separator
    line(2)
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations " + winner + "!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def turn_count
    counter=0
    @board.each do |position|
      if position=="X" || position=="O"
        counter+=1
      end
    end
    counter
  end

  def current_player
    turnN=turn_count
    if turnN%2==0
      "X"
    else
      "O"
    end
  end

end #class TicTacToe
