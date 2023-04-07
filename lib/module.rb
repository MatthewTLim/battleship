module Hitter
   def sunk? 
    if @health == 0
      true
    else
      @sunk
    end
  end

  def hit
    @health -= 1
  end
end