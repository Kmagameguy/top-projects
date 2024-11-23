# frozen_string_literal: true

# A class to manage terminal output
class Display
  def self.clear
    system('clear')
    system('cls')
  end

  def self.show(board, player, round)
    #self.clear
    puts "Round #{round}: #{player.name}'s turn."
    puts board.to_s
  end
end
