hsh = {
      first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'],
      fourth: ['over', 'the', 'lazy', 'dog']
      }
result = []

hsh.each do |_, array|
  array.each do |word|
    word.each_char { |char| result << char if 'aiuoe'.include?(char) }
  end
end

p result
