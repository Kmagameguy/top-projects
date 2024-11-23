# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'computer'
require_relative 'display'

# A class to manage our Connect Four game
class ConnectFour
  attr_accessor :board
  attr_reader :player, :computer, :current_player

  def initialize(player_name:)
    @board = Board.new
    @player = Player.new(player_name, @board.column_count)
    @computer = Computer.new
    @current_player = @player
    show_board
  end

  def play
    loop do
      switch_players
      show_turn_message
      add_chip
      show_board
      break if game_over?
    end

    puts "#{@current_player.name} wins!"
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
    board.drop_to_slot(pick_column, @current_player.marker)
  end

  def pick_column
    loop do
      column = verify_column(pick)
      return column if column

      puts 'That column is full, try another.'
    end
  end

  def game_over?
    board.any_in_a_row?(@current_player.marker)
  end

  private

  def show_turn_message
    if @current_player == @player
      puts "#{@current_player.name} it's your turn.  Next move?"
    else
      puts 'Computer is picking a spot...'
    end
  end

  def show_board
    Display.show(board.slots)
  end

  def verify_column(column)
    return column unless board.full?(column)
  end

  def pick
    @current_player.select_column
  end
end
