require_relative 'hex'

input = <<-END
Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal
END

key = "ICE".freeze
key_bytes = key.bytes

encrypted_bytes = []
input_bytes = input.chomp.bytes
input_bytes.each_with_index do |byte, index|
  key = key_bytes[index % key_bytes.size]
  encrypted_bytes << (byte ^ key)
end

ciphertext = encrypted_bytes.pack("C*").to_hex
puts "Ciphertext: #{ciphertext}"
