# frozen_string_literal: true

require_relative './lib/chess'

def setup_game
  Display.clear
  puts Display.introduction

  chess = Chess.new(first_player, second_player)
  chess.play
end

def first_player
  puts "Enter player 1's name:"
  create_player
end

def second_player
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
