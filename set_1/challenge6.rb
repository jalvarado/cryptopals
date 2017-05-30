require_relative 'fixed_xor'

INPUT_FILE_NAME = "challenge6_data.txt"
MASK = 0b11111111

def hamming_distance(left, right)
  raise "Undefined for strings of unequal lenfth" if left.length != right.length
  left.bytes.zip(right.bytes).map do |l,r|
    differences = (l.ord ^ r.ord) & MASK
    count_bits(differences)
  end.inject(0, &:+)
end

def count_bits(byte)
  count = 0
  while byte != 0
    byte = byte & byte-1
    count += 1
  end
  count
end

filepath = File.join(File.dirname(__FILE__), INPUT_FILE_NAME)

data = File.read(filepath)
binary_data = data.to_ascii

keysizes_to_try = (2..40).to_a
distances = keysizes_to_try.map do |keysize|
  {
    keysize: keysize,
    distance: hamming_distance(binary_data[0...keysize], binary_data[keysize...keysize*2])/keysize.to_f
  }
end


likely_key_size = distances.min {|a,b| a[:distance] <=> b[:distance]}
puts "Likely key size: #{likely_key_size}"

chunks = binary_data.bytes.each_slice(likely_key_size[:keysize]).to_a
transposed_chunks = chunks.transpose

results = transposed_chunks.map do |chunk|
  # Brute force the key for the tranposed chunk
  FixedXor.brute_force(chunk.map(&:chr).join)
end

puts results
