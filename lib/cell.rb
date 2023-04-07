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
    return false if @is_fired_upon == true
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
   elsif @is_fired_upon == true && @ship == ship
    # require 'pry'; binding.pry
      "H"
   elsif @is_fired_upon == false && ship && @ship.health == 0 
      "X"
   else
      "."
    end
  end
end
  # not been fired upon and contains a ship
  # if the cell has been fired upon and it contains a ship (the shot was a hit).
  # if the cell has been fired upon and its ship has been sunk.
  # def render(true)

  # end

