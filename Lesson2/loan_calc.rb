# loan_calc.rb

require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

def prompt(key)
  Kernel.puts("=> #{MESSAGES[key]}")
end

def integer?(num)
  /^\d+$/.match(num)
end

def float?(num)
  /\d/.match(num) && /^\d*.?\d*$/
end

def valid_integer?(num)
  integer?(num) && num.to_i.positive?
end

def valid_apr?(num)
  float?(num) && num.to_f.positive?
end

prompt('welcome')

loop do
  amount = ''
  prompt('loan_amount')

  loop do
    amount = Kernel.gets().chomp()
    break if valid_integer?(amount)
    prompt('invalid_integer')
  end

  amount = amount.to_i

  apr = ''
  prompt('apr')
  prompt('apr_example')

  loop do
    apr = Kernel.gets().chomp()
    break if valid_apr?(apr)
    prompt('invalid_apr')
  end

  apr = apr.to_f

  duration_in_months = ''
  prompt('duration')

  loop do
    duration_in_months = Kernel.gets().chomp()
    break if valid_integer?(duration_in_months)
    prompt('invalid_integer')
  end

  duration_in_months = duration_in_months.to_i
  monthly_interest = apr / 12

  monthly_payment = amount *
                    (monthly_interest /
                    (1 - (1 + monthly_interest)**(-duration_in_months)))

  final_output = <<-MSG
  => #{MESSAGES['monthly_interest']}: #{(monthly_interest * 100).round(2)}%
  => #{MESSAGES['monthly_payment']}: #{monthly_payment.round(2)}
  MSG

  puts final_output

  prompt('anothe_round')
  answer = ''
  loop do
    answer = Kernel.gets().chomp()
    break if %w(y n).include?(answer.downcase)
    prompt('invalid_answer')
  end

  break if answer == 'n'
end

prompt('goodby')
