def double_numbers!(num_arr)
  counter = 0
  loop do
    break if counter >= num_arr.size
    num_arr[counter] = num_arr[counter] * 2
    counter += 1
  end
num_arr
end

my_numbers = [1,4,3,7,2,6]
double_numbers!(my_numbers)

puts my_numbers
