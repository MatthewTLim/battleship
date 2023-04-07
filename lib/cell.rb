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

  def render(value=false)
   if @is_fired_upon == true && @ship == nil
      "M"
   elsif @is_fired_upon == false && @ship == ship && value == true
      "S"
   else
      "."
    end
  end

  # not been fired upon and contains a ship
  # if the cell has been fired upon and it contains a ship (the shot was a hit).

  # def render(true)

  # end
end
