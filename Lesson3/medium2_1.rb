total_male_age = 0

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

munsters.each_value do |details|
  total_male_age += details['age'] if details['gender'] == 'male'
end

puts sum
