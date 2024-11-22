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
# Loop over the dictionary and count the number of times that the word appears
# in the string
#   - get the length of the current dictionary word
#   - take user word and loop through the characters one-by-one, looking at a substring that is the length
#     of the dictionary word.  Increment an index var until we reach the end of the string  Example: word[currentIndex, DICTIONARY_WORD.length]
#   - Any time currentSubstring == DictionaryWord, increment that word's count and return to tracking hash
# Revisit one of the past articles on enumerables/hashes/arrays -- there was a good example of creating
# a key/pair with counted results (I think that was with .reduce())


def substrings(string)
  cleaned_string = string.downcase.gsub(/[^A-Z]/i, '')
  DICTIONARY.each do |word|
    cleaned_string.chars.each_with_index do |char, index|
      temp_str = cleaned_string[index, word.length]
      puts "Match found: #{word} in #{temp_str}" if temp_str == word
    end
  end
end

substrings("Howdy partner, sit down! How's it going?")
