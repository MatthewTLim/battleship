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

  def valid_coordinates?(coordinates)
      new_coordinates = coordinates.map do |coordinate|
      valid_coordinate?(coordinate) && @cells[coordinate].ship.nil?
      end
      new_coordinates.all?
  end

  # def valid_ship?(coordinates)
  #     new_coordinates = coordinates.map do |coordinate|
  #     @cells[coordinate].ship == nil
  #     end
  #     new_coordinates.all?
  # end

  def ascending?(data)
    data.each_cons(2).all?{|left, right| left <= right}
  end

  def valid_placement?(ship, coordinates)
    return false unless coordinates.length == ship.length
    return false unless valid_coordinates?(coordinates)
    # return false unless valid_ship?(coordinates)

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

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    else
      false
    end
  end

  def render(value=false)
    letter = " "
    new_display = "  1 2 3 4 "
    counter = 0
    @cells.each do |coordinate, cell|
      letters = coordinate.split
      letter_find = letters.map { |coord| coord[0]}
      letter = letter_find[0]
      if counter == 0
        new_display << "\n#{letter}"
      elsif counter % 4 == 0
        new_display << " \n#{letter}"
      end
      counter += 1
      new_display << " #{cell.render(value)}"
    end
    new_display << " \n"
  end

  def fire_upon(coordinate)
    return false unless valid_coordinate?(coordinate)
    @cells[coordinate].fire_upon
  end

end
