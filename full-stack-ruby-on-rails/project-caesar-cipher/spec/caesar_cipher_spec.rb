# frozen_string_literal: true

require_relative '../lib/caesar_cipher'

RSpec.describe CaesarCipher do
  describe '#encode' do
    it 'ensures case is preserved' do
      c = CaesarCipher.new(text: 'sPonGeBob TeXt', key: 1)
      expect(c.encode).to eq 'tQpoHfCpc UfYu'
      expect(c.encode).to_not eq 'TQPOHFCPC UFYU'
    end

    it 'ensures letters wrap back to the beginning' do
      c = CaesarCipher.new(text: 'ZZZZZZ', key: 3)
      expect(c.encode).to eq 'CCCCCC'
      expect(c.encode).to_not eq 'cccccc'
    end

    it 'does nothing to special characters and spaces' do
      c = CaesarCipher.new(text:'!@#$%^&* ()', key: 7)
      expect(c.encode).to eq '!@#$%^&* ()'
    end

    it 'correctly ciphers the given text' do
      c = CaesarCipher.new(text: 'What a string!', key: 5)
      expect(c.encode).to eq 'Bmfy f xywnsl!'
    end
  end
end
