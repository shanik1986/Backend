outer_arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

outer_arr = outer_arr.map do |hash|
              hash.each do |key, _|
                hash[key] += 1
              end
            end
p outer_arr
