def double_odd_indices(num_arr)
  counter = 0
  result = []

  loop do
    break if counter == num_arr.size
    current_number = num_arr[counter]

    if counter.odd?
      current_number *= 2
    end
    result << current_number

    counter += 1
  end
  result
end

my_numbers = [1, 4, 3, 7, 2, 6]

puts double_odd_indices(my_numbers) == [1, 8, 3, 14, 2, 12]
