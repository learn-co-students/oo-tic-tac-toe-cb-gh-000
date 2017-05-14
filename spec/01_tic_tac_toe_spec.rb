require_relative '../lib/tic_tac_toe.rb'

describe './lib/tic_tac_toe.rb' do
  describe TicTacToe do
    describe '#initialize' do
      it 'assigns an instance variable @board to an array with 9 blank spaces " "' do
        game = TicTacToe.new
        expect(game.instance_variable_get(:@board)).to eq([" "," "," "," "," "," "," "," "," "])
      end
    end

    describe 'WIN_COMBINATIONS' do
      it 'defines a constant WIN_COMBINATIONS with arrays for each win combination' do
        expect(TicTacToe::WIN_COMBINATIONS.size).to eq(8)

        expect(TicTacToe::WIN_COMBINATIONS).to include_array([0,1,2])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([3,4,5])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([6,7,8])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([0,3,6])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([1,4,7])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([2,5,8])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([0,4,8])
        expect(TicTacToe::WIN_COMBINATIONS).to include_array([6,4,2])
      end
    end

    describe '#display_board' do
      it 'prints arbitrary arrangements of the board' do
        board = ["X", "X", "X", "X", "O", "O", "X", "O", "O"]
        game = TicTacToe.new
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include(" X | X | X ")
        expect(output).to include("-----------")
        expect(output).to include(" X | O | O ")
        expect(output).to include("-----------")
        expect(output).to include(" X | O | O ")


        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include(" X | O | X ")
        expect(output).to include("-----------")
        expect(output).to include(" O | X | X ")
        expect(output).to include("-----------")
        expect(output).to include(" O | X | O ")
      end
    end


    describe '#turn_count' do
      it 'counts occupied positions' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.turn_count).to eq(3)

        board = ["O", " ", "O", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.turn_count).to eq(4)
      end
    end

    describe '#current_player' do
      it 'returns the correct player, X, for the third move' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", " "]
        game.instance_variable_set(:@board, board)

        expect(game.current_player).to eq("X")
      end

      it 'returns the correct player, O, for the fourth move' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.current_player).to eq("O")
      end
    end

    describe '#turn' do
      let(:game) { TicTacToe.new }

      it 'receives user input via the gets method' do
        allow($stdout).to receive(:puts)
        expect(game).to receive(:gets).and_return("1")

        game.turn
      end

      it "calls #input_to_index, #valid_move?, and #current_player" do
        allow($stdout).to receive(:puts)
        expect(game).to receive(:gets).and_return("5")
        expect(game).to receive(:input_to_index).and_return(4)
        expect(game).to receive(:valid_move?).and_return(true)
        expect(game).to receive(:current_player).and_return("X")

        game.turn
      end

      it 'makes valid moves and displays the board' do
        allow($stdout).to receive(:puts)
        expect(game).to receive(:gets).and_return("1")
        expect(game).to receive(:display_board)

        game.turn

        board = game.instance_variable_get(:@board)
        expect(board).to eq(["X", " ", " ", " ", " ", " ", " ", " ", " "])
      end

      it 'asks for input again after a failed validation' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)

        expect(game).to receive(:gets).and_return("invalid")
        expect(game).to receive(:gets).and_return("1")

        game.turn
      end
    end

    describe "#won?" do
      it 'returns false for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.won?).to be_falsey
      end

      it 'returns the winning combo for a win' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "O", "O", "X", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.won?).to contain_exactly(0,4,8)
      end
    end

    describe '#full?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.full?).to be_truthy
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
        game.instance_variable_set(:@board, board)

        expect(game.full?).to be_falsey
      end
    end

    describe '#draw?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_truthy
      end

      it 'returns false for a won game' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_falsey
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_falsey
      end
    end

    describe '#over?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.over?).to be_truthy
      end

      it 'returns true for a won game' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.over?).to be_truthy
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
        game.instance_variable_set(:@board, board)

        expect(game.over?).to be_falsey
      end
    end

    describe '#winner' do
      it 'return X when X won' do
        game = TicTacToe.new
        board = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to eq("X")
      end

      it 'returns O when O won' do
        game = TicTacToe.new
        board = ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to eq("O")
      end

      it 'returns nil when no winner' do
        game = TicTacToe.new
        board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to be_nil
      end
    end
  end
end
