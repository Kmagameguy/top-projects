# Use a word array to build our dictionary and freeze
# it to prevent modification
DICTIONARY = %w(
  below
  down
  go
  going
  horn
  how
  howdy
  it
  i
  low
  own
  part
  partner
  sit
).freeze

def substrings(string)
  cleaned_string = string.downcase.gsub(/[^A-Z]/i, '')
  matched_words = []

  DICTIONARY.map do |word|
    cleaned_string.chars.each_with_index do |char, index|
      substring = cleaned_string[index, word.length]
      matched_words.push(substring) if substring == word
    end
  end

  matched_words_with_counts = matched_words.reduce(Hash.new(0)) do |hash, key|
    hash[key] += 1
    hash
  end

  puts matched_words_with_counts
end

substrings("Howdy partner, sit down! How's it going?")
