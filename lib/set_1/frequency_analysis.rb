module FrequencyAnalysis
  extend self

  ENGLISH_FREQUENCIES = {
    'A' => 0.08167,
    'B' => 0.01492,
    'C' => 0.02782,
    'D' => 0.04253,
    'E' => 0.12702,
    'F' => 0.02228,
    'G' => 0.02015,
    'H' => 0.06094,
    'I' => 0.06966,
    'J' => 0.00153,
    'K' => 0.00772,
    'L' => 0.04025,
    'M' =>  0.02406,
    'N' => 0.06749,
    'O' => 0.07507,
    'P' =>  0.01929,
    'Q' => 0.00095,
    'R' => 0.05987,
    'S' => 0.06327,
    'T' => 0.09056,
    'U' => 0.02758,
    'V' => 0.00978,
    'W' => 0.02360,
    'X' => 0.00150,
    'Y' => 0.01974,
    'Z' => 0.00074
  }

  def chi_squared(input)
    letter_count = Hash.new(0)
    ignored = 0

    input.each_char do |char|
      if /[[:alpha:]]/.match(char)
        letter_count[char.upcase] += 1
      elsif /[[[:punct:]][[:space:]]]/.match(char)
        ignored += 1
      else
        return Float::INFINITY
      end
    end

    chi2 = 0.0
    chi_length = input.length - ignored

    return Float::INFINITY if chi_length == 0

    ('A'..'Z').each do |char|
      observed = letter_count[char]
      expected = chi_length * ENGLISH_FREQUENCIES[char]
      difference = observed - expected
      chi2 += difference * difference / expected
    end

    chi2
  end
end
