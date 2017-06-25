require 'test_helper'
require 'set_1/hex'

class TestHex < Minitest::Test
  def test_convert_hex_to_base64
    input = '49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d'
    expected = 'SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t'
    assert_equal input.to_b64, expected
  end

  def test_convert_hex_to_ascii
    hex_str = '7468697320776173206120747269756d7068'
    assert_equal 'this was a triumph', hex_str.to_ascii
  end

  def test_ignore_strings_with_non_hex_values
    invalid_str = "gg"
    assert_raises "Non-hex value in string" do
      invalid_str.to_ascii
    end
  end

  def test_ascii_to_hex
    hex_str = '7468697320776173206120747269756d7068'
    ascii_str = 'this was a triumph'
    assert_equal hex_str, ascii_str.to_hex
  end
end

