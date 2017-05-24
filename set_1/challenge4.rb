require_relative "fixed_xor"

file = File.new(File.join(File.dirname(__FILE__), "challenge4_data.txt"))

possible_keys = (0..255).map(&:chr)
decryptions = []
file.each_line do |input|
  best_chi2 = FixedXor.chi2_for_keys(input.chomp, possible_keys).first
  info = best_chi2.merge({
    input: input.chomp,
    line_number: file.lineno
  })
  decryptions << info unless best_chi2[:chi2] == Float::INFINITY
end

puts decryptions.first

