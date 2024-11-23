# frozen_string_literal: true

require_relative 'board'

# A class to manage screen rendering
class Display
  BOARD_ICONS = {
    nil => "⚪",
    'x' => "🔴",
    'o' => "🔵"
  }.freeze

  KEYCAPS = [
    "1️⃣",
    "2️⃣",
    "3️⃣",
    "4️⃣",
    "5️⃣",
    "6️⃣",
    "7️⃣"
  ].freeze

  SPACER = ' '.freeze
  DOUBLE_SPACER = SPACER + SPACER

  def self.show(board)
    puts column_header
    board.each do |row|
      print '|'
      print emojify(row)
      print "|\n"
    end
    print " --------------------\n"
  end

  def self.column_header
    SPACER + KEYCAPS.join(DOUBLE_SPACER)
  end

  def self.emojify(row)
    row.map { |cell| BOARD_ICONS[cell] }.join(SPACER)
  end
end
