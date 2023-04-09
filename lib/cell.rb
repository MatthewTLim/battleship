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

  def render(value=false)
    if value == true
      if @ship != nil && fired_upon? == false
        @display = "S"
      elsif @ship == nil && fired_upon? == false
        @display = "."
      elsif @display == "H" && @ship.sunk?
        @display = "X"
      elsif @display == "H"
        display = "H"
      elsif @display == "M"
        @display = "M"
      # else
      #   @display = "X"
      end
    else
      if (@display == "H") && @ship.sunk?
        # require 'pry'; binding.pry
        @display = "X"
      elsif @display == "S"
        @display = "."
      else 
        @display
      end
    end
  end
end
      # if fired_upon? == true
      #   @display
      # elsif @display == "S"
      #   @display = "."
      # else
      #   @display
      # end


#   end
# end


