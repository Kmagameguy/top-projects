# frozen_string_literal: true

# This module manages our word selection
module Wordable
  WORD_LIST = './assets/google-10000-english-no-swears.txt'
  MIN_LENGTH = 5
  MAX_LENGTH = 12

  def pick_word
    filtered_word_list.sample
  end

  private

  def filtered_word_list
    File.open(WORD_LIST).readlines.filter do |word|
      word.chomp!.length.between?(MIN_LENGTH, MAX_LENGTH)
    end
  end
end
