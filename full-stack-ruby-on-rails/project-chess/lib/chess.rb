# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'
require_relative 'input'
require_relative 'game_file'

# A class to manage the state of a chess game
class Chess
  attr_reader :board, :current_player

  def initialize(white_name, black_name, save_file = GameFile.new)
    @save_file = save_file
    @saved_and_quit = false
    @display = Display.new
    load_game? ? load! : new_game(white_name, black_name)
  end

  def new_game(white_name, black_name)
    @white_player = Player.new(white_name, :white)
    @black_player = Player.new(black_name, :black)
    @board = Board.new
    @current_player = @white_player
    @turn_count = 1
  end

  def load_game?
    return false unless @save_file.exists?

    puts 'Load saved game? (y/n)'
    Input.yes_response?
  end

  def save_game?
    puts 'Save before quitting? (y/n)'
    Input.yes_response?
  end

  def quit_game?
    puts 'Quit game? (y/n)'
    Input.yes_response?
  end

  def quit!
    @saved_and_quit = true
    save! if save_game?
  end

  def save!
    data = {
      black: @black_player,
      white: @white_player,
      board_state: @board,
      current_turn: @current_player,
      turns: @turn_count
    }

    @save_file.save!(data)
  end

  def load!
    data = @save_file.load!
    @black_player = data[:black]
    @white_player = data[:white]
    @board = data[:board_state]
    @current_player = data[:current_turn]
    @turn_count = data[:turns]
  end

  def play
    loop do
      @display.update!(board.squares, @current_player, @turn_count)
      break if game_over?

      puts 'Your King is checked!' if board.check?(@current_player.color, other_player.color)
      take_turn
      return if @saved_and_quit

      switch_players
      increment_round
    end
    puts "Game over! #{other_player.name} wins!"
  end

  def take_turn
    puts 'Make your move or type "quit game" to quit:'
    loop do
      input = Input.new

      if input.quit
        quit!
        break
      else
        piece = board.square(chess_notation_to_array(input.first_location))
        destination = chess_notation_to_array(input.second_location)

        if valid?(piece, destination)
          board.update!(piece, destination)
          break
        else
          print_error(piece, destination)
        end
      end
    end
  end

  def switch_players
    @current_player = other_player
  end

  def other_player
    if @current_player == @white_player
      @black_player
    else
      @white_player
    end
  end

  def increment_round
    @turn_count += 1
  end

  def valid?(piece, destination)
    valid_piece?(piece) && valid_destination?(piece, destination)
  end

  def game_over?
    checkmate?
  end

  def chess_notation_to_array(chess_notation)
    [rank(chess_notation), file(chess_notation)]
  end

  def array_to_chess_notation(array_notation)
    row, column = array_notation
    row = board.size - row
    "#{indexed_alphabet.key(column)}#{row}"
  end

  def print_error(piece, destination)
    if !valid_piece?(piece)
      if !own_piece?(piece)
        puts "That isn't one of your pieces."
      elsif trapped?(piece)
        puts "Your #{piece.class} cannot move."
      end
    elsif !valid_destination?(piece, destination)
      if in_move_set?(piece, destination)
        if hits_king?(destination)
          puts "You cannot take the opponent's King!"
        elsif moves_into_check?(piece, destination)
          puts "Moving #{piece.class} to #{array_to_chess_notation(destination)} would put your King into check!"
        end
      else
        puts "#{piece.class} cannot move to #{array_to_chess_notation(destination) }"
      end
    end
    puts 'Select again.'
  end

  private

  def valid_piece?(piece)
    return false unless own_piece?(piece)
    return false if trapped?(piece)

    true
  end

  def valid_destination?(piece, destination)
    if in_move_set?(piece, destination)
      return false if hits_king?(destination)
      return false if moves_into_check?(piece, destination)

      true
    else
      false
    end
  end

  def own_piece?(piece)
    piece&.color == @current_player.color
  end

  # To Do: Move to Piece class
  def trapped?(piece)
    piece&.possible_moves(board.squares)&.empty?
  end

  def in_move_set?(piece, move)
    piece.possible_moves(board.squares).include?(move) unless hits_king?(move)
  end

  def hits_king?(move)
    move == board.find_king(other_player.color)
  end

  def checkmate?
    board.check?(@current_player.color, other_player.color) &&
      !can_break_check?
  end

  def can_break_check?
    moves = []
    pieces = board.find_pieces(@current_player.color)
    pieces.each do |piece|
      moves << piece.possible_moves(board.squares).reject do |move|
        moves_into_check?(piece, move)
      end
    end
    !moves.flatten.empty?
  end

  def moves_into_check?(piece, move)
    temp_board = Marshal.load(Marshal.dump(board))
    piece = temp_board.square(piece.position)
    temp_board.update!(piece, move)
    temp_board.check?(@current_player.color, other_player.color)
  end

  def indexed_alphabet
    ('a'..'h').each_with_object({}).with_index do |(letter, hash), index|
      hash[letter] = index
    end
  end

  def rank(string)
    board.size - string.strip.chars.last.to_i
  end

  def file(string)
    indexed_alphabet[string.strip.chars.first.downcase]
  end
end
