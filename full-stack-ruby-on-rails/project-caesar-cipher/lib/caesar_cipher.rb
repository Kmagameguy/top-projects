# frozen_string_literal: true

# A class which offsets the characters in a given string by the provided key amount
class CaesarCipher
  attr_writer :text, :key

  def initialize(text:, key: 1)
    @text = text
    @key = key
    @cipher = create_cipher
  end

  def encode
    @text.split('').map { |char| @cipher.fetch(char, char) }.join
  end

  private

  def create_cipher
    upcase_alphabet = ('A'..'Z').to_a
    downcase_alphabet = upcase_alphabet.map(&:downcase)

    create_hash(upcase_alphabet).merge(create_hash(downcase_alphabet))
  end

  def create_hash(alphabet)
    rotated_alphabet = rotate_alphabet_by_key(alphabet)

    alphabet.each_with_object({}).with_index do |(key, hash), index|
      hash[key] = rotated_alphabet[index]
    end
  end

  def rotate_alphabet_by_key(alphabet)
    alphabet.rotate(@key)
  end
end
