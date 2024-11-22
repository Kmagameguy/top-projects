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

def is_lowercase?(char)
  return char == char.downcase
end

def adjust_casing(source_text, shifted_array)
  source_array = source_text.split('')
  cased_array = []
  shifted_array.each_with_index.map do |char, index|
    is_lowercase?(source_array[index]) ? cased_array.push(char.downcase) : cased_array.push(char)
  end
  cased_array
end

def caesar_cipher(text, offset)
  arr = text.split('')
  shifted_arr = arr.map do |char|
      map_to_char(shift(map_to_num(char), offset))
  end

  puts adjust_casing(text, shifted_arr).join
end

#caesar_cipher('What a string!', 5)

def create_hash(alphabet, rotated_alphabet)
  index = 0
  alphabet.reduce(Hash.new({})) do |hash, key|
    hash[key] = rotated_alphabet[index]
    index += 1
    hash
  end
end

def caesar_cipher2(text, offset)
  upcase_alphabet = ('A'..'Z').to_a
  upcase_rotated_alphabet = upcase_alphabet.rotate(offset)
  downcase_alphabet = ('a'..'z').to_a
  downcase_rotated_alphabet = downcase_alphabet.rotate(offset)


  cipher_upcase_hash = create_hash(upcase_alphabet, upcase_rotated_alphabet)
  cipher_downcase_hash = create_hash(downcase_alphabet, downcase_rotated_alphabet)

  cipher = cipher_upcase_hash.merge(cipher_downcase_hash)

  puts text.split('').map { |char| cipher.fetch(char, char)}.join
end

caesar_cipher2('What a string!', 5)
