# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'
require_relative 'input'
require_relative 'game_file'

# A class to manage the state of a chess game
class Chess
  attr_reader :board, :current_player

  def initialize(save_file = GameFile.new)
    @save_file = save_file
    @saved_and_quit = false
    @display = Display.new

    setup_game
  end

  def setup_game
    @display.welcome
    load_game? ? load! : new_game
  end

  def new_game
    @white_player = Player.new(create_player, :white)
    @black_player = Player.new(create_player, :black)
    @board = Board.new
    @current_player = @white_player
    @turn_count = 1
  end

  def create_player
    @white_player.nil? ? @display.player_one_prompt : @display.player_two_prompt

    loop do
      name = Input.user_input
      return name if Input.valid_name?(name)

      @display.empty_name_warning
    end
  end

  def load_game?
    return false unless @save_file.exists?

    @display.load_game_prompt
    Input.yes_response?
  end

  def save_game?
    @display.save_game_prompt
    Input.yes_response?
  end

  def quit_game?
    @display.quit_game_prompt
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

      @display.check_warning if board.check?(@current_player.color, other_player.color)
      take_turn
      return if @saved_and_quit

      switch_players
      increment_round
    end
    @display.show_winner(other_player.name)
  end

  def take_turn
    @display.turn_prompt

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
    if !own_piece?(piece)
      @display.not_piece_owner
    elsif piece&.trapped?(board.squares)
      @display.no_eligible_moves(piece.class)
    elsif !in_move_set(piece, destination)
      @display.invalid_destination(piece.class, array_to_chess_notation(destination))
    elsif hits_king?(destination)
      @display.cannot_take_king
    elsif moves_into_check?(piece, destination)
      @display.cannot_move_into_check
    end

    @display.prompt_for_reselection
  end

  private

  def valid_piece?(piece)
    return false unless own_piece?(piece)
    return false if piece&.trapped?(board.squares)

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
