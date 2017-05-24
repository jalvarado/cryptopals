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
    possible_keys = ('a'..'z').to_a.concat(('A'..'Z').to_a)
    results = chi2_for_keys(input, possible_keys)
    plain_text = results.first[:plain_text]
    plain_text
  end

  def self.chi2_for_keys(input, keys)
    keys.map do |key|
      plain_text = FixedXor.xor(input.to_ascii, key * input.to_ascii.size).to_ascii
      chi2 = FrequencyAnalysis.chi_squared(plain_text)
      {
        chi2: chi2,
        key: key,
        plain_text: plain_text
      }
    end.sort { |a,b| a[:chi2] <=> b[:chi2] }
  end
end
