require './lib/game'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

RSpec.describe Player do
  describe "#initialize" do
    it "exists" do 
    player1 = Player.new

    expect(player1).to be_an(Player)
    end

    it "has readable attributes" do
      player1 = Player.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(player1.ships).to eq([])
    end 
  end

  describe "#add_ship" do
    it "can add a ship" do
      player1 = Player.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(player1.ships).to eq([])
      player1.add_ship(cruiser)
      player1.add_ship(submarine)
      expect(player1.ships).to eq([cruiser, submarine])
    end
  end

  describe "#health" do
    it "has health" do
      player1 = Player.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      player1.add_ship(cruiser)
      player1.add_ship(submarine)

      expect(player1.health).to eq(5)
    end 
  end

end