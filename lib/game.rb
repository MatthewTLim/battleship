class Game
  attr_reader :cpu_board, 
  :player_board, 
  :player, 
  :cpu_player

  def initialize
    @player = Player.new
    @cpu_player = Player.new
    @player_board = Board.new
    @cpu_board = Board.new

  end
  
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
