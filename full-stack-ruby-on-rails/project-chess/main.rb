# frozen_string_literal: true

require_relative './lib/chess'

Display.new.welcome
chess = Chess.new
chess.play
