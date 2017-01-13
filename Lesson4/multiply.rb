def multiply(num_arr, multiplier)
  counter = 0
  result = []

  loop do
    break if counter == num_arr.size

    current_number = num_arr[counter] * multiplier
    result << current_number

    counter += 1
  end
  result
end


my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) == [3, 12, 9, 21, 6, 18]
