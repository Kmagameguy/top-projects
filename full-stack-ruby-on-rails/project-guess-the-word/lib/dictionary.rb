# frozen_string_literal: true

# This class manages our word selection
class Dictionary
  attr_reader :random_word

  WORD_LIST = './assets/google-10000-english-no-swears.txt'
  MIN_LENGTH = 5
  MAX_LENGTH = 12

  def initialize
    @random_word = pick_word
  end

  private

  def pick_word
    filtered_word_list.sample
  end

  def filtered_word_list
    File.open(WORD_LIST).readlines.filter do |word|
      word.chomp!.length.between?(MIN_LENGTH, MAX_LENGTH)
    end
  end
end
