arr = [['stars', 'river'], 'letter', ['leaves', ['horses', 'table']]]

new_arr = []

arr.each do |most_outer_item|
  if most_outer_item.class == Array
    most_outer_item.each do |middle_item|
      if middle_item.class == Array
        middle_item.each do |item|
          new_arr << item
        end
      else
        new_arr << middle_item
      end
    end
  else
    new_arr << most_outer_item
  end
end


p new_arr
