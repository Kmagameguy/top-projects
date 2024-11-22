# frozen_string_literal: true

require_relative '../lib/caesar_cipher'

describe 'Caesar Cipher' do
  describe '#encode' do
    it 'correctly ciphers the string' do
      c = CaesarCipher.new(text: 'What a string!', key: 5)
      expect(c.encode).to eq 'Bmfy f xywnsl!'
    end
  end
end
