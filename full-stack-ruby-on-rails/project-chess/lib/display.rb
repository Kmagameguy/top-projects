# frozen_string_literal: true

# A class to manage terminal output
class Display
  SPACER = ' '
  DOUBLE_SPACER = "#{SPACER}#{SPACER}"
  WALL = '|'
  NEWLINE = "\n"
  EMPTY_SQUARE = "-#{SPACER}"

  def welcome
    clear
    puts 'Welcome to Chess!'
  end

  def show_intro
    welcome
    puts introduction
  end

  def introduction
    <<~HEREDOC
      To get started, please enter your player names.
      The first player to enter their name will be playing as WHITE.

    HEREDOC
  end

  def player_one_prompt
    show_intro
    puts "Enter player 1's name:"
  end

  def player_two_prompt
    show_intro
    puts "Enter player 2's name:"
  end

  def empty_name_warning
    puts 'Name cannot be empty. Try again.'
  end

  def update!(board, player, round)
    clear
    stringify(board)
    puts "Round #{round}: #{player.name}'s turn."
  end

  def check_warning
    puts 'Your King is checked!'
  end

  def not_piece_owner
    puts 'That is not one of your pieces.'
  end

  def no_eligible_moves(piece)
    puts "Your #{piece} cannot move."
  end

  def invalid_destination(piece, destination)
    puts "#{piece} cannot move to #{destination}."
  end

  def cannot_take_king
    puts "You cannot take the opponent's King!"
  end

  def cannot_move_into_check(piece, destination)
    puts "Moving #{piece} to #{destination} would put your King into check!"
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
