# frozen_string_literal: true

require_relative './lib/noughts_and_crosses'

puts 'Get ready to play!  Enter your name:'
name = gets.chomp.to_s

game = NoughtsAndCrossesGame.new(name)
game.play
