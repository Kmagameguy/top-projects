# frozen_string_literal: true

require 'piece'

RSpec.describe Piece do
  # describe '#intialize' do
  #   context 'when creating black pieces' do
  #     let(:color) { :black }
  #     it 'creates a bishop' do
  #       type = :bishop

  #       bishop = described_class.new(color, type)
  #       expect(bishop).to have_attributes(color: :black, type: :bishop)
  #     end

  #     it 'creates a knight' do
  #       type = :knight

  #       knight = described_class.new(color, type)
  #       expect(knight).to have_attributes(color: :black, type: :knight)
  #     end

  #     it 'creates a rook' do
  #       type = :rook

  #       rook = described_class.new(color, type)
  #       expect(rook).to have_attributes(color: :black, type: :rook)
  #     end

  #     it 'creates a queen' do
  #       type = :queen

  #       queen = described_class.new(color, type)
  #       expect(queen).to have_attributes(color: :black, type: :queen)
  #     end

  #     it 'creates a king' do
  #       type = :king

  #       king = described_class.new(color, type)
  #       expect(king).to have_attributes(color: :black, type: :king)
  #     end
  #   end

  #   context 'when creating white pieces' do
  #     let(:color) { :white }

  #     it 'creates a pawn' do
  #       type = :pawn

  #       pawn = described_class.new(color, type)
  #       expect(pawn).to have_attributes(color: :white, type: :pawn)
  #     end

  #     it 'creates a bishop' do
  #       type = :bishop

  #       bishop = described_class.new(color, type)
  #       expect(bishop).to have_attributes(color: :white, type: :bishop)
  #     end

  #     it 'creates a knight' do
  #       type = :knight

  #       knight = described_class.new(color, type)
  #       expect(knight).to have_attributes(color: :white, type: :knight)
  #     end

  #     it 'creates a rook' do
  #       type = :rook

  #       rook = described_class.new(color, type)
  #       expect(rook).to have_attributes(color: :white, type: :rook)
  #     end

  #     it 'creates a queen' do
  #       type = :queen

  #       queen = described_class.new(color, type)
  #       expect(queen).to have_attributes(color: :white, type: :queen)
  #     end

  #     it 'creates a king' do
  #       type = :king

  #       king = described_class.new(color, type)
  #       expect(king).to have_attributes(color: :white, type: :king)
  #     end
  #   end
  # end

  # describe '#moved?' do
  #   subject(:piece) { described_class.new(:black, :pawn) }

  #   context 'when the piece has not moved from its initial position' do
  #     it 'returns false' do
  #       expect(piece).to_not be_moved
  #     end
  #   end

  #   context 'when the piece has moved from its initial position' do
  #     it 'returns true' do
  #       piece.move
  #       expect(piece).to be_moved
  #     end
  #   end
  # end

  # describe '#to_s' do
  #   context 'when the piece is a knight' do
  #     let(:black_knight) { described_class.new(:black, :knight) }
  #     let(:white_knight) { described_class.new(:white, :knight) }

  #     it 'shows a unicode representation of a black knight' do
  #       expect(black_knight.to_s).to eql '♞'
  #     end

  #     it 'shows a unicode representation of a white knight' do
  #       expect(white_knight.to_s).to eql '♘'
  #     end
  #   end

  #   context 'when the piece is a bishop' do
  #     let(:black_bishop) { described_class.new(:black, :bishop) }
  #     let(:white_bishop) { described_class.new(:white, :bishop) }

  #     it 'shows a unicode representation of a black bishop' do
  #       expect(black_bishop.to_s).to eql '♝'
  #     end

  #     it 'shows a unicode represntation of a white bishop' do
  #       expect(white_bishop.to_s).to eql '♗'
  #     end
  #   end

  #   context 'when the piece is a rook' do
  #     let(:black_rook) { described_class.new(:black, :rook) }
  #     let(:white_rook) { described_class.new(:white, :rook) }

  #     it 'shows a unicode representation of a black rook' do
  #       expect(black_rook.to_s).to eql '♜'
  #     end

  #     it 'shows a unicode representation of a white rook' do
  #       expect(white_rook.to_s).to eql '♖'
  #     end
  #   end

  #   context 'when the piece is a queen' do
  #     let(:black_queen) { described_class.new(:black, :queen) }
  #     let(:white_queen) { described_class.new(:white, :queen) }

  #     it 'shows a unicode representation of a black queen' do
  #       expect(black_queen.to_s).to eql '♛'
  #     end

  #     it 'shows a unicode representation of a white queen' do
  #       expect(white_queen.to_s).to eql '♕'
  #     end
  #   end

  #   context 'when the piece is a king' do
  #     let(:black_king) { described_class.new(:black, :king) }
  #     let(:white_king) { described_class.new(:white, :king) }

  #     it 'shows a unicode representation of a black king' do
  #       expect(black_king.to_s).to eql '♚'
  #     end

  #     it 'shows a unicode representation of a white king' do
  #       expect(white_king.to_s).to eql '♔'
  #     end
  #   end

  #   context 'when the piece is of an unknown type' do
  #     let(:mystery_piece) { described_class.new(:black, :paladin) }

  #     it 'shows nothing' do
  #       expect(mystery_piece.to_s).to be_nil
  #     end
  #   end

  #   context 'when the piece is of an unknown color' do
  #     let(:mystery_piece) { described_class.new(:blurple, :rook) }

  #     it 'shows nothing' do
  #       expect(mystery_piece.to_s).to be_nil
  #     end
  #   end
  # end
end
