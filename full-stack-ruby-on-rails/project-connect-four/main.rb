# frozen_string_literal: true

require_relative './lib/connect_four'

def setup_game
  Display.clear
  puts 'Welcome to Connect Four!'
  puts 'To get started, please enter your name:'

  c = ConnectFour.new(player_name: player_name)
  c.play
end

def player_name
  loop do
    name = user_input
    return name if valid?(name)

    puts "Name can't be empty.  Try again."
  end
end

def valid?(name)
  !name.strip.empty?
end

def user_input
  gets.chomp
end

setup_game
