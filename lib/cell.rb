class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @is_fired_upon = false
    @display = "."
  end

  def empty?
    @ship.nil?
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

  def render(value = false)
    if value == true
      if @display == "H" && @ship.sunk?
        @display = "X"
      elsif @display == "X"
        @display = "X"
      elsif @ship != nil && fired_upon? == false
        @display = "S"
      else 
        @display
      end

    else
      if @display == "H" && @ship.sunk?
        @display = "X"
      elsif @display == "X"
        @display = "X"
      elsif @display == "S"
        @display = "."
      else
        @display
      end
    end

  end
end


