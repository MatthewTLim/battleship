require './lib/game'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/player'

player = Player.new
cpu_player = Player.new

game = Game.new(player, cpu_player)
print game.main_menu