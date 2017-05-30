require_relative "fixed_xor"


file = File.new(File.join(File.dirname(__FILE__), "challenge4_data.txt"))

decryptions = FixedXor.detect(file.readlines)
puts decryptions.first

