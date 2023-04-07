class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @is_empty = true
  end

  def empty?
    if @ship.nil?
      @is_empty
    else
      false
    end
  end

  def place_ship(ship) 
    @ship = ship
  end




end