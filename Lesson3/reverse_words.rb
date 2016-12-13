sentence = "Humpty Dumpty sat on a wall."

words = sentence.split(/\W/)

new_sentence = words.reverse.join(' ') + '.'
p new_sentence
