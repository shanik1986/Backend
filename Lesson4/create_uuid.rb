SECTIONS = [8, 4, 4, 4, 12].freeze
CHARACTERS = (('a'..'z').to_a + ('0'..'9').to_a).freeze

def create_single_section(section_length)
  (1..section_length).each_with_object('') do |_, result|
    result << CHARACTERS.sample
  end
end

def create_uuid
  result = SECTIONS.each_with_object([]) do |char_number, array|
             array << create_single_section(char_number)
           end
  result.join('-')
end

p create_uuid
