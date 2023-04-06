require './lib/ship'

RSpec.describe Ship do
  describe "#initialize"
    it "exists" do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser).to be_an(Ship)
    end

    it "has attributes" do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)  
    end
    
  describe "#sunk?" do
    it "starts as not sunk" do
      cruiser = Ship.new("Cruiser", 3)

      expect(cruiser.sunk?).to eq(false)
    end
  end

  describe "#hit?" do
    it "it deducts the health by one" do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser.health).to eq(3)
      cruiser.hit
      expect(cruiser.health).to eq(2)
    end
  end
end