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
end

# A game board which displays the current open and marked cells to the player
class Board
  def initialize(size)
    @board = Array.new(size, ' ')
    show_board
  end

  def update_cells(move_list = [], marker = ' ')
    # Offset by 1 to map back from 1-indexed array to @board's 0-indexed array
    @board[move_list.last - 1] = marker if move_list.last
    show_board
  end

  def available_cells(used_moves)
    (1..@board.size).to_a - used_moves
  end

  private

  def show_board
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
    @computer = Player.new('o')
    @current_player = @computer
    @board = Board.new(WIN_CONDITIONS.flatten.uniq.size)
    @board.update_cells
  end

  def play
    @current_player = @current_player == @player ? @computer : @player
    @current_player.moves << if @current_player == @player
                               prompt_for_input
                             else
                               random_move
                             end
    @board.update_cells(@current_player.moves, @current_player.marker)
    play unless game_over?
  end

  private

  def all_moves
    @player.moves + @computer.moves
  end

  def prompt_for_input
    valid_cells = @board.available_cells(all_moves)

    loop do
      puts "#{@current_player.name}, make your move! Valid options are: #{valid_cells}"

      selection = gets.chomp.to_s.to_i
      break selection if valid_cells.include?(selection)

      puts 'Invalid input. Try again.'
    end
  end

  def random_move
    selection = @board.available_cells(all_moves).sample
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
    no_moves_left = all_moves.count >= 9
    puts "Game over! It's a draw!" if no_moves_left
    no_moves_left
  end
end

puts 'Get ready to play!  Enter your name:'
name = gets.chomp.to_s

game = NoughtsAndCrossesGame.new(name)
game.play
