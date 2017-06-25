require 'test_helper'
require 'set_1/fixed_xor'
require 'securerandom'

class TestFixedXor < Minitest::Test
  def test_unequal_length_strings
    assert_raises ArgumentError do
      FixedXor.xor('a', 'ab')
    end
  end

  def test_xor
    left = "1c0111001f010100061a024b53535009181c"
    right = "686974207468652062756c6c277320657965"
    output = FixedXor.xor(left.to_ascii, right.to_ascii)
    expected_output = "746865206b696420646f6e277420706c6179"
    assert_equal output, expected_output
  end

  def test_single_byte_xor
    input = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    output = FixedXor.brute_force(input)[:plain_text]
    assert_equal "Cooking MC's like a pound of bacon", output
  end

  def test_detect_single_character_xor
    cipher_text = "0c30312b782f392b7839782c2a312d352830"
    random_hex = SecureRandom.hex[0..cipher_text.length]
    input = [cipher_text, random_hex]
    result = FixedXor.detect(input).first
    index = result[:line_number]
    assert_equal 0, index
  end
end
