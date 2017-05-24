module Hex
  def to_ascii
    return self if self[/\H/]
    [self].pack("H*")
  end

  def to_b64
    return self if self[/\H/]
    [self.to_ascii].pack("m0*")
  end

  def to_hex
    self.unpack("H*").first
  end
end

class String
  include Hex
end
