require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  describe '#initialize' do 
    it 'exists' do 
      board = Board.new

      expect(board).to be_an(Board)
    end

    it "has readable attributes" do
      board = Board.new

      expect(board.cells).to be_a(Hash)
    end

    
  end
end