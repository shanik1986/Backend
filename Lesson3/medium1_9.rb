def decide_age_group(age)

  case age
  when (0..17)
    'kid'
  when (18..64)
    'adult'
  when age > 65
    'senior'
  else
    'Error'
  end
end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |_, value|
  value["age group"] = decide_age_group(value['age'])
end

puts munsters
