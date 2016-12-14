def uuid_generator
  uuid = [random_string(8)]

  3.times {uuid += [random_string(4)]}

  uuid += [random_string(12)]

  # p uuid
  uuid.join('-')
end

def random_string(string_length)
  chars = ('a'..'f').to_a + ('0'..'9').to_a

  string = ''
  string_length.times {string += chars[rand(0..(chars.size - 1))]}
  string
end

uuid = uuid_generator

puts uuid
