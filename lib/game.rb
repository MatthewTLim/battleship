class Game
  attr_reader   :player, 
                :cpu_player,
                :player_board,
                :cpu_board


  def initialize(player, cpu_player)
    @player = player
    @cpu_player = cpu_player
    @player_ships = {cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
    @cpu_ships = {cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
    @player_board = Board.new
    @cpu_board = Board.new
  end

  # def ships
  #   Ship.new("Cruiser", 3)
  #   Ship.new("Submarine", 2)
  # end

  def setup 
  puts "Welcome to BATTLESHIP Enter p to play. Enter q to quit."
    data = gets.chomp.downcase
    if data == "p"  
    puts "GO!"
    elsif data == "q" 
      puts "Quitting"
    else
      puts "Invalid input please try again."
      main_menu
    end
  end

  def place_ship(ship, coordinates)
    @player_board.place(ship, coordinates)
  end

end
