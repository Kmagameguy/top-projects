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


# Assignment: Return a hash which counts the number of times
# any words from our dictionary appear as a substring of the user-provided word.
#   - Make sure the evaluation is case-insensitive
#   - Make sure it can evaluate multiple words
#
# To Do:
# X - Downcase user input for easy comparison against the dictionary
# X - Toss out special characters
# X - Loop over the dictionary and count the number of times that the word appears
# in the string
#   - get the length of the current dictionary word
#   - take user word and loop through the characters one-by-one, looking at a substring that is the length
#     of the dictionary word.  Increment an index var until we reach the end of the string  Example: word[currentIndex, DICTIONARY_WORD.length]
#   - Any time currentSubstring == DictionaryWord, increment that word's count and return to tracking hash
# X - Revisit one of the past articles on enumerables/hashes/arrays -- there was a good example of creating
# a key/pair with counted results (I think that was with .reduce())


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
