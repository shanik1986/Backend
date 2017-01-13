outer_arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

outer_arr = outer_arr.sort_by do |arr|
              arr.select { |item| item.odd? }
            end

p outer_arr
