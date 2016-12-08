require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(num)
  /^\d+$/.match(num)
end

def float?(num)
  /\d/.match(num) && /^\d*.?\d*/.match(num)
end

def number?(num)
  integer?(num) || float?(num)
end

def operation_to_message(op)
  case op
  when '1'
    MESSAGES['add_verb']
  when '2'
    MESSAGES['subtract_verb']
  when '3'
    MESSAGES['multiply_verb']
  when '4'
    MESSAGES['divide_verb']
  end
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt(MESSAGES['hi_with_name'] + ' ' + name)

loop do # Main loop

  number1 = ''
  loop do
    prompt(MESSAGES['first_number'])
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_number'])
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  prompt(MESSAGES['operation'])

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['valid_operation'])
    end
  end

  prompt(operation_to_message(operator) + ' ' + MESSAGES['operation_description'])

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            when '4'
              number1.to_f / number2.to_f
            end

  prompt(MESSAGES['result'] + " #{result}")

  prompt(MESSAGES['more_operations'])
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'])
