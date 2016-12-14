def dot_separated_ip_address?(input_string)
  result = true

  dot_separated_words = input_string.split(".")
  result = false if dot_separated_words.size != 4

  while dot_separated_words.size && result > 0 do
    word = dot_separated_words.pop
    unless is_an_ip_number?(word)
      reult = false
      break
    end
  end

  result
end
