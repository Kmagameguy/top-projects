# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'computer'

# This is our main class which will instantiate a game of Noughts & Crosses.
class NoughtsAndCrossesGame
  WIN_CONDITIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ].freeze

  # Derive board size from our list of win conditions.
  # This would allow for silly changes like a 4x4-sized grid.
  BOARD_SIZE = WIN_CONDITIONS.flatten.uniq.size

  def initialize(name)
    @player = Player.new('x', name)
    @computer = Computer.new('o')
    @current_player = @player
    @board = Board.new(BOARD_SIZE)
    @board.update_cells
  end

  def play
    change_players unless @board.blank?
    player_pick_cell
    show_turn_results
    play unless game_over?
  end

  def game_over?
    winning_move? || game_draw?
  end

  def change_players
    @current_player = @current_player == @player ? @computer : @player
  end

  private

  def player_pick_cell
    @current_player.moves << @current_player.move(@board.available_cells)
  end

  def show_turn_results
    @board.update_cells(@current_player.moves, @current_player.marker)
  end

  def winning_move?
    game_won = WIN_CONDITIONS.any? do |win_path|
      win_path.all? { |cell| @current_player.moves.include?(cell) }
    end
    puts "#{@current_player.name} wins!" if game_won
    game_won
  end

  def game_draw?
    no_moves_left = @board.available_cells.count <= 0
    puts "Game over! It's a draw!" if no_moves_left
    no_moves_left
  end
end
