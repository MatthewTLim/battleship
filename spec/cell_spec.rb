require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe '#initialize' do 
    it 'exists' do 
      cell = Cell.new("B4")

      expect(cell).to be_a(Cell)
    end

    it 'has readable attributes' do 
      cell = Cell.new("B4")

      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to eq(nil)
    end
  end

  describe "#empty?" do
    it "checks if cell is empty" do 
      cell = Cell.new("B4")

      expect(cell.empty?).to be(true)
    end
  end

  describe "#place_ship(ship)" do
    it "adds a ship to the cell" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to be(false)
    end
  end

  describe "#fired_upon?" do 
    it "checks if cell has been fired upon" do 
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to be(false)
    end
  end

  describe "#fire_upon" do 
    it "fires upon a cell" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to be(false)

      cell.fire_upon
      
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be(true)
    end
  end

  describe "#render" do
    it "renders . when not fired upon" do
      cell_1 = Cell.new("B4")
      
      expect(cell_1.render).to eq(".")
    end

    it "renders M when fired upon" do
      cell_1 = Cell.new("B4")
      
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
    end
    
    it "renders . when ship is placed" do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq(".")
    end

    it "renders S to reveals a ships location" do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_2.place_ship(cruiser)
      expect(cell_2.render(true)).to eq("S")
    end

    it "renders H when a ship is hit" do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_2.place_ship(cruiser)
      expect(cell_2.render(true)).to eq("S")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
    end

    it " renders X when sunk" do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      
      cell_2.place_ship(cruiser)
      cruiser.hit
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
      
      expect(cell_2.render).to eq("X")
    end
  end
end