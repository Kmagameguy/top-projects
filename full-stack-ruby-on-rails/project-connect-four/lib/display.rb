# frozen_string_literal: true

require_relative 'board'

# A class to manage screen rendering
class Display
  NIL_ICON = {
    nil => "⚪"
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
    clear
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
    row.map do |cell|
      NIL_ICON[cell] || cell
    end.join(SPACER)
  end

  def self.clear
    system('clear')
  end
end
