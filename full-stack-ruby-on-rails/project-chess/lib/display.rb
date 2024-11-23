# frozen_string_literal: true

# A class to manage terminal output
class Display
  SPACER = ' '
  DOUBLE_SPACER = "#{SPACER}#{SPACER}"
  WALL = '|'
  NEWLINE = "\n"
  EMPTY_SQUARE = "-#{SPACER}"

  def show_intro
    clear
    puts introduction
  end

  def introduction
    <<~HEREDOC
      Welcome to Chess!
      To get started, please enter your player names.
      The first player to enter their name will be playing as WHITE.

    HEREDOC
  end

  def update!(board, player, round)
    clear
    stringify(board)
    puts "Round #{round}: #{player.name}'s turn."
  end

  private

  def clear
    system('clear')
    system('cls')
  end

  def stringify(board)
    board.each_with_index do |row, index|
      print rank_index(index, board)
      row.each do |square|
        print stringify_square(square)
      end
      print "#{WALL}#{NEWLINE}"
    end

    print "#{file_index}#{NEWLINE}#{NEWLINE}"
  end

  def stringify_square(square)
    if square.nil?
      EMPTY_SQUARE
    else
      "#{square}#{SPACER}"
    end
  end

  def rank_index(index, board)
    "#{board.size - index}#{WALL}"
  end

  def file_index
    "#{SPACER}#{SPACER}#{a_to_h}"
  end

  def a_to_h
    ('a'..'h').to_a.join(SPACER)
  end
end
