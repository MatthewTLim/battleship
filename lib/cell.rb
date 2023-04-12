class Cell
  attr_reader   :coordinate, 
                :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @display = "."
  end

  def empty?
    @ship.nil?
  end

  def display
    if @display == "H" && @ship.sunk?
      @display = "X"
    end
      @display
  end

  def place_ship(ship) 
    @ship = ship
    @display = "S"
  end

  def fired_upon?
    @display == "H" || @display == "M"
  end

  def fire_upon
    return "Please enter new coordinates" if fired_upon?
    if @ship = ship
      @display = "H"
      @ship.hit
    else
      @display = "M"
    end
  end

  def render(ship_locator = false)
    if ship_locator == true
      if @ship != nil && fired_upon? == false
        @display = "S"
      end
    else
      if @display == "S"
        @display = "."
      end
    end
    display
  end
  
end


