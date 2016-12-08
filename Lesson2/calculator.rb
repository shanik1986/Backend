Kernel.puts("Welcome to Calculator!")

Kernel.puts("What's the first number?")
number1 = Kernel.gets().chomp()

Kernel.puts("What's the second number?")
number2 = Kernel.gets().chomp()

Kernel.puts("What's the operation to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i + number2.to_i
elsif operator == '2'
  result = number1.to_i - number2.to_i
elsif operator == '3'
  result = number1.to_i * number2.to_i
elsif operator == '4'
  result = number1.to_f / number2.to_f
end

Kernel.puts("The result is #{result}")



=begin
Kernel.puts('Please enter the first number:')
num1 = Kernel.gets().chomp

Kernel.puts('Please enter the second number:')
num2 = Kernel.gets().chomp
Kernel.puts("What operation would you like us to perform? (Type: 'add', 'subtract', 'multiply', 'divide')")

operation = nil
loop do
  operation = Kernel.gets().chomp().downcase
  break if operation == 'add' || operation == 'subtract' || operation == 'multiply' || operation == 'divide'
  Kernel.puts("Input error! Please use the following commands only: 'add', 'subtract', 'multiply', 'divide'")
end

answer = case operation
when 'add'      then num1.to_i + num2.to_i
when 'subtract' then num1.to_i - num2.to_i
when 'multiply' then num1.to_i * num2.to_i
when 'divide'   then num1.to_f / num2.to_f
end

Kernel.puts(answer)
=end
