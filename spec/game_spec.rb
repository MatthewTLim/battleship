require './lib/game'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

RSpec.describe Game do
  describe "#initialize" do
    it "exists" do 
      player1 = Player.new
      cpu_player = Player.new
      game = Game.new(player1, cpu_player)
      expect(game).to be_an(Game)
    end

    it "has readable attributes" do
      player1 = Player.new
      cpu_player = Player.new
      game = Game.new(player1, cpu_player)

      expect(player1).to be_an(Player)
      expect(cpu_player).to be_an(Player)
      expect(game.player).to eq(player1)
    end
  end
end