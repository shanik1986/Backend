def generate_uuid
  sections_length = [8, 4, 4, 4, 12]

  uuid = []
  sections_length.each {|length| uuid += [random_string(length)]}

  uuid.join('-')
end

def random_string(string_length)
  chars = ('a'..'f').to_a + ('0'..'9').to_a

  string = ''
  string_length.times {string += chars.sample}
  string
end

uuid = generate_uuid

puts uuid
