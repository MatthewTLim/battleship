class Player
  attr_reader :ships
  def initialize
    @ships = []
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