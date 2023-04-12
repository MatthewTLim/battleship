require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do 
    it 'exists' do 
      expect(@cell).to be_a(Cell)
    end

    it 'has readable attributes' do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to eq(nil)
    end
  end
  
  describe "#empty?" do
    it "checks if a cell is empty" do 
      expect(@cell.empty?).to be(true)
    end
  end

  describe "#display" do
    it "defaults to ." do
      expect(@cell.display).to eq(".")
    end

    it "returns X for a cell once a ship has sunk" do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      @cruiser.hit
      @cruiser.hit

      expect(@cell.display).to eq("X")
    end
  end

  describe "#place_ship(ship)" do
    it "adds a ship to a cell" do
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be(false)
      expect(@cell.display).to eq("S")
    end
  end

  describe "#fired_upon?" do 
    it "checks if a cell has been fired upon" do 
      @cell.place_ship(@cruiser)

      expect(@cell.fired_upon?).to be(false)
    end
  end

  describe "#fire_upon" do 
    it "hits when firing upon a cell with a ship" do
      @cell.place_ship(@cruiser)

      expect(@cell.ship.health).to eq(3)
      expect(@cell.fired_upon?).to be(false)
      expect(@cell.display).to eq("S")

      @cell.fire_upon
      
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be(true)
      expect(@cell.display).to eq("H")
    end

    it "misses when firing upon an empty cell" do
      expect(@cell.empty?).to be(true)

      @cell.fire_upon

      expect(@cruiser.health).to eq(3)
      expect(@cell.fired_upon?).to be(true)
      expect(@cell.display).to eq("M")
    end

    it "can only fire on a cell once" do
      expect(@cell.fired_upon?).to be(false)

      @cell.fire_upon
      expect(@cell.fired_upon?).to be(true)

      expect(@cell.fire_upon).to eq("Please enter new coordinates")
    end
  end

  describe "#render(ship_locator)" do
    before(:each) do
      @cell_1 = Cell.new("B4")
      @cell_2 = Cell.new("C3")
    end

    it "shows display as . when a cell has no ship and is not fired upon" do
      expect(@cell_1.render).to eq(".")
    end

    it "shows display as M when a cell has no ship and is fired upon" do
      @cell_1.fire_upon
      expect(@cell_1.render).to eq("M")
    end

    it "shows display as . when a cell is placed with a ship and the ship locator is off" do 
      @cell_2.place_ship(@cruiser)

      expect(@cell_2.render).to eq(".")
    end

    it "shows display as H when a cell is placed with a ship and is fired upon" do
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")
    end

    it "shows display as S when a cell is placed with a ship, is not fired upon, and the ship locator is on" do
      @cell_2.place_ship(@cruiser)

      expect(@cell_2.render(true)).to eq("S")
    end

    it "shows display as X when a cell with a placed ship has sunk" do
      @cell_2.place_ship(@cruiser)

      expect(@cell_2.render).to eq(".")
      expect(@cell_2.render(true)).to eq("S")

      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to eq(false)

      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
  end

end