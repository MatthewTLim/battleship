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

      expect(game.player).to be_an(Player)
      expect(game.cpu_player).to be_an(Player)
      
      expect(game.player).to eq(player1)
      expect(game.cpu_player).to eq(cpu_player1)
    end
  end

  # describe "#place_ships" do
  #   it "can place_ships on board" do
  #     player1 = Player.new
  #     cpu_player1 = Player.new
  #     game = Game.new(player1, cpu_player1)
  #     cruiser = Ship.new("Cruiser", 3)

  #     expect(game.player_board).to be_a(Board)
  #     game.place_ship(cruiser, ["A1", "A2", "A3"])
  #     expect(game.player_board.cells["A1"].ship.nil?).to be(false)
  #     expect(game.player_board.cells["A2"].ship.nil?).to be(false)
  #     expect(game.player_board.cells["A3"].ship.nil?).to be(false)
  #   end
  # end

  # describe "#generate_computer_board(ship)" do
  #   it "generates computer board with placed ships" do
  #     cruiser = Ship.new("Cruiser", 3)
  #     player1 = Player.new
  #     cpu_player1 = Player.new
  #     game = Game.new(player1, cpu_player1)
  #     game.generate_computer_board(cruiser)
  #     require 'pry'; binding.pry
  #     expect(game.cpu_board.cells).to eq(1)

  #   end
  # end



end