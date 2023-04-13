class Game
  attr_reader   :player, 
                :cpu_player,
                :player_board,
                :cpu_board,
                :cpu_cruiser


  def initialize(player, cpu_player)
    @player = player
    @cpu_player = cpu_player
    @player_cruiser = Ship.new("Cruiser", 3)
    @cpu_cruiser =  Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @cpu_submarine = Ship.new("Submarine", 2)

    @player_board = Board.new
    @cpu_board = Board.new
  end

  # def ships
  #   Ship.new("Cruiser", 3)
  #   Ship.new("Submarine", 2)
  # end

  def main_menu
  puts "Welcome to BATTLESHIP Enter p to play. Enter q to quit."
    data = gets.chomp.downcase
    if data == "p"  
    puts "Lets play!"
    elsif data == "q" 
      puts "Quitting"
    else
      puts "Invalid input please try again."
      main_menu
    end
    if data == "p"
      p generate_computer_board(@cpu_cruiser)
      p generate_computer_board(@cpu_submarine)
      puts "PLACE SHIPS".center(60, "=")
      puts "I have laid out my ships on the grid.".center(60, " ")
      puts "You now need to lay out your two ships.".center(60, " ")
      puts "The Cruiser is three units long and the Submarine is two units long.".center(60, " ")
    end
  end
  
  
  def generate_computer_board(ship)
    cells = @cpu_board.cells.keys 
    coordinates = cells.sample(ship.length)
    until (@cpu_board.valid_placement?(ship, coordinates)) == true
      coordinates = cells.sample(ship.length)
    end
    @cpu_board.place(ship, coordinates)
    @cpu_board.render(true)
  end

  def place_ship(ship, coordinates)
    @player_board.place(ship, coordinates)
  end

end
