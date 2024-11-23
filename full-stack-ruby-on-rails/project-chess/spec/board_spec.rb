# frozen_string_literal: true

require 'board'

RSpec.describe Board do
  # subject(:board) { described_class.new }

  # describe '#initialize' do
  #   it 'creates 8 rows' do
  #     row_count = board.squares.size
  #     expect(row_count).to be 8
  #   end

  #   it 'creates 8 columns' do
  #     column_count = board.squares.map { |row| row.size }.min
  #     expect(column_count).to be 8
  #   end
  # end

  # describe '#setup_board' do
  #   context 'when creating the black pieces' do
  #     row8 = 0
  #     row7 = 1
  #     let(:special_piece_row) { board.squares[row8] }
  #     let(:pawn_row) { board.squares[row7] }

  #     it 'creates rooks at positions a8 and h8' do
  #       a8 = 0
  #       h8 = 7
  #       expect(special_piece_row[a8]).to have_attributes(type: :rook, color: :black)
  #       expect(special_piece_row[h8]).to have_attributes(type: :rook, color: :black)
  #     end

  #     it 'creates knights at positions b8 and g8' do
  #       b8 = 1
  #       g8 = 6
  #       expect(special_piece_row[b8]).to have_attributes(type: :knight, color: :black)
  #       expect(special_piece_row[g8]).to have_attributes(type: :knight, color: :black)
  #     end

  #     it 'creates bishops at positions c8 and f8' do
  #       c8 = 2
  #       f8 = 5
  #       expect(special_piece_row[c8]).to have_attributes(type: :bishop, color: :black)
  #       expect(special_piece_row[f8]).to have_attributes(type: :bishop, color: :black)
  #     end

  #     it 'creates a queen at d8' do
  #       d8 = 3
  #       expect(special_piece_row[d8]).to have_attributes(type: :queen, color: :black)
  #     end

  #     it 'creates a king at e8' do
  #       e8 = 4
  #       expect(special_piece_row[e8]).to have_attributes(type: :king, color: :black)
  #     end

  #     it 'creates 8 pawns in row 7' do
  #       expect(pawn_row).to all(have_attributes(type: :pawn, color: :black))
  #     end
  #   end

  #   context 'when creating the white pieces' do
  #     row1 = 7
  #     row2 = 6
  #     let(:special_piece_row) { board.squares[row1] }
  #     let(:pawn_row) { board.squares[row2] }

  #     it 'creates rooks at positions a1 and h1' do
  #       a1 = 0
  #       h1 = 7
  #       expect(special_piece_row[a1]).to have_attributes(type: :rook, color: :white)
  #       expect(special_piece_row[h1]).to have_attributes(type: :rook, color: :white)
  #     end

  #     it 'creates knights at positions b1 and g1' do
  #       b1 = 1
  #       g1 = 6
  #       expect(special_piece_row[b1]).to have_attributes(type: :knight, color: :white)
  #       expect(special_piece_row[g1]).to have_attributes(type: :knight, color: :white)
  #     end

  #     it 'creates bishops at positions c1 and f1' do
  #       c1 = 2
  #       f1 = 5
  #       expect(special_piece_row[c1]).to have_attributes(type: :bishop, color: :white)
  #       expect(special_piece_row[f1]).to have_attributes(type: :bishop, color: :white)
  #     end

  #     it 'creates a queen at d1' do
  #       d1 = 3
  #       expect(special_piece_row[d1]).to have_attributes(type: :queen, color: :white)
  #     end

  #     it 'creates a king at e1' do
  #       e1 = 4
  #       expect(special_piece_row[e1]).to have_attributes(type: :king, color: :white)
  #     end

  #     it 'creates 8 pawns in row 2' do
  #       expect(pawn_row).to all(have_attributes(type: :pawn, color: :white))
  #     end
  #   end
  # end
end
