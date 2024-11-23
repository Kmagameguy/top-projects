# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'

# A class to manage the state of a chess game
class Chess
  attr_reader :board

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
      take_turn
      break if game_over?

      switch_players
      increment_round
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

  def take_turn
    piece = choose_piece
    destination = choose_destination(piece)
    board.update!(piece, destination)
  end

  def choose_piece
    puts 'Choose a piece to move:'
    loop do
      piece = board.square(chess_notation_to_array(choose_square))

      if !own_piece?(piece)
        puts "That isn't one of your pieces. Select again."
      elsif trapped?(piece)
        puts "Your #{piece.class} cannot move. Select again."
      else
        return piece
      end
    end
  end

  def choose_destination(piece)
    puts "Choose a destination for your #{piece.class}:"
    loop do
      destination = chess_notation_to_array(choose_square)
      return destination if valid_move?(piece, destination)

      puts "#{piece.class} cannot move there. Select again."
    end
  end

  def choose_square
    input = user_input

    until chess_notation?(input)
      puts 'Invalid option. Try [Letter][Number].'
      input = user_input
    end
    input
  end

  def user_input
    gets.chomp.strip
  end

  def chess_notation?(string)
    string.match(/^([a-h])([1-8])/i)
  end

  def own_piece?(piece)
    piece&.color == @current_player.color
  end

  def trapped?(piece)
    piece&.possible_moves(board.squares)&.empty?
  end

  def valid_move?(piece, move)
    piece.possible_moves(board.squares).include?(move) unless hits_king?(move)
  end

  def hits_king?(move)
    move == board.find_king(other_player.color)
  end

  def increment_round
    @turn_count += 1
  end

  def game_over?
    @turn_count == 75
  end

  def chess_notation_to_array(chess_notation)
    [rank(chess_notation), file(chess_notation)]
  end

  def array_to_chess_notation(array_notation)
    row, column = array_notation
    row = board.size - row
    "#{indexed_alphabet.key(column)}#{row}"
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
