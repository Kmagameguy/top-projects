# frozen_string_literal: true

# A player character
class Player
  attr_accessor :name, :moves
  attr_reader :character

  def initialize(character, name = 'Computer')
    @character = character
    @name = name
    @moves = []
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

  BOARD = Array.new(WIN_CONDITIONS.flatten.uniq.size, ' ')

  def initialize
    @player = Player.new('x', 'Vin Diesel')
    @computer = Player.new('o')
    @current_player = @computer
    show_board
  end

  def play
    @current_player = @current_player == @player ? @computer : @player
    @current_player.moves << if @current_player == @player
                               prompt_for_input
                             else
                               random_move
                             end
    show_board
    play unless game_over?
  end

  private

  def prompt_for_input
    valid_cells = (1..9).to_a - (@player.moves + @computer.moves)

    loop do
      puts "#{@current_player.name}, make your move! Valid options are: #{valid_cells}"

      selection = gets.chomp.to_s.to_i
      break selection if valid_cells.include?(selection)

      puts 'Invalid input. Try again.'
    end
  end

  def random_move
    valid_cells = (1..9).to_a - (@player.moves + @computer.moves)
    selection = valid_cells.sample
    puts "#{@current_player.name} selected #{selection}."
    selection
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
    no_moves_left = (@player.moves + @computer.moves).count >= 9
    puts "Game over! It's a draw!" if no_moves_left
    no_moves_left
  end

  def clear_screen
    system('clear')
    puts "\n"
  end

  def update_marked_cells
    player = @current_player
    BOARD[player.moves.last - 1] = player.character if player.moves.last
  end

  def draw_cell(value)
    print "|#{value}|"
  end

  def show_board
    new_rows = [2, 5]
    clear_screen
    update_marked_cells
    BOARD.each_with_index do |cell, index|
      draw_cell(cell)
      puts "\n" if new_rows.include?(index)
    end
    puts "\n\n"
  end
end

game = NoughtsAndCrossesGame.new
game.play
# Essentially have a "grid"

# | 1. | 2. | 3. |
# | 4. | 5. | 6. |
# | 7. | 8. | 9. |

# win conditions: any three in a row:
# winner_winner_chicken_dinner = [
#       Rows
#       [1, 2, 3],
#       [4, 5, 6],
#       [7, 8, 9],
#       Columns
#       [1, 4, 7],
#       [2, 5, 8],
#       [3, 6, 9],
#       Diagonals
#       [1, 5, 9],
#       [3, 5, 7]
# ]

# Board HAS-MANY cells
# cell may be: empty, cross, or nought
# 2 players (pvp or pve)

# Game Loop
# 1. Player 1 is X; Computer is O
# 2. Move
#   - Prompt for user grid selection (use rand assignment for computer)
#   - Check if move is valid (does a cross or nought already exist in the cell?)
#     - If invalid, notify and prompt again until valid
#   - Place player's cross (or nought) in selected cell
#   - Alternate players between loops, starting with crosses
# 3. Check win conditions
#    - if player 1 or computer have a win condition:
#      - announce game over
#    - else if all squares are full
#      - announce cat's game (draw)
# 4. Repeat

# Game is the main class
# Should "own" the gameplay loop
# Nothing else can exist "alone", so maybe those are modules?
# - Players
#   - is either cross (x) or nought (o)
# - Board
#   - has many cells (with an ID each?)
