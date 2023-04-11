class Player
  attr_reader :ships, :health, :player_board
  def initialize
    @ships = []
    @player_board = Board.new
  end

  def health
    total_health = ships.sum do |ship|
      ship.health
    end
    total_health
  end

  def add_ship(ship)
    @ships << ship
  end
end