# frozen_string_literal: true

# A player character
class Player
  attr_accessor :moves

  def initialize
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

  def initialize
    @player = Player.new
    @computer = Player.new
  end

  def play
    @player.moves = [1, 5, 8, 9]

    p winning_move?(@player)
  end

  private

  def winning_move?(player)
    WIN_CONDITIONS.any? do |win_path|
      win_path.all? { |cell| player.moves.include?(cell) }
    end
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
