class Game
  attr_reader   :player, 
                :cpu_player

  def initialize(player, cpu_player)
    @player = player
    @cpu_player = cpu_player
    @player_ships = {cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
    @cpu_ships = {cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
  end

  # def ships
  #   Ship.new("Cruiser", 3)
  #   Ship.new("Submarine", 2)
  # end

  def main_menu
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
end
