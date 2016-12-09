require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
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
    'add_verb'
  when '2'
    'subtract_verb'
  when '3'
    'multiply_verb'
  when '4'
    'divide_verb'
  end
end

prompt('welcome')

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

Kernel.puts("=> #{MESSAGES[LANGUAGE]['hi_with_name']} #{name}")

loop do # Main loop
  number1 = ''
  loop do
    prompt('first_number')
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt('valid_number')
    end
  end

  number2 = ''
  loop do
    prompt('second_number')
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt('valid_number')
    end
  end

  prompt('operation')

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('valid_operation')
    end
  end

  operator_verb = operation_to_message(operator)
  Kernel.puts("=> #{MESSAGES[LANGUAGE][operator_verb]} #{MESSAGES[LANGUAGE]['operation_description']}")

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

  Kernel.puts("=> #{MESSAGES[LANGUAGE]['result']} #{result}")

  prompt('more_operations')
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt('goodbye')
