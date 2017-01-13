require 'pry'

def select_fruit(hsh)
  items = hsh.keys
  counter = 0
  only_fruit = {}

  loop do
    break if counter >= items.size
    current_key = items[counter]
    current_value = hsh[current_key]

    if current_value == 'Fruit'
      only_fruit[current_key] = current_value
    end

    counter += 1
  end
  only_fruit
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

puts select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
