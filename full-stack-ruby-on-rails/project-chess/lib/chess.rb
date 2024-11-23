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
    @en_passantable_pawns = []
    @display = Display.new

    setup_game
  end

  def setup_game
    @display.welcome
    load_game? ? load! : new_game
  end

  def play
    loop do
      @display.update!(board.squares, @current_player, @turn_count)
      break if game_over?

      @display.check_warning if board.check?(@current_player.color, other_player.color)
      take_turn
      return if @saved_and_quit

      record_rushing_pawns
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
        destination_piece = board.square(destination)

        if castling?(piece, destination_piece)
          rook, king = identify_rook_and_king(piece, destination_piece)

          if valid_castle?(king, rook)
            castle!(king, rook)
            break
          else
            puts 'You cannot castle those pieces. Select again.'
            next
          end
        end

        if valid?(piece, destination)
          board.update!(piece, destination)
          reset_en_passant
          promote(piece) if promote?(piece)
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

  def castling?(piece, destination_piece)
    (destination_piece.is_a?(King) && piece.is_a?(Rook)) ||
      (destination_piece.is_a?(Rook) && piece.is_a?(King))
  end

  def identify_rook_and_king(piece_one, piece_two)
    king = piece_one.is_a?(King) ? piece_one : piece_two
    rook = piece_one.is_a?(Rook) ? piece_one : piece_two

    [king, rook]
  end

  def valid_castle?(king, rook)
    !board.check?(@current_player.color, other_player.color) &&
      (!king.moved? && !rook.moved?) &&
      own_piece?(king) && own_piece?(rook) &&
      rook_to_king_is_empty?(king, rook) &&
      !king_passes_through_check?(king, rook)
  end

  def castle!(king, rook)
    king_rank, king_file = king.position
    _, rook_file = rook.position

    if king_file > rook_file
      # move king left and rook right
      king_destination = king_file - 2
      rook_destination = king_destination + 1
    else
      # move king right and rook left
      king_destination = king_file + 2
      rook_destination = king_destination - 1
    end

    board.update!(king, [king_rank, king_destination])
    board.update!(rook, [king_rank, rook_destination])
  end

  def valid?(piece, destination)
    valid_piece?(piece) && valid_destination?(piece, destination)
  end

  def game_over?
    checkmate?
  end

  def promote(pawn)
    @display.update!(board.squares, @current_player, @turn_count)
    board.create_piece(pawn.position, replacement_piece, @current_player.color)
  end

  def replacement_piece
    board.special_pieces[Input.promote_piece]
  end

  def promote?(piece)
    piece.is_a?(Pawn) && piece.promote?
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
    elsif !in_move_set?(piece, destination)
      @display.invalid_destination(piece.class, array_to_chess_notation(destination))
    elsif hits_king?(destination)
      @display.cannot_take_king
    elsif moves_into_check?(piece, destination)
      @display.cannot_move_into_check
    end

    @display.prompt_for_reselection
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
      rushing_pawns: @en_passantable_pawns,
      turns: @turn_count
    }

    @save_file.save!(data)
  end

  def save_game?
    @display.save_game_prompt
    Input.yes_response?
  end

  private

  def load_game?
    return false unless @save_file.exists?

    @display.load_game_prompt
    Input.yes_response?
  end

  def load!
    data = @save_file.load!
    @black_player = data[:black]
    @white_player = data[:white]
    @board = data[:board_state]
    @current_player = data[:current_turn]
    @en_passantable_pawns = data[:rushing_pawns]
    @turn_count = data[:turns]
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
    move == board.find_king(other_player.color).position
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

  def rook_to_king_is_empty?(king, rook)
    king_rank, king_file = king.position
    rook_rank, rook_file = rook.position

    return false if king_rank != rook_rank

    min = [king_file, rook_file].min
    max = [king_file, rook_file].max

    board.squares[king_rank][min + 1...max].compact.empty?
  end

  def king_passes_through_check?(king, rook)
    king_rank, king_file = king.position
    _, rook_file = rook.position

    min = [king_file, rook_file].min
    max = [king_file, rook_file].max

    steps = (min + 1...max).to_a

    steps.any? do |file|
      move = [king_rank, file]
      moves_into_check?(king, move)
    end
  end

  def record_rushing_pawns
    @en_passantable_pawns = rushing_pawns
  end

  def rushing_pawns
    board.find_pieces(@current_player.color)
         .select { |piece| piece.is_a?(Pawn) }
         .select(&:rushing?)
  end

  def reset_en_passant
    @en_passantable_pawns.each { |piece| piece.rushing = false }
    @en_passantable_pawns = []
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
