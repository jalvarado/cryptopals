require 'test_helper'
require 'set_1/hamming_distance'

class HammingDistanceTest < Minitest::Test
  def test_bitwise_hamming_distance
    left = "this is a test"
    right = "wokka wokka!!!"
    assert_equal 37, HammingDistance.new(left, right).calculate
  end
end
