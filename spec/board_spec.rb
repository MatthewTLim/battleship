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

      expect(board.cells.length).to eq(16)
      expect(board.cells).to include("A1", "D4")
      expect(board.cells["A1"]).to be_an_instance_of(Cell)
    end
  end

  describe "#valid_coordinate?(coordinate)" do
    it "can validate coordinate" do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be(true)
      expect(board.valid_coordinate?("D4")).to be(true)
      expect(board.valid_coordinate?("A5")).to be(false)
      expect(board.valid_coordinate?("E1")).to be(false)
      expect(board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe "#valid_coordinates?(coordinates)" do
    it "can validate coordinates" do
      board = Board.new

      expect(board.valid_coordinates?(["A1", "B2", "C4"])).to be(true)
      expect(board.valid_coordinates?(["A3", "A5", "A1"])).to be(false)
    
        #!!!!! CHECK TO SEE IF WE NEED TO ADD ADDITTIONAL TESTING HERE????
    
    end
  end

  describe "#valid_placement?" do
    before(:each) do 
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end
    
    it "returns false if number of coordinates is not the same as the ship length" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
    end

    it "returns false if coordinates are not consecutive" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
    end

    it "returns false if coordinates are diagonal" do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
    end

    it "returns true if placement is valid" do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
      expect(@board.valid_placement?(@submarine, ["E1", "E2"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
    end

    it "returns false if placement coordinates are invalid" do
      expect(@board.valid_placement?(@submarine, ["E1", "E2"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["C1", "D1", "E1"])).to be(false)
    end
  end

  describe "#place(ship)" do
    it "places a ship opn the board" do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)

      @board.place(@cruiser, ["A1", "A2", "A3"])

      cell_1 = @board.cells["A1"]    
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]    

      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)

      expect(cell_3.ship == cell_2.ship).to be(true)
    end

    it 'does not overlap ships when placing' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      submarine = Ship.new("Submarine", 2)    
      
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be (false)
    end
  end

  describe "#render" do
    it "renders the board" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)    

      board.place(cruiser, ["A1", "A2", "A3"])    

      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end

    it "renders H when a placed ship is hit" do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2) 

      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])

      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC S . . . \nD S . . . \n")

      board.fire_upon("A1")
      expect(board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

end