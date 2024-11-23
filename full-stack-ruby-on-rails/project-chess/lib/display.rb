# frozen_string_literal: true

# A class to manage terminal output
class Display

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
    puts board.to_s
    puts "Round #{round}: #{player.name}'s turn."
  end

  private

  def clear
    system('clear')
    system('cls')
  end

end
