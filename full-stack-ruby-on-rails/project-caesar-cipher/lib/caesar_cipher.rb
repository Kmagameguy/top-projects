# frozen_string_literal: true

def caesar_cipher(text, offset)
  upcase_alphabet = ('A'..'Z').to_a
  upcase_rotated_alphabet = upcase_alphabet.rotate(offset)
  downcase_alphabet = ('a'..'z').to_a
  downcase_rotated_alphabet = downcase_alphabet.rotate(offset)

  cipher_upcase_hash = create_hash(upcase_alphabet, upcase_rotated_alphabet)
  cipher_downcase_hash = create_hash(downcase_alphabet, downcase_rotated_alphabet)

  cipher = cipher_upcase_hash.merge(cipher_downcase_hash)

  puts text.split('').map { |char| cipher.fetch(char, char) }.join
end

def create_hash(alphabet, rotated_alphabet)
  index = 0
  alphabet.reduce(Hash.new({})) do |hash, key|
    hash[key] = rotated_alphabet[index]
    index += 1
    hash
  end
end

caesar_cipher('What a string!', 5)
