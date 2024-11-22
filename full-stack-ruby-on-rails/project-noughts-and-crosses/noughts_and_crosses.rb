# frozen_string_literal: true

# A player character
class Player
  attr_accessor :name, :moves
  attr_reader :marker

  def initialize(marker, name = 'Computer')
    @marker = marker
    @name = name
    @moves = []
  end

  def move(available_cells)
    loop do
      puts "#{@name}, make your move! Valid options are: #{available_cells}"

      selection = gets.chomp.to_s.to_i
      break selection if available_cells.include?(selection)

      puts 'Invalid input. Try again.'
    end
  end
end

# A computer character with alternative guessing methods
class Computer < Player
  def move(available_cells)
    available_cells.sample
  end
end

# A game board which displays the current open and marked cells to the player
class Board
  def initialize(size)
    @board = Array.new(size, ' ')
    draw_board
  end

  def update_cells(move_list = [], marker = ' ')
    # Offset by 1 to map back from 1-indexed array to @board's 0-indexed array
    @board[move_list.last - 1] = marker unless move_list.empty?
    draw_board
  end

  def available_cells
    (1..@board.size).to_a - indexes_of_marked_cells
  end

  def blank?
    available_cells.count == @board.size
  end

  private

  def draw_board
    new_rows = [2, 5]
    clear_screen
    @board.each_with_index do |cell, index|
      draw_cell(cell)
      puts "\n" if new_rows.include?(index)
    end
    puts "\n\n"
  end

  def clear_screen
    system('clear')
    puts "\n"
  end

  def draw_cell(value)
    print "|#{value}|"
  end

  def indexes_of_marked_cells
    @board.map.with_index do |cell_value, cell_index|
      cell_index + 1 unless cell_value == ' '
    end.compact
  end
end

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

  def initialize(name)
    @player = Player.new('x', name)
    @computer = Computer.new('o')
    @current_player = @player
    @board = Board.new(WIN_CONDITIONS.flatten.uniq.size)
    @board.update_cells
  end

  def play
    change_players unless @board.blank?
    player_pick_cell
    show_turn_results
    play unless game_over?
  end

  private

  def change_players
    @current_player = @current_player == @player ? @computer : @player
  end

  def player_pick_cell
    @current_player.moves << @current_player.move(@board.available_cells)
  end

  def show_turn_results
    @board.update_cells(@current_player.moves, @current_player.marker)
  end

  def game_over?
    winning_move? || game_draw?
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

puts 'Get ready to play!  Enter your name:'
name = gets.chomp.to_s

game = NoughtsAndCrossesGame.new(name)
game.play
