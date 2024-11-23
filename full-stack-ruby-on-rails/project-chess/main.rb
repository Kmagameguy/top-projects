# frozen_string_literal: true

require_relative './lib/chess'

def setup_game
  system('clear')
  system('cls')

  puts 'Welcome to Chess!'
  puts 'To get started, please enter your player names.'
  puts 'The first player to enter their name will be playing as WHITE'

  c = Chess.new(player1, player2)
  p c
end

def player1
  puts "Enter player 1's name:"
  create_player
end

def player2
  puts "Enter player 2's name:"
  create_player
end

def create_player
  loop do
    name = user_input
    return name if valid?(name)

    puts 'Name cannot be empty. Try again.'
  end
end

def valid?(name)
  !name.strip.empty?
end

def user_input
  gets.chomp.strip
end

setup_game
