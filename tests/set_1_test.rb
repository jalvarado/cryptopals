require 'minitest/autorun'
require 'minitest/pride'

require 'securerandom'
require 'fixed_xor'

class Set1Test < MiniTest::Test
  def setup
    # setup
  end

  def test_convert_hex_to_base64
    input = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    expected = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
    assert_equal input.to_b64, expected
  end

  def test_fixed_xor
    left = "1c0111001f010100061a024b53535009181c"
    right = "686974207468652062756c6c277320657965"
    output = FixedXor.xor(left.to_ascii, right.to_ascii)
    expected_output = "746865206b696420646f6e277420706c6179"
    assert_equal output, expected_output
  end

  def test_single_byte_xor
    input = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    output = FixedXor.brute_force(input)[:plain_text]
    assert_equal output, "Cooking MC's like a pound of bacon"
  end

  def test_detect_single_character_xor
    cipher_text = "0c30312b782f392b7839782c2a312d352830"
    random_hex = SecureRandom.hex[0..cipher_text.length]
    input = [cipher_text, random_hex]
    index = FixedXor.detect(input)[:index]
    assert_equal index, 1
  end
end
