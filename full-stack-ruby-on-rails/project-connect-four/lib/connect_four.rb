# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# A class to manage our Connect Four game
class ConnectFour
  attr_accessor :board
  attr_reader :player, :computer, :current_player

  def initialize(player_name:, player_marker:, board: Board.new)
    @board = board
    @player = Player.new(player_name, player_marker)
    @computer = Player.new('computer', 'o')
    @current_player = @player
  end

  def play
    add_chip
  end

  def add_chip
    puts "#{@current_player.name} it's your turn.  Next move?"
    board.drop_to_slot(pick_column, @current_player.marker)
  end

  def pick_column
    loop do
      column = verify_column(pick)
      return column if column

      puts 'That column is full, try another.'
    end
  end

  def verify_column(column)
    return column unless board.full?(column)
  end

  def pick
    @current_player.select_column
  end
end
