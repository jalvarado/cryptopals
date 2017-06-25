require_relative "fixed_xor"

input = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736".freeze

plain_text = FixedXor.brute_force(input)
puts plain_text

