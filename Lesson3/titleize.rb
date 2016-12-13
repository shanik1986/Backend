def titleize(str)
  storage = str.downcase.split
  storage.map! {|word| word.capitalize!}
  storage.join(' ')
end

test = "this is a nice test to have! At least, I think..."

test = titleize(test)

puts test
