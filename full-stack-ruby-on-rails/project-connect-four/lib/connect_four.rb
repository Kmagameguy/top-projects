# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# A class to manage our Connect Four game
class ConnectFour
  attr_accessor :board
  attr_reader :player, :computer, :current_player

  def initialize(player_name:, player_marker:)
    @board = Board.new
    @player = Player.new(player_name, player_marker, @board.column_count)
    @computer = Player.new('computer', 'o')
    @current_player = @player
  end

  def play
    switch_players
    add_chip
  end

  def switch_players
    return if board.blank?

    @current_player = if @current_player == @player
                        @computer
                      else
                        @player
                      end
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
