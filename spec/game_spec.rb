require './lib/game'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

RSpec.describe Game do
  describe "#initialize" do
    it "exists" do 
      player1 = Player.new
      cpu_player1 = Player.new
      game = Game.new(player1, cpu_player1)
      expect(game).to be_an(Game)
    end

    it "has readable attributes" do
      player1 = Player.new
      cpu_player1 = Player.new
      game = Game.new(player1, cpu_player1)

      expect(player1).to be_an(Player)
      expect(cpu_player1).to be_an(Player)
      
      expect(game.player).to eq(player1)
      expect(game.cpu_player).to eq(cpu_player1)
    end
  end

  describe "#place_ships" do
    it "can place_ships on board" do
      player1 = Player.new
      cpu_player1 = Player.new
      game = Game.new(player1, cpu_player1)
      cruiser = Ship.new("Cruiser", 3)

      expect(game.player_board).to be_a(Board)
      game.place_ship(cruiser, ["A1", "A2", "A3"])
      expect(game.player_board.cells["A1"].ship.nil?).to be(false)
      expect(game.player_board.cells["A2"].ship.nil?).to be(false)
      expect(game.player_board.cells["A3Z"].ship.nil?).to be(false)
    end
  end
end