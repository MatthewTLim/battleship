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
      player1.add_ship(cruiser)
      player1.add_ship(submarine)
      expect(player1.health).to eq(5)
      expect(player1.player_board).to be_an(Board)
    end
  end
end