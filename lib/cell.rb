class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @is_fired_upon = false
  end

  def empty?
    if @ship.nil?
      true
    else
      false
    end
  end

  def place_ship(ship) 
    @ship = ship
  end

  def fired_upon?
    @is_fired_upon
  end

  def fire_upon
    if @ship = ship
      @is_fired_upon = true
      @ship.hit
    else
      @is_fired_upon = true
    end
  end

  def render
   if @is_fired_upon == true && @ship == nil
      "M"
    else
      "."
    end
  end
end
