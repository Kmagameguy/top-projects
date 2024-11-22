# frozen_string_literal: true

# This class manages our word selection
class Word
  attr_reader :word

  WORD_LIST = "./assets/google-10000-english-no-swears.txt".freeze

  def initialize
    @word = pick_word
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def pick_word
    filtered_word_list.sample
  end

  private

  def filtered_word_list
    File.open(WORD_LIST).readlines.filter do |word|
      word.chomp!.length.between?(5, 13)
    end
  end
end
