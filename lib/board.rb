require './lib/cell'

class Board

  attr_reader :cells
  
  def initialize
    @cells = {}
    ("A".."D").each do |letter|
      (1..4).each do |number|
        cell_key = "#{letter}#{number}"
        @cells[cell_key] = Cell.new(cell_key)
      end
    end
  end



  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def ascending?(data)
    data.each_cons(2).all?{|left, right| left <= right}
  end

  def valid_placement?(ship, coordinates)
    return false unless coordinates.length == ship.length
    
    new_coordinates = coordinates.map do |coordinate|
    valid_coordinate?(coordinate)
    end

    return false if !new_coordinates.all?


    letters = coordinates.map { |coord| coord[0]}
    numbers = coordinates.map { |coord| coord[1..-1].to_i}
    
    if letters.uniq.length == 1
      (numbers.max - numbers.min + 1) == ship.length && ascending?(numbers)
    elsif numbers.uniq.length == 1
      (letters.max.ord - letters.min.ord + 1) == ship.length && ascending?(letters)
    else
      false
    end
  end
end
