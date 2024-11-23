# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# A class to manage the state of a chess game
class Chess
  attr_reader :board

  def initialize(black_name, white_name)
    @board = Board.new
    @black_player = Player.new(black_name, :black)
    @white_player = Player.new(white_name, :white)
    @current_player = @white_player
  end

  def chess_notation_to_array(chess_notation)
    [rank(chess_notation), file(chess_notation)]
  end

  def array_to_chess_notation(array_notation)
    x, y = array_notation
    x = board.size - x
    "#{indexed_alphabet.key(y)}#{x}"
  end

  def make_move(from, to)
    a_from = chess_notation_to_array(from)
    a_to = chess_notation_to_array(to)

    board.update(a_from, a_to) if valid_move?(a_from, a_to)

    puts "Moving from #{from} to #{to} is illegal. Try again."
  end

  def valid_move?(square, move)
    square_rank, square_file = square
    piece = board.squares[square_rank][square_file]

    piece.possible_moves(board.squares).include?(move)
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
