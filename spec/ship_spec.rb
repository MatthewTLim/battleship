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
      expect(cruiser.health).to eq(cruiser.length)  
    end
  
end