# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'
require_relative 'input'

# A class to manage the state of a chess game
class Chess
  attr_reader :board, :current_player

  def initialize(white_name, black_name)
    @board = Board.new
    @black_player = Player.new(black_name, :black)
    @white_player = Player.new(white_name, :white)
    @current_player = @white_player
    @turn_count = 1
  end

  def play
    loop do
      Display.show(board, @current_player, @turn_count)
      break if game_over?

      puts 'Your King is checked!' if board.check?(@current_player.color, other_player.color)
      take_turn
      switch_players
      increment_round
    end
    puts "Game over! #{other_player.name} wins!"
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

  def take_turn
    puts 'Make your move:'
    loop do
      input = Input.new
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

  def valid?(piece, destination)
    valid_piece?(piece) && valid_destination?(piece, destination)
  end

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

  def increment_round
    @turn_count += 1
  end

  def game_over?
    @turn_count == 75 || checkmate?
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
