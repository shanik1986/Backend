statement = 'The Flitstones Rock!'
result = {}
# letters = ('a'..'z').to_a + ('A'..'Z').to_a
#
# letters.each do |letter|
#   letter_frequency =  statement.scan(letter).count
#   result[letter] = letter_frequency if letter_frequency > 0
# end
#
# puts result

statement.each_char do |char|
  char = char.downcase
  next if char.match(/[^a-z]/)
  result.key?(char) ? result[char] += 1 : result[char] = 1
end

puts result
