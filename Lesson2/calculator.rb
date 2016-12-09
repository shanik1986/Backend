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

  if name.empty?() || name.match(/^\s+$/)
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
    break if number?(number1)

    prompt('valid_number')
  end

  number2 = ''
  loop do
    prompt('second_number')
    number2 = Kernel.gets().chomp()
    break if number?(number2)

    prompt('valid_number')
  end

  prompt('operation')

  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    break if %w(1 2 3 4).include?(operator)

    prompt('valid_operation')
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
              if num2.zero?
                (MESSAGES[LANGUAGE]['illigal_operation'])
              else
                number1.to_f / number2.to_f
              end

            end

  Kernel.puts("=> #{MESSAGES[LANGUAGE]['result']} #{result}")

  prompt('more_operations')

  answer = ''
  loop do
    answer = Kernel.gets().chomp().downcase
    break if %w(y n).include?(answer.downcase)
    prompt('valid_response')
  end
  break if answer == 'n'
end

prompt('goodbye')
