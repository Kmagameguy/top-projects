# frozen_string_literal: true

# A class which offsets the characters in a given string by the provided key amount
class CaesarCipher
  def initialize(text:, key: 1)
    @text = text
    @key = key
  end

  def encode
    upcase_alphabet = ('A'..'Z').to_a
    upcase_ciphered_alphabet = upcase_alphabet.rotate(@key)
    downcase_alphabet = ('a'..'z').to_a
    downcase_ciphered_alphabet = downcase_alphabet.rotate(@key)

    cipher_upcase_hash = create_hash(upcase_alphabet, upcase_ciphered_alphabet)
    cipher_downcase_hash = create_hash(downcase_alphabet, downcase_ciphered_alphabet)

    cipher = cipher_upcase_hash.merge(cipher_downcase_hash)

    @text.split('').map { |char| cipher.fetch(char, char) }.join
  end

  private

  def create_hash(alphabet, rotated_alphabet)
    index = 0
    alphabet.each_with_object({}) do |key, hash|
      hash[key] = rotated_alphabet[index]
      index += 1
    end
  end
end

c = CaesarCipher.new(text: 'What a string!', key: 5)
p c.encode
