require_relative 'hex'
require_relative "frequency_analysis"

class FixedXor
  def self.xor(left, right)
    left_bytes = left.bytes
    right_bytes = right.bytes

    result_bytes = left_bytes.zip(right_bytes).map {|l,r| l^r}
    result_bytes.pack("U*").to_hex
  end

  def self.brute_force(input)
    possible_keys = (0..255).to_a.map(&:chr)
    chi2_values = chi2_for_keys(input.to_ascii, possible_keys)
    chi2_values.min {|a,b| a[:chi2] <=> b[:chi2]}
  end

  def self.chi2_for_keys(input, keys)
    keys.map do |key|
      plain_text = FixedXor.xor(input, key * input.size).to_ascii
      chi2 = FrequencyAnalysis.chi_squared(plain_text)
      {
        chi2: chi2,
        key: key,
        plain_text: plain_text
      }
    end
  end

  def self.detect(input)
    possible_keys = (0..255).map(&:chr)
    decryptions = []
    input.each_with_index do |line, index|
      chi2_values = FixedXor.chi2_for_keys(line.chomp.to_ascii, possible_keys)
      best_chi2 = chi2_values.min {|a,b| a[:chi2] <=> b[:chi2]}
      info = best_chi2.merge({
        input: line.chomp,
        line_number: index
      })
      decryptions << info unless best_chi2[:chi2] == Float::INFINITY
    end
    decryptions.sort { |a,b| a[:chi2] <=> b[:chi2]}
  end

end
