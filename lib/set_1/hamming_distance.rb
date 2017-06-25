class HammingDistance
  MASK = 0b11111111
  attr_reader :left, :right

  def initialize(left, right)
    @left = left
    @right = right
  end

  def self.calculate(left, right)
    new(left, right).calculate
  end

  def calculate
    raise "Undefined for strings of unequal lenfth" if left.length != right.length
    left.bytes.zip(right.bytes).map do |l,r|
      differences = (l.ord ^ r.ord) & MASK
      count_bits(differences)
    end.inject(0, &:+)
  end

  private

  def count_bits(byte)
    count = 0
    while byte != 0
      byte = byte & byte-1
      count += 1
    end
    count
  end

end
