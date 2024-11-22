#  A  B  C  D  E  F  G  H  I   J   K   L   M   N
#  0  1  2  3  4  5  6  7  8   9  10  11  12  13

#  O   P   Q   R   S   T   U   V   W   X   Y   Z
# 14  15  16  17  18  19  20  21  22  23  24  25 =>

# Need to:
# X - Take text input and convert it to an array of characters
# X - Map each character to its position in the alphabet
#    X - (ignoring special characters)
# X - Add the offset to each character (and wrap if above 26)
# X - Map each number back to its corresponding character
# Join back into a string
# Keep the casing consistent

ALPHA_MAP = {
  0 =>  'A',
  1 =>  'B',
  2 =>  'C',
  3 =>  'D',
  4 =>  'E',
  5 =>  'F',
  6 =>  'G',
  7 =>  'H',
  8 =>  'I',
  9 =>  'J',
  10 => 'K',
  11 => 'L',
  12 => 'M',
  13 => 'N',
  14 => 'O',
  15 => 'P',
  16 => 'Q',
  17 => 'R',
  18 => 'S',
  19 => 'T',
  20 => 'U',
  21 => 'V',
  22 => 'W',
  23 => 'X',
  24 => 'Y',
  25 => 'Z'
}


def map_to_num(char)
  # Upcase and subtract 65 to shift the ordinal number index
  # to 'A' = 0 through 'Z' = 25
  return char.between?('A', 'z') ? char.upcase.ord - 65 : char
end

# Scratch:
# offset = 5
# char = W : 22

# we need to reduce the offset the distance between W and 25
# 25 - 22 = 3
# 5 - 3 = 2 after wrap-around

def shift(char_index, offset)
  return char_index if !char_index.is_a?(Integer)

  last_index_of_alphabet = 25
  new_char_position = char_index + offset

  return new_char_position unless new_char_position > last_index_of_alphabet
  # subtract one from the total equation to account for 0-indexed array of alphabets
  return (offset - (last_index_of_alphabet - char_index)) - 1
end

def map_to_char(num)
  return num if !num.is_a?(Integer)
  return ALPHA_MAP[num]
end

def caesar_cipher(text, offset)
  arr = text.split('')
  shifted_arr = arr.map do |char|
      map_to_char(shift(map_to_num(char), offset))
  end

  p shifted_arr
end

caesar_cipher('What a string!', 5)
