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

def substrings(word)
  puts word; puts DICTIONARY
end

substrings('below')
