class TicTacToe
  WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],
  [0,3,6],[1,4,7],[2,5,8],
  [0,4,8],[6,4,2]
]
  def initialize
    @board = [" "," "," "," "," "," "," "," "," "]
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    return input.to_i - 1
  end

  def move(index, character)
    @board[index] =  character
  end

  def position_taken?(index)
  !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    if (!index.between?(0,8))
        return false
    end
    return (position_taken?(index) == false)
  end

  def turn_count
    return @board.select { |tile| tile == 'X' || tile == 'O'}.length
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def current_player
    return turn_count % 2 == 0 ? 'X': 'O'
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      if (combinationMatch?(combination, 'X') || combinationMatch?(combination, 'O'))
        return combination
      end
    end
    return false
  end

  def combinationMatch?(combination, character)
    return combination.all? do |index|
        @board[index] == character
    end
  end

  def draw?
    if (full? && !won?)
      return true
    end
    return false
  end

  def full?
    return !(@board.include?(' ') || @board.include?(''))
  end

  def over?
  return won? || full? || draw?
  end

  def winner
    winner = won?
    if (winner == false)
      return nil
    else
      WIN_COMBINATIONS.each do |combination|
        if (combinationMatch?(combination, 'X'))
          return 'X'
        elsif (combinationMatch?(combination, 'O'))
          return 'O'
        end
      end
    end
  end

  def play
    until over? || won? do
      puts 'Turn starting'
        turn
    end
    gameWinner = winner
    if (gameWinner != nil)
      puts "Congratulations #{gameWinner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
