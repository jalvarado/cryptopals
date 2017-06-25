require_relative 'fixed_xor'
require_relative 'hamming_distance'
require 'base64'

INPUT_FILE_NAME = "challenge6_data.txt"

filepath = File.join(File.dirname(__FILE__), INPUT_FILE_NAME)

base_64_data = File.read(filepath)
binary_data = Base64.decode64(base_64_data)

keysizes_to_try = (2..40).to_a
distances = keysizes_to_try.map do |keysize|
  left = binary_data[0...keysize]
  right = binary_data[keysize...keysize*2]
  distance = HammingDistance.new(left,right).calculate / keysize.to_f
  {
    keysize: keysize,
    distance: distance
  }
end

puts distances.inspect

likely_key_size = distances.min {|a,b| a[:distance] <=> b[:distance]}
puts "Likely key size: #{likely_key_size}"


keysize = likely_key_size[:keysize]
bytes = binary_data.bytes.map(&:chr)
padding = (keysize - bytes.size % keysize ) % keysize
bytes = bytes.concat(Array.new(padding, nil))

chunks = bytes.each_slice(keysize).to_a

transposed_chunks = chunks.transpose

results = transposed_chunks.map do |chunk|
  # Brute force the key for the tranposed chunk
  FixedXor.brute_force(chunk.join)
end

puts results
