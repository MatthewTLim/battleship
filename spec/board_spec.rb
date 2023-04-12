require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@board).to be_an(Board)
    end

    it "has readable attributes" do
      expect(@board.cells).to include("A1", "D4")
      expect(@board.cells["A1"]).to be_an_instance_of(Cell)
      expect(@board.cells.length).to eq(16)
    end
  end

  describe "#valid_coordinate?(coordinate)" do
    it "can validate a coordinate" do
      expect(@board.valid_coordinate?("A1")).to be(true)
      expect(@board.valid_coordinate?("D4")).to be(true)
      expect(@board.valid_coordinate?("A5")).to be(false)
      expect(@board.valid_coordinate?("E1")).to be(false)
      expect(@board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe "#valid_coordinates?(coordinates)" do
    it "can validate multiple coordinates" do
      expect(@board.valid_coordinates?(["A1", "B2", "C4"])).to be(true)
      expect(@board.valid_coordinates?(["A3", "A5", "A1"])).to be(false)
    
        #!!!!! CHECK TO SEE IF WE NEED TO ADD ADDITTIONAL TESTING HERE????
    
    end
  end

  ### Need test for ascending?(data) !!!!!!!!

  describe "#valid_placement?" do   
    it "only validates placement if number of coordinates entered matches the ship length" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
    end

    it "only validates placement if coordinates are placed consecutively" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
    end

    it "only validates placement if coordinates are not placed diagonally" do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
    end

    it "only validates placement if valid coordinates are used" do
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
      expect(@board.valid_placement?(@submarine, ["E1", "E2"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
      expect(@board.valid_placement?(@cruiser, ["C1", "D1", "E1"])).to be(false)
    end
  end

  describe "#place(ship)" do
    it "places a ship opn the board" do
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
      @board.place(@cruiser, ["A1", "A2", "A3"]) 
      
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be (false)
    end
  end

  describe "#render" do
    it "displays . for all cells with a placed ship onto the board when ship locator is off" do
      @board.place(@cruiser, ["A1", "A2", "A3"])    

      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it "displays S for all cells with a placed ship onto the board when ship locator is on" do
      @board.place(@cruiser, ["A1", "A2", "A3"])    

      expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  
    it "displays H for all hit cells onto the board only if the ship has not sunk" do
      @board.place(@cruiser, ["A1", "A2", "A3"])   
      @board.place(@submarine, ["C1", "D1"])  
  
      @board.fire_upon("A1")

      expect(@board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it "displays M for all missed cells onto the board" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["C1", "D1"])

      @board.fire_upon("B4")
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . M \nC . . . . \nD . . . . \n")
    end

    it "displays X for all cells with sunk ship onto the board" do 
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["C1", "D1"])

      @board.fire_upon("C1")
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC H . . . \nD . . . . \n")

      @board.fire_upon("D1")
      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC X . . . \nD X . . . \n")
    end

    it "displays S for all cells placed with a ship and not fired upon onto the board when the ship locator is on" do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @board.place(@submarine, ["C1", "D1"])

      expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC S . . . \nD S . . . \n")

      @board.fire_upon("A1")
      expect(@board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC S . . . \nD S . . . \n")

      @board.fire_upon("B4")
      expect(@board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . M \nC S . . . \nD S . . . \n")

      @board.fire_upon("C1")
      expect(@board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . M \nC H . . . \nD S . . . \n")

      @board.fire_upon("D1")
      expect(@board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . M \nC X . . . \nD X . . . \n")
      
      expect(@board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . M \nC X . . . \nD X . . . \n")
    end

  end


  ### Need test for fire_upon(coordinate) !!!!!!!!

end