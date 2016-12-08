def find_greatest(numbers)
  return if numbers.nil? || numbers.empty?
  saved_number = numbers.first

  numbers.each do |num|
    current_number = num
    if saved_number >= current_number
      next
    else
      saved_number = current_number
    end
  end

  saved_number
end

arr = [1,2,3,5,242,4,778]
puts find_greatest(arr)
